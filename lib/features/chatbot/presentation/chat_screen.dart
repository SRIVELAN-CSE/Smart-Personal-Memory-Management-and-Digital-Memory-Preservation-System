import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/app_navigation.dart';
import '../../event_management/presentation/memory_controller.dart';
import 'chat_controller.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_result_card.dart';
import 'widgets/suggested_chips.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});
  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  void _send(String text) {
    ref.read(chatControllerProvider.notifier).send(text);
    _input.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatControllerProvider);
    final library = ref.watch(memoryControllerProvider);
    final ready = !library.isRestoring && !library.restoreFailed;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Companion'),
        actions: [
          IconButton(
            tooltip: 'Clear conversation',
            onPressed: () => ref.read(chatControllerProvider.notifier).clear(),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: ResponsivePage(
          child: Column(
            children: [
              const Text(
                'Offline search of your saved memories. Up to 8 events per answer.',
              ),
              Expanded(
                child: library.isRestoring
                    ? const Center(child: CircularProgressIndicator())
                    : library.restoreFailed
                    ? Center(
                        child: TextButton(
                          onPressed: () => ref
                              .read(memoryControllerProvider.notifier)
                              .retryRestore(),
                          child: const Text('Retry loading memories'),
                        ),
                      )
                    : messages.isEmpty
                    ? Center(
                        child: Text(
                          library.events.isEmpty
                              ? 'Import memories to start exploring them here.'
                              : 'Ask about a title, person, place or date.',
                        ),
                      )
                    : ListView.builder(
                        controller: _scroll,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ChatBubble(
                                text: message.text,
                                isUser: message.isUser,
                                timestamp: message.createdAt,
                              ),
                              for (final target in message.targets)
                                ChatResultCard(target: target),
                            ],
                          );
                        },
                      ),
              ),
              if (ready) SuggestedChips(onSelected: _send),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      enabled: ready,
                      maxLength: 500,
                      textInputAction: TextInputAction.send,
                      onSubmitted: _send,
                      decoration: const InputDecoration(
                        labelText: 'Ask about your memories',
                        counterText: '',
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Send message',
                    onPressed: ready ? () => _send(_input.text) : null,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
