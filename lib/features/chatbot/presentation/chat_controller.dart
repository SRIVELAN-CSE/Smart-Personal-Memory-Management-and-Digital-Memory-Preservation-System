import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../event_management/presentation/memory_controller.dart';
import '../domain/entities/chat_message.dart';
import '../domain/services/intent_detector.dart';
import '../domain/services/memory_retrieval_service.dart';
import '../domain/services/response_generator.dart';

final chatControllerProvider =
    NotifierProvider<ChatController, List<ChatMessage>>(ChatController.new);

class ChatController extends Notifier<List<ChatMessage>> {
  int _nextId = 0;
  @override
  List<ChatMessage> build() => const [];
  void send(String input) {
    final query = input.trim();
    if (query.isEmpty) return;
    final library = ref.read(memoryControllerProvider);
    if (library.isRestoring || library.restoreFailed) return;
    final intent = const IntentDetector().detect(query);
    final events = const MemoryRetrievalService().retrieve(
      query: query,
      intent: intent,
      events: library.events,
    );
    final response = const ResponseGenerator().generate(
      query: query,
      intent: intent,
      events: events,
    );
    final now = DateTime.now();
    state = [
      ...state,
      ChatMessage(
        id: '${_nextId++}',
        sessionId: 'local',
        role: ChatRole.user,
        text: query,
        createdAt: now,
      ),
      ChatMessage(
        id: '${_nextId++}',
        sessionId: 'local',
        role: ChatRole.assistant,
        text: response.text,
        createdAt: now,
        intent: intent,
        linkedEventIds: response.linkedEventIds,
        results: response.results,
        pendingAction: response.pendingAction,
      ),
    ];
  }

  void clear() => state = const [];
}
