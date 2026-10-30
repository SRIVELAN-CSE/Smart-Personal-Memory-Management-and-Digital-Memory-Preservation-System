import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/memory_target_link.dart';
import '../../../core/widgets/library_status_banner.dart';
import '../../../core/widgets/app_navigation.dart';
import '../../../core/models/memory_target.dart';
import 'widgets/chat_event_card.dart';
import '../../event_management/presentation/memory_controller.dart';
import 'chat_controller.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/suggested_chips.dart';

class MemoryCompanionScreen extends ConsumerStatefulWidget {
  const MemoryCompanionScreen({super.key});
  @override
  ConsumerState<MemoryCompanionScreen> createState() =>
      _MemoryCompanionScreenState();
}

class _MemoryCompanionScreenState extends ConsumerState<MemoryCompanionScreen> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send(String query) {
    ref.read(chatControllerProvider.notifier).send(query);
    _input.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatControllerProvider);
    final library = ref.watch(memoryControllerProvider);
    final ready = !library.isRestoring && !library.restoreFailed;
    return AppNavigation(
      selectedIndex: 4,
      title: 'Memory Companion',
      actions: [
        IconButton(
          tooltip: 'Clear conversation',
          onPressed: () => ref.read(chatControllerProvider.notifier).clear(),
          icon: const Icon(Icons.delete_outline),
        ),
      ],
      child: SafeArea(
        child: Column(
          children: [
            const LibraryStatusBanner(),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Search your memories privately. This conversation stays on this device.',
              ),
            ),
            Expanded(
              child: !ready
                  ? const Center(
                      child: Text(
                        'Loading your library. Retry above if loading failed.',
                      ),
                    )
                  : messages.isEmpty
                  ? const Center(
                      child: Text(
                        'Try “memories with Asha last month” or “photos at Campus hall”.',
                      ),
                    )
                  : ListView.builder(
                      controller: _scroll,
                      padding: const EdgeInsets.all(12),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final stale = message.results.any(
                          (target) => !target.available(library.events),
                        );
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ChatBubble(
                              text: stale
                                  ? 'Some linked memories are no longer available. Search again for current results.'
                                  : message.text,
                              isUser: message.isUser,
                              timestamp: message.createdAt,
                            ),
                            for (final event
                                in library.events
                                    .where(
                                      (e) =>
                                          !e.isSensitive &&
                                          message.linkedEventIds.contains(e.id),
                                    )
                                    .take(20))
                              ChatEventCard(event: event),
                            if (message.results.isNotEmpty)
                              Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: [
                                  for (final result
                                      in message.results
                                          .where(
                                            (r) =>
                                                r.type !=
                                                MemoryTargetType.event,
                                          )
                                          .take(12))
                                    MemoryTargetLink(target: result),
                                ],
                              ),
                            if (message.pendingAction?.type == 'start_story' &&
                                !stale)
                              TextButton.icon(
                                icon: const Icon(Icons.edit_note),
                                label: const Text('Write a story'),
                                onPressed: () {
                                  final id =
                                      message.pendingAction!.payload['eventId'];
                                  if (id != null &&
                                      ref
                                          .read(memoryControllerProvider)
                                          .events
                                          .any(
                                            (e) => e.id == id && !e.isSensitive,
                                          )) {
                                    context.push(
                                      '/event/${Uri.encodeComponent(id)}/story',
                                    );
                                  }
                                },
                              ),
                          ],
                        );
                      },
                    ),
            ),
            if (ready) SuggestedChips(onSelected: _send),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      enabled: ready,
                      onSubmitted: _send,
                      decoration: const InputDecoration(
                        labelText: 'Ask about your memories',
                      ),
                      textInputAction: TextInputAction.send,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Send message',
                    onPressed: ready ? () => _send(_input.text) : null,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
