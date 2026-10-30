import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/demo_seed_repository.dart';
import '../../../core/database/memory_snapshot_repository.dart';
import '../../../core/models/memory_models.dart';
import '../../event_clustering/domain/entities/cluster_media.dart';
import '../../event_clustering/domain/services/clustering_config.dart';
import '../../event_clustering/domain/services/event_clusterer.dart';
import '../../media_import/data/photo_manager_media_import_gateway.dart';
import '../../media_import/domain/media_import_gateway.dart';
import '../../prediction/domain/services/context_completeness_evaluator.dart';
import '../../prediction/domain/entities/factor_contribution.dart';
import '../../prediction/domain/services/rediscovery_risk_predictor.dart';
import '../../prediction/domain/services/significance_predictor.dart';
import '../../preprocessing/data/ml_kit_ocr_gateway.dart';
import '../data/demo_memory_data.dart';
import '../data/device_place_name_gateway.dart';
import '../domain/services/place_name_gateway.dart';

enum ScanState { idle, requestingPermission, scanning, completed, failed }

class MemoryAppState {
  const MemoryAppState({
    this.events = const [],
    this.recommendations = const [],
    this.unassignedMedia = const [],
    this.scanState = ScanState.idle,
    this.galleryAccess,
    this.scanProgress = 0,
    this.scanStage = '',
    this.errorMessage,
    this.demoMode = false,
    this.isRestoring = false,
    this.restoreFailed = false,
    this.saveFailed = false,
  });

  final List<MemoryEvent> events;
  final List<PreservationRecommendation> recommendations;
  final List<MediaItem> unassignedMedia;
  final ScanState scanState;
  final GalleryAccess? galleryAccess;
  final double scanProgress;
  final String scanStage;
  final String? errorMessage;
  final bool demoMode;
  final bool isRestoring;
  final bool restoreFailed;
  final bool saveFailed;

  MemoryAppState copyWith({
    List<MemoryEvent>? events,
    List<PreservationRecommendation>? recommendations,
    List<MediaItem>? unassignedMedia,
    ScanState? scanState,
    GalleryAccess? galleryAccess,
    double? scanProgress,
    String? scanStage,
    String? errorMessage,
    bool clearError = false,
    bool? demoMode,
    bool? isRestoring,
    bool? restoreFailed,
    bool? saveFailed,
  }) {
    return MemoryAppState(
      events: events ?? this.events,
      recommendations: recommendations ?? this.recommendations,
      unassignedMedia: unassignedMedia ?? this.unassignedMedia,
      scanState: scanState ?? this.scanState,
      galleryAccess: galleryAccess ?? this.galleryAccess,
      scanProgress: scanProgress ?? this.scanProgress,
      scanStage: scanStage ?? this.scanStage,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      demoMode: demoMode ?? this.demoMode,
      isRestoring: isRestoring ?? this.isRestoring,
      restoreFailed: restoreFailed ?? this.restoreFailed,
      saveFailed: saveFailed ?? this.saveFailed,
    );
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase.production();
  ref.onDispose(database.close);
  return database;
});

final mediaImportGatewayProvider = Provider<MediaImportGateway>((ref) {
  return const PhotoManagerMediaImportGateway(ocrGateway: MlKitOcrGateway());
});

final memorySnapshotRepositoryProvider = Provider<MemorySnapshotRepository>((
  ref,
) {
  return MemorySnapshotRepository(ref.watch(appDatabaseProvider));
});

final placeNameGatewayProvider = Provider<PlaceNameGateway>((ref) {
  return DevicePlaceNameGateway();
});

class MemoryController extends Notifier<MemoryAppState> {
  var _revision = 0;
  Future<void>? _restoration;
  bool _disposed = false;
  int _scanGeneration = 0;

  @override
  MemoryAppState build() {
    ref.onDispose(() => _disposed = true);
    _restoration = Future<void>.microtask(_restorePersistedState);
    return const MemoryAppState(isRestoring: true);
  }

  MemorySnapshotRepository get _repository =>
      ref.read(memorySnapshotRepositoryProvider);

  Future<void> _restorePersistedState() async {
    final revision = _revision;
    try {
      final snapshot = await _repository.load();
      if (_disposed || revision != _revision) return;
      state = state.copyWith(
        events: snapshot.events
            .map((event) => event.withResolvedPlace())
            .toList(),
        recommendations: snapshot.recommendations,
        unassignedMedia: snapshot.unassignedMedia,
        isRestoring: false,
        restoreFailed: false,
        clearError: true,
      );
    } on Object {
      if (_disposed || revision != _revision) return;
      state = state.copyWith(
        isRestoring: false,
        restoreFailed: true,
        errorMessage:
            'Your saved memories could not be opened. They have not '
            'been deleted. Retry loading or install the latest compatible update.',
      );
    }
  }

  Future<void> ensureRestored() async => await _restoration;

