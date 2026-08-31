import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_navigation.dart';
import '../../event_management/presentation/memory_controller.dart';
import 'widgets/memory_event_card.dart';

class StoryTimelineScreen extends ConsumerWidget {
  const StoryTimelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(memoryControllerProvider).events.toList()
      ..sort((a, b) => b.startAt.compareTo(a.startAt));
    return AppNavigation(
      selectedIndex: 1,
      title: 'Story timeline',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/scan'),
        icon: const Icon(Icons.add_photo_alternate_outlined),
        label: const Text('Scan'),
      ),
      child: ResponsivePage(
        child: events.isEmpty
            ? _EmptyTimeline(
                onDemo: () async {
                  await ref
                      .read(memoryControllerProvider.notifier)
                      .enableDemoMode();
                },
              )
            : ListView.separated(
                key: const Key('story-timeline-list'),
                itemCount: events.length + 1,
                separatorBuilder: (_, _) => const SizedBox(height: 18),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '${events.length} event ${events.length == 1 ? 'story' : 'stories'} • newest first',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    );
                  }
                  return MemoryEventCard(event: events[index - 1]);
                },
              ),
      ),
    );
  }
}

class _EmptyTimeline extends StatelessWidget {
  const _EmptyTimeline({required this.onDemo});

  final VoidCallback onDemo;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_stories_outlined, size: 70),
          const SizedBox(height: 16),
          Text(
            'Your story starts here',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text('Scan selected gallery media or load the private demo.'),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: onDemo,
            child: const Text('Load demo memory'),
          ),
        ],
      ),
    );
  }
}
