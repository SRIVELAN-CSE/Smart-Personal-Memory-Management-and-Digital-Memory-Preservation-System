import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/features/event_management/data/demo_memory_data.dart';
import 'package:smart_memory_preservation/features/timeline/presentation/widgets/memory_event_card.dart';

void main() {
  testWidgets('demo timeline card exposes explainable memory details', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: MemoryEventCard(event: DemoMemoryData.event),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Final-Year Project Review'), findsOneWidget);
    expect(find.textContaining('18 photos'), findsOneWidget);
    expect(find.textContaining('Significance'), findsOneWidget);
    expect(find.textContaining('AUTOMATIC TEMPLATE'), findsOneWidget);
  });
}