  Future<void> retryRestore() async {
    if (state.isRestoring) return;
    state = state.copyWith(isRestoring: true, clearError: true);
    _restoration = _restorePersistedState();
    await _restoration;
  }

  Future<void> retrySave() async {
    try {
      await _persistCurrentState();
      if (!_disposed) {
        state = state.copyWith(saveFailed: false, clearError: true);
      }
    } on Object {
      _reportSaveFailure();
    }
  }

  void _reportSaveFailure() {
    if (_disposed) return;
    state = state.copyWith(
      saveFailed: true,
      errorMessage:
          'The latest changes could not be saved. Keep the app open '
          'and retry saving.',
    );
  }

  Future<void> enableDemoMode() async {
    await ensureRestored();
    if (state.restoreFailed ||
        state.events.any((event) => !event.isDemo) ||
        state.unassignedMedia.isNotEmpty) {
      return;
    }
    _scanGeneration++;
    _revision++;
    state = MemoryAppState(
      events: [DemoMemoryData.event],
      recommendations: [DemoMemoryData.recommendation],
      scanState: ScanState.idle,
      demoMode: true,
      isRestoring: false,
    );
    try {
      await DemoSeedRepository(ref.read(appDatabaseProvider)).ensureSeeded();
    } on Object {
      // The demo remains fully usable in-memory if a platform database cannot
      // be opened (for example, in a browser preview).
    }
  }

  Future<GalleryAccess> requestGalleryAccess() async {
    await ensureRestored();
    if (state.restoreFailed) return GalleryAccess.denied;
    _revision++;
    state = state.copyWith(
      scanState: ScanState.requestingPermission,
      isRestoring: false,
      clearError: true,
    );
    try {
      final access = await ref.read(mediaImportGatewayProvider).requestAccess();
      state = state.copyWith(galleryAccess: access, scanState: ScanState.idle);
      unawaited(
        _repository.recordGalleryAccess(access.name).catchError((_) {}),
      );
      return access;
    } on Object catch (error) {
      state = state.copyWith(
        scanState: ScanState.failed,
        errorMessage: 'Could not request gallery access: $error',
      );
      return GalleryAccess.denied;
    }
  }

  Future<void> scanGallery({
    bool resolvePlaceNames = true,
    bool recheckLocations = false,
  }) async {
    await _restoration;
    if (state.restoreFailed || state.scanState == ScanState.scanning) return;
    final generation = ++_scanGeneration;
    bool isCurrentScan() => !_disposed && generation == _scanGeneration;
    _revision++;
    state = state.copyWith(
      scanState: ScanState.scanning,
      scanProgress: 0,
      scanStage: 'Preparing private on-device scan',
      isRestoring: false,
      clearError: true,
    );
    String? scanId;
    var discoveredCount = 0;
    try {
      final gateway = ref.read(mediaImportGatewayProvider);
      final access = await gateway.currentAccess();
      if (!isCurrentScan()) return;
      if (access == GalleryAccess.denied) {
        state = state.copyWith(
          galleryAccess: access,
          scanState: ScanState.failed,
          errorMessage:
              'Photo access is not allowed. Grant gallery access to '
              'scan; your saved memories remain available.',
        );
        return;
      }
      state = state.copyWith(galleryAccess: access);
      await _repository.recordGalleryAccess(access.name);
      scanId = await _repository.beginScan(permissionMode: access.name);

      final knownIds =
          state.events
              .expand((event) => event.media)
              .map((item) => item.assetIdentifier)
              .toSet()
            ..addAll(state.unassignedMedia.map((item) => item.assetIdentifier))
            ..addAll(await _repository.knownAssetIdentifiers());
      final knownMedia = [
        ...state.events.expand((event) => event.media),
        ...state.unassignedMedia,
      ];
      final scanned = await gateway.scan(
        knownAssetIdentifiers: knownIds,
        refreshLocationAssetIdentifiers: knownMedia
            .where(
              (item) =>
                  item.captureLocation == null &&
                  (recheckLocations || !item.locationChecked),
            )
            .map((item) => item.assetIdentifier)
            .toSet(),
        onProgress: (progress) {
          if (!isCurrentScan()) return;
          discoveredCount = progress.total;
          state = state.copyWith(
            scanState: ScanState.scanning,
            scanProgress: progress.fraction,
            scanStage: progress.currentStage,
          );
        },
      );
      if (!isCurrentScan() || state.scanState != ScanState.scanning) return;
      final imported = scanned
          .where((item) => !knownIds.contains(item.assetIdentifier))
          .toList();
      final refreshedByAsset = {
        for (final item in scanned)
          if (knownIds.contains(item.assetIdentifier))
            item.assetIdentifier: item,
      };
      MediaItem refreshMedia(MediaItem item) {
        final location = refreshedByAsset[item.assetIdentifier];
        return location == null
            ? item
            : item.withCaptureLocation(location.captureLocation);
      }

      final detected = _eventsFromMedia(imported);
      final existingEvents = state.events
          .where((event) => !event.isDemo)
          .map(
            (event) => event
                .copyWith(media: event.media.map(refreshMedia).toList())
                .withResolvedPlace(),
          )
          .toList();
      state = state.copyWith(
        events: [...existingEvents, ...detected],
        unassignedMedia: state.unassignedMedia.map(refreshMedia).toList(),
        recommendations: [
          ...state.recommendations.where((item) => !item.isDemo),
          ...detected.expand(_recommendationsFor),
        ],
        scanStage: 'Finding place names for photo locations',
        demoMode: false,
      );
      final resolved = resolvePlaceNames
          ? await _resolveLocations(state.events)
          : <String, MemoryPlace>{};
      if (!isCurrentScan() || state.scanState != ScanState.scanning) return;
      // Apply to the latest state so a manual edit during lookup wins.
      state = state.copyWith(
        events: [
          for (final event in state.events)
            if (resolved[event.id] case final place?
                when event.place?.isConfirmed != true &&
                    event.primaryCaptureLocation?.latitude == place.latitude &&
                    event.primaryCaptureLocation?.longitude == place.longitude)
              event.copyWith(place: place)
            else
              event,
        ],
        scanState: ScanState.completed,
        scanProgress: 1,
        scanStage: imported.isNotEmpty
            ? 'Created ${detected.length} event groups'
            : refreshedByAsset.isNotEmpty
            ? 'Updated locations for ${refreshedByAsset.length} saved media items'
            : 'No new media found',
      );
      await _persistCurrentState();
      await _repository.completeScan(
        scanId: scanId,
        discoveredCount: discoveredCount,
        importedCount: imported.length,
        skippedCount: (discoveredCount - imported.length)
            .clamp(0, discoveredCount)
            .toInt(),
      );
    } on Object catch (error) {
      if (!isCurrentScan()) return;
      if (scanId != null) {
        unawaited(
          _repository.failScan(scanId: scanId, error: error).catchError((_) {}),
        );
      }
      state = state.copyWith(
        scanState: ScanState.failed,
        errorMessage: error.toString(),
        scanStage: 'Scan stopped safely',
      );
    }
  }

