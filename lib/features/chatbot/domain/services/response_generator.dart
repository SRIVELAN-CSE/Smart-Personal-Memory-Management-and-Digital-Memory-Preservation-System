import '../../../timeline/domain/event_filter.dart';
import '../../../../core/models/memory_target.dart';
import '../../../../core/models/memory_models.dart';
import '../entities/chat_message.dart';
import 'entity_extractor.dart';

/// Builds template-based response text and optional pending actions from
/// retrieved events. No text is invented — all output is derived strictly
/// from the user's confirmed stored memories.
class ResponseGenerator {
  const ResponseGenerator();

  static const _notFound =
      "I could not find this information in your saved memories.";

  static const _helpText = '''
Here's what I can help you with:

• **Search memories** — "Show my college memories" or "Memories from July 2026"
• **Find people** — "Who attended the review event?"
• **Find places** — "Show memories at the park"
• **Important memories** — "Which important memories do I have?"
• **High-risk memories** — "Which memories have high rediscovery risk?"
• **Explain recommendations** — "Why is this memory recommended?"
• **Add context** — "Add a story to this memory"
• **Set reminders** — "Remind me about this event next year"

Everything runs locally — your memories never leave this device.''';

  /// Generates a response for the given [intent] and [events].
  ChatResponse generate({
    required String query,
    required ChatIntent intent,
    required List<MemoryEvent> events,
  }) {
    final safe = events.where((e) => !e.isSensitive).toList();
    if (safe.length > 1 &&
        (intent == ChatIntent.openEvent || intent == ChatIntent.startStory)) {
      return ChatResponse(
        text:
            'Several memories match. Choose a memory below to ${intent == ChatIntent.startStory ? 'add its story' : 'open it'}, or include its title in your message.',
        linkedEventIds: safe.map((e) => e.id).toList(),
      );
    }
    final response = _generateText(query: query, intent: intent, events: safe);
    final results = <String, MemoryTarget>{};
    for (final event in safe.where(
      (e) => response.linkedEventIds.contains(e.id),
    )) {
      results['event:${event.id}'] = MemoryTarget(
        type: MemoryTargetType.event,
        id: event.id,
        title: event.title,
      );
      if (RegExp(
        r'\b(photo|photos|media|video|videos|pictures)\b',
        caseSensitive: false,
      ).hasMatch(query)) {
        for (final (index, media) in event.media.take(5).indexed) {
          results['media:${event.id}:${media.id}'] = MemoryTarget(
            type: MemoryTargetType.media,
            id: media.id,
            eventId: event.id,
            title:
                '${media.kind == MediaKind.image ? 'Photo' : 'Video'} ${index + 1} · ${event.title}',
          );
        }
      }
      for (final person in event.people) {
        results['person:${person.id}'] = MemoryTarget(
          type: MemoryTargetType.person,
          id: person.id,
          title: person.name,
        );
      }
      final place = event.resolvedPlace;
      if (place != null) {
        results['place:${place.name}'] = MemoryTarget(
          type: MemoryTargetType.location,
          id: place.name,
          title: place.name,
        );
      }
    }
    return ChatResponse(
      text: response.text,
      linkedEventIds: response.linkedEventIds,
      pendingAction: response.pendingAction,
      results: results.values.toList(),
    );
  }

