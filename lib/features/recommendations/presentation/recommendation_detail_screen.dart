import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/memory_models.dart';
import '../../../core/widgets/score_chip.dart';
import '../../event_management/presentation/memory_controller.dart';

class RecommendationDetailScreen extends ConsumerWidget {
  const RecommendationDetailScreen({required this.recommendationId, super.key});

  final String recommendationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(memoryControllerProvider);
    final item = state.recommendations
        .where((value) => value.id == recommendationId)
        .firstOrNull;
    if (item == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Recommendation not found')),
      );
    }
    final event = state.events
        .where((value) => value.id == item.eventId)
        .firstOrNull;
    if (event == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Related event not found')),
      );
    }
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Why this needs attention')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Icon(
            Icons.health_and_safety_outlined,
            size: 64,
            color: scheme.primary,
          ),
          const SizedBox(height: 18),
          Text(
            item.title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            event.title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 20),
          Card(
            color: scheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                item.explanation,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(height: 1.55),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ScoreChip(
                label: 'Significance',
                value: event.scores.significance,
                color: scheme.primary,
              ),
              ScoreChip(
                label: 'Risk',
                value: event.scores.rediscoveryRisk,
                color: scheme.tertiary,
              ),
              ScoreChip(
                label: 'Context',
                value: event.scores.contextCompleteness,
                color: Colors.teal,
              ),
              ScoreChip(
                label: 'Final need',
                value: event.scores.preservationNeed,
                color: Colors.deepOrange,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Preservation need = significance × rediscovery risk × (1 − context completeness) × (1 − sensitivity).',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => context.push('/event/${event.id}/voice'),
            icon: const Icon(Icons.mic_none),
            label: const Text('Record a voice note'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => context.push('/event/${event.id}/story'),
            icon: const Icon(Icons.edit_note),
            label: const Text('Write a short story'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => context.push('/event/${event.id}/people'),
            icon: const Icon(Icons.person_add_alt),
            label: const Text('Tag people'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => context.push('/recommendation/${item.id}/capsule'),
            icon: const Icon(Icons.schedule_send),
            label: const Text('Create time capsule'),
          ),
          const SizedBox(height: 12),
          Text(
            'Was this recommendation useful?',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                selected: item.feedback == RecommendationFeedback.helpful,
                avatar: const Icon(Icons.thumb_up_outlined, size: 18),
                label: const Text('Helpful'),
                onSelected: (_) {
                  ref
                      .read(memoryControllerProvider.notifier)
                      .submitRecommendationFeedback(
                        item.id,
                        RecommendationFeedback.helpful,
                      );
                },
              ),
              ChoiceChip(
                selected: item.feedback == RecommendationFeedback.notHelpful,
                avatar: const Icon(Icons.thumb_down_outlined, size: 18),
                label: const Text('Not helpful'),
                onSelected: (_) {
                  ref
                      .read(memoryControllerProvider.notifier)
                      .submitRecommendationFeedback(
                        item.id,
                        RecommendationFeedback.notHelpful,
                      );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              ref
                  .read(memoryControllerProvider.notifier)
                  .dismissRecommendation(item.id);
              context.pop();
            },
            child: const Text('Dismiss this suggestion'),
          ),
          const SizedBox(height: 14),
          Text(
            'This estimate describes app usage only. It does not detect emotion and does not predict biological forgetting.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