  Future<void> manageLimitedSelection() async {
    try {
      await ref.read(mediaImportGatewayProvider).openLimitedSelection();
      state = state.copyWith(
        scanState: ScanState.idle,
        scanProgress: 0,
        scanStage: 'Selection updated; start another incremental scan',
        clearError: true,
      );
    } on Object catch (error) {
      state = state.copyWith(
        errorMessage: 'Could not update selected photos: $error',
      );
    }
  }

  void markViewed(String eventId) {
    _updateEvent(eventId, (event) {
      return _rescore(
        event.copyWith(
          viewCount: event.viewCount + 1,
          lastViewedAt: DateTime.now(),
        ),
      );
    }, completedAction: RecommendationAction.revisit);
  }

  void saveEventDetails({
    required String eventId,
    required String title,
    required String description,
    required String placeName,
  }) {
    final normalizedTitle = title.trim();
    if (normalizedTitle.isEmpty) return;
    final normalizedDescription = description.trim();
    final normalizedPlace = placeName.trim();
    _updateEvent(eventId, (event) {
      final previous = event.resolvedPlace;
      final samePlace = previous?.name == normalizedPlace;
      final place = normalizedPlace.isEmpty
          ? null
          : MemoryPlace(
              id: 'manual_place_${event.id}',
              name: normalizedPlace,
              latitude: previous?.latitude,
              longitude: previous?.longitude,
              locality: samePlace ? previous?.locality : null,
              city: samePlace ? previous?.city : null,
              state: samePlace ? previous?.state : null,
              country: samePlace ? previous?.country : null,
              formattedAddress: samePlace ? previous?.formattedAddress : null,
              isConfirmed: true,
            );
      return _rescore(
        event.copyWith(
          title: normalizedTitle,
          titleOrigin: ContentOrigin.userConfirmed,
          titleConfirmed: true,
          description: normalizedDescription,
          clearDescription: normalizedDescription.isEmpty,
          place: place,
          clearPlace: normalizedPlace.isEmpty,
          correctionCount: event.correctionCount + 1,
        ),
      );
    });
  }

  void renameEvent(String eventId, String title) {
    if (title.trim().isEmpty) return;
    _updateEvent(
      eventId,
      (event) => _rescore(
        event.copyWith(
          title: title.trim(),
          titleOrigin: ContentOrigin.userConfirmed,
          titleConfirmed: true,
          correctionCount: event.correctionCount + 1,
        ),
      ),
    );
  }

  void toggleImportant(String eventId) {
    _updateEvent(
      eventId,
      (event) => _rescore(event.copyWith(isImportant: !event.isImportant)),
    );
  }

  void setRating(String eventId, int rating) {
    _updateEvent(eventId, (event) => _rescore(event.copyWith(rating: rating)));
  }

