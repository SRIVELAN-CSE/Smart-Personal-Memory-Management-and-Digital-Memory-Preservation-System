import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../routing/memory_destination.dart';
import '../../../event_management/presentation/memory_controller.dart';
import 'chat_event_card.dart';

class ChatResultCard extends ConsumerWidget {
  const ChatResultCard({required this.target, super.key});
  final MemoryDestination target;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resolved = target.resolve(ref.watch(memoryControllerProvider).events);
    if (resolved != null && target.type == MemoryTargetType.event) {
      return ChatEventCard(
        key: ValueKey(
          'chat-result/${target.type.name}/${target.eventId ?? ''}/${target.id}',
        ),
        event: ref
            .read(memoryControllerProvider)
            .events
            .firstWhere((e) => e.id == target.id),
      );
    }
    final icon = switch (target.type) {
      MemoryTargetType.event => Icons.auto_stories_outlined,
      MemoryTargetType.media => Icons.photo_outlined,
      MemoryTargetType.person => Icons.person_outline,
      MemoryTargetType.location => Icons.place_outlined,
    };
    return Card(
      child: ListTile(
        key: ValueKey(
          'chat-result/${target.type.name}/${target.eventId ?? ''}/${target.id}',
        ),
        leading: Icon(resolved == null ? Icons.link_off : icon),
        title: Text(resolved?.title ?? 'Memory no longer available'),
        subtitle: Text(target.type.name),
        trailing: resolved == null ? null : const Icon(Icons.chevron_right),
        enabled: resolved != null,
        onTap: resolved == null
            ? null
            : () {
                final latest = target.resolve(
                  ref.read(memoryControllerProvider).events,
                );
                if (latest == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('This memory is no longer available.'),
                    ),
                  );
                } else {
                  context.push(latest.route);
                }
              },
      ),
    );
  }
}
