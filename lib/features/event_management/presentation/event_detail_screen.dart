import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/formatters.dart';
import '../../../core/widgets/memory_cover.dart';
import '../../../core/widgets/score_chip.dart';
import 'memory_controller.dart';

class EventDetailScreen extends ConsumerStatefulWidget {
  const EventDetailScreen({required this.eventId, super.key});

  final String eventId;

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  var _viewRecorded = false;

  @override
  Widget build(BuildContext context) {
    final event = ref
        .watch(memoryControllerProvider)
        .events
        .where((item) => item.id == widget.eventId)
        .firstOrNull;
    if (event == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('This derived event is no longer available.'),
        ),
      );
    }
    if (!_viewRecorded) {
      _viewRecorded = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(memoryControllerProvider.notifier).markViewed(widget.eventId);
      });
    }
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory details'),
        actions: [
          IconButton(
            tooltip: event.isFavourite ? 'Remove favourite' : 'Favourite',
            onPressed: () => ref
                .read(memoryControllerProvider.notifier)
                .toggleFavourite(event.id),
            icon: Icon(
              event.isFavourite ? Icons.favorite : Icons.favorite_border,
              color: event.isFavourite ? scheme.error : null,
            ),
          ),
          IconButton(
            tooltip: 'Edit memory',
            onPressed: () => context.push('/event/${event.id}/edit'),
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: MemoryCover(event: event, height: 260),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  event.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              if (event.isSensitive)
                const Chip(
                  avatar: Icon(Icons.lock_outline, size: 16),
                  label: Text('Hidden'),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            formatMemoryDate(event.startAt),
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
          if (event.place != null) ...[
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: scheme.primary,
                ),
                const SizedBox(width: 6),
                Expanded(child: Text(event.place!.name)),
              ],
            ),
          ],
          const SizedBox(height: 16),
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
                label: 'Rediscovery risk',
                value: event.scores.rediscoveryRisk,
                color: scheme.tertiary,
                icon: Icons.history,
              ),
              ScoreChip(
                label: 'Context',
                value: event.scores.contextCompleteness,
                color: Colors.teal,
                icon: Icons.fact_check_outlined,
              ),
              ScoreChip(
                label: 'Preservation need',
                value: event.scores.preservationNeed,
                color: Colors.deepOrange,
                icon: Icons.health_and_safety_outlined,
              ),
            ],
          ),
          if (event.scores.isIllustrative) ...[
            const SizedBox(height: 8),
            Text(
              'Demo scores • illustrative, not experimentally validated',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
          const SizedBox(height: 24),
          if (event.hasDescription) ...[
            _DetailSection(
              title: 'Event description',
              child: Text(
                event.description!,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(height: 1.5),
              ),
            ),
            const SizedBox(height: 14),
          ],
          _DetailSection(
            title: 'Personal context',
            child: event.hasStory
                ? Text(
                    event.story!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(height: 1.5),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('No personal story has been added yet.'),
                      const SizedBox(height: 10),
                      FilledButton.tonalIcon(
                        onPressed: () =>
                            context.push('/event/${event.id}/story'),
                        icon: const Icon(Icons.edit_note),
                        label: const Text('Add a short story'),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 14),
          _DetailSection(
            title: 'People',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (event.people.isEmpty)
                  const Text('No confirmed people tags.')
                else
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final person in event.people)
                        Chip(
                          avatar: const Icon(Icons.person_outline, size: 18),
                          label: Text(person.name),
                        ),
                    ],
                  ),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () => context.push('/event/${event.id}/people'),
                  icon: const Icon(Icons.person_add_alt),
                  label: const Text('Manage people tags'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _DetailSection(
            title: 'Voice context',
            child: Row(
              children: [
                Icon(
                  event.hasVoiceNote ? Icons.graphic_eq : Icons.mic_none,
                  color: scheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    event.hasVoiceNote
                        ? 'A private app voice note is attached.'
                        : 'No voice note attached.',
                  ),
                ),
                TextButton(
                  onPressed: () => context.push('/event/${event.id}/voice'),
                  child: Text(event.hasVoiceNote ? 'Replace' : 'Record'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _DetailSection(
            title: 'Why this score?',
            child: Column(
              children: [
                ...event.scores.significanceFactors.map(
                  (factor) => _FactorTile(
                    icon: Icons.star_outline,
                    title: factor.label,
                    subtitle: factor.explanation,
                    contribution: factor.contribution,
                  ),
                ),
                ...event.scores.rediscoveryFactors.map(
                  (factor) => _FactorTile(
                    icon: Icons.history,
                    title: factor.label,
                    subtitle: factor.explanation,
                    contribution: factor.contribution,
                  ),
                ),
                ...event.scores.contextFactors.map(
                  (factor) => _FactorTile(
                    icon: Icons.fact_check_outlined,
                    title: factor.label,
                    subtitle: factor.explanation,
                    contribution: factor.contribution,
                  ),
                ),
                if (event.scores.significanceFactors.isEmpty)
                  const Text(
                    'Scores are deterministic weighted estimates based on your interactions. They do not detect emotion or biological forgetting.',
                  ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: () => context.push('/event/${event.id}/edit'),
            icon: const Icon(Icons.tune),
            label: const Text('Correct this generated event'),
          ),
        ],
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _FactorTile extends StatelessWidget {
  const _FactorTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.contribution,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final double contribution;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text('+${(contribution * 100).round()}%'),
    );
  }
}