  void toggleFavourite(String eventId) {
    _updateEvent(
      eventId,
      (event) => _rescore(event.copyWith(isFavourite: !event.isFavourite)),
    );
  }

  void setSensitive(String eventId, bool sensitive) {
    final events = [
      for (final event in state.events)
        if (event.id == eventId)
          _rescore(
            event.copyWith(
              sensitivity: sensitive
                  ? SensitivityLevel.hidden
                  : SensitivityLevel.safe,
            ),
          )
        else
          event,
    ];
    var recommendations = state.recommendations;
    if (sensitive) {
      recommendations = recommendations
          .where((item) => item.eventId != eventId)
          .toList();
    } else {
      final event = events.where((item) => item.id == eventId).firstOrNull;
      if (event != null &&
          !recommendations.any((item) => item.eventId == eventId)) {
        recommendations = [...recommendations, ..._recommendationsFor(event)];
      }
    }
    _commit(state.copyWith(events: events, recommendations: recommendations));
  }

  void selectCover(String eventId, String mediaId) {
    _updateEvent(
      eventId,
      (event) => _rescore(
        event.copyWith(
          coverMediaId: mediaId,
          coverConfirmed: true,
          correctionCount: event.correctionCount + 1,
        ),
      ),
    );
  }

  void removeMedia(String eventId, String mediaId) {
    final event = eventById(eventId);
    if (event == null || event.media.length <= 1) return;
    final removed = event.media.where((item) => item.id == mediaId).firstOrNull;
    if (removed == null) return;
    final remaining = event.media.where((item) => item.id != mediaId).toList();
    final updated = _rescore(
      event.copyWith(
        startAt: remaining.first.capturedAt,
        endAt: remaining.last.capturedAt,
        media: remaining,
        coverMediaId: event.coverMediaId == mediaId
            ? remaining.first.id
            : event.coverMediaId,
        coverConfirmed: event.coverMediaId == mediaId
            ? false
            : event.coverConfirmed,
        correctionCount: event.correctionCount + 1,
      ),
    );
    _commit(
      state.copyWith(
        events: [
          for (final item in state.events)
            if (item.id == eventId) updated else item,
        ],
        unassignedMedia: [...state.unassignedMedia, removed],
      ),
    );
  }

  void addMedia(String eventId, String mediaId) {
    final event = eventById(eventId);
    final media = state.unassignedMedia
        .where((item) => item.id == mediaId)
        .firstOrNull;
    if (event == null || media == null) return;
    final combined = [...event.media, media]
      ..sort((left, right) => left.capturedAt.compareTo(right.capturedAt));
    final updated = _rescore(
      event.copyWith(
        startAt: combined.first.capturedAt,
        endAt: combined.last.capturedAt,
        media: combined,
        correctionCount: event.correctionCount + 1,
      ),
    );
    _commit(
      state.copyWith(
        events: [
          for (final item in state.events)
            if (item.id == eventId) updated else item,
        ],
        unassignedMedia: state.unassignedMedia
            .where((item) => item.id != mediaId)
            .toList(),
      ),
    );
  }

  void saveStory(String eventId, String story) {
    _updateEvent(
      eventId,
      (event) => _rescore(
        event.copyWith(
          story: story.trim(),
          storyOrigin: ContentOrigin.userConfirmed,
          correctionCount: event.correctionCount + 1,
        ),
      ),
      completedAction: RecommendationAction.addStory,
    );
  }

  void saveMediaText(String eventId, String mediaId, String text) {
    _updateEvent(
      eventId,
      (event) => event.copyWith(
        media: event.media
            .map(
              (item) =>
                  item.id == mediaId ? item.withOcrText(text.trim()) : item,
            )
            .toList(),
      ),
    );
  }

  void attachVoiceNote(String eventId, String path) {
    _updateEvent(
      eventId,
      (event) => _rescore(event.copyWith(voiceNotePath: path)),
      completedAction: RecommendationAction.addVoiceNote,
    );
  }

  void addPerson(String eventId, String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    _updateEvent(eventId, (event) {
      if (event.people.any(
        (person) => person.name.toLowerCase() == trimmed.toLowerCase(),
      )) {
        return event;
      }
      return _rescore(
        event.copyWith(
          people: [
            ...event.people,
            MemoryPerson(
              id: 'person_${DateTime.now().microsecondsSinceEpoch}',
              name: trimmed,
            ),
          ],
          correctionCount: event.correctionCount + 1,
        ),
      );
    }, completedAction: RecommendationAction.tagPeople);
  }

  void removePerson(String eventId, String personId) {
    _updateEvent(
      eventId,
      (event) => _rescore(
        event.copyWith(
          people: event.people
              .where((person) => person.id != personId)
              .toList(),
          correctionCount: event.correctionCount + 1,
        ),
      ),
    );
  }

