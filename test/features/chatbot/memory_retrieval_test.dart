import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';
import 'package:smart_memory_preservation/features/chatbot/domain/services/entity_extractor.dart';
import 'package:smart_memory_preservation/features/chatbot/domain/services/memory_retrieval_service.dart';
import 'package:smart_memory_preservation/features/chatbot/domain/services/response_generator.dart';
import 'package:smart_memory_preservation/routing/memory_destination.dart';
import '../../support/library_fixture.dart';

void main() {
  final event = libraryFixture().events.single;
  const retrieval = MemoryRetrievalService();
  test('retrieval combines tagged person, location and date', () {
    expect(
      retrieval
          .retrieve('Show photos with Asha at Campus hall from August 2026', [
            event,
          ])
          .events
          .single
          .id,
      event.id,
    );
    expect(
      retrieval.retrieve('with Asha from August 2025', [event]).events,
      isEmpty,
    );
    expect(retrieval.retrieve('with Unknown', [event]).events, isEmpty);
    expect(retrieval.retrieve('at Unknown', [event]).events, isEmpty);
    expect(
      retrieval.retrieve('with Asha', [
        event.copyWith(people: [], title: 'Asha'),
      ]).events,
      isEmpty,
    );
  });
  test(
    'one answer contains independent event, photo, person and place targets',
    () {
      final result = retrieval.retrieve('Show saved memories', [event]);
      expect(
        result.targets.map((t) => t.type).toSet(),
        MemoryTargetType.values.toSet(),
      );
      final response = const ResponseGenerator().generate(
        query: 'saved',
        intent: result.intent,
        events: result.events,
        targets: result.targets,
      );
      expect(response.text, isNotEmpty);
      expect(
        response.targets.where((t) => t.type == MemoryTargetType.media).length,
        3,
      );
      for (final target in response.targets) {
        expect(target.resolve([event]), isNotNull);
        expect(target.resolve([]), isNull);
      }
      final hidden = event.copyWith(sensitivity: SensitivityLevel.hidden);
      expect(
        retrieval.retrieve('Show saved memories', [hidden]).targets,
        isEmpty,
      );
      expect(
        response.targets.every((t) => t.resolve([hidden]) == null),
        isTrue,
      );
    },
  );
  test(
    'relative dates agree with timeline and month names require word boundaries',
    () {
      const extractor = EntityExtractor();
      final now = DateTime(2026, 1, 1, 23);
      final range = extractor.extractDates('last 7 days', now: now)!;
      expect(range.start, DateTime(2025, 12, 26));
      expect(range.endExclusive, DateTime(2026, 1, 2));
      expect(extractor.extractDates('market memories', now: now), isNull);
      expect(extractor.extractDates('July 2035')!.start, DateTime(2035, 7));
    },
  );
  test('favourites and important searches do not match every memory', () {
    final ordinary = event.copyWith(
      isFavourite: false,
      isImportant: false,
      scores: const MemoryScores(
        significance: .1,
        rediscoveryRisk: .1,
        contextCompleteness: .1,
        preservationNeed: .1,
      ),
    );
    expect(
      retrieval.retrieve('Show favourite memories', [event]).events.length,
      1,
    );
    expect(
      retrieval.retrieve('Show favourite memories', [ordinary]).events,
      isEmpty,
    );
    expect(
      retrieval.retrieve('Show important memories', [ordinary]).events,
      isEmpty,
    );
  });
}
