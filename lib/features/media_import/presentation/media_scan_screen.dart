import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../event_management/presentation/memory_controller.dart';
import '../domain/media_import_gateway.dart';

final _resolvePlaceNamesProvider = StateProvider<bool>((ref) => false);
final _recheckLocationsProvider = StateProvider<bool>((ref) => false);

class MediaScanScreen extends ConsumerWidget {
  const MediaScanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(memoryControllerProvider);
    final resolveNames = ref.watch(_resolvePlaceNamesProvider);
    final recheckLocations = ref.watch(_recheckLocationsProvider);
    final scanning = state.scanState == ScanState.scanning;
    final complete = state.scanState == ScanState.completed;
    final blocked = scanning || state.isRestoring || state.restoreFailed;
    return Scaffold(
      appBar: AppBar(title: const Text('Scan gallery')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: ListView(
              padding: const EdgeInsets.all(28),
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Icon(
                    complete ? Icons.check_rounded : Icons.manage_search,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  complete
                      ? 'On-device scan complete'
                      : 'Turn media into event suggestions',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  scanning || complete
                      ? state.scanStage
                      : 'Read capture metadata and clearer image previews on this device. Original photos and videos remain unchanged in the gallery.',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(height: 1.5),
                ),
                const SizedBox(height: 28),
                LinearProgressIndicator(
                  value: scanning || complete ? state.scanProgress : 0,
                ),
                const SizedBox(height: 10),
                Text(
                  scanning
                      ? '${(state.scanProgress * 100).round()}%'
                      : complete
                      ? '100%'
                      : 'Ready',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const _PipelineStep(
                  icon: Icons.info_outline,
                  label: 'Read capture metadata',
                ),
                const _PipelineStep(
                  icon: Icons.text_snippet_outlined,
                  label: 'Recognize useful text on-device',
                ),
                const _PipelineStep(
                  icon: Icons.fingerprint,
                  label: 'Create thumbnail duplicate fingerprints',
                ),
                const _PipelineStep(
                  icon: Icons.account_tree_outlined,
                  label: 'Apply explainable hybrid clustering',
                ),
                if (!scanning) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About photo locations',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Camera media has a capture location only when GPS was saved. Downloads, movies, screenshots and recordings usually have none. You can add a place inside any event.',
                          ),
                          TextButton(
                            onPressed: blocked
                                ? null
                                : () => ref
                                      .read(memoryControllerProvider.notifier)
                                      .requestGalleryAccess(),
                            child: const Text(
                              'Review gallery & location access',
                            ),
                          ),
                          if (state.events.isNotEmpty)
                            Text(
                              '${state.events.expand((e) => e.media).where((m) => m.captureLocation != null).length} media items have saved GPS in this library.',
                            ),
                        ],
                      ),
                    ),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Look up place names (optional)'),
                    subtitle: const Text(
                      'The device service may send photo coordinates to its provider. Photos are never uploaded. Offline scans keep coordinates.',
                    ),
                    value: resolveNames,
                    onChanged: blocked
                        ? null
                        : (value) =>
                              ref
                                      .read(_resolvePlaceNamesProvider.notifier)
                                      .state =
                                  value,
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Recheck missing photo locations'),
                    subtitle: const Text(
                      'Use after changing photo permissions or restoring originals.',
                    ),
                    value: recheckLocations,
                    onChanged: blocked
                        ? null
                        : (value) =>
                              ref
                                      .read(_recheckLocationsProvider.notifier)
                                      .state =
                                  value ?? false,
                  ),
                ],
                if (state.errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Card(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        state.errorMessage!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 26),
                if (!complete)
                  FilledButton.icon(
                    onPressed: blocked
                        ? null
                        : () => ref
                              .read(memoryControllerProvider.notifier)
                              .scanGallery(
                                resolvePlaceNames: resolveNames,
                                recheckLocations: recheckLocations,
                              ),
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: Text(
                      scanning ? 'Scanning privately…' : 'Start on-device scan',
                    ),
                  )
                else
                  FilledButton.icon(
                    onPressed: () => context.go('/timeline'),
                    icon: const Icon(Icons.auto_stories_outlined),
                    label: const Text('Open story timeline'),
                  ),
                if (!blocked && state.galleryAccess == GalleryAccess.denied)
                  OutlinedButton.icon(
                    onPressed: () async {
                      final controller = ref.read(
                        memoryControllerProvider.notifier,
                      );
                      final access = await controller.requestGalleryAccess();
                      if (access != GalleryAccess.denied) {
                        await controller.scanGallery(
                          resolvePlaceNames: resolveNames,
                          recheckLocations: recheckLocations,
                        );
                      }
                    },
                    icon: const Icon(Icons.photo_library_outlined),
                    label: const Text('Allow photo access'),
                  ),
                if (complete)
                  OutlinedButton.icon(
                    onPressed: () => ref
                        .read(memoryControllerProvider.notifier)
                        .scanGallery(
                          resolvePlaceNames: resolveNames,
                          recheckLocations: recheckLocations,
                        ),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Scan for new photos'),
                  ),
                if (state.galleryAccess == GalleryAccess.limited)
                  OutlinedButton.icon(
                    onPressed: blocked
                        ? null
                        : () => ref
                              .read(memoryControllerProvider.notifier)
                              .manageLimitedSelection(),
                    icon: const Icon(Icons.photo_library_outlined),
                    label: const Text('Change selected photos'),
                  ),
                TextButton(
                  onPressed: scanning ? null : () => context.go('/home'),
                  child: const Text('Return to dashboard'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PipelineStep extends StatelessWidget {
  const _PipelineStep({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(label),
      dense: true,
    );
  }
}
