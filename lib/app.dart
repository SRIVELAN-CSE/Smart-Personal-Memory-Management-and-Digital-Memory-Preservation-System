import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'core/widgets/library_status_banner.dart';
import 'features/privacy/presentation/privacy_controller.dart';
import 'routing/app_router.dart';

class SmartMemoryApp extends ConsumerWidget {
  const SmartMemoryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(
      privacyControllerProvider.select((settings) => settings.themeMode),
    );
    return MaterialApp.router(
      title: 'Smart Memory',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: ref.watch(appRouterProvider),
      builder: (context, child) => Column(
        children: [
          const LibraryStatusBanner(),
          Expanded(child: child ?? const SizedBox.shrink()),
        ],
      ),
    );
  }
}
