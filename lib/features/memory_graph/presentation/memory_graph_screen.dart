import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:graphview/GraphView.dart';

import '../../../core/models/memory_models.dart';
import '../../../core/widgets/app_navigation.dart';
import '../domain/memory_graph_data.dart';
import '../../event_management/presentation/memory_controller.dart';

class MemoryGraphScreen extends ConsumerWidget {
  const MemoryGraphScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final library = ref.watch(memoryControllerProvider);
    final events = library.events.where((event) => !event.isSensitive).toList();
    return AppNavigation(
      selectedIndex: 2,
      title: 'Personal memory graph',
      child: library.isRestoring
          ? const Center(child: CircularProgressIndicator())
          : library.restoreFailed
          ? Center(
              child: TextButton(
                onPressed: () =>
                    ref.read(memoryControllerProvider.notifier).retryRestore(),
                child: const Text('Retry loading memories'),
              ),
            )
          : events.isEmpty
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
                Expanded(child: _GraphCanvas(events: events)),
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

class _GraphCanvas extends ConsumerWidget {
  _GraphCanvas({required List<MemoryEvent> events})
    : data = MemoryGraphData(events) {
    for (final node in data.nodes.values) {
      graph.addNode(Node.Id(node.key));
    }
    for (final edge in data.edges) {
      graph.addEdge(Node.Id(edge.$1), Node.Id(edge.$2));
    }
  }
  final MemoryGraphData data;
  final Graph graph = Graph();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GraphView.builder(
      graph: graph,
      autoZoomToFit: true,
      algorithm: FruchtermanReingoldAlgorithm(
        FruchtermanReingoldConfiguration(iterations: 180, repulsionRate: 0.35),
      ),
      builder: (node) {
        final item = data.nodes[node.key?.value];
        if (item == null) return const SizedBox.shrink();
        final style = _nodeStyle(item.kind);
        return Material(
          color: style.color,
          borderRadius: BorderRadius.circular(18),
          elevation: item.kind == 'event' ? 5 : 1,
          child: InkWell(
            key: ValueKey('graph/${item.key}'),
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              final target = item.target.resolve(
                ref.read(memoryControllerProvider).events,
              );
              if (target == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('This memory is no longer available.'),
                  ),
                );
              } else {
                context.push(target.route);
              }
            },
            child: Container(
              constraints: BoxConstraints(
                maxWidth: item.kind == 'event' ? 170 : 128,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(style.icon, size: 18, color: Colors.white),
                  const SizedBox(width: 7),
                  Flexible(
                    child: Text(
                      item.label,
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
