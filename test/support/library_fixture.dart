import 'package:smart_memory_preservation/core/database/memory_snapshot_repository.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';

MemorySnapshot libraryFixture() {
  final media = List.generate(
    3,
    (i) => MediaItem(
      id: 'saved_photo_$i',
      assetIdentifier: 'saved_asset_$i',
      kind: MediaKind.image,
      capturedAt: DateTime.utc(2026, 8, 1, 10, i * 5),
      width: 1200,
      height: 900,
      latitude: 10.96,
      longitude: 78.08,
      ocrText: 'Review',
      fingerprint: 'unique_$i',
    ),
  );
  final event = MemoryEvent(
    id: 'saved_event',
    title: 'Saved gallery memory',
    startAt: media.first.capturedAt,
    endAt: media.last.capturedAt,
    media: media,
    people: const [MemoryPerson(id: 'saved_person', name: 'Asha')],
    place: const MemoryPlace(
      id: 'saved_place',
      name: 'Campus hall',
      latitude: 10.96,
      longitude: 78.08,
      isConfirmed: true,
    ),
    story: 'Keep this personal story.',
    description: 'A saved description.',
    voiceNotePath: '/app-private/saved.m4a',
    coverMediaId: media.last.id,
    rating: 5,
    isFavourite: true,
    isImportant: true,
    titleConfirmed: true,
    coverConfirmed: true,
    titleOrigin: ContentOrigin.userConfirmed,
    scores: const MemoryScores(
      significance: .8,
      rediscoveryRisk: .7,
      contextCompleteness: .6,
      preservationNeed: .224,
    ),
  );
  return MemorySnapshot(
    events: [event],
    recommendations: [
      PreservationRecommendation(
        id: 'saved_recommendation',
        eventId: event.id,
        title: 'Future revisit',
        explanation: 'Preserve this memory',
        primaryAction: RecommendationAction.timeCapsule,
        createdAt: DateTime.utc(2026, 8, 1),
        scheduledFor: DateTime.utc(2028, 8, 1),
        feedback: RecommendationFeedback.helpful,
      ),
    ],
  );
}
