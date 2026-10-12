import 'dart:typed_data';

import 'capture_location.dart';

enum MediaKind { image, video }

enum ContentOrigin { automatic, userConfirmed, demo }

enum SensitivityLevel { safe, hidden }

enum RecommendationAction {
  addStory,
  addVoiceNote,
  tagPeople,
  revisit,
  timeCapsule,
}

enum RecommendationStatus { pending, completed, dismissed }

enum RecommendationFeedback { helpful, notHelpful }

class MediaItem {
  const MediaItem({
    required this.id,
    required this.assetIdentifier,
    required this.kind,
    required this.capturedAt,
    required this.width,
    required this.height,
    this.duration = Duration.zero,
    this.fileSize,
    this.latitude,
    this.longitude,
    this.ocrText = '',
    this.fingerprint = '',
    this.thumbnailBytes,
  });

  final String id;
  final String assetIdentifier;
  final MediaKind kind;
  final DateTime capturedAt;
  final int width;
  final int height;
  final Duration duration;
  final int? fileSize;
  final double? latitude;
  final double? longitude;
  final String ocrText;
  final String fingerprint;
  final Uint8List? thumbnailBytes;

  CaptureLocation? get captureLocation =>
      CaptureLocation.fromCoordinates(latitude, longitude);

  MediaItem withCaptureLocation(CaptureLocation location) => MediaItem(
    id: id,
    assetIdentifier: assetIdentifier,
    kind: kind,
    capturedAt: capturedAt,
    width: width,
    height: height,
    duration: duration,
    fileSize: fileSize,
    latitude: location.latitude,
    longitude: location.longitude,
    ocrText: ocrText,
    fingerprint: fingerprint,
    thumbnailBytes: thumbnailBytes,
  );
}

class MemoryPerson {
  const MemoryPerson({required this.id, required this.name});

  final String id;
  final String name;
}

class MemoryPlace {
  const MemoryPlace({
    required this.id,
    required this.name,
    this.latitude,
    this.longitude,
    this.isConfirmed = false,
    this.locality,
    this.city,
    this.region,
    this.country,
    this.formattedAddress,
  });

  final String id;
  final String name;
  final double? latitude;
  final double? longitude;
  final bool isConfirmed;
  final String? locality;
  final String? city;
  final String? region;
  final String? country;
  final String? formattedAddress;

  String get searchText => [
    name,
    locality,
    city,
    region,
    country,
    formattedAddress,
  ].whereType<String>().join(' ');
}

class ScoreFactor {
  const ScoreFactor({
    required this.label,
    required this.normalizedValue,
    required this.weight,
    required this.contribution,
    required this.explanation,
  });

  final String label;
  final double normalizedValue;
  final double weight;
  final double contribution;
  final String explanation;
}

class MemoryScores {
  const MemoryScores({
    required this.significance,
    required this.rediscoveryRisk,
    required this.contextCompleteness,
    required this.preservationNeed,
    this.significanceFactors = const [],
    this.rediscoveryFactors = const [],
    this.contextFactors = const [],
    this.isIllustrative = false,
  });

  final double significance;
  final double rediscoveryRisk;
  final double contextCompleteness;
  final double preservationNeed;
  final List<ScoreFactor> significanceFactors;
  final List<ScoreFactor> rediscoveryFactors;
  final List<ScoreFactor> contextFactors;
  final bool isIllustrative;
}

class MemoryEvent {
  const MemoryEvent({
    required this.id,
    required this.title,
    required this.startAt,
    required this.endAt,
    required this.media,
    required this.people,
    required this.scores,
    this.place,
    this.description,
    this.story,
    this.voiceNotePath,
    this.coverMediaId,
    this.rating = 0,
    this.isFavourite = false,
    this.isImportant = false,
    this.sensitivity = SensitivityLevel.safe,
    this.titleOrigin = ContentOrigin.automatic,
    this.storyOrigin = ContentOrigin.automatic,
    this.titleConfirmed = false,
    this.coverConfirmed = false,
    this.viewCount = 0,
    this.lastViewedAt,
    this.correctionCount = 0,
    this.isDemo = false,
  });

  final String id;
  final String title;
  final DateTime startAt;
  final DateTime endAt;
  final List<MediaItem> media;
  final List<MemoryPerson> people;
  final MemoryPlace? place;
  final String? description;
  final String? story;
  final String? voiceNotePath;
  final String? coverMediaId;
  final int rating;
  final bool isFavourite;
  final bool isImportant;
  final SensitivityLevel sensitivity;
  final ContentOrigin titleOrigin;
  final ContentOrigin storyOrigin;
  final bool titleConfirmed;
  final bool coverConfirmed;
  final int viewCount;
  final DateTime? lastViewedAt;
  final int correctionCount;
  final MemoryScores scores;
  final bool isDemo;

