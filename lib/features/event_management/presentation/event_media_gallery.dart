import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../core/models/memory_models.dart';
import '../../../core/services/device_media_service.dart';
import '../../../core/widgets/media_thumbnail.dart';
import '../../preprocessing/data/ml_kit_ocr_gateway.dart';
import 'memory_controller.dart';

class EventMediaGallery extends StatefulWidget {
  const EventMediaGallery({
    required this.event,
    this.initialMediaId,
    super.key,
  });
  final MemoryEvent event;
  final String? initialMediaId;
  @override
  State<EventMediaGallery> createState() => _EventMediaGalleryState();
}

class _EventMediaGalleryState extends State<EventMediaGallery> {
  final _selected = <String>{};
  bool _selecting = false, _sharing = false;
  Future<void> _share() async {
    if (_selected.isEmpty || _sharing) return;
    setState(() => _sharing = true);
    try {
      await DeviceMediaService.share(
        widget.event.media.where((m) => _selected.contains(m.id)).toList(),
      );
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Some media is unavailable. Check gallery permission and try again.',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              '${event.media.length} media · ${event.imageCount} photos · ${event.videoCount} videos',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            TextButton(
              onPressed: () => setState(() {
                _selecting = !_selecting;
                _selected.clear();
              }),
              child: Text(_selecting ? 'Cancel selection' : 'Select & share'),
            ),
          ],
        ),
        if (_selecting)
          Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text('${_selected.length} selected'),
              TextButton(
                onPressed: () => setState(() {
                  if (_selected.length == event.media.length) {
                    _selected.clear();
                  } else {
                    _selected.addAll(event.media.map((m) => m.id));
                  }
                }),
                child: Text(
                  _selected.length == event.media.length
                      ? 'Clear'
                      : 'Select all',
                ),
              ),
              FilledButton.tonalIcon(
                onPressed: _selected.isEmpty || _sharing ? null : _share,
                icon: const Icon(Icons.share_outlined),
                label: Text(_sharing ? 'Preparing…' : 'Share selected'),
              ),
            ],
          ),
        SizedBox(
          height: 132,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: event.media.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final media = event.media[index];
              final selected = _selected.contains(media.id);
              return Semantics(
                label:
                    '${media.kind == MediaKind.video ? 'Video' : 'Photo'} ${index + 1}',
                selected: selected,
                button: true,
                child: InkWell(
                  onLongPress: () => setState(() {
                    _selecting = true;
                    _selected.add(media.id);
                  }),
                  onTap: () {
                    if (_selecting) {
                      setState(() {
                        if (selected) {
                          _selected.remove(media.id);
                        } else {
                          _selected.add(media.id);
                        }
                      });
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => EventMediaViewer(
                            event: event,
                            initialIndex: index,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 3,
                        color: selected || widget.initialMediaId == media.id
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          MediaThumbnail(media: media),
                          if (media.kind == MediaKind.video)
                            const Center(
                              child: Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                                size: 38,
                              ),
                            ),
                          if (_selecting)
                            Positioned(
                              top: 4,
                              right: 4,
                              child: Icon(
                                selected
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color: selected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Tap to view · hold to select · sharing opens your device’s share sheet',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class EventMediaViewer extends ConsumerStatefulWidget {
  const EventMediaViewer({
    required this.event,
    required this.initialIndex,
    super.key,
  });
  final MemoryEvent event;
  final int initialIndex;
  @override
  ConsumerState<EventMediaViewer> createState() => _EventMediaViewerState();
}

class _EventMediaViewerState extends ConsumerState<EventMediaViewer> {
  late int _index = widget.initialIndex;
  late final PageController _pages = PageController(initialPage: _index);
  bool _recognizing = false;
  final Map<String, String> _recognized = {};
  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  Future<void> _action(Future<void> Function() action) async {
    try {
      await action();
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Original media is unavailable. Check gallery access.',
            ),
          ),
        );
      }
    }
  }

  Future<void> _text(MediaItem media) async {
    var text = _recognized[media.id] ?? media.ocrText;
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, update) => SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * .7,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Text in this photo',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Review recognised text before using it. Small, blurred or unsupported scripts may not be read correctly.',
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SelectableText(
                        text.isEmpty
                            ? 'No readable text saved. Try reading the original photo.'
                            : text,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.copy),
                        label: const Text('Copy text'),
                        onPressed: text.isEmpty
                            ? null
                            : () =>
                                  Clipboard.setData(ClipboardData(text: text)),
                      ),
                      FilledButton.tonalIcon(
                        icon: const Icon(Icons.document_scanner_outlined),
                        label: Text(
                          _recognizing ? 'Reading…' : 'Read original photo',
                        ),
                        onPressed: _recognizing
                            ? null
                            : () async {
                                update(() => _recognizing = true);
                                try {
                                  final asset = await AssetEntity.fromId(
                                    media.assetIdentifier,
                                  );
                                  final file = await asset?.originFile;
                                  if (file == null) {
                                    throw StateError('Original unavailable');
                                  }
                                  final result = await const MlKitOcrGateway()
                                      .recognizeFile(file.path);
                                  if (!mounted) return;
                                  ref
                                      .read(memoryControllerProvider.notifier)
                                      .saveMediaText(
                                        widget.event.id,
                                        media.id,
                                        result,
                                      );
                                  if (context.mounted) {
                                    update(() {
                                      text = result;
                                      _recognized[media.id] = result;
                                    });
                                  }
                                } on Object {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Could not read this original photo. Check gallery access.',
                                        ),
                                      ),
                                    );
                                  }
                                } finally {
                                  _recognizing = false;
                                  if (context.mounted) update(() {});
                                }
                              },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = widget.event.media[_index];
    return Scaffold(
      appBar: AppBar(
        title: Text('${_index + 1} of ${widget.event.media.length}'),
        actions: [
          IconButton(
            tooltip: 'Share this media',
            onPressed: () => _action(() => DeviceMediaService.share([media])),
            icon: const Icon(Icons.share_outlined),
          ),
          if (media.kind == MediaKind.image)
            IconButton(
              tooltip: 'Extract text',
              onPressed: () => _text(media),
              icon: const Icon(Icons.text_snippet_outlined),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pages,
              itemCount: widget.event.media.length,
              onPageChanged: (value) => setState(() => _index = value),
              itemBuilder: (context, index) {
                final item = widget.event.media[index];
                return InteractiveViewer(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: item.width > 0 && item.height > 0
                          ? item.width / item.height
                          : 1,
                      child: MediaThumbnail(
                        media: item,
                        size: 2048,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton.tonalIcon(
                onPressed: () => _action(() => DeviceMediaService.open(media)),
                icon: Icon(
                  media.kind == MediaKind.video
                      ? Icons.play_arrow
                      : Icons.open_in_new,
                ),
                label: Text(
                  media.kind == MediaKind.video
                      ? 'Play original video'
                      : 'Open original photo',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
