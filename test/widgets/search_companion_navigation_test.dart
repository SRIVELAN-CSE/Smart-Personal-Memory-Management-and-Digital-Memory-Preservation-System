import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';
import 'package:smart_memory_preservation/features/event_management/data/demo_memory_data.dart';
import 'package:smart_memory_preservation/features/event_management/presentation/memory_controller.dart';
import 'package:smart_memory_preservation/features/chatbot/presentation/chat_screen.dart';
import 'package:smart_memory_preservation/features/chatbot/presentation/widgets/chat_result_card.dart';
import 'package:smart_memory_preservation/features/chatbot/domain/services/memory_retrieval_service.dart';
import 'package:smart_memory_preservation/features/timeline/domain/event_filter.dart';
import 'package:smart_memory_preservation/features/timeline/presentation/story_timeline_screen.dart';

void main() {
  final event = DemoMemoryData.event;
  testWidgets(
    'timeline combines edits, independently clears and fits keyboard',
    (tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            memoryControllerProvider.overrideWith(() => _Memory(event)),
          ],
          child: MaterialApp(
            home: StoryTimelineScreen(
              initialFilter: EventFilter(
                personId: event.people.first.id,
                person: event.people.first.name,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final search = find.widgetWithText(TextField, 'Search memories');
      await tester.enterText(search, 'no such event');
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('No memories match these filters.'), findsOneWidget);
      await tester.tap(find.byTooltip('Clear search'));
      await tester.pumpAndSettle();
      expect(find.text('Person: ${event.people.first.name}'), findsOneWidget);
      expect(find.text('No memories match these filters.'), findsNothing);
      tester.view.viewInsets = const FakeViewPadding(bottom: 350);
      addTearDown(tester.view.resetViewInsets);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('chat renders ordinary text plus several independent results', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          memoryControllerProvider.overrideWith(() => _Memory(event)),
        ],
        child: const MaterialApp(home: ChatScreen()),
      ),
    );
    await tester.enterText(find.byType(TextField), 'Show memories');
    await tester.tap(find.byTooltip('Send message'));
    await tester.pumpAndSettle();
    expect(find.byType(ChatResultCard), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'each chat target opens its own route and stale results are disabled',
    (tester) async {
      final targets = const MemoryRetrievalService().retrieve('Show memories', [
        event,
      ]).targets;
      final memory = _Memory(event);
      final container = ProviderContainer(
        overrides: [memoryControllerProvider.overrideWith(() => memory)],
      );
      addTearDown(container.dispose);
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => Scaffold(
              body: ListView(
                children: [
                  for (final target in targets) ChatResultCard(target: target),
                ],
              ),
            ),
          ),
          GoRoute(
            path: '/event/:id',
            builder: (_, state) => Scaffold(body: Text(state.uri.toString())),
          ),
          GoRoute(
            path: '/timeline',
            builder: (_, state) => Scaffold(body: Text(state.uri.toString())),
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      for (final type in targets.map((t) => t.type).toSet()) {
        final target = targets.firstWhere((t) => t.type == type);
        final tile = find.byKey(
          ValueKey(
            'chat-result/${target.type.name}/${target.eventId ?? ''}/${target.id}',
          ),
        );
        await tester.ensureVisible(tile);
        await tester.tap(tile);
        await tester.pumpAndSettle();
        expect(find.text(target.resolve([event])!.route), findsOneWidget);
        router.pop();
        await tester.pumpAndSettle();
      }
      memory.hide();
      await tester.pumpAndSettle();
      expect(find.text(event.title), findsNothing);
      expect(find.text('Memory no longer available'), findsWidgets);
      for (final tile in tester.widgetList<ListTile>(find.byType(ListTile))) {
        expect(tile.onTap, isNull);
      }
    },
  );
}

class _Memory extends MemoryController {
  _Memory(this.event);
  final MemoryEvent event;
  @override
  MemoryAppState build() => MemoryAppState(events: [event], demoMode: true);
  void hide() => state = const MemoryAppState();
  @override
  void markViewed(String eventId) {}
}
