import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/memory_models.dart';
import '../../../event_management/presentation/memory_controller.dart';

/// A compact event card displayed inline in the chat response.
class ChatEventCard extends ConsumerWidget {
  const ChatEventCard({super.key, required this.event});

  final MemoryEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(memoryControllerProvider);
    final event = state.events
        .where((item) => item.id == this.event.id)
        .firstOrNull;
    if (event == null) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.info_outline),
          title: Text(
            state.isRestoring
                ? 'Loading memory…'
                : 'This memory is no longer available.',
          ),
        ),
      );
    }
    if (event.isSensitive) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.lock_outline),
          title: const Text('Sensitive memory'),
          onTap: () => context.push('/event/${event.id}'),
        ),
      );
    }
    final scheme = Theme.of(context).colorScheme;
    final sig = (event.scores.significance * 100).round();
    final risk = (event.scores.rediscoveryRisk * 100).round();
    final ctx = (event.scores.contextCompleteness * 100).round();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/event/${event.id}'),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    event.isImportant
                        ? Icons.star
                        : Icons.photo_library_outlined,
                    size: 16,
                    color: event.isImportant
                        ? Colors.amber.shade700
                        : scheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      event.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: scheme.onSurfaceVariant,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                _formatDate(event.startAt),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
              if (event.resolvedPlace != null) ...[
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                      Icons.place_outlined,
                      size: 12,
                      color: scheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        event.resolvedPlace!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              if (event.people.isNotEmpty) ...[
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                      Icons.group_outlined,
                      size: 12,
                      color: scheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        event.people.map((p) => p.name).join(', '),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                children: [
                  _ScorePill(label: 'Sig $sig%', color: scheme.primary),
                  _ScorePill(
                    label: 'Risk $risk%',
                    color: risk >= 60 ? Colors.deepOrange : scheme.tertiary,
                  ),
                  _ScorePill(
                    label: 'Ctx $ctx%',
                    color: ctx >= 60 ? Colors.teal : Colors.indigo,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${dt.day} ${months[dt.month]} ${dt.year}';
  }
}

class _ScorePill extends StatelessWidget {
  const _ScorePill({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final foreground = Theme.of(context).brightness == Brightness.dark
        ? Color.lerp(color, Colors.white, .4)!
        : color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