  void splitEvent(String eventId, int splitIndex) {
    final event = eventById(eventId);
    if (event == null || splitIndex <= 0 || splitIndex >= event.media.length) {
      return;
    }
    final first = event.media.sublist(0, splitIndex);
    final second = event.media.sublist(splitIndex);
    final firstEvent = _rescore(
      event.copyWith(
        startAt: first.first.capturedAt,
        endAt: first.last.capturedAt,
        media: first,
        coverMediaId: first.any((item) => item.id == event.coverMediaId)
            ? event.coverMediaId
            : first.first.id,
        coverConfirmed: first.any((item) => item.id == event.coverMediaId)
            ? event.coverConfirmed
            : false,
        correctionCount: event.correctionCount + 1,
      ),
    );
    final secondEvent = MemoryEvent(
      id: '${event.id}_split_${DateTime.now().millisecondsSinceEpoch}',
      title: '${event.title} (part 2)',
      startAt: second.first.capturedAt,
      endAt: second.last.capturedAt,
      media: second,
      people: event.people,
      place: event.place,
      description: event.description,
      coverMediaId: second.first.id,
      rating: event.rating,
      isFavourite: event.isFavourite,
      isImportant: event.isImportant,
      sensitivity: event.sensitivity,
      titleOrigin: ContentOrigin.userConfirmed,
      titleConfirmed: true,
      correctionCount: 1,
      scores: event.scores,
    );
    final rescoredSecond = _rescore(secondEvent);
    _commit(
      state.copyWith(
        events: [
          for (final item in state.events)
            if (item.id == eventId) firstEvent else item,
          rescoredSecond,
        ],
        recommendations: [
          ...state.recommendations,
          ..._recommendationsFor(rescoredSecond),
        ],
      ),
    );
  }

  void mergeEvents(String targetId, String sourceId) {
    if (targetId == sourceId) return;
    final target = eventById(targetId);
    final source = eventById(sourceId);
    if (target == null || source == null) return;
    final mediaById = <String, MediaItem>{
      for (final item in target.media) item.id: item,
      for (final item in source.media) item.id: item,
    };
    final peopleById = <String, MemoryPerson>{
      for (final person in target.people) person.id: person,
      for (final person in source.people) person.id: person,
    };
    final mergedMedia = mediaById.values.toList()
      ..sort((a, b) => a.capturedAt.compareTo(b.capturedAt));
    final merged = _rescore(
      target.copyWith(
        startAt: mergedMedia.first.capturedAt,
        endAt: mergedMedia.last.capturedAt,
        media: mergedMedia,
        people: peopleById.values.toList(),
        place: target.place?.isConfirmed == true
            ? target.place
            : source.place?.isConfirmed == true
            ? source.place
            : target.place ?? source.place,
        description: target.hasDescription
            ? target.description
            : source.description,
        story: target.hasStory ? target.story : source.story,
        voiceNotePath: target.hasVoiceNote
            ? target.voiceNotePath
            : source.voiceNotePath,
        correctionCount: target.correctionCount + 1,
      ),
    );
    _commit(
      state.copyWith(
        events: [
          for (final event in state.events)
            if (event.id == targetId)
              merged
            else if (event.id != sourceId)
              event,
        ],
        recommendations: state.recommendations
            .where((item) => item.eventId != sourceId)
            .toList(),
      ),
    );
  }

  void dismissRecommendation(String id) {
    _commit(
      state.copyWith(
        recommendations: [
          for (final item in state.recommendations)
            if (item.id == id)
              item.copyWith(status: RecommendationStatus.dismissed)
            else
              item,
        ],
      ),
    );
  }

  void submitRecommendationFeedback(
    String id,
    RecommendationFeedback feedback,
  ) {
    _commit(
      state.copyWith(
        recommendations: [
          for (final item in state.recommendations)
            if (item.id == id) item.copyWith(feedback: feedback) else item,
        ],
      ),
    );
  }

  void scheduleTimeCapsule(String recommendationId, DateTime date) {
    _commit(
      state.copyWith(
        recommendations: [
          for (final item in state.recommendations)
            if (item.id == recommendationId)
              item.copyWith(
                scheduledFor: date,
                status: RecommendationStatus.completed,
              )
            else
              item,
        ],
      ),
    );
  }

  void deleteEvent(String eventId) {
    final event = eventById(eventId);
    if (event == null) return;
    final unassignedById = <String, MediaItem>{
      for (final media in state.unassignedMedia) media.id: media,
      for (final media in event.media) media.id: media,
    };
    _commit(
      state.copyWith(
        events: state.events.where((item) => item.id != eventId).toList(),
        recommendations: state.recommendations
            .where((item) => item.eventId != eventId)
            .toList(),
        unassignedMedia: unassignedById.values.toList(),
      ),
    );
  }

