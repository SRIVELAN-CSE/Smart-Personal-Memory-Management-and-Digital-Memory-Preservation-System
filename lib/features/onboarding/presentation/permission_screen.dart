import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../event_management/presentation/memory_controller.dart';
import '../../media_import/domain/media_import_gateway.dart';

class PermissionScreen extends ConsumerWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(memoryControllerProvider);
    final busy = state.scanState == ScanState.requestingPermission;
    return Scaffold(
      appBar: AppBar(title: const Text('Your gallery, your choice')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 72,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 22),
            Text(
              'Allow selected media access',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            Text(
              'Smart Memory needs read access to the photos and videos you choose. It stores asset references and derived metadata—never full original files in SQLite.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 28),
            const _PermissionReason(
              icon: Icons.calendar_month_outlined,
              title: 'Capture dates',
              body:
                  'Build a chronological story without manual calendar events.',
            ),
            const _PermissionReason(
              icon: Icons.text_snippet_outlined,
              title: 'On-device OCR',
              body: 'Use visible text as a supporting grouping signal.',
            ),
            const _PermissionReason(
              icon: Icons.location_on_outlined,
              title: 'Embedded locations',
              body: 'Read media location metadata only when it is available.',
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'No upload is performed. Cloud backup is disabled. Permission denial is safe and demo mode stays available.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state.errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                state.errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: busy
                  ? null
                  : () async {
                      final access = await ref
                          .read(memoryControllerProvider.notifier)
                          .requestGalleryAccess();
                      if (!context.mounted) return;
                      if (access == GalleryAccess.denied) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Gallery permission was not granted. You can still use demo mode.',
                            ),
                          ),
                        );
                      } else {
                        context.go('/scan');
                      }
                    },
              icon: busy
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.add_photo_alternate_outlined),
              label: const Text('Choose photos and continue'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: busy
                  ? null
                  : () async {
                      await ref
                          .read(memoryControllerProvider.notifier)
                          .enableDemoMode();
                      if (context.mounted) context.go('/home');
                    },
              icon: const Icon(Icons.science_outlined),
              label: const Text('Explore with demo data'),
            ),
            TextButton(
              onPressed: () => context.push('/privacy'),
              child: const Text('Read privacy controls'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PermissionReason extends StatelessWidget {
  const _PermissionReason({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(child: Icon(icon)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(body),
    );
  }
}
