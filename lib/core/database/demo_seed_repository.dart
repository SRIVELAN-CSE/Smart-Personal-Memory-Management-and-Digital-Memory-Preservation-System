import 'dart:convert';

import 'package:drift/drift.dart';

import 'app_database.dart';

class DemoSeedResult {
  const DemoSeedResult({required this.inserted, required this.mediaCount});

  final bool inserted;
  final int mediaCount;
}

class DemoSeedRepository {
  DemoSeedRepository(this._database);

  final AppDatabase _database;

  static const demoEventId = 'demo_event_final_year_review';
  static const demoPlaceId = 'demo_place_mkce';
  static const demoPersonSudeepId = 'demo_person_sudeep_k';
  static const demoPersonSudharshananId = 'demo_person_sudharshanan_k_s';
  static const demoRecommendationId = 'demo_recommendation_preserve_context';

  static const demoMediaCount = 18;
  static const demoSignificance = 0.86;
  static const demoRediscoveryRisk = 0.78;
  static const demoContextCompleteness = 0.40;
  static const demoPreservationNeed =
      demoSignificance * demoRediscoveryRisk * (1 - demoContextCompleteness);

  static const demoRecommendationText =
      'This appears to be an important academic memory. It has not been '
      'opened for 14 months and is missing personal context. Add a short '
      'voice note or story, or schedule it as a future time capsule.';

  Future<bool> hasDemoData() async {
    final event = await (_database.select(
      _database.events,
    )..where((row) => row.id.equals(demoEventId))).getSingleOrNull();
    return event != null;
  }