  Future<bool> deleteAllDerivedData() async {
    await ensureRestored();
    if (state.restoreFailed) return false;
    final voiceNotePaths = state.events
        .map((event) => event.voiceNotePath)
        .whereType<String>()
        .toSet();
    _scanGeneration++;
    _revision++;
    try {
      await _repository.deleteAllDerivedData();
      if (_disposed) return true;
      state = const MemoryAppState();
      for (final path in voiceNotePaths) {
        try {
          final file = File(path);
          if (await file.exists()) await file.delete();
        } on Object {
          // Missing app-private recordings do not affect database deletion.
        }
      }
      return true;
    } on Object {
      if (!_disposed) {
        state = state.copyWith(
          scanState: ScanState.idle,
          errorMessage:
              'App data could not be cleared. Your memories are still available.',
        );
      }
      return false;
    }
  }

  MemoryEvent? eventById(String id) {
    for (final event in state.events) {
      if (event.id == id) return event;
    }
    return null;
  }

  PreservationRecommendation? recommendationById(String id) {
    for (final item in state.recommendations) {
      if (item.id == id) return item;
    }
    return null;
  }

  List<MemoryEvent> _eventsFromMedia(List<MediaItem> media) {
    if (media.isEmpty) return const [];
    final byId = {for (final item in media) item.id: item};
    final result = DeterministicEventClusterer().cluster(
      media
          .map(
            (item) => ClusterMedia(
              id: item.id,
              capturedAtUtc: item.capturedAt.toUtc(),
              latitude: item.latitude,
              longitude: item.longitude,
              ocrText: item.ocrText,
            ),
          )
          .toList(),
      const ClusteringConfig(),
    );
    return [
      for (var index = 0; index < result.clusters.length; index++)
        _newEvent(
          index,
          result.clusters[index].mediaIds.map((id) => byId[id]!).toList(),
        ),
    ];
  }

  Future<Map<String, MemoryPlace>> _resolveLocations(
    List<MemoryEvent> events,
  ) async {
    final resolved = <String, MemoryPlace>{};
    final names = <String, MemoryPlace?>{};
    final elapsed = Stopwatch()..start();
    final gateway = ref.read(placeNameGatewayProvider);
    for (final event in events) {
      final location = event.primaryCaptureLocation;
      final place = event.resolvedPlace;
      if (location == null ||
          place == null ||
          place.isConfirmed ||
          place.name != location.label) {
        continue;
      }
      // Bound optional device-service work; coordinates already work offline.
      final remainingMs = 8000 - elapsed.elapsedMilliseconds;
      if (remainingMs <= 0) break;
      try {
        if (!names.containsKey(location.key)) {
          names[location.key] = await (() async {
            if (gateway is DetailedPlaceNameGateway) {
              return gateway.placeFor(location);
            }
            final name = await gateway.nameFor(location);
            return name == null ? null : MemoryPlace(id: place.id, name: name);
          })().timeout(Duration(milliseconds: remainingMs.clamp(1, 2000)));
        }
        final details = names[location.key];
        final name = details?.name.trim();
        if (name == null || name.isEmpty) continue;
        resolved[event.id] = MemoryPlace(
          id: place.id,
          name: name,
          locality: details?.locality,
          city: details?.city,
          state: details?.state,
          country: details?.country,
          formattedAddress: details?.formattedAddress,
          latitude: location.latitude,
          longitude: location.longitude,
        );
      } on Object {
        // Offline, unavailable, or rate-limited: retain GPS and retry next scan.
        break;
      }
    }
    return resolved;
  }

  MemoryEvent _newEvent(int index, List<MediaItem> media) {
    final title = _generatedTitle(media.first.capturedAt, media);
    final event = MemoryEvent(
      id: 'event_${DateTime.now().microsecondsSinceEpoch}_$index',
      title: title,
      startAt: media.first.capturedAt,
      endAt: media.last.capturedAt,
      media: media,
      people: const [],
      titleOrigin: ContentOrigin.automatic,
      scores: const MemoryScores(
        significance: 0,
        rediscoveryRisk: 0,
        contextCompleteness: 0,
        preservationNeed: 0,
      ),
    );
    return _rescore(event);
  }

  String _generatedTitle(DateTime capturedAt, List<MediaItem> media) {
    final ocr = media
        .map((item) => item.ocrText)
        .firstWhere((text) => text.trim().isNotEmpty, orElse: () => '');
    if (ocr.isNotEmpty) {
      final compact = ocr.replaceAll(RegExp(r'\s+'), ' ').trim();
      return compact.length > 44 ? '${compact.substring(0, 44)}…' : compact;
    }
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return 'Memory from ${capturedAt.day} ${months[capturedAt.month - 1]}';
  }

