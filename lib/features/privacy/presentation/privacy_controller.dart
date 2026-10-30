import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/security/device_security_service.dart';

class PrivacySettings {
  const PrivacySettings({
    this.themeMode = ThemeMode.system,
    this.biometricLock = false,
    this.neutralNotifications = true,
    this.hideSensitivePreviews = true,
    this.cloudBackupEnabled = false,
  });

  final ThemeMode themeMode;
  final bool biometricLock;
  final bool neutralNotifications;
  final bool hideSensitivePreviews;
  final bool cloudBackupEnabled;

  PrivacySettings copyWith({
    ThemeMode? themeMode,
    bool? biometricLock,
    bool? neutralNotifications,
    bool? hideSensitivePreviews,
  }) {
    return PrivacySettings(
      themeMode: themeMode ?? this.themeMode,
      biometricLock: biometricLock ?? this.biometricLock,
      neutralNotifications: neutralNotifications ?? this.neutralNotifications,
      hideSensitivePreviews:
          hideSensitivePreviews ?? this.hideSensitivePreviews,
      cloudBackupEnabled: cloudBackupEnabled,
    );
  }
}

class PrivacyController extends Notifier<PrivacySettings> {
  bool _disposed = false;
  int _themeRevision = 0;

  @override
  PrivacySettings build() {
    _disposed = false;
    ref.onDispose(() => _disposed = true);
    Future<void>.microtask(() async {
      final revision = _themeRevision;
      try {
        final saved = await ref
            .read(deviceSecurityServiceProvider)
            .readThemePreference();
        if (_disposed || revision != _themeRevision) return;
        final theme = ThemeMode.values
            .where((mode) => mode.name == saved)
            .firstOrNull;
        if (theme != null) state = state.copyWith(themeMode: theme);
      } on Object {
        // Device theme remains available when preferences cannot be read.
      }
    });
    return const PrivacySettings();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final revision = ++_themeRevision;
    await ref
        .read(deviceSecurityServiceProvider)
        .saveThemePreference(mode.name);
    if (!_disposed && revision == _themeRevision) {
      state = state.copyWith(themeMode: mode);
    }
  }

  void setBiometricLock(bool value) {
    state = state.copyWith(biometricLock: value);
  }

  void setNeutralNotifications(bool value) {
    state = state.copyWith(neutralNotifications: value);
  }

  void setHideSensitivePreviews(bool value) {
    state = state.copyWith(hideSensitivePreviews: value);
  }
}

final privacyControllerProvider =
    NotifierProvider<PrivacyController, PrivacySettings>(PrivacyController.new);
