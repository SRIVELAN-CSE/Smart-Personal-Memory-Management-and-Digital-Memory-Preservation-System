import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_memory_preservation/features/chatbot/presentation/memory_companion_screen.dart';
import 'package:smart_memory_preservation/features/event_management/presentation/event_detail_screen.dart';
import 'package:smart_memory_preservation/features/event_management/presentation/memory_controller.dart';
import 'package:smart_memory_preservation/features/timeline/presentation/story_timeline_screen.dart';
import '../support/library_fixture.dart';

void main() {
  late ProviderContainer container;
  late GoRouter router;
  Future<void> mount(WidgetTester tester, String initial) async {
    tester.view.physicalSize = const Size(400, 850);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    container = ProviderContainer(
      overrides: [memoryControllerProvider.overrideWith(_Memory.new)],
    );
    router = GoRouter(
      initialLocation: initial,
      routes: [
        GoRoute(
          path: '/chat',
          builder: (_, _) => const MemoryCompanionScreen(),
        ),
        GoRoute(
          path: '/timeline',
          builder: (_, state) => StoryTimelineScreen(
            personId: state.uri.queryParameters['person'],
            location: state.uri.queryParameters['location'],
          ),
        ),
        GoRoute(
          path: '/event/:id',
          builder: (_, state) => EventDetailScreen(
            eventId: state.pathParameters['id']!,
            mediaId: state.uri.queryParameters['media'],
          ),
        ),
      ],
    );
    addTearDown(router.dispose);
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets(
    'chat links independently open event, photo, person and location',
    (tester) async {
      await mount(tester, '/chat');
      await tester.enterText(find.byType(TextField), 'photos with Asha');
      await tester.tap(find.byTooltip('Send message'));
      await tester.pumpAndSettle();
      final destinations = {
        'Saved gallery memory': '/event/saved_event',
        'Photo 2 · Saved gallery memory':
            '/event/saved_event?media=saved_photo_1',
        'Asha': '/timeline?person=saved_person',
        'Campus hall': '/timeline?location=Campus+hall',
      };
      for (final destination in destinations.entries) {
        final link = destination.key == 'Saved gallery memory'
            ? find.text(destination.key)
            : find.widgetWithText(ActionChip, destination.key);
        await tester.ensureVisible(link);
        await tester.tap(link);
        await tester.pumpAndSettle();
        expect(router.state.uri.toString(), destination.value);
        if (destination.key.startsWith('Photo')) {
          expect(find.textContaining('Selected image:'), findsOneWidget);
        }
        expect(tester.takeException(), isNull);
        router.pop();
        await tester.pumpAndSettle();
      }
      (container.read(memoryControllerProvider.notifier) as _Memory)
          .removeAll();
      await tester.pumpAndSettle();
      expect(find.text('Saved gallery memory'), findsNothing);
      expect(find.textContaining('unavailable'), findsWidgets);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'timeline debounces combined filters and independently clears them',
    (tester) async {
      await mount(tester, '/timeline?person=saved_person');
      expect(find.text('Person: Asha'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'gallery Nowhere');
      await tester.pump(const Duration(milliseconds: 310));
      await tester.pumpAndSettle();
      expect(find.text('No events match these filters.'), findsOneWidget);
      await tester.tap(find.byTooltip('Clear search'));
      await tester.pumpAndSettle();
      expect(find.text('Saved gallery memory'), findsOneWidget);
      expect(find.text('Person: Asha'), findsOneWidget);
      await tester.tap(find.text('Reset filters'));
      await tester.pumpAndSettle();
      expect(find.text('Person: Asha'), findsNothing);
      expect(find.text('Reset filters'), findsNothing);
      await tester.tap(find.byKey(const Key('timeline-filters')));
      await tester.pumpAndSettle();
      expect(find.text('Last week'), findsOneWidget);
      expect(find.text('Last month'), findsOneWidget);
      expect(find.text('Custom date range'), findsOneWidget);
      await tester.tap(find.text('Yesterday'));
      await tester.pumpAndSettle();
      expect(find.text('No events match these filters.'), findsOneWidget);
      await tester.tap(find.text('Reset filters'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Favourites'));
      await tester.pumpAndSettle();
      expect(find.text('Saved gallery memory'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}

class _Memory extends MemoryController {
  @override
  MemoryAppState build() => MemoryAppState(events: libraryFixture().events);
  @override
  void markViewed(String eventId) {}
  void removeAll() => state = const MemoryAppState();
}
