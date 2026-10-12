import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final deviceSecurityServiceProvider = Provider<DeviceSecurityService>(
  (ref) => DeviceSecurityService(),
);

final biometricGateEnabledProvider = FutureProvider<bool>((ref) async {
  return ref.watch(deviceSecurityServiceProvider).isBiometricGateEnabled();
});

class DeviceSecurityService {
  DeviceSecurityService({
    LocalAuthentication? authentication,
    FlutterSecureStorage? secureStorage,
  }) : _authentication = authentication ?? LocalAuthentication(),
       _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final LocalAuthentication _authentication;
  final FlutterSecureStorage _secureStorage;

  Future<String?> readThemePreference() =>
      _secureStorage.read(key: 'theme_mode');

  Future<void> saveThemePreference(String mode) =>
      _secureStorage.write(key: 'theme_mode', value: mode);

  Future<bool> isBiometricGateEnabled() async {
    try {
      return await _secureStorage.read(key: 'biometric_gate_enabled') == 'true';
    } on Object {
      return false;
    }
  }

  Future<bool> authenticateForEntry() async {
    try {
      if (!await _authentication.isDeviceSupported()) return false;
      return _authentication.authenticate(
        localizedReason: 'Unlock Smart Memory',
        persistAcrossBackgrounding: true,
      );
    } on Object {
      return false;
    }
  }

  Future<bool> enableBiometricGate() async {
    if (!await _authentication.isDeviceSupported()) return false;
    final authenticated = await _authentication.authenticate(
      localizedReason: 'Authenticate to protect Smart Memory',
      persistAcrossBackgrounding: true,
    );
    if (authenticated) {
      await _secureStorage.write(key: 'biometric_gate_enabled', value: 'true');
    }
    return authenticated;
  }

  Future<void> disableBiometricGate() async {
    await _secureStorage.write(key: 'biometric_gate_enabled', value: 'false');
  }
}
