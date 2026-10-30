import 'dart:convert';

import 'package:drift/drift.dart';

import '../models/memory_models.dart';
import 'app_database.dart';

typedef SnapshotClock = DateTime Function();

/// The complete non-demo state rendered by the application.
///
/// Gallery bytes are deliberately absent. Media rows contain stable Android
/// asset identifiers and derived metadata only.
class MemorySnapshot {
  const MemorySnapshot({
    this.events = const [],
    this.recommendations = const [],
    this.unassignedMedia = const [],
  });

  final List<MemoryEvent> events;
  final List<PreservationRecommendation> recommendations;
  final List<MediaItem> unassignedMedia;
}

/// Persists controller state as one atomic, normalized Drift snapshot.
///
/// Snapshot replacement keeps complex split/merge corrections transactional and
/// deterministic for the MVP. Demo rows and scan-history audit rows are retained.
class MemorySnapshotRepository {
  MemorySnapshotRepository(this._database, {SnapshotClock? clock})
    : _clock = clock ?? DateTime.now;

  final AppDatabase _database;
  final SnapshotClock _clock;
  Future<void> _writeTail = Future<void>.value();

  Future<Set<String>> knownAssetIdentifiers() async {
    final rows = await _database.select(_database.mediaItems).get();
    return rows.map((row) => row.assetId).toSet();
  }

  Future<void> recordGalleryAccess(String mode) async {
    await _database
        .into(_database.privacySettings)
        .insert(
          PrivacySettingsCompanion.insert(id: 'default'),
          mode: InsertMode.insertOrIgnore,
        );
    await (_database.update(
      _database.privacySettings,
    )..where((row) => row.id.equals('default'))).write(
      PrivacySettingsCompanion(
        galleryAccessMode: Value(mode),
        updatedAt: Value(_clock().toUtc()),
      ),
    );
  }

  Future<String> beginScan({required String permissionMode}) async {
    final startedAt = _clock().toUtc();
    final id = 'scan_${startedAt.microsecondsSinceEpoch}';
    await _database
        .into(_database.scanHistory)
        .insert(
          ScanHistoryCompanion.insert(
            id: id,
            startedAt: startedAt,
            status: 'running',
            permissionMode: permissionMode,
          ),
        );
    return id;
  }

  Future<void> completeScan({
    required String scanId,
    required int discoveredCount,
    required int importedCount,
    required int skippedCount,
  }) async {
    await (_database.update(
      _database.scanHistory,
    )..where((row) => row.id.equals(scanId))).write(
      ScanHistoryCompanion(
        completedAt: Value(_clock().toUtc()),
        status: const Value('completed'),
        discoveredCount: Value(discoveredCount),
        processedCount: Value(discoveredCount),
        importedCount: Value(importedCount),
        skippedCount: Value(skippedCount),
      ),
    );
  }

  Future<void> failScan({required String scanId, required Object error}) async {
    await (_database.update(
      _database.scanHistory,
    )..where((row) => row.id.equals(scanId))).write(
      ScanHistoryCompanion(
        completedAt: Value(_clock().toUtc()),
        status: const Value('failed'),
        errorSummary: Value(error.toString()),
      ),
    );
  }

  Future<void> save(MemorySnapshot snapshot) {
    final operation = _writeTail.then<void>((_) => _saveNow(snapshot));
    _writeTail = operation.then<void>((_) {}, onError: (_, _) {});
    return operation;
  }

  Future<void> deleteAllDerivedData() {
    final operation = _writeTail.then<void>((_) => _deleteAllDerivedDataNow());
    _writeTail = operation.then<void>((_) {}, onError: (_, _) {});
    return operation;
  }

