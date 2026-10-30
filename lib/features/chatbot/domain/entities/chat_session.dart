import 'package:flutter/foundation.dart';

import 'chat_message.dart';

@immutable
class ChatSession {
  const ChatSession({
    required this.id,
    required this.title,
    required this.createdAt,
    this.messages = const [],
  });

  final String id;
  final String title;
  final DateTime createdAt;
  final List<ChatMessage> messages;

  bool get isEmpty => messages.isEmpty;
}
