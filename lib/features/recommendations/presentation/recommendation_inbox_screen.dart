import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/memory_models.dart';
import '../../../core/widgets/app_navigation.dart';
import '../../event_management/presentation/memory_controller.dart';

class RecommendationInboxScreen extends ConsumerWidget {
  const RecommendationInboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(memoryControllerProvider);
    final recommendations = state.recommendations
        .where((item) => item.status == RecommendationStatus.pending)
        .toList();
    return AppNavigation(
      selectedIndex: 3,
      title: 'Preservation inbox',
      child: ResponsivePage(
        child: recommendations.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.inbox_outlined, size: 72),
                    const SizedBox(height: 14),
                    Text(
                      'Nothing needs attention',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sensitive memories are suppressed from this proactive inbox.',
                    ),
                  ],
                ),
              )
            : ListView.separated(
                itemCount: recommendations.length + 1,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Suggestions are deterministic and explainable. Dismissal feedback is stored locally.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }
                  final item = recommendations[index - 1];
                  final event = state.events
                      .where((event) => event.id == item.eventId)
                      .firstOrNull;
                  return Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => context.push('/recommendation/${item.id}'),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: _actionColor(
                                context,
                                item.primaryAction,
                              ).withValues(alpha: 0.14),
                              foregroundColor: _actionColor(
                                context,
                                item.primaryAction,
                              ),
                              child: Icon(_actionIcon(item.primaryAction)),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    event?.title ?? 'Derived memory',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelLarge,
                                  ),
                                  const SizedBox(height: 7),
                                  Text(
                                    item.explanation,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (item.scheduledFor != null) ...[
                                    const SizedBox(height: 8),
                                    Chip(
                                      avatar: const Icon(
                                        Icons.schedule_send,
                                        size: 16,
                                      ),
                                      label: Text(
                                        'Capsule scheduled ${item.scheduledFor!.day}/${item.scheduledFor!.month}/${item.scheduledFor!.year}',
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  IconData _actionIcon(RecommendationAction action) => switch (action) {
    RecommendationAction.addStory => Icons.edit_note,
    RecommendationAction.addVoiceNote => Icons.mic_none,
    RecommendationAction.tagPeople => Icons.person_add_alt,
    RecommendationAction.revisit => Icons.history,
    RecommendationAction.timeCapsule => Icons.schedule_send,
  };

  Color _actionColor(BuildContext context, RecommendationAction action) =>
      switch (action) {
        RecommendationAction.addStory => Colors.indigo,
        RecommendationAction.addVoiceNote => Theme.of(
          context,
        ).colorScheme.primary,
        RecommendationAction.tagPeople => Colors.teal,
        RecommendationAction.revisit => Theme.of(context).colorScheme.tertiary,
        RecommendationAction.timeCapsule => Colors.deepOrange,
      };
}
