import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';
import 'package:smart_memory_preservation/features/memory_graph/domain/memory_graph_data.dart';
import 'package:smart_memory_preservation/routing/memory_destination.dart';
import '../support/library_fixture.dart';

void main() {
  final event = libraryFixture().events.single;
  test('every graph relationship resolves its correct typed destination', () {
    final graph = MemoryGraphData([event]);
    final nodes = graph.nodes.values;
    expect(
      nodes.firstWhere((n) => n.kind == 'event').target.resolve([event])!.route,
      '/event/saved_event',
    );
    expect(
      Uri.parse(
        nodes.firstWhere((n) => n.kind == 'media').target.resolve([
          event,
        ])!.route,
      ).queryParameters['media'],
      'saved_photo_0',
    );
    expect(
      Uri.parse(
        nodes.firstWhere((n) => n.kind == 'person').target.resolve([
          event,
        ])!.route,
      ).queryParameters['personId'],
      'saved_person',
    );
    expect(
      Uri.parse(
        nodes.firstWhere((n) => n.kind == 'place').target.resolve([
          event,
        ])!.route,
      ).queryParameters['location'],
      'Campus hall',
    );
    for (final node in nodes) {
      expect(node.target.resolve([]), isNull);
      expect(
        node.target.resolve([
          event.copyWith(sensitivity: SensitivityLevel.hidden),
        ]),
        isNull,
      );
    }
  });
  test('deleted media is rejected and reserved characters are encoded', () {
    final target = MemoryDestination(
      type: MemoryTargetType.media,
      id: event.media.first.id,
      eventId: event.id,
      title: 'Photo',
    );
    expect(target.resolve([event.copyWith(media: [])]), isNull);
    final route = Uri.parse(eventRoute('event:/? &', mediaId: 'photo:/? &'));
    expect(route.pathSegments.last, 'event:/? &');
    expect(route.queryParameters['media'], 'photo:/? &');
  });
}
