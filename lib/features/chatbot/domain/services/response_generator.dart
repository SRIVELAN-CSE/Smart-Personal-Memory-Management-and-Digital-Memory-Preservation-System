import '../../../../core/models/memory_models.dart';
import '../../../../routing/memory_destination.dart';
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

This conversation runs locally and stays on your device.''';

  /// Generates a response for the given [intent] and [events].
  ChatResponse generate({
    required String query,
    required ChatIntent intent,
    required List<MemoryEvent> events,
    List<MemoryDestination> targets = const [],
  }) {
    final response = _generateText(
      query: query,
      intent: intent,
      events: events,
    );
    return ChatResponse(
      text: response.text,
      linkedEventIds: response.linkedEventIds,
      pendingAction: response.pendingAction,
      targets: targets.isNotEmpty
          ? targets
          : events
                .where(
                  (e) =>
                      response.linkedEventIds.contains(e.id) && !e.isSensitive,
                )
                .map(
                  (e) => MemoryDestination(
                    type: MemoryTargetType.event,
                    id: e.id,
                    title: e.title,
                  ),
                )
                .toList(),
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
          text: "Select a result to open its details.",
          linkedEventIds: [events.first.id],
          pendingAction: PendingChatAction(
            type: 'open_event',
            label: 'Open ""',
            payload: {'eventId': events.first.id},
          ),
        );

      case ChatIntent.startStory:
        if (events.isEmpty) {
          return ChatResponse(text: _notFound, linkedEventIds: []);
        }
        return ChatResponse(
          text:
              "Open a result below and choose Add story to write its context.",
          linkedEventIds: [events.first.id],
          pendingAction: PendingChatAction(
            type: 'start_story',
            label: 'Start story for ""',
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
              "I found **${events.length}** memor${events.length == 1 ? 'y' : 'ies'} from $rangeStr:",
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.searchByPerson:
        if (events.isEmpty) {
          return ChatResponse(text: _notFound, linkedEventIds: []);
        }
        return ChatResponse(
          text:
              "Here are **${events.length}** memor${events.length == 1 ? 'y' : 'ies'} with matching people:",
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.searchByPlace:
        if (events.isEmpty) {
          return ChatResponse(text: _notFound, linkedEventIds: []);
        }
        return ChatResponse(
          text:
              "Found **${events.length}** memor${events.length == 1 ? 'y' : 'ies'} at the matching location:",
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
      case ChatIntent.explainRecommendation:
      case ChatIntent.addContext:
      case ChatIntent.createReminder:
        return ChatResponse(
          text: events.isEmpty
              ? _notFound
              : intent == ChatIntent.createReminder
              ? 'Open a memory below and use its preservation recommendation to schedule a time capsule.'
              : 'Here are up to eight matching memories. Select a result to explore its context.',
          linkedEventIds: events.map((e) => e.id).toList(),
        );

      case ChatIntent.unknown:
        return ChatResponse(text: _notFound, linkedEventIds: []);
    }
  }

  String _formatDateRange(DateRange range) {
    String day(DateTime date) =>
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return day(range.start) == day(range.end)
        ? day(range.start)
        : '${day(range.start)} to ${day(range.end)}';
  }
}

class ChatResponse {
  const ChatResponse({
    required this.text,
    required this.linkedEventIds,
    this.pendingAction,
    this.targets = const [],
  });

  final String text;
  final List<String> linkedEventIds;
  final PendingChatAction? pendingAction;
  final List<MemoryDestination> targets;
}
