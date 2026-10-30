import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/memory_models.dart';
import '../../../core/widgets/app_navigation.dart';
import '../../../core/widgets/library_status_banner.dart';
import '../../../core/widgets/media_thumbnail.dart';
import '../../../core/widgets/memory_target_link.dart';
import '../domain/memory_graph_projection.dart';
import '../../event_management/presentation/memory_controller.dart';

class MemoryGraphScreen extends ConsumerStatefulWidget {
  const MemoryGraphScreen({super.key});
  @override
  ConsumerState<MemoryGraphScreen> createState() => _MemoryGraphScreenState();
}

class _MemoryGraphScreenState extends ConsumerState<MemoryGraphScreen> {
  String? _selected;
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(memoryControllerProvider);
    final events = state.events.where((e) => !e.isSensitive).toList()
      ..sort((a, b) => b.startAt.compareTo(a.startAt));
    final event =
        events.where((e) => e.id == _selected).firstOrNull ??
        events.firstOrNull;
    return AppNavigation(
      selectedIndex: 2,
      title: 'Personal memory graph',
      child: Column(
        children: [
          const LibraryStatusBanner(),
          if (event != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: DropdownButtonFormField<String>(
                key: ValueKey(event.id),
                initialValue: event.id,
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Selected event'),
                items: events
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(
                          e.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (id) => setState(() => _selected = id),
              ),
            ),
            Expanded(
              child: _RadialMemoryGraph(key: ValueKey(event.id), event: event),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Pinch to zoom · drag to explore · tap a connection\nOpen the event to view all its media and people.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ] else
            Expanded(
              child: Center(
                child: state.isRestoring
                    ? const CircularProgressIndicator()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.hub_outlined, size: 64),
                          const SizedBox(height: 16),
                          const Text('Your memories connect here'),
                          TextButton(
                            onPressed: () => context.push('/scan'),
                            child: const Text('Scan your gallery'),
                          ),
                        ],
                      ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RadialMemoryGraph extends ConsumerStatefulWidget {
  const _RadialMemoryGraph({required this.event, super.key});
  final MemoryEvent event;
  @override
  ConsumerState<_RadialMemoryGraph> createState() => _RadialMemoryGraphState();
}

class _RadialMemoryGraphState extends ConsumerState<_RadialMemoryGraph> {
  final _transform = TransformationController();
  Size? _lastSize;
  @override
  void dispose() {
    _transform.dispose();
    super.dispose();
  }

  void _fit(Size size) {
    final scale = math.min(size.width / 560, size.height / 560).clamp(.3, 1.0);
    _transform.value = Matrix4.identity()
      ..translateByDouble(
        (size.width - 560 * scale) / 2,
        (size.height - 560 * scale) / 2,
        0,
        1,
      )
      ..scaleByDouble(scale, scale, 1, 1);
  }

  void _zoom(double factor) {
    final scale = _transform.value.getMaxScaleOnAxis();
    if (scale * factor >= .3 && scale * factor <= 2.5) {
      _transform.value = _transform.value.clone()
        ..scaleByDouble(factor, factor, 1, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final projection = MemoryGraphProjection([widget.event]);
    final firstMedia = projection.nodes.values
        .where((n) => n.type == 'media')
        .firstOrNull;
    final satellites = [
      if (firstMedia != null)
        MemoryGraphNode(
          firstMedia.key,
          'media',
          '${widget.event.imageCount} photos\n${widget.event.videoCount} videos',
          firstMedia.target,
        ),
      ...projection.nodes.values.where(
        (n) => n.type != 'event' && n.type != 'media',
      ),
    ];
    final positions = List.generate(satellites.length, (i) {
      final angle = -math.pi / 2 + i * 2 * math.pi / satellites.length;
      return Offset(280 + math.cos(angle) * 205, 280 + math.sin(angle) * 205);
    });
    final scheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        if (_lastSize != size) {
          _lastSize = size;
          _fit(size);
        }
        return Stack(
          children: [
            InteractiveViewer(
              transformationController: _transform,
              constrained: false,
              minScale: .3,
              maxScale: 2.5,
              boundaryMargin: const EdgeInsets.all(300),
              child: SizedBox(
                width: 560,
                height: 560,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _Connections(positions, scheme.outlineVariant),
                      ),
                    ),
                    for (final (index, node) in satellites.indexed) ...[
                      Positioned(
                        left: (280 + positions[index].dx) / 2 - 35,
                        top: (280 + positions[index].dy) / 2 - 12,
                        child: Container(
                          width: 70,
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          decoration: BoxDecoration(
                            color: scheme.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            switch (node.type) {
                              'media' => 'contains',
                              'person' => 'with',
                              'place' => 'at',
                              'voice' => 'voice',
                              _ => 'story',
                            },
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: positions[index].dx - 50,
                        top: positions[index].dy - 50,
                        child: _GraphBubble(
                          node: node,
                          onTap: node.target == null
                              ? () => context.push(
                                  '/event/${widget.event.id}/edit',
                                )
                              : () => openMemoryTarget(
                                  context,
                                  ref,
                                  node.target!,
                                ),
                        ),
                      ),
                    ],
                    Positioned(
                      left: 190,
                      top: 190,
                      child: Semantics(
                        button: true,
                        label: 'Open ${widget.event.title}',
                        child: Material(
                          color: scheme.primaryContainer,
                          elevation: 6,
                          shape: const CircleBorder(),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () =>
                                context.push('/event/${widget.event.id}'),
                            child: SizedBox(
                              width: 180,
                              height: 180,
                              child: Padding(
                                padding: const EdgeInsets.all(22),
                                child: Column(
                                  children: [
                                    if (widget.event.media.isNotEmpty)
                                      Expanded(
                                        child: SizedBox(
                                          width: 82,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: MediaThumbnail(
                                              media:
                                                  widget.event.media
                                                      .where(
                                                        (m) =>
                                                            m.id ==
                                                            widget
                                                                .event
                                                                .coverMediaId,
                                                      )
                                                      .firstOrNull ??
                                                  widget.event.media.first,
                                            ),
                                          ),
                                        ),
                                      ),
                                    const SizedBox(height: 8),
                                    Text(
                                      widget.event.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: scheme.onPrimaryContainer,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      '${widget.event.startAt.day}/${widget.event.startAt.month}/${widget.event.startAt.year}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: scheme.onPrimaryContainer,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'Zoom in',
                      onPressed: () => _zoom(1.2),
                      icon: const Icon(Icons.add),
                    ),
                    IconButton(
                      tooltip: 'Fit graph',
                      onPressed: () => _fit(size),
                      icon: const Icon(Icons.center_focus_strong),
                    ),
                    IconButton(
                      tooltip: 'Zoom out',
                      onPressed: () => _zoom(.8),
                      icon: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GraphBubble extends StatelessWidget {
  const _GraphBubble({required this.node, required this.onTap});
  final MemoryGraphNode node;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final color = switch (node.type) {
      'media' => const Color(0xFF946400),
      'person' => const Color(0xFF006B62),
      'place' => const Color(0xFF9C4610),
      'voice' => const Color(0xFF7C3D9B),
      _ => const Color(0xFF395CA3),
    };
    final icon = switch (node.type) {
      'media' => Icons.photo_library_outlined,
      'person' => Icons.person,
      'place' => Icons.place,
      'voice' => Icons.mic,
      _ => Icons.edit_note,
    };
    return Semantics(
      label: '${node.type}: ${node.label}',
      button: true,
      child: Material(
        color: color,
        elevation: 3,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 100,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 25),
                  const SizedBox(height: 5),
                  Flexible(
                    child: Text(
                      node.label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Connections extends CustomPainter {
  const _Connections(this.positions, this.color);
  final List<Offset> positions;
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;
    for (final position in positions) {
      canvas.drawLine(const Offset(280, 280), position, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _Connections old) =>
      old.color != color || old.positions.length != positions.length;
}
