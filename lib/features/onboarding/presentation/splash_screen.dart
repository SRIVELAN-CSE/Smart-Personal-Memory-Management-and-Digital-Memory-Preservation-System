import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/security/device_security_service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  var _unlockFailed = false;

  @override
  void initState() {
    super.initState();
    _continueToApp();
  }

  Future<void> _continueToApp() async {
    setState(() => _unlockFailed = false);
    await Future<void>.delayed(const Duration(milliseconds: 650));
    final security = ref.read(deviceSecurityServiceProvider);
    final gateEnabled = await security.isBiometricGateEnabled();
    if (gateEnabled && !await security.authenticateForEntry()) {
      if (mounted) setState(() => _unlockFailed = true);
      return;
    }
    if (mounted) context.go('/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              scheme.primaryContainer,
              scheme.surface,
              scheme.tertiaryContainer,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.auto_awesome_mosaic,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Smart Memory',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Preserve the context, not just the photo.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 28),
              if (_unlockFailed) ...[
                const Icon(Icons.lock_outline, size: 34),
                const SizedBox(height: 10),
                const Text('Authentication was not completed.'),
                const SizedBox(height: 10),
                FilledButton.icon(
                  onPressed: _continueToApp,
                  icon: const Icon(Icons.fingerprint),
                  label: const Text('Try again'),
                ),
              ] else
                const SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
