import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/app.dart';
import 'package:smart_memory_preservation/core/security/device_security_service.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';
import 'package:smart_memory_preservation/features/event_management/data/demo_memory_data.dart';
import 'package:smart_memory_preservation/features/event_management/data/voice_recording_service.dart';
import 'package:smart_memory_preservation/features/event_management/presentation/memory_controller.dart';
import 'package:smart_memory_preservation/features/privacy/presentation/privacy_controller.dart';
import 'package:smart_memory_preservation/features/reminders/domain/notification_gateway.dart';
import 'package:smart_memory_preservation/features/reminders/presentation/reminder_providers.dart';
import 'package:smart_memory_preservation/routing/app_router.dart';

void main() {
  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('smart_memory/device_media'),
          (_) async => null,
        );
  });
  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('smart_memory/device_media'),
          null,
        );
  });
  late ProviderContainer container;
  late _Security security;
  late _Voice voice;
  late _Notifications notifications;
  Future<void> mount(WidgetTester tester, {MemoryAppState? state}) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    security = _Security();
    voice = _Voice();
    notifications = _Notifications();
    container = ProviderContainer(
      overrides: [
        memoryControllerProvider.overrideWith(
          () => _Memory(
            state ??
                MemoryAppState(
                  events: [DemoMemoryData.event],
                  recommendations: [DemoMemoryData.recommendation],
                  demoMode: true,
                ),
          ),
        ),
        deviceSecurityServiceProvider.overrideWithValue(security),
        voiceRecordingFactoryProvider.overrideWithValue(() => voice),
        notificationGatewayProvider.overrideWithValue(notifications),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const SmartMemoryApp(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();
  }

  testWidgets(
    'saved library opens dashboard and every main screen fits a small phone',
    (tester) async {
      await mount(tester);
      final router = container.read(appRouterProvider);
      expect(router.routeInformationProvider.value.uri.path, '/home');
      final id = DemoMemoryData.event.id;
      final recommendation = DemoMemoryData.recommendation.id;
      for (final route in [
        '/timeline',
        '/chat',
        '/event/$id',
        '/event/$id/edit',
        '/event/$id/people',
        '/event/$id/story',
        '/event/$id/voice',
        '/graph',
        '/recommendations',
        '/recommendation/$recommendation',
        '/recommendation/$recommendation/capsule',
        '/privacy',
        '/data-management',
        '/about',
        '/scan',
        '/onboarding',
        '/permissions',
        '/event/missing',
        '/recommendation/missing',
        '/unknown',
      ]) {
        router.go(route);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: route);
      }
      await container
          .read(privacyControllerProvider.notifier)
          .setThemeMode(ThemeMode.dark);
      for (final route in [
        '/home',
        '/timeline',
        '/graph',
        '/recommendations',
        '/chat',
        '/event/$id',
        '/event/$id/edit',
        '/event/$id/story',
        '/event/$id/voice',
      ]) {
        router.go(route);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: 'dark: $route');
      }
    },
  );

  testWidgets('new installation opens onboarding', (tester) async {
    await mount(tester, state: const MemoryAppState());
    expect(
      container.read(appRouterProvider).routeInformationProvider.value.uri.path,
      '/onboarding',
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'restore failure presents retry instead of an empty gallery prompt',
    (tester) async {
      await mount(
        tester,
        state: const MemoryAppState(
          restoreFailed: true,
          errorMessage: 'Saved library could not be opened.',
        ),
      );
      expect(
        container
            .read(appRouterProvider)
            .routeInformationProvider
            .value
            .uri
            .path,
        '/home',
      );
      expect(find.text('Retry loading memories'), findsOneWidget);
      expect(
        find.textContaining('Your saved library is still on this device'),
        findsOneWidget,
      );
      container.read(appRouterProvider).go('/scan');
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.text('Start on-device scan'), 300);
      final button = tester.widget<ButtonStyleButton>(
        find
            .ancestor(
              of: find.text('Start on-device scan'),
              matching: find.byWidgetPredicate(
                (widget) => widget is ButtonStyleButton,
              ),
            )
            .first,
      );
      expect(button.onPressed, isNull);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'microphone denial and recording failure are handled, then recording succeeds',
    (tester) async {
      await mount(tester);
      container
          .read(appRouterProvider)
          .go('/event/${DemoMemoryData.event.id}/voice');
      await tester.pumpAndSettle();
      voice.allowed = false;
      await tester.tap(find.text('Start recording'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Microphone permission was denied'),
        findsOneWidget,
      );
      voice.allowed = true;
      voice.failStart = true;
      await tester.tap(find.text('Start recording'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Recording could not be completed'),
        findsOneWidget,
      );
      voice.failStart = false;
      await tester.tap(find.text('Start recording'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 2));
      expect(find.text('00:02'), findsOneWidget);
      await tester.tap(find.text('Stop and attach'));
      await tester.pumpAndSettle();
      expect(
        container.read(memoryControllerProvider).events.single.voiceNotePath,
        '/test/voice.m4a',
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('notification denial does not mark a capsule scheduled', (
    tester,
  ) async {
    await mount(tester);
    final router = container.read(appRouterProvider);
    final id = DemoMemoryData.recommendation.id;
    router.go('/recommendation/$id/capsule');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Choose a date'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Schedule neutral reminder'));
    await tester.tap(find.text('Schedule neutral reminder'));
    await tester.pumpAndSettle();
    expect(notifications.calls, 1);
    expect(
      container
          .read(memoryControllerProvider)
          .recommendations
          .single
          .scheduledFor,
      isNull,
    );
    expect(
      find.textContaining('Notification permission was denied'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('granted notifications save the chosen capsule date', (
    tester,
  ) async {
    await mount(tester);
    notifications.allowed = true;
    final id = DemoMemoryData.recommendation.id;
    container.read(appRouterProvider).go('/recommendation/$id/capsule');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Choose a date'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Schedule neutral reminder'));
    await tester.tap(find.text('Schedule neutral reminder'));
    await tester.pumpAndSettle();
    final item = container
        .read(memoryControllerProvider)
        .recommendations
        .single;
    expect(item.scheduledFor, isNotNull);
    expect(item.status, RecommendationStatus.completed);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'theme choice is saved and restored after restarting the controller',
    (tester) async {
      await mount(tester);
      await container
          .read(privacyControllerProvider.notifier)
          .setThemeMode(ThemeMode.dark);
      expect(security.theme, 'dark');
      container.invalidate(privacyControllerProvider);
      await tester.pumpAndSettle();
      expect(
        container.read(privacyControllerProvider).themeMode,
        ThemeMode.dark,
      );
      expect(tester.takeException(), isNull);
    },
  );
}

class _Memory extends MemoryController {
  _Memory(this.initial);
  final MemoryAppState initial;
  @override
  MemoryAppState build() => initial;
}

class _Security extends DeviceSecurityService {
  String? theme;
  @override
  Future<bool> isBiometricGateEnabled() async => false;
  @override
  Future<String?> readThemePreference() async => theme;
  @override
  Future<void> saveThemePreference(String mode) async {
    theme = mode;
  }
}

class _Voice implements VoiceRecordingService {
  bool allowed = true, failStart = false;
  @override
  Future<bool> hasPermission() async => allowed;
  @override
  Future<void> start(String eventId) async {
    if (failStart) throw StateError('simulated recorder failure');
  }

  @override
  Future<String?> stop() async => '/test/voice.m4a';
  @override
  Future<void> dispose() async {}
}

class _Notifications implements NotificationGateway {
  int calls = 0;
  bool allowed = false;
  @override
  Future<bool> scheduleNeutralReminder({
    required int id,
    required DateTime scheduledFor,
    required String eventId,
  }) async {
    calls++;
    return allowed;
  }

  @override
  Future<void> cancelAll() async {}
}