  Future<MemorySnapshot> load() async {
    await _writeTail;

    final eventRows =
        await (_database.select(_database.events)
              ..where((row) => row.isDemo.equals(false))
              ..orderBy([(row) => OrderingTerm.desc(row.startAt)]))
            .get();
    final mediaRows = await (_database.select(
      _database.mediaItems,
    )..where((row) => row.isDemo.equals(false))).get();
    final mediaById = {for (final row in mediaRows) row.id: _mediaFromRow(row)};

    if (eventRows.isEmpty) {
      return MemorySnapshot(unassignedMedia: mediaById.values.toList());
    }

    final eventIds = eventRows.map((row) => row.id).toSet();
    final memberships =
        (await _database.select(_database.eventMedia).get())
            .where((row) => eventIds.contains(row.eventId))
            .toList()
          ..sort((left, right) => left.position.compareTo(right.position));
    final eventPeople = (await _database.select(_database.eventPersons).get())
        .where((row) => eventIds.contains(row.eventId))
        .toList();
    final peopleById = {
      for (final row in await _database.select(_database.persons).get())
        row.id: MemoryPerson(id: row.id, name: row.displayName),
    };
    final placesById = {
      for (final row in await _database.select(_database.places).get())
        row.id: MemoryPlace(
          id: row.id,
          name: row.name,
          latitude: row.latitude,
          longitude: row.longitude,
          isConfirmed: row.isConfirmed,
          locality: row.locality,
          city: row.city,
          state: row.state,
          country: row.country,
          formattedAddress: row.formattedAddress,
        ),
    };
    final notes = (await _database.select(_database.notes).get())
        .where((row) => eventIds.contains(row.eventId))
        .toList();
    final voiceNotes = (await _database.select(_database.voiceNotes).get())
        .where((row) => eventIds.contains(row.eventId))
        .toList();
    final interactions =
        (await _database.select(_database.eventInteractions).get())
            .where((row) => eventIds.contains(row.eventId))
            .toList();

    final significanceByEvent = _latestSignificance(
      (await _database.select(_database.significanceScores).get()).where(
        (row) => eventIds.contains(row.eventId),
      ),
    );
    final rediscoveryByEvent = _latestRediscovery(
      (await _database.select(_database.rediscoveryScores).get()).where(
        (row) => eventIds.contains(row.eventId),
      ),
    );
    final contextByEvent = _latestContext(
      (await _database.select(_database.contextScores).get()).where(
        (row) => eventIds.contains(row.eventId),
      ),
    );

    final events = <MemoryEvent>[];
    for (final row in eventRows) {
      final eventMedia = memberships
          .where((membership) => membership.eventId == row.id)
          .map((membership) => mediaById[membership.mediaId])
          .whereType<MediaItem>()
          .toList();
      if (eventMedia.isEmpty) continue;

      final significance = significanceByEvent[row.id];
      final rediscovery = rediscoveryByEvent[row.id];
      final context = contextByEvent[row.id];
      final significanceScore = significance?.score ?? 0;
      final rediscoveryScore = rediscovery?.score ?? 0;
      final contextScore = context?.score ?? 0;
      final sensitivity = row.isSensitive || row.isHidden ? 1.0 : 0.0;

      events.add(
        MemoryEvent(
          id: row.id,
          title: row.confirmedTitle ?? row.generatedTitle,
          startAt: row.startAt,
          endAt: row.endAt,
          media: eventMedia,
          people: eventPeople
              .where((link) => link.eventId == row.id)
              .map((link) => peopleById[link.personId])
              .whereType<MemoryPerson>()
              .toList(),
          place: row.placeId == null ? null : placesById[row.placeId],
          description: row.description,
          story: notes
              .where(
                (note) => note.eventId == row.id && note.noteType == 'story',
              )
              .map((note) => note.body)
              .firstOrNull,
          voiceNotePath: voiceNotes
              .where((voice) => voice.eventId == row.id)
              .map((voice) => voice.filePath)
              .firstOrNull,
          coverMediaId: row.coverMediaId,
          rating: row.manualRating ?? 0,
          isFavourite: row.isFavourite,
          isImportant: row.isImportant,
          sensitivity: row.isSensitive || row.isHidden
              ? SensitivityLevel.hidden
              : SensitivityLevel.safe,
          titleOrigin: row.isTitleConfirmed
              ? ContentOrigin.userConfirmed
              : ContentOrigin.automatic,
          storyOrigin: ContentOrigin.userConfirmed,
          titleConfirmed: row.isTitleConfirmed,
          coverConfirmed: row.isCoverUserSelected,
          viewCount: row.viewCount,
          lastViewedAt: row.lastViewedAt,
          correctionCount: interactions
              .where(
                (interaction) =>
                    interaction.eventId == row.id &&
                    interaction.interactionType == 'correction',
              )
              .length,
          scores: MemoryScores(
            significance: significanceScore,
            rediscoveryRisk: rediscoveryScore,
            contextCompleteness: contextScore,
            preservationNeed:
                significanceScore *
                rediscoveryScore *
                (1 - contextScore) *
                (1 - sensitivity),
            significanceFactors: _decodeFactors(significance?.factorsJson),
            rediscoveryFactors: _decodeFactors(rediscovery?.factorsJson),
            contextFactors: _decodeFactors(context?.factorsJson),
          ),
        ),
      );
    }

    final reminders = await _database.select(_database.reminders).get();
    final reminderByRecommendation = <String, ReminderRow>{};
    for (final reminder in reminders) {
      final recommendationId = reminder.recommendationId;
      if (recommendationId != null) {
        reminderByRecommendation[recommendationId] = reminder;
      }
    }
    final feedbackRows = await _database.select(_database.userFeedback).get();
    final feedbackByRecommendation = <String, RecommendationFeedback>{};
    for (final feedback in feedbackRows) {
      final recommendationId = feedback.recommendationId;
      if (recommendationId != null) {
        feedbackByRecommendation[recommendationId] =
            feedback.feedbackType == 'helpful'
            ? RecommendationFeedback.helpful
            : RecommendationFeedback.notHelpful;
      }
    }
    final eventById = {for (final event in events) event.id: event};
    final recommendationRows =
        (await _database.select(_database.preservationRecommendations).get())
            .where((row) => eventIds.contains(row.eventId));
    final recommendations = <PreservationRecommendation>[];
    for (final row in recommendationRows) {
      final payload = _decodeObject(row.actionPayloadJson);
      final event = eventById[row.eventId];
      if (event == null) continue;
      recommendations.add(
        PreservationRecommendation(
          id: row.id,
          eventId: row.eventId,
          title: payload['title'] as String? ?? row.recommendationType,
          explanation: row.explanation,
          primaryAction: _recommendationAction(row.proposedAction),
          status: _recommendationStatus(row.status),
          createdAt: row.createdAt,
          scheduledFor: reminderByRecommendation[row.id]?.scheduledAt,
          feedback: feedbackByRecommendation[row.id],
        ),
      );
    }

    final assignedMediaIds = memberships.map((row) => row.mediaId).toSet();
    return MemorySnapshot(
      events: events,
      recommendations: recommendations,
      unassignedMedia: mediaById.entries
          .where((entry) => !assignedMediaIds.contains(entry.key))
          .map((entry) => entry.value)
          .toList(),
    );
  }

