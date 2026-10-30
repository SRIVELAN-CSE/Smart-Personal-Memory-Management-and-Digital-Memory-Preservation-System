import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/services/device_media_service.dart';
import 'package:smart_memory_preservation/core/widgets/voice_note_player.dart';
import 'package:smart_memory_preservation/features/event_management/presentation/event_media_gallery.dart';
import '../support/library_fixture.dart';

void main() {
  final calls = <MethodCall>[];
  setUp(() {
    calls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(DeviceMediaService.channel, (call) async {
          calls.add(call);
          if (call.method == 'audioStatus') {
            return {'playing': true, 'position': 1000, 'duration': 4000};
          }
          return null;
        });
  });
  tearDown(
    () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(DeviceMediaService.channel, null),
  );

  testWidgets(
    'play and pause use attached file; replacement stops the previous player',
    (tester) async {
      Future<void> mount(String path) => tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: VoiceNotePlayer(path: path)),
        ),
      );
      await mount('/app/first.m4a');
      await tester.tap(find.byTooltip('Play voice note'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 310));
      expect(calls.first.method, 'audioPlay');
      expect(calls.first.arguments, {'path': '/app/first.m4a'});
      expect(find.text('0:01 / 0:04'), findsOneWidget);
      await tester.tap(find.byTooltip('Pause voice note'));
      await tester.pump();
      expect(calls.last.method, 'audioPause');
      await mount('/app/replacement.m4a');
      await tester.pump();
      expect(calls.last.method, 'audioStop');
      await tester.tap(find.byTooltip('Play voice note'));
      await tester.pump();
      expect(calls.last.arguments, {'path': '/app/replacement.m4a'});
      await tester.pumpWidget(const SizedBox());
      await tester.pump();
      expect(calls.last.method, 'audioStop');
    },
  );

  testWidgets('gallery shares exactly the selected originals', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: EventMediaGallery(event: libraryFixture().events.single),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Select & share'));
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Photo 1'));
    await tester.pump();
    await tester.tap(find.text('Share selected'));
    await tester.pumpAndSettle();
    final shared = calls.singleWhere((c) => c.method == 'share');
    expect(shared.arguments, {
      'media': [
        {'id': 'saved_asset_0', 'video': false},
      ],
    });
    expect(tester.takeException(), isNull);
  });
}
