import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/event_management/presentation/memory_controller.dart';

class LibraryStatusBanner extends ConsumerWidget {
  const LibraryStatusBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(memoryControllerProvider);
    if (!state.restoreFailed && !state.saveFailed) {
      return const SizedBox.shrink();
    }
    return Material(
      color: Theme.of(context).colorScheme.errorContainer,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(state.errorMessage ?? 'The saved library is unavailable.'),
              TextButton.icon(
                onPressed: state.isRestoring
                    ? null
                    : () {
                        final controller = ref.read(
                          memoryControllerProvider.notifier,
                        );
                        if (state.restoreFailed) {
                          controller.retryRestore();
                        } else {
                          controller.retrySave();
                        }
                      },
                icon: const Icon(Icons.refresh),
                label: Text(
                  state.restoreFailed
                      ? 'Retry loading memories'
                      : 'Retry saving',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