  ChatResponse _generateText({
    required String query,
    required ChatIntent intent,
    required List<MemoryEvent> events,
  }) {
    switch (intent) {
      case ChatIntent.help:
        return ChatResponse(text: _helpText, linkedEventIds: []);

      case ChatIntent.searchFavourite:
        if (events.isEmpty) {
          return ChatResponse(
            text: "No favourite memories found.",
            linkedEventIds: [],
          );
        }
        return ChatResponse(
          text:
              "Here are your **${events.length}** favourite memor${events.length == 1 ? 'y' : 'ies'}:",
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.searchHighlyRated:
        if (events.isEmpty) {
          return ChatResponse(
            text: "No highly rated memories found.",
            linkedEventIds: [],
          );
        }
        return ChatResponse(
          text:
              "Here are **${events.length}** highly rated memor${events.length == 1 ? 'y' : 'ies'}:",
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.searchRecent:
        if (events.isEmpty) {
          return ChatResponse(
            text: "No recent memories found.",
            linkedEventIds: [],
          );
        }
        return ChatResponse(
          text:
              "Here are **${events.length}** of your most recent memor${events.length == 1 ? 'y' : 'ies'}:",
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.searchMissingStory:
        if (events.isEmpty) {
          return ChatResponse(
            text: "No memories found missing a story.",
            linkedEventIds: [],
          );
        }
        return ChatResponse(
          text:
              "These **${events.length}** memor${events.length == 1 ? 'y' : 'ies'} are missing a story. You can select one and write a short story to preserve it.",
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.searchVoiceNotes:
        if (events.isEmpty) {
          return ChatResponse(
            text: "No voice notes found.",
            linkedEventIds: [],
          );
        }
        return ChatResponse(
          text:
              "These **${events.length}** memor${events.length == 1 ? 'y' : 'ies'} have a voice note attached:",
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.explainSignificance:
        return ChatResponse(
          text:
              "Significance is determined by factors like explicit user rating, favourite status, the amount of linked media, and the presence of identified people. Highly significant memories are prioritized for preservation.",
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.explainRediscovery:
        return ChatResponse(
          text:
              "Rediscovery Risk tracks how likely a memory is to be forgotten. It increases over time since the memory was captured or last viewed, and is lower if a memory is frequently revisited.",
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.explainPreservation:
        return ChatResponse(
          text:
              "The Preservation Need score combines Significance, Rediscovery Risk, and Context Completeness. It highlights memories that are highly important, at risk of being forgotten, and missing key context (like a story or people tags), guiding you to preserve what matters most.",
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.openEvent:
        if (events.isEmpty) {
          return ChatResponse(text: _notFound, linkedEventIds: []);
        }
        return ChatResponse(
          text: "I can open the details for **${events.first.title}**.",
          linkedEventIds: [events.first.id],
          pendingAction: PendingChatAction(
            type: 'open_event',
            label: 'Open memory',
            payload: {'eventId': events.first.id},
          ),
        );

      case ChatIntent.startStory:
        if (events.isEmpty) {
          return ChatResponse(text: _notFound, linkedEventIds: []);
        }
        return ChatResponse(
          text: "I can start the story editor for **${events.first.title}**.",
          linkedEventIds: [events.first.id],
          pendingAction: PendingChatAction(
            type: 'start_story',
            label: 'Write a story',
            payload: {'eventId': events.first.id},
          ),
        );

      case ChatIntent.searchByDate:
        final extractor = const EntityExtractor();
        final range = extractor.extractDateRange(query);
        if (events.isEmpty) {
          final rangeStr = range != null
              ? _formatDateRange(range)
              : 'the specified period';
          return ChatResponse(
            text: "I could not find any memories from $rangeStr.",
            linkedEventIds: [],
          );
        }
        final rangeStr = range != null
            ? _formatDateRange(range)
            : 'the specified period';
        return ChatResponse(
          text:
              "I found **${events.length}** ${events.length == 1 ? 'memory' : 'memories'} from $rangeStr:",
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.searchByPerson:
        if (events.isEmpty) {
          return ChatResponse(text: _notFound, linkedEventIds: []);
        }
        return ChatResponse(
          text:
              "Here are **${events.length}** memor${events.length == 1 ? 'y' : 'ies'} with confirmed people: ${events.expand((e) => e.people).map((p) => p.name).toSet().join(', ')}.",
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.searchByPlace:
        if (events.isEmpty) {
          return ChatResponse(text: _notFound, linkedEventIds: []);
        }
        return ChatResponse(
          text:
              "Found **${events.length}** memor${events.length == 1 ? 'y' : 'ies'} with saved places: ${events.map((e) => e.resolvedPlace?.name).whereType<String>().toSet().join(', ')}.",
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.searchByTitle:
        if (events.isEmpty) {
          return ChatResponse(text: _notFound, linkedEventIds: []);
        }
        return ChatResponse(
          text:
              "Found **${events.length}** matching memor${events.length == 1 ? 'y' : 'ies'}:",
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.searchImportant:
      case ChatIntent.searchHighRisk:
        return ChatResponse(
          text: events.isEmpty
              ? _notFound
              : 'Found ${events.length} ${intent == ChatIntent.searchImportant ? 'important' : 'higher rediscovery-risk'} memories. Tap an event to view its details.',
          linkedEventIds: events.map((e) => e.id).toList(),
        );
      case ChatIntent.explainRecommendation:
      case ChatIntent.addContext:
      case ChatIntent.createReminder:
        return ChatResponse(
          text: events.isEmpty
              ? _notFound
              : "Select a related memory below to review or add context. Reminders are available from Preserve:",
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.unknown:
        return ChatResponse(text: _notFound, linkedEventIds: []);
    }
  }

  String _formatDateRange(DateRange range) =>
      EventDateRange.custom(range.start, range.end).label;
}

class ChatResponse {
  const ChatResponse({
    required this.text,
    required this.linkedEventIds,
    this.pendingAction,
    this.results = const [],
  });

  final List<MemoryTarget> results;
  final String text;
  final List<String> linkedEventIds;
  final PendingChatAction? pendingAction;
}
