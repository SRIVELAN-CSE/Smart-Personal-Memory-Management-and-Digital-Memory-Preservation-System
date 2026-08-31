import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  @override
  PrivacySettings build() => const PrivacySettings();

  void setThemeMode(ThemeMode mode) => state = state.copyWith(themeMode: mode);

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
