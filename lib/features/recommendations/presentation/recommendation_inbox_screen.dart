import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/memory_models.dart';
import '../../../core/widgets/app_navigation.dart';
import '../../../core/widgets/library_status_banner.dart';
import '../../../core/widgets/media_thumbnail.dart';
import '../../event_management/presentation/memory_controller.dart';

class RecommendationInboxScreen extends ConsumerWidget {
  const RecommendationInboxScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(memoryControllerProvider);
    final pending = state.recommendations
        .where((r) => r.status == RecommendationStatus.pending)
        .toList();
    final events =
        state.events
            .where(
              (e) =>
                  !e.isSensitive &&
                  (!e.hasStory ||
                      !e.hasVoiceNote ||
                      pending.any((r) => r.eventId == e.id)),
            )
            .toList()
          ..sort((a, b) {
            final need = b.scores.preservationNeed.compareTo(
              a.scores.preservationNeed,
            );
            return need != 0 ? need : b.startAt.compareTo(a.startAt);
          });
    return AppNavigation(
      selectedIndex: 3,
      title: 'Preserve your memories',
      child: ResponsivePage(
        child: Column(
          children: [
            const LibraryStatusBanner(),
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Text(
                'Keep the meaning, not just the photo. Add a story or your voice to the memories below.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Expanded(
              child: state.isRestoring
                  ? const Center(child: CircularProgressIndicator())
                  : events.isEmpty
                  ? const Center(child: Text('Your memories are up to date.'))
                  : ListView.separated(
                      itemCount: events.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final event = events[index];
                        final suggestions = pending
                            .where((r) => r.eventId == event.id)
                            .toList();
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                InkWell(
                                  onTap: () =>
                                      context.push('/event/${event.id}'),
                                  child: Row(
                                    children: [
                                      if (event.media.isNotEmpty)
                                        SizedBox(
                                          width: 72,
                                          height: 72,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                            child: MediaThumbnail(
                                              media: event.media.first,
                                            ),
                                          ),
                                        ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              event.title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              [
                                                if (!event.hasStory)
                                                  'Story missing',
                                                if (!event.hasVoiceNote)
                                                  'Voice note missing',
                                                if (event.hasStory &&
                                                    event.hasVoiceNote)
                                                  'Ready to revisit',
                                              ].join(' · '),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.chevron_right),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 6,
                                  children: [
                                    FilledButton.tonalIcon(
                                      onPressed: () => context.push(
                                        '/event/${event.id}/story',
                                      ),
                                      icon: const Icon(Icons.edit_note),
                                      label: Text(
                                        event.hasStory
                                            ? 'Edit story'
                                            : 'Add story',
                                      ),
                                    ),
                                    OutlinedButton.icon(
                                      onPressed: () => context.push(
                                        '/event/${event.id}/voice',
                                      ),
                                      icon: const Icon(Icons.mic_none),
                                      label: Text(
                                        event.hasVoiceNote
                                            ? 'Voice note'
                                            : 'Add voice',
                                      ),
                                    ),
                                    if (suggestions.isNotEmpty)
                                      TextButton(
                                        onPressed: () => context.push(
                                          '/recommendation/${suggestions.first.id}',
                                        ),
                                        child: const Text('Why preserve this?'),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