  int get imageCount =>
      media.where((item) => item.kind == MediaKind.image).length;
  int get videoCount =>
      media.where((item) => item.kind == MediaKind.video).length;
  bool get isSensitive => sensitivity == SensitivityLevel.hidden;
  bool get hasDescription =>
      description != null && description!.trim().isNotEmpty;
  bool get hasStory => story != null && story!.trim().isNotEmpty;
  bool get hasVoiceNote => voiceNotePath != null && voiceNotePath!.isNotEmpty;

  CaptureLocation? get primaryCaptureLocation {
    final ordered = media.where((item) => item.captureLocation != null).toList()
      ..sort((a, b) {
        final time = a.capturedAt.compareTo(b.capturedAt);
        return time == 0 ? a.id.compareTo(b.id) : time;
      });
    return CaptureLocation.representative(
      ordered.map((item) => item.captureLocation!),
    );
  }

  /// Keep a manual place; otherwise derive the place from the current media.
  /// This also handles older imports and split/merge/remove-media corrections.
  MemoryPlace? get resolvedPlace {
    if (place?.isConfirmed == true && place!.name.trim().isNotEmpty) {
      return place;
    }
    final location = primaryCaptureLocation;
    if (location == null) return null;
    if (place != null &&
        place!.name.trim().isNotEmpty &&
        place!.latitude == location.latitude &&
        place!.longitude == location.longitude) {
      return place;
    }
    return MemoryPlace(
      id: 'photo_location_$id',
      name: location.label,
      latitude: location.latitude,
      longitude: location.longitude,
    );
  }

  String get locationLabel => resolvedPlace?.name ?? 'Location unavailable';

  MemoryEvent withResolvedPlace() {
    final resolved = resolvedPlace;
    return identical(resolved, place)
        ? this
        : copyWith(place: resolved, clearPlace: resolved == null);
  }

  MemoryEvent copyWith({
    String? title,
    DateTime? startAt,
    DateTime? endAt,
    List<MediaItem>? media,
    List<MemoryPerson>? people,
    MemoryPlace? place,
    bool clearPlace = false,
    String? description,
    bool clearDescription = false,
    String? story,
    bool clearStory = false,
    String? voiceNotePath,
    bool clearVoiceNote = false,
    String? coverMediaId,
    int? rating,
    bool? isFavourite,
    bool? isImportant,
    SensitivityLevel? sensitivity,
    ContentOrigin? titleOrigin,
    ContentOrigin? storyOrigin,
    bool? titleConfirmed,
    bool? coverConfirmed,
    int? viewCount,
    DateTime? lastViewedAt,
    int? correctionCount,
    MemoryScores? scores,
  }) {
    return MemoryEvent(
      id: id,
      title: title ?? this.title,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      media: media ?? this.media,
      people: people ?? this.people,
      place: clearPlace ? null : (place ?? this.place),
      description: clearDescription ? null : (description ?? this.description),
      story: clearStory ? null : (story ?? this.story),
      voiceNotePath: clearVoiceNote
          ? null
          : (voiceNotePath ?? this.voiceNotePath),
      coverMediaId: coverMediaId ?? this.coverMediaId,
      rating: rating ?? this.rating,
      isFavourite: isFavourite ?? this.isFavourite,
      isImportant: isImportant ?? this.isImportant,
      sensitivity: sensitivity ?? this.sensitivity,
      titleOrigin: titleOrigin ?? this.titleOrigin,
      storyOrigin: storyOrigin ?? this.storyOrigin,
      titleConfirmed: titleConfirmed ?? this.titleConfirmed,
      coverConfirmed: coverConfirmed ?? this.coverConfirmed,
      viewCount: viewCount ?? this.viewCount,
      lastViewedAt: lastViewedAt ?? this.lastViewedAt,
      correctionCount: correctionCount ?? this.correctionCount,
      scores: scores ?? this.scores,
      isDemo: isDemo,
    );
  }
}

class PreservationRecommendation {
  const PreservationRecommendation({
    required this.id,
    required this.eventId,
    required this.title,
    required this.explanation,
    required this.primaryAction,
    required this.createdAt,
    this.status = RecommendationStatus.pending,
    this.scheduledFor,
    this.feedback,
    this.isDemo = false,
  });

  final String id;
  final String eventId;
  final String title;
  final String explanation;
  final RecommendationAction primaryAction;
  final RecommendationStatus status;
  final DateTime createdAt;
  final DateTime? scheduledFor;
  final RecommendationFeedback? feedback;
  final bool isDemo;

  PreservationRecommendation copyWith({
    RecommendationStatus? status,
    DateTime? scheduledFor,
    RecommendationFeedback? feedback,
  }) {
    return PreservationRecommendation(
      id: id,
      eventId: eventId,
      title: title,
      explanation: explanation,
      primaryAction: primaryAction,
      status: status ?? this.status,
      createdAt: createdAt,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      feedback: feedback ?? this.feedback,
      isDemo: isDemo,
    );
  }
}
