import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../event_management/presentation/memory_controller.dart';
import '../../timeline/presentation/search_providers.dart';
import '../domain/entities/chat_message.dart';
import '../domain/services/memory_retrieval_service.dart';
import '../domain/services/response_generator.dart';

final chatControllerProvider =
    NotifierProvider.autoDispose<ChatController, List<ChatMessage>>(
      ChatController.new,
    );

/// Session-only local conversation. No prompts or memories leave the device.
class ChatController extends AutoDisposeNotifier<List<ChatMessage>> {
  int _sequence = 0;
  @override
  List<ChatMessage> build() => [];
  void send(String query) {
    final text = query.trim();
    final library = ref.read(memoryControllerProvider);
    if (text.isEmpty || library.isRestoring || library.restoreFailed) return;
    final now = DateTime.now();
    final retrieved = const MemoryRetrievalService().retrieve(
      text,
      library.events,
      now: now,
      index: ref.read(eventSearchIndexProvider),
    );
    final response = const ResponseGenerator().generate(
      query: text,
      intent: retrieved.intent,
      events: retrieved.events,
      targets: retrieved.targets,
    );
    final messages = [
      ...state,
      ChatMessage(
        id: 'chat_${_sequence++}',
        sessionId: 'local',
        role: ChatRole.user,
        text: text,
        createdAt: now,
      ),
      ChatMessage(
        id: 'chat_${_sequence++}',
        sessionId: 'local',
        role: ChatRole.assistant,
        text: response.text,
        createdAt: now,
        intent: retrieved.intent,
        linkedEventIds: response.linkedEventIds,
        targets: response.targets,
      ),
    ];
    state = messages.length > 60
        ? messages.sublist(messages.length - 60)
        : messages;
  }

  void clear() => state = [];
}
