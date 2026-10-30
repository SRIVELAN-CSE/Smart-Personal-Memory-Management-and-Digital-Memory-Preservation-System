import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/memory_target.dart';
import '../../features/event_management/presentation/memory_controller.dart';

void openMemoryTarget(
  BuildContext context,
  WidgetRef ref,
  MemoryTarget target,
) {
  final state = ref.read(memoryControllerProvider);
  if (!target.available(state.events)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          state.isRestoring
              ? 'Loading memories...'
              : 'This memory or filter is no longer available.',
        ),
      ),
    );
    return;
  }
  context.push(target.route);
}

class MemoryTargetLink extends ConsumerWidget {
  const MemoryTargetLink({required this.target, super.key});
  final MemoryTarget target;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final available = target.available(
      ref.watch(memoryControllerProvider).events,
    );
    return ActionChip(
      avatar: Icon(switch (target.type) {
        MemoryTargetType.event => Icons.auto_stories_outlined,
        MemoryTargetType.media => Icons.photo_outlined,
        MemoryTargetType.person => Icons.person_outline,
        MemoryTargetType.location => Icons.place_outlined,
      }, size: 18),
      label: Text(available ? target.title : 'Memory unavailable'),
      onPressed: available
          ? () => openMemoryTarget(context, ref, target)
          : null,
    );
  }
}