  Future<DemoSeedResult> ensureSeeded() {
    return _database.transaction(() async {
      await _database
          .into(_database.privacySettings)
          .insert(
            PrivacySettingsCompanion.insert(id: 'default'),
            mode: InsertMode.insertOrIgnore,
          );

      if (await hasDemoData()) {
        final countExpression = _database.eventMedia.eventId.count();
        final countQuery = _database.selectOnly(_database.eventMedia)
          ..addColumns([countExpression])
          ..where(_database.eventMedia.eventId.equals(demoEventId));
        final countRow = await countQuery.getSingle();
        return DemoSeedResult(
          inserted: false,
          mediaCount: countRow.read(countExpression) ?? 0,
        );
      }

      final eventDate = DateTime.utc(2026, 7, 14);
      // This deliberately follows the supplied illustrative scenario even
      // though its relative date is not a validated observation.
      final illustrativeLastViewedAt = DateTime.utc(2025, 6, 30);

      await _database
          .into(_database.places)
          .insert(
            PlacesCompanion.insert(
              id: demoPlaceId,
              name: 'M. Kumarasamy College of Engineering',
              latitude: const Value(10.9577),
              longitude: const Value(78.0800),
              isConfirmed: const Value(true),
              isDemo: const Value(true),
            ),
          );

      await _database.batch((batch) {
        batch.insertAll(_database.persons, [
          PersonsCompanion.insert(
            id: demoPersonSudeepId,
            displayName: 'Sudeep K',
            isDemo: const Value(true),
          ),
          PersonsCompanion.insert(
            id: demoPersonSudharshananId,
            displayName: 'Sudharshanan K S',
            isDemo: const Value(true),
          ),
        ]);
      });

      final mediaRows = [
        for (var index = 0; index < demoMediaCount; index++)
          MediaItemsCompanion.insert(
            id: _mediaId(index),
            assetId: 'demo://final-year-review/${index + 1}',
            assetUri: Value('demo://final-year-review/${index + 1}'),
            mediaType: 'image',
            mimeType: const Value('image/jpeg'),
            captureAt: eventDate.add(Duration(minutes: index * 3)),
            latitude: const Value(10.9577),
            longitude: const Value(78.0800),
            width: const Value(4032),
            height: const Value(3024),
            fileSizeBytes: Value(2200000 + (index * 50000)),
            ocrText: index == 0
                ? const Value('Final-Year Project Review MKCE')
                : const Value.absent(),
            normalizedOcrText: index == 0
                ? const Value('final year project review mkce')
                : const Value.absent(),
            duplicateFingerprint: Value('demo-fingerprint-${index + 1}'),
            thumbnailKey: Value('demo-thumbnail-${index + 1}'),
            isDemo: const Value(true),
          ),
      ];
      await _database.batch((batch) {
        batch.insertAll(_database.mediaItems, mediaRows);
      });

      await _database
          .into(_database.events)
          .insert(
            EventsCompanion.insert(
              id: demoEventId,
              generatedTitle: 'Final-Year Project Review',
              confirmedTitle: const Value('Final-Year Project Review'),
              isTitleConfirmed: const Value(true),
              startAt: eventDate,
              endAt: eventDate.add(const Duration(minutes: 51)),
              placeId: const Value(demoPlaceId),
              coverMediaId: Value(_mediaId(0)),
              isCoverUserSelected: const Value(true),
              isFavourite: const Value(true),
              manualRating: const Value(5),
              isImportant: const Value(true),
              lastViewedAt: Value(illustrativeLastViewedAt),
              viewCount: const Value(1),
              source: const Value('demo'),
              clusteringVersion: const Value('demo-illustrative-v1'),
              isDemo: const Value(true),
            ),
          );

      await _database.batch((batch) {
        batch.insertAll(_database.eventMedia, [
          for (var index = 0; index < demoMediaCount; index++)
            EventMediaCompanion.insert(
              eventId: demoEventId,
              mediaId: _mediaId(index),
              position: Value(index),
              clusteringConfidence: const Value(0.92),
              isUserConfirmed: const Value(true),
            ),
        ]);
        batch.insertAll(_database.eventPersons, [
          EventPersonsCompanion.insert(
            eventId: demoEventId,
            personId: demoPersonSudeepId,
          ),
          EventPersonsCompanion.insert(
            eventId: demoEventId,
            personId: demoPersonSudharshananId,
          ),
        ]);
        batch.insertAll(_database.mediaPersons, [
          MediaPersonsCompanion.insert(
            mediaId: _mediaId(0),
            personId: demoPersonSudeepId,
          ),
          MediaPersonsCompanion.insert(
            mediaId: _mediaId(0),
            personId: demoPersonSudharshananId,
          ),
        ]);
      });

      await _insertIllustrativeScores(eventDate);

      await _database
          .into(_database.preservationRecommendations)
          .insert(
            PreservationRecommendationsCompanion.insert(
              id: demoRecommendationId,
              eventId: demoEventId,
              recommendationType: 'add_personal_context',
              explanation: demoRecommendationText,
              proposedAction: 'add_voice_note_or_story',
              actionPayloadJson: Value(
                jsonEncode({
                  'alternativeAction': 'schedule_time_capsule',
                  'isIllustrative': true,
                }),
              ),
              preservationNeed: demoPreservationNeed,
              sensitivityAtCreation: const Value(0),
              isSafeForNotification: const Value(true),
            ),
          );

      await _database
          .into(_database.eventInteractions)
          .insert(
            EventInteractionsCompanion.insert(
              id: 'demo_interaction_single_view',
              eventId: demoEventId,
              interactionType: 'view',
              source: const Value('demo_fixture'),
              occurredAt: illustrativeLastViewedAt,
              metadataJson: Value(
                jsonEncode({
                  'isIllustrative': true,
                  'displayDescription': '14 months ago',
                }),
              ),
            ),
          );

      await _insertGraph();

      return const DemoSeedResult(inserted: true, mediaCount: demoMediaCount);
    });
  }

