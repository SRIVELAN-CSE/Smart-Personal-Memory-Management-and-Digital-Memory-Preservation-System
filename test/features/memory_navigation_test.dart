import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';
import 'package:smart_memory_preservation/core/models/memory_target.dart';
import 'package:smart_memory_preservation/features/memory_graph/domain/memory_graph_projection.dart';
import 'package:smart_memory_preservation/features/chatbot/domain/entities/chat_message.dart';
import 'package:smart_memory_preservation/features/chatbot/domain/services/intent_detector.dart';
import 'package:smart_memory_preservation/features/chatbot/domain/services/memory_retrieval_service.dart';
import 'package:smart_memory_preservation/features/chatbot/domain/services/response_generator.dart';
import '../support/library_fixture.dart';

void main() {
  test('graph targets use real IDs and typed destinations', () {
    final event = libraryFixture().events.single;
    final graph = MemoryGraphProjection([event]);
    final targets = graph.nodes.values
        .map((n) => n.target)
        .whereType<MemoryTarget>()
        .toList();
    for (final type in MemoryTargetType.values) {
      expect(targets.any((t) => t.type == type), isTrue);
    }
    expect(targets.every((t) => t.available([event])), isTrue);
    final media = targets.firstWhere((t) => t.type == MemoryTargetType.media);
    expect(
      Uri.parse(media.route).queryParameters['media'],
      event.media.first.id,
    );
    expect(media.route, startsWith('/event/${event.id}?'));
    final person = targets.firstWhere((t) => t.type == MemoryTargetType.person);
    expect(
      Uri.parse(person.route).queryParameters['person'],
      event.people.single.id,
    );
    expect(
      graph.edges.map((e) => e.relation),
      containsAll(['contains', 'tagged person', 'occurred at']),
    );
    expect(
      MemoryGraphProjection([
        event.copyWith(sensitivity: SensitivityLevel.hidden),
      ]).nodes,
      isEmpty,
    );
  });
  test('encoding and missing targets are safe', () {
    const location = MemoryTarget(
      type: MemoryTargetType.location,
      id: 'A & B/Chennai?x=#',
      title: 'label',
    );
    expect(Uri.parse(location.route).queryParameters['location'], location.id);
    const event = MemoryTarget(
      type: MemoryTargetType.event,
      id: 'a/b:c ?#',
      title: 'label',
    );
    expect(Uri.parse(event.route).pathSegments.last, event.id);
    expect(event.available([]), isFalse);
    const media = MemoryTarget(
      type: MemoryTargetType.media,
      id: 'deleted',
      eventId: 'saved_event',
      title: 'old photo',
    );
    expect(media.available(libraryFixture().events), isFalse);
  });
  test(
    'offline retrieval combines people, location and shared date presets',
    () {
      final events = libraryFixture().events;
      const service = MemoryRetrievalService();
      final result = service.retrieve(
        query: 'photos with Asha at Campus hall last month',
        intent: ChatIntent.searchByPerson,
        events: events,
        now: DateTime(2026, 9, 2),
      );
      expect(result, events);
      expect(
        service.retrieve(
          query: 'memories with Nobody',
          intent: ChatIntent.searchByPerson,
          events: events,
        ),
        isEmpty,
      );
      expect(
        service.retrieve(
          query: 'photos with Asha last year',
          intent: ChatIntent.searchByPerson,
          events: events,
          now: DateTime(2026, 9, 2),
        ),
        isEmpty,
      );
      expect(
        const IntentDetector().detect('Show photos yesterday'),
        ChatIntent.searchByDate,
      );
    },
  );
  test('one or multiple chatbot events have independent structured links', () {
    final event = libraryFixture().events.single;
    final other = MemoryEvent(
      id: 'other',
      title: 'Other event',
      startAt: event.startAt,
      endAt: event.endAt,
      media: event.media,
      people: event.people,
      scores: event.scores,
    );
    for (final events in [
      [event],
      [event, other],
    ]) {
      final response = const ResponseGenerator().generate(
        query: 'show photos',
        intent: ChatIntent.searchByTitle,
        events: events,
      );
      expect(
        response.results.where((r) => r.type == MemoryTargetType.event),
        hasLength(events.length),
      );
      expect(
        response.results.where((r) => r.type == MemoryTargetType.media),
        hasLength(events.length * 3),
      );
      expect(response.results.every((r) => r.available(events)), isTrue);
      expect(response.results.any((r) => r.available([])), isFalse);
    }
    expect(
      const ResponseGenerator()
          .generate(query: 'hello', intent: ChatIntent.help, events: [])
          .results,
      isEmpty,
    );
  });
}
