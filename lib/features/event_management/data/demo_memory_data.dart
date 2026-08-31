import '../../../core/models/memory_models.dart';

abstract final class DemoMemoryData {
  static const eventId = 'demo_final_year_review';

  static MemoryEvent get event {
    final capturedAt = DateTime(2026, 7, 14, 10, 30);
    final media = List<MediaItem>.generate(
      18,
      (index) => MediaItem(
        id: 'demo_media_${index + 1}',
        assetIdentifier: 'demo://project-review/${index + 1}',
        kind: MediaKind.image,
        capturedAt: capturedAt.add(Duration(minutes: index * 4)),
        width: 1920,
        height: 1080,
        ocrText: index == 0 ? 'FINAL YEAR PROJECT REVIEW MKCE' : '',
        fingerprint: 'demo-${index + 1}',
      ),
    );
    return MemoryEvent(
      id: eventId,
      title: 'Final-Year Project Review',
      startAt: capturedAt,
      endAt: capturedAt.add(const Duration(hours: 2)),
      media: media,
      people: const [
        MemoryPerson(id: 'demo_person_sudeep', name: 'Sudeep K'),
        MemoryPerson(id: 'demo_person_sudharshanan', name: 'Sudharshanan K S'),
      ],
      place: const MemoryPlace(
        id: 'demo_place_mkce',
        name: 'M. Kumarasamy College of Engineering',
        isConfirmed: true,
      ),
      coverMediaId: 'demo_media_1',
      rating: 5,
      isFavourite: true,
      isImportant: true,
      titleOrigin: ContentOrigin.demo,
      storyOrigin: ContentOrigin.demo,
      titleConfirmed: true,
      coverConfirmed: true,
      viewCount: 1,
      lastViewedAt: DateTime(2025, 6, 14),
      scores: const MemoryScores(
        significance: 0.86,
        rediscoveryRisk: 0.78,
        contextCompleteness: 0.40,
        preservationNeed: 0.40,
        isIllustrative: true,
        significanceFactors: [
          ScoreFactor(
            label: 'Five-star rating',
            normalizedValue: 1,
            weight: 0.35,
            contribution: 0.35,
            explanation: 'You gave this memory the highest manual rating.',
          ),
          ScoreFactor(
            label: 'Favourite',
            normalizedValue: 1,
            weight: 0.20,
            contribution: 0.20,
            explanation: 'You marked this event as a favourite.',
          ),
          ScoreFactor(
            label: 'People tags',
            normalizedValue: 0.4,
            weight: 0.10,
            contribution: 0.04,
            explanation: 'Two confirmed people are connected to the event.',
          ),
        ],
        rediscoveryFactors: [
          ScoreFactor(
            label: 'Time since view',
            normalizedValue: 1,
            weight: 0.40,
            contribution: 0.40,
            explanation:
                'Demo assumption: it has not been opened for 14 months.',
          ),
          ScoreFactor(
            label: 'Low view count',
            normalizedValue: 0.9,
            weight: 0.25,
            contribution: 0.225,
            explanation: 'It has only been viewed once inside this app.',
          ),
        ],
        contextFactors: [
          ScoreFactor(
            label: 'Personal story',
            normalizedValue: 0,
            weight: 1 / 6,
            contribution: 0,
            explanation: 'A personal story is missing.',
          ),
          ScoreFactor(
            label: 'Voice context',
            normalizedValue: 0,
            weight: 1 / 6,
            contribution: 0,
            explanation: 'A voice note is missing.',
          ),
        ],
      ),
      isDemo: true,
    );
  }

  static PreservationRecommendation get recommendation =>
      PreservationRecommendation(
        id: 'demo_recommendation_review',
        eventId: eventId,
        title: 'Preserve the story behind your project review',
        explanation:
            'This appears to be an important academic memory. It has not been '
            'opened for 14 months and is missing personal context. Add a short '
            'voice note or story, or schedule it as a future time capsule.',
        primaryAction: RecommendationAction.addVoiceNote,
        createdAt: DateTime(2026, 8, 31),
        isDemo: true,
      );
}
