import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../event_management/presentation/memory_controller.dart';
import '../../reminders/presentation/reminder_providers.dart';

class DataManagementScreen extends ConsumerWidget {
  const DataManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(memoryControllerProvider);
    final mediaReferences = state.events.fold<int>(
      state.unassignedMedia.length,
      (total, event) => total + event.media.length,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Data management')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Local derived data',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.auto_stories_outlined),
                  title: const Text('Event records'),
                  trailing: Text('${state.events.length}'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.link),
                  title: const Text('Gallery asset references'),
                  trailing: Text('$mediaReferences'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.lightbulb_outline),
                  title: const Text('Recommendations'),
                  trailing: Text('${state.recommendations.length}'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.photo_library_outlined),
            title: Text('Original gallery media'),
            subtitle: Text(
              'Not owned by Smart Memory and never deleted by this screen.',
            ),
          ),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.storage_outlined),
            title: Text('SQLite contents'),
            subtitle: Text(
              'Asset identifiers, metadata, OCR text, graph projections, score factors, reminders, and user-entered context. Original image bytes are never stored.',
            ),
          ),
          const SizedBox(height: 26),
          FilledButton.tonalIcon(
            style: FilledButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const Icon(Icons.warning_amber_rounded),
                  title: const Text('Delete all derived data?'),
                  content: const Text(
                    'This clears Smart Memory events, references, OCR text, people, notes, voice-note records, scores, graph data, recommendations, and reminders. Original gallery photos and videos remain unchanged.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Delete derived data'),
                    ),
                  ],
                ),
              );
              if (confirmed != true) return;
              try {
                await ref.read(notificationGatewayProvider).cancelAll();
              } on Object {
                // Database and file deletion remain available even when the
                // platform notification service cannot be reached.
              }
              final deleted = await ref
                  .read(memoryControllerProvider.notifier)
                  .deleteAllDerivedData();
              if (!context.mounted) return;
              if (!deleted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Data could not be cleared. Your memories are still available.',
                    ),
                  ),
                );
                return;
              }
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Derived app data cleared. Gallery originals were not changed.',
                    ),
                  ),
                );
                context.go('/home');
              }
            },
            icon: const Icon(Icons.delete_forever_outlined),
            label: const Text('Delete all derived app data'),
          ),
        ],
      ),
    );
  }
}
