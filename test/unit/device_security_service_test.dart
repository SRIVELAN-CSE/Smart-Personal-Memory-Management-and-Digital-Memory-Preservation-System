import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:smart_memory_preservation/core/security/device_security_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('an asynchronous authentication failure safely denies entry', () async {
    final authentication = _Authentication(fail: true);
    final service = DeviceSecurityService(authentication: authentication);

    await expectLater(service.authenticateForEntry(), completion(isFalse));
    expect(authentication.requested, isTrue);
  });

  test('successful authentication still allows entry', () async {
    final service = DeviceSecurityService(
      authentication: _Authentication(fail: false),
    );

    await expectLater(service.authenticateForEntry(), completion(isTrue));
  });
}

class _Authentication extends LocalAuthentication {
  _Authentication({required this.fail});

  final bool fail;
  bool requested = false;

  @override
  Future<bool> isDeviceSupported() async => true;

  @override
  Future<bool> authenticate({
    required String localizedReason,
    Iterable<Object> authMessages = const [],
    bool biometricOnly = false,
    bool sensitiveTransaction = true,
    bool persistAcrossBackgrounding = false,
  }) async {
    requested = true;
    await Future<void>.delayed(Duration.zero);
    if (fail) throw PlatformException(code: 'authentication_unavailable');
    return true;
  }
}