  List<PreservationRecommendation> _recommendationsFor(MemoryEvent event) {
    if (event.isSensitive) return const [];
    final actions = <RecommendationAction>[
      if (!event.hasStory) RecommendationAction.addStory,
      if (!event.hasVoiceNote) RecommendationAction.addVoiceNote,
      if (event.people.isEmpty) RecommendationAction.tagPeople,
      if (event.scores.significance >= 0.7 &&
          event.scores.rediscoveryRisk >= 0.6)
        RecommendationAction.timeCapsule,
      if (event.scores.contextCompleteness >= 1 &&
          event.scores.rediscoveryRisk >= 0.6)
        RecommendationAction.revisit,
    ];
    return [
      for (final action in actions.take(3))
        PreservationRecommendation(
          id: 'recommendation_${event.id}_${action.name}',
          eventId: event.id,
          title: _recommendationTitle(action),
          explanation: _recommendationExplanation(event, action),
          primaryAction: action,
          createdAt: DateTime.now(),
        ),
    ];
  }

  String _recommendationTitle(RecommendationAction action) => switch (action) {
    RecommendationAction.addStory => 'Add the story behind this memory',
    RecommendationAction.addVoiceNote => 'Record missing voice context',
    RecommendationAction.tagPeople => 'Confirm who was there',
    RecommendationAction.revisit => 'Revisit this memory',
    RecommendationAction.timeCapsule => 'Save this for a future date',
  };

  String _recommendationExplanation(
    MemoryEvent event,
    RecommendationAction action,
  ) {
    final scoreSummary =
        'The current app estimate is ${(event.scores.significance * 100).round()}% significance, '
        '${(event.scores.rediscoveryRisk * 100).round()}% rediscovery risk, and '
        '${(event.scores.contextCompleteness * 100).round()}% context completeness.';
    final actionReason = switch (action) {
      RecommendationAction.addStory =>
        'A personal written story is missing, so the surrounding meaning could be lost.',
      RecommendationAction.addVoiceNote =>
        'No voice note is attached; a short recording can preserve first-person context.',
      RecommendationAction.tagPeople =>
        'No confirmed people are linked to this event.',
      RecommendationAction.revisit =>
        'This complete memory has a high chance of remaining unopened in this app.',
      RecommendationAction.timeCapsule =>
        'Its high application significance and rediscovery risk make a future revisit useful.',
    };
    return '$scoreSummary $actionReason';
  }

  MemoryEvent _rescore(MemoryEvent event) {
    event = event.withResolvedPlace();
    final significance = const RuleBasedSignificancePredictor().predict(
      SignificanceInput(
        manualRating: event.rating == 0 ? null : event.rating,
        isFavourite: event.isFavourite,
        isMarkedImportant: event.isImportant,
        viewCount: event.viewCount,
        peopleTagCount: event.people.length,
        hasStory: event.hasStory,
        hasNote: event.hasDescription,
        hasVoiceNote: event.hasVoiceNote,
        userCorrectionCount: event.correctionCount,
      ),
    );
    final risk = const RuleBasedRediscoveryRiskPredictor().predict(
      RediscoveryRiskInput(
        eventCreatedAtUtc: event.startAt.toUtc(),
        lastViewedAtUtc: event.lastViewedAt?.toUtc(),
        nowUtc: DateTime.now().toUtc(),
        viewCount: event.viewCount,
      ),
    );
    final context = const RuleBasedContextCompletenessEvaluator().evaluate(
      ContextCompletenessInput(
        hasConfirmedTitle: event.titleConfirmed,
        hasConfirmedPlace: event.place?.isConfirmed ?? false,
        hasTaggedPeople: event.people.isNotEmpty,
        hasStory: event.hasStory,
        hasVoiceNote: event.hasVoiceNote,
        hasUserSelectedCover: event.coverConfirmed,
      ),
    );
    final sensitivity = event.isSensitive ? 1.0 : 0.0;
    final need =
        significance.score *
        risk.score *
        (1 - context.score) *
        (1 - sensitivity);
    return event.copyWith(
      scores: MemoryScores(
        significance: significance.score,
        rediscoveryRisk: risk.score,
        contextCompleteness: context.score,
        preservationNeed: need,
        significanceFactors: _scoreFactors(significance.contributions),
        rediscoveryFactors: _scoreFactors(risk.contributions),
        contextFactors: _scoreFactors(context.breakdown.contributions),
      ),
    );
  }

  List<ScoreFactor> _scoreFactors(List<FactorContribution> contributions) => [
    for (final factor in contributions)
      ScoreFactor(
        label: _factorLabel(factor.key),
        normalizedValue: factor.normalizedValue,
        weight: factor.weight,
        contribution: factor.contribution,
        explanation: _factorExplanation(factor),
      ),
  ];

