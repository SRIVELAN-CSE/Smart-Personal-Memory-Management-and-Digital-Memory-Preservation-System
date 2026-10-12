import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/memory_models.dart';
import '../../../../routing/memory_destination.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/memory_cover.dart';
import '../../../../core/widgets/score_chip.dart';

class MemoryEventCard extends StatelessWidget {
  const MemoryEventCard({required this.event, super.key});

  final MemoryEvent event;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(eventRoute(event.id)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MemoryCover(
              event: event,
              height: 178,
              borderRadius: BorderRadius.zero,
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          event.isSensitive ? 'Sensitive memory' : event.title,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                      if (event.isFavourite)
                        Icon(Icons.favorite, color: scheme.error, size: 20),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    [formatMemoryDate(event.startAt)].join(' • '),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.place_outlined,
                        size: 17,
                        color: scheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          event.isSensitive
                              ? 'Location hidden'
                              : event.locationLabel,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _InfoPill(
                        icon: Icons.photo_outlined,
                        label: '${event.imageCount} photos',
                      ),
                      if (event.videoCount > 0)
                        _InfoPill(
                          icon: Icons.videocam_outlined,
                          label: '${event.videoCount} videos',
                        ),
                      if (event.people.isNotEmpty)
                        _InfoPill(
                          icon: Icons.people_outline,
                          label: '${event.people.length} people',
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ScoreChip(
                        label: 'Significance',
                        value: event.scores.significance,
                        color: scheme.primary,
                        icon: Icons.star_outline,
                      ),
                      ScoreChip(
                        label: 'Risk',
                        value: event.scores.rediscoveryRisk,
                        color: scheme.tertiary,
                        icon: Icons.history,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest.withValues(
                        alpha: 0.55,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      event.isSensitive
                          ? 'Open this memory to view its private context.'
                          : event.hasStory
                          ? event.story!
                          : _templateStory(event),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(height: 1.4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    event.hasStory
                        ? 'USER STORY'
                        : 'AUTOMATIC TEMPLATE • EDITABLE',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _templateStory(MemoryEvent event) {
    final people = event.people.isEmpty
        ? ''
        : ' with ${event.people.length} ${event.people.length == 1 ? 'person' : 'people'}';
    final place = event.place == null ? '' : ' at ${event.place!.name}';
    return 'You captured ${event.media.length} items$place$people. Add your own story to preserve what made this event meaningful.';
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 5),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}
