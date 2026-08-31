import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:graphview/GraphView.dart';

import '../../../core/models/memory_models.dart';
import '../../../core/widgets/app_navigation.dart';
import '../../event_management/presentation/memory_controller.dart';

class MemoryGraphScreen extends ConsumerWidget {
  const MemoryGraphScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(memoryControllerProvider).events;
    return AppNavigation(
      selectedIndex: 2,
      title: 'Personal memory graph',
      child: events.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.hub_outlined, size: 70),
                  const SizedBox(height: 14),
                  const Text('The graph grows from confirmed memories.'),
                  const SizedBox(height: 14),
                  FilledButton(
                    onPressed: () => ref
                        .read(memoryControllerProvider.notifier)
                        .enableDemoMode(),
                    child: const Text('Load demo graph'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 4, 18, 8),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 6,
                    children: const [
                      _LegendDot(color: Colors.deepPurple, label: 'Event'),
                      _LegendDot(color: Colors.blue, label: 'Media'),
                      _LegendDot(color: Colors.teal, label: 'Person'),
                      _LegendDot(color: Colors.orange, label: 'Place'),
                      _LegendDot(color: Colors.indigo, label: 'Note'),
                      _LegendDot(color: Colors.pink, label: 'Voice note'),
                    ],
                  ),
                ),
                Expanded(
                  child: InteractiveViewer(
                    constrained: false,
                    boundaryMargin: const EdgeInsets.all(160),
                    minScale: 0.35,
                    maxScale: 2.5,
                    child: _GraphCanvas(events: events),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Tap a node to open its related details. Large libraries are intentionally shown as bounded event-centred subgraphs.',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
    );
  }
}

class _GraphCanvas extends StatelessWidget {
  _GraphCanvas({required this.events}) {
    for (final event in events.take(8)) {
      final eventNode = Node.Id('event:${event.id}');
      graph.addNode(eventNode);
      labels[eventNode.key!.value as String] = event.title;
      for (final media in event.media.take(5)) {
        final node = Node.Id('media:${event.id}:${media.id}');
        labels[node.key!.value as String] = media.kind.name;
        graph.addEdge(eventNode, node);
      }
      for (final person in event.people.take(5)) {
        final node = Node.Id('person:${event.id}:${person.id}');
        labels[node.key!.value as String] = person.name;
        graph.addEdge(eventNode, node);
      }
      if (event.place != null) {
        final node = Node.Id('place:${event.id}:${event.place!.id}');
        labels[node.key!.value as String] = event.place!.name;
        graph.addEdge(eventNode, node);
      }
      if (event.hasStory) {
        final node = Node.Id('note:${event.id}');
        labels[node.key!.value as String] = 'Personal story';
        graph.addEdge(eventNode, node);
      }
      if (event.hasVoiceNote) {
        final node = Node.Id('voice:${event.id}');
        labels[node.key!.value as String] = 'Voice note';
        graph.addEdge(eventNode, node);
      }
    }
  }

  final List<MemoryEvent> events;
  final Graph graph = Graph();
  final Map<String, String> labels = {};

  @override
  Widget build(BuildContext context) {
    return GraphView.builder(
      graph: graph,
      algorithm: FruchtermanReingoldAlgorithm(
        FruchtermanReingoldConfiguration(iterations: 180, repulsionRate: 0.35),
      ),
      builder: (node) {
        final id = node.key?.value.toString() ?? '';
        final type = id.split(':').first;
        final eventId = id.split(':').length > 1 ? id.split(':')[1] : '';
        final style = _nodeStyle(type);
        return Material(
          color: style.color,
          borderRadius: BorderRadius.circular(18),
          elevation: type == 'event' ? 5 : 1,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              if (type == 'event') {
                context.push('/event/$eventId');
              } else if (type == 'person') {
                context.push('/event/$eventId/people');
              } else {
                _showNodeDetails(context, id, type, eventId);
              }
            },
            child: Container(
              constraints: BoxConstraints(
                maxWidth: type == 'event' ? 170 : 128,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(style.icon, size: 18, color: Colors.white),
                  const SizedBox(width: 7),
                  Flexible(
                    child: Text(
                      labels[id] ?? type,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ({Color color, IconData icon}) _nodeStyle(String type) => switch (type) {
    'event' => (color: Colors.deepPurple, icon: Icons.auto_stories),
    'media' => (color: Colors.blue, icon: Icons.photo_outlined),
    'person' => (color: Colors.teal, icon: Icons.person_outline),
    'place' => (color: Colors.orange.shade800, icon: Icons.place_outlined),
    'voice' => (color: Colors.pink, icon: Icons.graphic_eq),
    _ => (color: Colors.indigo, icon: Icons.note_outlined),
  };

  void _showNodeDetails(
    BuildContext context,
    String id,
    String type,
    String eventId,
  ) {
    final event = events.where((item) => item.id == eventId).firstOrNull;
    final entityId = id.split(':').skip(2).join(':');
    final media = event?.media
        .where((item) => item.id == entityId)
        .firstOrNull;
    final detail = switch (type) {
      'media' when media != null =>
        '${media.kind.name} • ${media.width} × ${media.height} • ${media.capturedAt.toLocal()}',
      'place' => event?.place?.name ?? 'Place linked to this event',
      'note' => event?.story ?? 'Personal story linked to this event',
      'voice' => 'App-private voice-note reference linked to this event.',
      _ => 'Related memory node',
    };
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                labels[id] ?? type,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              Text(detail),
              const SizedBox(height: 18),
              FilledButton.icon(
                onPressed: event == null
                    ? null
                    : () {
                        Navigator.pop(context);
                        context.push('/event/${event.id}');
                      },
                icon: const Icon(Icons.open_in_new),
                label: const Text('Open related event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}