  Future<void> _saveNow(MemorySnapshot snapshot) async {
    final now = _clock().toUtc();
    final mediaById = <String, MediaItem>{
      for (final media in snapshot.unassignedMedia) media.id: media,
      for (final event in snapshot.events)
        for (final media in event.media) media.id: media,
    };
    final peopleById = <String, MemoryPerson>{
      for (final event in snapshot.events)
        for (final person in event.people) person.id: person,
    };
    final placesById = <String, MemoryPlace>{
      for (final event in snapshot.events)
        if (event.resolvedPlace case final place?) place.id: place,
    };

    await _database.transaction(() async {
      await (_database.delete(
        _database.graphNodes,
      )..where((row) => row.id.like('runtime%'))).go();
      await (_database.delete(
        _database.events,
      )..where((row) => row.isDemo.equals(false))).go();
      await (_database.delete(
        _database.mediaItems,
      )..where((row) => row.isDemo.equals(false))).go();
      await (_database.delete(
        _database.persons,
      )..where((row) => row.isDemo.equals(false))).go();
      await (_database.delete(
        _database.places,
      )..where((row) => row.isDemo.equals(false))).go();

      if (mediaById.isNotEmpty) {
        await _database.batch((batch) {
          batch.insertAll(
            _database.mediaItems,
            mediaById.values.map((media) {
              return MediaItemsCompanion.insert(
                id: media.id,
                assetId: media.assetIdentifier,
                mediaType: media.kind.name,
                captureAt: media.capturedAt.toUtc(),
                width: Value(media.width),
                height: Value(media.height),
                durationMs: Value(media.duration.inMilliseconds),
                fileSizeBytes: Value(media.fileSize),
                locationChecked: Value(media.locationChecked),
                latitude: Value(media.latitude),
                longitude: Value(media.longitude),
                ocrText: Value(media.ocrText),
                normalizedOcrText: Value(_normalizeText(media.ocrText)),
                duplicateFingerprint: Value(media.fingerprint),
                thumbnailKey: Value(media.assetIdentifier),
                createdAt: Value(now),
                updatedAt: Value(now),
                importedAt: Value(now),
              );
            }).toList(),
          );
        });
      }
      if (placesById.isNotEmpty) {
        await _database.batch((batch) {
          batch.insertAll(
            _database.places,
            placesById.values
                .map(
                  (place) => PlacesCompanion.insert(
                    id: place.id,
                    name: place.name,
                    latitude: Value(place.latitude),
                    longitude: Value(place.longitude),
                    isConfirmed: Value(place.isConfirmed),
                    locality: Value(place.locality),
                    city: Value(place.city),
                    state: Value(place.state),
                    country: Value(place.country),
                    formattedAddress: Value(place.formattedAddress),
                    createdAt: Value(now),
                    updatedAt: Value(now),
                  ),
                )
                .toList(),
          );
        });
      }
      if (peopleById.isNotEmpty) {
        await _database.batch((batch) {
          batch.insertAll(
            _database.persons,
            peopleById.values
                .map(
                  (person) => PersonsCompanion.insert(
                    id: person.id,
                    displayName: person.name,
                    createdAt: Value(now),
                    updatedAt: Value(now),
                  ),
                )
                .toList(),
          );
        });
      }

      if (snapshot.events.isNotEmpty) {
        await _database.batch((batch) {
          batch.insertAll(
            _database.events,
            snapshot.events.map((event) {
              return EventsCompanion.insert(
                id: event.id,
                generatedTitle: event.title,
                confirmedTitle: event.titleConfirmed
                    ? Value(event.title)
                    : const Value.absent(),
                isTitleConfirmed: Value(event.titleConfirmed),
                description: Value(event.description),
                startAt: event.startAt.toUtc(),
                endAt: event.endAt.toUtc(),
                placeId: Value(event.resolvedPlace?.id),
                coverMediaId: Value(event.coverMediaId),
                isCoverUserSelected: Value(event.coverConfirmed),
                isFavourite: Value(event.isFavourite),
                manualRating: event.rating == 0
                    ? const Value.absent()
                    : Value(event.rating),
                isImportant: Value(event.isImportant),
                isSensitive: Value(event.isSensitive),
                viewCount: Value(event.viewCount),
                lastViewedAt: Value(event.lastViewedAt?.toUtc()),
                source: const Value('generated'),
                clusteringVersion: const Value('hybrid-deterministic-v1'),
                generatedAt: Value(now),
                createdAt: Value(now),
                updatedAt: Value(now),
              );
            }).toList(),
          );
        });

        await _database.batch((batch) {
          batch.insertAll(_database.eventMedia, [
            for (final event in snapshot.events)
              for (var index = 0; index < event.media.length; index++)
                EventMediaCompanion.insert(
                  eventId: event.id,
                  mediaId: event.media[index].id,
                  position: Value(index),
                  isUserConfirmed: Value(event.correctionCount > 0),
                ),
          ]);
          batch.insertAll(_database.eventPersons, [
            for (final event in snapshot.events)
              for (final person in event.people)
                EventPersonsCompanion.insert(
                  eventId: event.id,
                  personId: person.id,
                ),
          ]);
          batch.insertAll(_database.mediaPersons, [
            for (final event in snapshot.events)
              for (final media in event.media)
                for (final person in event.people)
                  MediaPersonsCompanion.insert(
                    mediaId: media.id,
                    personId: person.id,
                  ),
          ], mode: InsertMode.insertOrIgnore);
        });
      }

      await _insertContextRows(snapshot, now);
      await _insertRecommendations(snapshot, now);
      await _insertGraph(snapshot, mediaById, peopleById, placesById);
    });
  }

