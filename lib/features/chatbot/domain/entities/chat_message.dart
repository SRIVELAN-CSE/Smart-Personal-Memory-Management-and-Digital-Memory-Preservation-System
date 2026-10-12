import 'package:flutter/foundation.dart';
import '../../../../routing/memory_destination.dart';

enum ChatRole { user, assistant }

enum ChatIntent {
  searchByPerson,
  searchByPlace,
  searchByDate,
  searchByTitle,
  searchImportant,
  searchHighRisk,
  searchFavourite,
  searchHighlyRated,
  searchRecent,
  searchMissingStory,
  searchVoiceNotes,
  explainRecommendation,
  explainSignificance,
  explainRediscovery,
  explainPreservation,
  addContext,
  createReminder,
  openEvent,
  startStory,
  help,
  unknown,
}

/// A pending action that needs user confirmation before it is executed.
@immutable
class PendingChatAction {
  const PendingChatAction({
    required this.type,
    required this.label,
    required this.payload,
  });

  /// e.g. 'add_story', 'create_reminder', 'open_assistant'
  final String type;

  /// Human-readable description shown in confirmation card.
  final String label;

  final Map<String, String> payload;
}

@immutable
class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.sessionId,
    required this.role,
    required this.text,
    required this.createdAt,
    this.intent,
    this.linkedEventIds = const [],
    this.targets = const [],
    this.pendingAction,
  });

  final String id;
  final String sessionId;
  final ChatRole role;
  final String text;
  final DateTime createdAt;
  final ChatIntent? intent;
  final List<String> linkedEventIds;
  final List<MemoryDestination> targets;
  final PendingChatAction? pendingAction;

  bool get isUser => role == ChatRole.user;
  bool get isAssistant => role == ChatRole.assistant;
  bool get hasEvents => linkedEventIds.isNotEmpty;
  bool get requiresConfirmation => pendingAction != null;
}
