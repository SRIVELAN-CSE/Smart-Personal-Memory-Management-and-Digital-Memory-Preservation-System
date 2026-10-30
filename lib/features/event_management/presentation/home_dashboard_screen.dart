import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_navigation.dart';
import '../../../core/widgets/section_header.dart';
import '../../timeline/presentation/widgets/memory_event_card.dart';
import 'memory_controller.dart';

class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(memoryControllerProvider);
    if (state.isRestoring || state.restoreFailed) {
      return AppNavigation(
        selectedIndex: 0,
        title: 'Smart Memory',
        child: Center(
          child: state.isRestoring
              ? const CircularProgressIndicator()
              : const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Your saved library is still on this device. '
                    'Retry loading it before scanning or editing memories.',
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
      );
    }
    final events = state.events;
    final pending = state.recommendations
        .where((item) => item.status.name == 'pending')
        .length;
    final important = events
        .where((event) => event.scores.significance >= 0.7)
        .length;
    final highRisk = events
        .where((event) => event.scores.rediscoveryRisk >= 0.6)
        .length;
    final incomplete = events
        .where((event) => event.scores.contextCompleteness < 0.7)
        .length;
    final capsules = state.recommendations
        .where((item) => item.scheduledFor != null)
        .length;
    return AppNavigation(
      selectedIndex: 0,
      title: 'Smart Memory',
      child: ResponsivePage(
        child: ListView(
          children: [
            if (state.demoMode)
              Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: const ListTile(
                  leading: Icon(Icons.science_outlined),
                  title: Text('Demo mode'),
                  subtitle: Text(
                    'Illustrative values are clearly marked and are not experimentally validated.',
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Text(
              'Keep the meaning alive.',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              'Review memories that are important, rarely opened, or missing personal context.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.sizeOf(context).width >= 780 ? 3 : 2,
                mainAxisExtent: 74 + MediaQuery.textScalerOf(context).scale(60),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              children: [
                _SummaryCard(
                  icon: Icons.auto_stories,
                  label: 'Total memories',
                  value: '${events.length}',
                  color: Theme.of(context).colorScheme.primary,
                ),
                _SummaryCard(
                  icon: Icons.auto_awesome,
                  label: 'Detected events',
                  value: '${events.length}',
                  color: Theme.of(context).colorScheme.secondary,
                ),
                _SummaryCard(
                  icon: Icons.star,
                  label: 'Important',
                  value: '$important',
                  color: Colors.amber.shade800,
                ),
                _SummaryCard(
                  icon: Icons.history,
                  label: 'High rediscovery risk',
                  value: '$highRisk',
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                _SummaryCard(
                  icon: Icons.edit_note,
                  label: 'Incomplete context',
                  value: '$incomplete',
                  color: Colors.indigo,
                ),
                _SummaryCard(
                  icon: Icons.schedule_send,
                  label: 'Upcoming capsules',
                  value: '$capsules',
                  color: Colors.teal,
                ),
              ],
            ),
            const SizedBox(height: 28),
            const SectionHeader(
              title: 'Quick actions',
              subtitle:
                  'Everything runs locally unless you explicitly choose otherwise.',
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _QuickAction(
                  icon: Icons.add_photo_alternate_outlined,
                  label: 'Scan gallery',
                  onTap: () => context.push('/scan'),
                ),
                _QuickAction(
                  icon: Icons.auto_stories_outlined,
                  label: 'Open timeline',
                  onTap: () => context.go('/timeline'),
                ),
                _QuickAction(
                  icon: Icons.hub_outlined,
                  label: 'Memory graph',
                  onTap: () => context.go('/graph'),
                ),
                _QuickAction(
                  icon: Icons.lightbulb_outline,
                  label: 'Review $pending',
                  onTap: () => context.go('/recommendations'),
                ),
              ],
            ),
            const SizedBox(height: 28),
            SectionHeader(
              title: 'Memory needing attention',
              subtitle: pending == 0
                  ? 'No pending recommendations.'
                  : '$pending explainable recommendation${pending == 1 ? '' : 's'} waiting',
              trailing: TextButton(
                onPressed: () => context.go('/recommendations'),
                child: const Text('See all'),
              ),
            ),
            const SizedBox(height: 12),
            if (events.isEmpty)
              _EmptyDashboard(
                onDemo: () => ref
                    .read(memoryControllerProvider.notifier)
                    .enableDemoMode(),
                onScan: () => context.push('/scan'),
              )
            else
              MemoryEventCard(
                event: events.reduce(
                  (a, b) =>
                      a.scores.preservationNeed >= b.scores.preservationNeed
                      ? a
                      : b,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const Spacer(),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    );
  }
}

class _EmptyDashboard extends StatelessWidget {
  const _EmptyDashboard({required this.onDemo, required this.onScan});

  final VoidCallback onDemo;
  final VoidCallback onScan;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.photo_album_outlined, size: 54),
            const SizedBox(height: 12),
            const Text('No derived memories yet.'),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              children: [
                FilledButton(
                  onPressed: onScan,
                  child: const Text('Scan gallery'),
                ),
                OutlinedButton(
                  onPressed: onDemo,
                  child: const Text('Load demo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