  Future<void> _insertIllustrativeScores(DateTime evaluatedAt) async {
    await _database.batch((batch) {
      batch.insert(
        _database.significanceScores,
        SignificanceScoresCompanion.insert(
          id: 'demo_score_significance',
          eventId: demoEventId,
          score: demoSignificance,
          factorsJson: jsonEncode({
            'manualRating': {
              'normalized': 1.0,
              'weight': 0.35,
              'contribution': 0.35,
            },
            'favourite': {
              'normalized': 1.0,
              'weight': 0.20,
              'contribution': 0.20,
            },
            'revisitFrequency': {
              'normalized': 0.4,
              'weight': 0.15,
              'contribution': 0.06,
            },
            'peopleTags': {
              'normalized': 1.0,
              'weight': 0.10,
              'contribution': 0.10,
            },
            'addedContext': {
              'normalized': 0.5,
              'weight': 0.10,
              'contribution': 0.05,
            },
            'userCorrections': {
              'normalized': 1.0,
              'weight': 0.10,
              'contribution': 0.10,
            },
            'isIllustrative': true,
          }),
          algorithmVersion: 'demo-illustrative-v1',
          isIllustrative: const Value(true),
          evaluatedAt: Value(evaluatedAt),
        ),
      );
      batch.insert(
        _database.rediscoveryScores,
        RediscoveryScoresCompanion.insert(
          id: 'demo_score_rediscovery',
          eventId: demoEventId,
          score: demoRediscoveryRisk,
          factorsJson: jsonEncode({
            'daysSinceLastView': 426,
            'viewCount': 1,
            'displayDescription': '14 months ago',
            'isIllustrative': true,
          }),
          algorithmVersion: 'demo-illustrative-v1',
          isIllustrative: const Value(true),
          evaluatedAt: Value(evaluatedAt),
        ),
      );
      batch.insert(
        _database.contextScores,
        ContextScoresCompanion.insert(
          id: 'demo_score_context',
          eventId: demoEventId,
          score: demoContextCompleteness,
          factorsJson: jsonEncode({
            'confirmedTitle': true,
            'confirmedPlace': true,
            'taggedPeople': true,
            'writtenStory': false,
            'voiceNote': false,
            'userSelectedCover': true,
            'isIllustrative': true,
          }),
          algorithmVersion: 'demo-illustrative-v1',
          isIllustrative: const Value(true),
          evaluatedAt: Value(evaluatedAt),
        ),
      );
    });
  }

  Future<void> _insertGraph() async {
    final nodes = <GraphNodesCompanion>[
      GraphNodesCompanion.insert(
        id: 'demo_node_event',
        nodeType: 'event',
        entityId: demoEventId,
        label: 'Final-Year Project Review',
      ),
      GraphNodesCompanion.insert(
        id: 'demo_node_place',
        nodeType: 'place',
        entityId: demoPlaceId,
        label: 'M. Kumarasamy College of Engineering',
      ),
      GraphNodesCompanion.insert(
        id: 'demo_node_person_sudeep',
        nodeType: 'person',
        entityId: demoPersonSudeepId,
        label: 'Sudeep K',
      ),
      GraphNodesCompanion.insert(
        id: 'demo_node_person_sudharshanan',
        nodeType: 'person',
        entityId: demoPersonSudharshananId,
        label: 'Sudharshanan K S',
      ),
      for (var index = 0; index < demoMediaCount; index++)
        GraphNodesCompanion.insert(
          id: _mediaNodeId(index),
          nodeType: 'media',
          entityId: _mediaId(index),
          label: 'Project review photo ${index + 1}',
        ),
    ];
    await _database.batch((batch) {
      batch.insertAll(_database.graphNodes, nodes);
    });

    final edges = <GraphEdgesCompanion>[
      GraphEdgesCompanion.insert(
        id: 'demo_edge_event_place',
        sourceNodeId: 'demo_node_event',
        targetNodeId: 'demo_node_place',
        relationType: 'occurred_at',
      ),
      GraphEdgesCompanion.insert(
        id: 'demo_edge_sudeep_event',
        sourceNodeId: 'demo_node_person_sudeep',
        targetNodeId: 'demo_node_event',
        relationType: 'attended',
      ),
      GraphEdgesCompanion.insert(
        id: 'demo_edge_sudharshanan_event',
        sourceNodeId: 'demo_node_person_sudharshanan',
        targetNodeId: 'demo_node_event',
        relationType: 'attended',
      ),
      for (var index = 0; index < demoMediaCount; index++)
        GraphEdgesCompanion.insert(
          id: 'demo_edge_event_media_${index + 1}',
          sourceNodeId: 'demo_node_event',
          targetNodeId: _mediaNodeId(index),
          relationType: 'contains',
        ),
    ];
    await _database.batch((batch) {
      batch.insertAll(_database.graphEdges, edges);
    });
  }

  static String _mediaId(int zeroBasedIndex) =>
      'demo_media_${zeroBasedIndex + 1}';

  static String _mediaNodeId(int zeroBasedIndex) =>
      'demo_node_media_${zeroBasedIndex + 1}';
}