  Future<void> _deleteAllDerivedDataNow() async {
    await _database.deleteMigrationBackup();
    await _database.transaction(() async {
      // Explicit child-to-parent order keeps foreign-key enforcement enabled.
      await _database.delete(_database.graphEdges).go();
      await _database.delete(_database.graphNodes).go();
      await _database.delete(_database.processingJobs).go();
      await _database.delete(_database.userFeedback).go();
      await _database.delete(_database.reminders).go();
      await _database.delete(_database.preservationRecommendations).go();
      await _database.delete(_database.contextScores).go();
      await _database.delete(_database.rediscoveryScores).go();
      await _database.delete(_database.significanceScores).go();
      await _database.delete(_database.eventInteractions).go();
      await _database.delete(_database.mediaPersons).go();
      await _database.delete(_database.eventPersons).go();
      await _database.delete(_database.eventMedia).go();
      await _database.delete(_database.notes).go();
      await _database.delete(_database.voiceNotes).go();
      await _database.delete(_database.events).go();
      await _database.delete(_database.persons).go();
      await _database.delete(_database.places).go();
      await _database.delete(_database.mediaItems).go();
      await _database.delete(_database.scanHistory).go();
    });
  }

  Future<void> _insertContextRows(MemorySnapshot snapshot, DateTime now) async {
    for (final event in snapshot.events) {
      if (event.hasStory) {
        await _database
            .into(_database.notes)
            .insert(
              NotesCompanion.insert(
                id: _runtimeId('story', event.id),
                eventId: event.id,
                body: event.story!,
                noteType: const Value('story'),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
      }
      if (event.hasVoiceNote) {
        await _database
            .into(_database.voiceNotes)
            .insert(
              VoiceNotesCompanion.insert(
                id: _runtimeId('voice', event.id),
                eventId: event.id,
                filePath: event.voiceNotePath!,
                durationMs: 0,
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
      }
      for (var index = 0; index < event.correctionCount; index++) {
        await _database
            .into(_database.eventInteractions)
            .insert(
              EventInteractionsCompanion.insert(
                id: _runtimeId('correction_$index', event.id),
                eventId: event.id,
                interactionType: 'correction',
                occurredAt: now,
              ),
            );
      }
      await _database.batch((batch) {
        batch.insertAll(_database.significanceScores, [
          SignificanceScoresCompanion.insert(
            id: _runtimeId('significance', event.id),
            eventId: event.id,
            score: event.scores.significance,
            factorsJson: _encodeFactors(event.scores.significanceFactors),
            algorithmVersion: 'significance-rule-v1',
            evaluatedAt: Value(now),
          ),
        ]);
        batch.insertAll(_database.rediscoveryScores, [
          RediscoveryScoresCompanion.insert(
            id: _runtimeId('rediscovery', event.id),
            eventId: event.id,
            score: event.scores.rediscoveryRisk,
            factorsJson: _encodeFactors(event.scores.rediscoveryFactors),
            algorithmVersion: 'rediscovery-risk-rule-v1',
            evaluatedAt: Value(now),
          ),
        ]);
        batch.insertAll(_database.contextScores, [
          ContextScoresCompanion.insert(
            id: _runtimeId('context', event.id),
            eventId: event.id,
            score: event.scores.contextCompleteness,
            factorsJson: _encodeFactors(event.scores.contextFactors),
            algorithmVersion: 'context-completeness-rule-v1',
            evaluatedAt: Value(now),
          ),
        ]);
      });
    }
  }

  Future<void> _insertRecommendations(
    MemorySnapshot snapshot,
    DateTime now,
  ) async {
    final eventById = {for (final event in snapshot.events) event.id: event};
    for (final recommendation in snapshot.recommendations) {
      final event = eventById[recommendation.eventId];
      if (event == null || event.isSensitive) continue;
      await _database
          .into(_database.preservationRecommendations)
          .insert(
            PreservationRecommendationsCompanion.insert(
              id: recommendation.id,
              eventId: recommendation.eventId,
              recommendationType: recommendation.title,
              explanation: recommendation.explanation,
              proposedAction: recommendation.primaryAction.name,
              actionPayloadJson: Value(
                jsonEncode({'title': recommendation.title}),
              ),
              preservationNeed: event.scores.preservationNeed,
              isSafeForNotification: const Value(true),
              status: Value(recommendation.status.name),
              actedAt: recommendation.status == RecommendationStatus.completed
                  ? Value(now)
                  : const Value.absent(),
              dismissedAt:
                  recommendation.status == RecommendationStatus.dismissed
                  ? Value(now)
                  : const Value.absent(),
              createdAt: Value(recommendation.createdAt.toUtc()),
              updatedAt: Value(now),
            ),
          );
      if (recommendation.scheduledFor != null) {
        await _database
            .into(_database.reminders)
            .insert(
              RemindersCompanion.insert(
                id: _runtimeId('reminder', recommendation.id),
                eventId: recommendation.eventId,
                recommendationId: Value(recommendation.id),
                reminderType: 'time_capsule',
                scheduledAt: recommendation.scheduledFor!.toUtc(),
                neutralText: 'You have a memory ready to revisit.',
                notificationId: Value(recommendation.id.hashCode & 0x7fffffff),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
      }
      if (recommendation.feedback != null) {
        await _database
            .into(_database.userFeedback)
            .insert(
              UserFeedbackCompanion.insert(
                id: _runtimeId('feedback', recommendation.id),
                eventId: recommendation.eventId,
                recommendationId: Value(recommendation.id),
                feedbackType:
                    recommendation.feedback == RecommendationFeedback.helpful
                    ? 'helpful'
                    : 'not_helpful',
                createdAt: Value(now),
              ),
            );
      }
    }
  }

  Future<void> _insertGraph(
    MemorySnapshot snapshot,
    Map<String, MediaItem> mediaById,
    Map<String, MemoryPerson> peopleById,
    Map<String, MemoryPlace> placesById,
  ) async {
    final nodes = <GraphNodesCompanion>[
      for (final event in snapshot.events)
        GraphNodesCompanion.insert(
          id: _runtimeId('event', event.id),
          nodeType: 'event',
          entityId: event.id,
          label: event.title,
        ),
      for (final media in mediaById.values)
        GraphNodesCompanion.insert(
          id: _runtimeId('media', media.id),
          nodeType: 'media',
          entityId: media.id,
          label: media.kind == MediaKind.image ? 'Photo' : 'Video',
        ),
      for (final person in peopleById.values)
        GraphNodesCompanion.insert(
          id: _runtimeId('person', person.id),
          nodeType: 'person',
          entityId: person.id,
          label: person.name,
        ),
      for (final place in placesById.values)
        GraphNodesCompanion.insert(
          id: _runtimeId('place', place.id),
          nodeType: 'place',
          entityId: place.id,
          label: place.name,
        ),
      for (final event in snapshot.events)
        if (event.hasStory)
          GraphNodesCompanion.insert(
            id: _runtimeId('note', event.id),
            nodeType: 'note',
            entityId: _runtimeId('story', event.id),
            label: 'Personal story',
          ),
      for (final event in snapshot.events)
        if (event.hasVoiceNote)
          GraphNodesCompanion.insert(
            id: _runtimeId('voice_node', event.id),
            nodeType: 'voice_note',
            entityId: _runtimeId('voice', event.id),
            label: 'Voice note',
          ),
    ];
    if (nodes.isNotEmpty) {
      await _database.batch((batch) {
        batch.insertAll(_database.graphNodes, nodes);
      });
    }

    final edges = <GraphEdgesCompanion>[
      for (final event in snapshot.events)
        for (final media in event.media)
          _edge(
            event.id,
            _runtimeId('event', event.id),
            _runtimeId('media', media.id),
            'contains',
            media.id,
          ),
      for (final event in snapshot.events)
        for (final person in event.people)
          _edge(
            event.id,
            _runtimeId('person', person.id),
            _runtimeId('event', event.id),
            'attended',
            person.id,
          ),
      for (final event in snapshot.events)
        if (event.resolvedPlace case final place?)
          _edge(
            event.id,
            _runtimeId('event', event.id),
            _runtimeId('place', place.id),
            'occurred_at',
            place.id,
          ),
      for (final event in snapshot.events)
        if (event.hasStory)
          _edge(
            event.id,
            _runtimeId('event', event.id),
            _runtimeId('note', event.id),
            'has_note',
            'story',
          ),
      for (final event in snapshot.events)
        if (event.hasVoiceNote)
          _edge(
            event.id,
            _runtimeId('event', event.id),
            _runtimeId('voice_node', event.id),
            'has_voice_note',
            'voice',
          ),
    ];
    if (edges.isNotEmpty) {
      await _database.batch((batch) {
        batch.insertAll(_database.graphEdges, edges);
      });
    }
  }

  GraphEdgesCompanion _edge(
    String eventId,
    String source,
    String target,
    String relation,
    String discriminator,
  ) => GraphEdgesCompanion.insert(
    id: _runtimeId('edge_$relation', '$eventId:$discriminator'),
    sourceNodeId: source,
    targetNodeId: target,
    relationType: relation,
  );

  MediaItem _mediaFromRow(MediaItemRow row) => MediaItem(
    id: row.id,
    assetIdentifier: row.assetId,
    kind: row.mediaType == 'video' ? MediaKind.video : MediaKind.image,
    capturedAt: row.captureAt,
    width: row.width ?? 0,
    height: row.height ?? 0,
    duration: Duration(milliseconds: row.durationMs ?? 0),
    fileSize: row.fileSizeBytes,
    locationChecked: row.locationChecked,
    latitude: row.latitude,
    longitude: row.longitude,
    ocrText: row.ocrText ?? '',
    fingerprint: row.duplicateFingerprint ?? '',
  );

  Map<String, SignificanceScoreRow> _latestSignificance(
    Iterable<SignificanceScoreRow> rows,
  ) => _latestByEvent(
    rows,
    eventId: (row) => row.eventId,
    evaluatedAt: (row) => row.evaluatedAt,
  );

  Map<String, RediscoveryScoreRow> _latestRediscovery(
    Iterable<RediscoveryScoreRow> rows,
  ) => _latestByEvent(
    rows,
    eventId: (row) => row.eventId,
    evaluatedAt: (row) => row.evaluatedAt,
  );

  Map<String, ContextScoreRow> _latestContext(Iterable<ContextScoreRow> rows) =>
      _latestByEvent(
        rows,
        eventId: (row) => row.eventId,
        evaluatedAt: (row) => row.evaluatedAt,
      );

  Map<String, T> _latestByEvent<T>(
    Iterable<T> rows, {
    required String Function(T row) eventId,
    required DateTime Function(T row) evaluatedAt,
  }) {
    final result = <String, T>{};
    for (final row in rows) {
      final id = eventId(row);
      final current = result[id];
      if (current == null || evaluatedAt(row).isAfter(evaluatedAt(current))) {
        result[id] = row;
      }
    }
    return result;
  }

  String _encodeFactors(List<ScoreFactor> factors) => jsonEncode([
    for (final factor in factors)
      {
        'label': factor.label,
        'normalizedValue': factor.normalizedValue,
        'weight': factor.weight,
        'contribution': factor.contribution,
        'explanation': factor.explanation,
      },
  ]);

  List<ScoreFactor> _decodeFactors(String? encoded) {
    if (encoded == null || encoded.isEmpty) return const [];
    try {
      final values = jsonDecode(encoded) as List<dynamic>;
      return [
        for (final value in values)
          if (value case final Map<String, dynamic> map)
            ScoreFactor(
              label: map['label'] as String? ?? 'Factor',
              normalizedValue:
                  (map['normalizedValue'] as num?)?.toDouble() ?? 0,
              weight: (map['weight'] as num?)?.toDouble() ?? 0,
              contribution: (map['contribution'] as num?)?.toDouble() ?? 0,
              explanation: map['explanation'] as String? ?? '',
            ),
      ];
    } on Object {
      return const [];
    }
  }

  Map<String, dynamic> _decodeObject(String encoded) {
    try {
      return jsonDecode(encoded) as Map<String, dynamic>;
    } on Object {
      return const {};
    }
  }

  RecommendationAction _recommendationAction(String name) {
    for (final action in RecommendationAction.values) {
      if (action.name == name) return action;
    }
    return RecommendationAction.addStory;
  }

  RecommendationStatus _recommendationStatus(String name) {
    for (final status in RecommendationStatus.values) {
      if (status.name == name) return status;
    }
    return RecommendationStatus.pending;
  }

  String _normalizeText(String value) =>
      value.toLowerCase().replaceAll(RegExp('[^a-z0-9]+'), ' ').trim();

  String _runtimeId(String kind, String value) {
    final encoded = base64Url.encode(utf8.encode(value)).replaceAll('=', '');
    return 'runtime_${kind}_$encoded';
  }
}
