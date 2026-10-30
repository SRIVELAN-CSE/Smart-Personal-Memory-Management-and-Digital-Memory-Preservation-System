import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/models/capture_location.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';
import 'package:smart_memory_preservation/core/widgets/memory_location.dart';
import 'package:smart_memory_preservation/features/event_management/data/demo_memory_data.dart';
import 'package:smart_memory_preservation/features/event_management/presentation/event_detail_screen.dart';
import 'package:smart_memory_preservation/features/event_management/presentation/memory_controller.dart';
import 'package:smart_memory_preservation/features/memory_graph/presentation/memory_graph_screen.dart';
import 'package:smart_memory_preservation/features/timeline/presentation/widgets/memory_event_card.dart';

void main() {
  final demo = DemoMemoryData.event;
  final located = demo.copyWith(
    clearPlace: true,
    media: [
      demo.media.first.withCaptureLocation(
        CaptureLocation.fromCoordinates(10.96, 78.08)!,
      ),
      demo.media[1],
    ],
  );
  final named = located.copyWith(
    place: const MemoryPlace(
      id: 'karur',
      name: 'Karur, Tamil Nadu, India',
      latitude: 10.96,
      longitude: 78.08,
    ),
  );

  testWidgets(
    'event details show named place, GPS and per-photo missing data',
    (tester) async {
      await tester.pumpWidget(
        _app(named, EventDetailScreen(eventId: named.id)),
      );
      await tester.pumpAndSettle();
      expect(find.text('Karur, Tamil Nadu, India'), findsOneWidget);
      expect(find.text('10.96000° N, 78.08000° E'), findsOneWidget);
      await tester.ensureVisible(find.text('Media locations'));
      await tester.tap(find.text('Media locations'));
      await tester.pumpAndSettle();
      expect(find.text('1 of 2 media items have GPS'), findsOneWidget);
      expect(find.text('No saved capture GPS'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('location fallback and manual entry fit a narrow screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final missing = demo.copyWith(clearPlace: true);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: MemoryLocation(event: missing, onEdit: () {}),
          ),
        ),
      ),
    );
    expect(find.text('Location unavailable'), findsOneWidget);
    expect(find.text('Add location'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('timeline uses GPS fallback and hides sensitive locations', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        located,
        Scaffold(
          body: SingleChildScrollView(child: MemoryEventCard(event: located)),
        ),
      ),
    );
    expect(find.text('10.96000° N, 78.08000° E'), findsOneWidget);
    final hidden = located.copyWith(sensitivity: SensitivityLevel.hidden);
    await tester.pumpWidget(
      _app(
        hidden,
        Scaffold(
          body: SingleChildScrollView(child: MemoryEventCard(event: hidden)),
        ),
      ),
    );
    expect(find.text('Location hidden'), findsOneWidget);
    expect(find.text('10.96000° N, 78.08000° E'), findsNothing);
  });

  testWidgets('graph opens event details with the tapped photo selected', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final event = named.copyWith(people: [], media: [named.media.first]);
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => const MemoryGraphScreen()),
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
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          memoryControllerProvider.overrideWith(() => _Memory(event)),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Karur, Tamil Nadu, India'), findsOneWidget);
    await tester.tap(find.text('1 photos\n0 videos'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Selected image:'), findsOneWidget);
    expect(router.state.uri.queryParameters['media'], event.media.first.id);
    expect(tester.takeException(), isNull);
  });

  testWidgets('graph includes unknown location and excludes hidden memories', (
    tester,
  ) async {
    final missing = demo.copyWith(
      clearPlace: true,
      people: [],
      media: [demo.media.first],
    );
    await tester.pumpWidget(_app(missing, const MemoryGraphScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Location unavailable'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    final hidden = named.copyWith(sensitivity: SensitivityLevel.hidden);
    await tester.pumpWidget(_app(hidden, const MemoryGraphScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Karur, Tamil Nadu, India'), findsNothing);
    expect(find.text(named.title), findsNothing);
  });
}

Widget _app(MemoryEvent event, Widget home) => ProviderScope(
  overrides: [memoryControllerProvider.overrideWith(() => _Memory(event))],
  child: MaterialApp(home: home),
);

class _Memory extends MemoryController {
  _Memory(this.event);
  final MemoryEvent event;
  @override
  MemoryAppState build() => MemoryAppState(events: [event], demoMode: true);
  @override
  void markViewed(String eventId) {}
}