  String _factorLabel(String key) => switch (key) {
    'manual_priority' => 'Manual rating or important mark',
    'favourite' => 'Favourite status',
    'revisit_frequency' => 'Revisit frequency',
    'people_tags' => 'Confirmed people',
    'added_context' => 'Added personal context',
    'user_corrections' => 'User corrections',
    'staleness' => 'Time since last view',
    'low_view_count' => 'Low view count',
    'event_age' => 'Age of event',
    'never_reminded' => 'Reminder history',
    'reminder_dismissal_rate' => 'Dismissed reminders',
    'confirmed_title' => 'Confirmed title',
    'confirmed_place' => 'Confirmed place',
    'tagged_people' => 'People tags',
    'story' => 'Personal story',
    'voice_note' => 'Voice note',
    'user_selected_cover' => 'Selected cover',
    _ => key.replaceAll('_', ' '),
  };

  String _factorExplanation(FactorContribution factor) {
    final percentage = (factor.normalizedValue * 100).round();
    return switch (factor.key) {
      'staleness' =>
        '${factor.rawValue.round()} days since the last relevant in-app view.',
      'low_view_count' =>
        '${factor.rawValue.round()} in-app views produce a $percentage% low-view signal.',
      'event_age' =>
        'The event is approximately ${factor.rawValue.round()} days old.',
      'manual_priority' when factor.normalizedValue == 0 =>
        'No manual rating or important mark has been supplied.',
      'manual_priority' =>
        'The user-controlled rating or important mark contributes $percentage%.',
      'favourite' =>
        factor.normalizedValue == 1
            ? 'The event is marked as a favourite.'
            : 'The event is not marked as a favourite.',
      'revisit_frequency' =>
        '${factor.rawValue.round()} views normalize to a $percentage% revisit signal.',
      'people_tags' || 'tagged_people' =>
        factor.normalizedValue > 0
            ? 'Confirmed people are linked to this event.'
            : 'No confirmed people are linked yet.',
      'added_context' =>
        factor.normalizedValue > 0
            ? 'Written or voice context has been added.'
            : 'No written or voice context has been added.',
      'user_corrections' =>
        factor.normalizedValue > 0
            ? 'Manual corrections are treated as an explicit engagement signal.'
            : 'No grouping or metadata correction has been recorded.',
      'confirmed_title' =>
        factor.normalizedValue > 0
            ? 'The generated title was confirmed by the user.'
            : 'The generated title still needs confirmation.',
      'confirmed_place' =>
        factor.normalizedValue > 0
            ? 'A place was confirmed by the user.'
            : 'A confirmed place is missing.',
      'story' =>
        factor.normalizedValue > 0
            ? 'A personal story is present.'
            : 'A personal story is missing.',
      'voice_note' =>
        factor.normalizedValue > 0
            ? 'A private voice note is attached.'
            : 'A voice note is missing.',
      'user_selected_cover' =>
        factor.normalizedValue > 0
            ? 'The cover was selected by the user.'
            : 'The cover has not been confirmed.',
      'never_reminded' =>
        factor.normalizedValue > 0
            ? 'No previous reminder has been shown.'
            : 'A reminder has previously been shown.',
      'reminder_dismissal_rate' =>
        factor.normalizedValue > 0
            ? 'Some previous recommendations were dismissed.'
            : 'No reminder dismissals contribute to this estimate.',
      _ => 'Normalized signal: $percentage%.',
    };
  }

  void _updateEvent(
    String eventId,
    MemoryEvent Function(MemoryEvent) update, {
    RecommendationAction? completedAction,
  }) {
    var changed = false;
    final events = [
      for (final event in state.events)
        if (event.id == eventId)
          (() {
            final updated = update(event);
            changed = !identical(updated, event);
            return updated;
          })()
        else
          event,
    ];
    final recommendations = changed && completedAction != null
        ? [
            for (final item in state.recommendations)
              if (item.eventId == eventId &&
                  item.primaryAction == completedAction &&
                  item.status == RecommendationStatus.pending)
                item.copyWith(status: RecommendationStatus.completed)
              else
                item,
          ]
        : state.recommendations;
    _commit(state.copyWith(events: events, recommendations: recommendations));
  }

  void _commit(MemoryAppState next) {
    if (state.isRestoring || state.restoreFailed || _disposed) return;
    _revision++;
    state = next.copyWith(
      events: next.events.map((event) => event.withResolvedPlace()).toList(),
      isRestoring: false,
    );
    if (!state.demoMode) {
      unawaited(_persistCurrentState().catchError((_) => _reportSaveFailure()));
    }
  }

  Future<void> _persistCurrentState() {
    if (state.restoreFailed || state.isRestoring) {
      return Future<void>.error(
        StateError('Load saved memories before saving.'),
      );
    }
    if (state.demoMode) return Future<void>.value();
    return _repository.save(
      MemorySnapshot(
        events: state.events.where((event) => !event.isDemo).toList(),
        recommendations: state.recommendations
            .where((item) => !item.isDemo)
            .toList(),
        unassignedMedia: state.unassignedMedia
            .where((media) => !media.assetIdentifier.startsWith('demo://'))
            .toList(),
      ),
    );
  }
}

final memoryControllerProvider =
    NotifierProvider<MemoryController, MemoryAppState>(MemoryController.new);
