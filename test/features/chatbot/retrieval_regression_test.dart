import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';
import 'package:smart_memory_preservation/features/chatbot/domain/entities/chat_message.dart';
import 'package:smart_memory_preservation/features/chatbot/domain/services/intent_detector.dart';
import 'package:smart_memory_preservation/features/chatbot/domain/services/memory_retrieval_service.dart';
import 'package:smart_memory_preservation/features/chatbot/domain/services/response_generator.dart';
import '../../support/library_fixture.dart';

void main() {
  final original = libraryFixture().events.single;
  final other = MemoryEvent(
    id: 'other',
    title: original.title,
    startAt: original.startAt,
    endAt: original.endAt,
    media: original.media,
    scores: original.scores,
    story: original.story,
    isFavourite: true,
    people: const [MemoryPerson(id: 'other_asha', name: 'Asha')],
  );
  List<MemoryEvent> search(String query, List<MemoryEvent> events) =>
      const MemoryRetrievalService().retrieve(
        query: query,
        intent: const IntentDetector().detect(query),
        events: events,
      );

  test('same person with different per-event tag IDs matches both events', () {
    expect(search('Show photos with Asha', [original, other]), hasLength(2));
  });
  test(
    'polite plural favourites query excludes non-favourites and hidden events',
    () {
      expect(
        search('Could you please show my favorites?', [
          original,
          other.copyWith(isFavourite: false),
          original.copyWith(sensitivity: SensitivityLevel.hidden),
        ]).map((e) => e.id),
        ['saved_event'],
      );
    },
  );
  test('unknown location cannot match title text instead', () {
    expect(
      search('Show memories at London', [
        original.copyWith(title: 'London movie'),
      ]),
      isEmpty,
    );
  });
  test('who and where answers need saved people and places', () {
    expect(
      search('Who attended this event?', [original.copyWith(people: [])]),
      isEmpty,
    );
    expect(
      search('Where was this memory taken?', [
        original.copyWith(clearPlace: true, media: []),
      ]),
      isEmpty,
    );
  });
  test('missing-story query does not match completed stories', () {
    expect(
      search('memories without stories', [
        original,
        other.copyWith(story: ''),
      ]).map((e) => e.id),
      ['other'],
    );
  });
  test(
    'ambiguous action asks user to choose without selecting first match',
    () {
      final response = const ResponseGenerator().generate(
        query: 'add a story',
        intent: ChatIntent.startStory,
        events: [original, other],
      );
      expect(response.pendingAction, isNull);
      expect(response.linkedEventIds, hasLength(2));
      expect(response.text, contains('Choose a memory'));
    },
  );
}
