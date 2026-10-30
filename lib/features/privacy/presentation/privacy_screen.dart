import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/security/device_security_service.dart';
import 'privacy_controller.dart';

class PrivacyScreen extends ConsumerWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(privacyControllerProvider);
    final persistedBiometric = ref
        .watch(biometricGateEnabledProvider)
        .when(
          data: (value) => value,
          error: (_, _) => settings.biometricLock,
          loading: () => settings.biometricLock,
        );
    final controller = ref.read(privacyControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy & security')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        children: [
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: const Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.shield_outlined, size: 38),
                  SizedBox(height: 12),
                  Text(
                    'Local-first by design',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Original photos remain in the gallery. Smart Memory stores asset references and derived metadata. OCR and scoring run on the device.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text('Protection', style: Theme.of(context).textTheme.titleLarge),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: persistedBiometric,
            title: const Text('Optional biometric access gate'),
            subtitle: const Text(
              'Protects app entry when supported. It is not database encryption.',
            ),
            secondary: const Icon(Icons.fingerprint),
            onChanged: (value) async {
              if (value) {
                try {
                  final enabled = await ref
                      .read(deviceSecurityServiceProvider)
                      .enableBiometricGate();
                  if (enabled) {
                    controller.setBiometricLock(true);
                    ref.invalidate(biometricGateEnabledProvider);
                  } else if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Biometric or device authentication is unavailable.',
                        ),
                      ),
                    );
                  }
                } on Object catch (error) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Could not enable the access gate: $error',
                        ),
                      ),
                    );
                  }
                }
              } else {
                try {
                  await ref
                      .read(deviceSecurityServiceProvider)
                      .disableBiometricGate();
                  if (!context.mounted) return;
                  controller.setBiometricLock(false);
                  ref.invalidate(biometricGateEnabledProvider);
                } on Object {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Could not update the access gate. Please try again.',
                        ),
                      ),
                    );
                  }
                }
              }
            },
          ),
          const SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: true,
            title: Text('Hide sensitive previews'),
            subtitle: Text(
              'Sensitive events use a concealed cover and are suppressed from recommendations.',
            ),
            secondary: Icon(Icons.visibility_off_outlined),
            onChanged: null,
          ),
          const SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: true,
            onChanged: null,
            title: Text('Neutral lock-screen wording'),
            subtitle: Text(
              'Notifications never include event titles, names, places, OCR text, or previews.',
            ),
            secondary: Icon(Icons.notifications_active_outlined),
          ),
          const Divider(height: 32),
          Text('Appearance', style: Theme.of(context).textTheme.titleLarge),
          RadioGroup<ThemeMode>(
            groupValue: settings.themeMode,
            onChanged: (value) async {
              if (value == null) return;
              try {
                await controller.setThemeMode(value);
              } on Object {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Could not save the appearance setting. Please try again.',
                      ),
                    ),
                  );
                }
              }
            },
            child: const Column(
              children: [
                RadioListTile<ThemeMode>(
                  contentPadding: EdgeInsets.zero,
                  value: ThemeMode.system,
                  title: Text('Use device theme'),
                ),
                RadioListTile<ThemeMode>(
                  contentPadding: EdgeInsets.zero,
                  value: ThemeMode.light,
                  title: Text('Light'),
                ),
                RadioListTile<ThemeMode>(
                  contentPadding: EdgeInsets.zero,
                  value: ThemeMode.dark,
                  title: Text('Dark'),
                ),
              ],
            ),
          ),
          const Divider(height: 32),
          Text(
            'Data boundaries',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.cloud_off_outlined),
            title: Text('Cloud backup disabled'),
            subtitle: Text(
              'No media, OCR text, names, notes, or scores are uploaded.',
            ),
          ),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.lock_outline),
            title: Text('Secure values'),
            subtitle: Text(
              'Small security preferences use platform secure storage. The ordinary Drift database is not claimed to be encrypted.',
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.delete_sweep_outlined),
            title: const Text('Data management'),
            subtitle: const Text('Inspect and delete all derived app data.'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/data-management'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.science_outlined),
            title: const Text('Methodology & limitations'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/about'),
          ),
        ],
      ),
    );
  }
}
