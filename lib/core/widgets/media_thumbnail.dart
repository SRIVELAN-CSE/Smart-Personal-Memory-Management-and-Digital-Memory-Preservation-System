import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import '../models/memory_models.dart';

class MediaThumbnail extends StatefulWidget {
  const MediaThumbnail({
    required this.media,
    this.fit = BoxFit.cover,
    this.size = 400,
    super.key,
  });
  final MediaItem media;
  final BoxFit fit;
  final int size;
  @override
  State<MediaThumbnail> createState() => _MediaThumbnailState();
}

class _MediaThumbnailState extends State<MediaThumbnail> {
  late Future<Uint8List?> _bytes;
  @override
  void initState() {
    super.initState();
    _bytes = _load();
  }

  @override
  void didUpdateWidget(covariant MediaThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.media.assetIdentifier != widget.media.assetIdentifier ||
        oldWidget.size != widget.size) {
      _bytes = _load();
    }
  }

  Future<Uint8List?> _load() async {
    if (widget.media.thumbnailBytes != null && widget.size <= 512) {
      return widget.media.thumbnailBytes;
    }
    if (widget.media.assetIdentifier.startsWith('demo://')) return null;
    try {
      final asset = await AssetEntity.fromId(widget.media.assetIdentifier);
      final longest = widget.media.width > widget.media.height
          ? widget.media.width
          : widget.media.height;
      final scale = longest > 0 ? widget.size / longest : 1.0;
      return await asset?.thumbnailDataWithSize(
        widget.size > 512
            ? ThumbnailSize(
                (widget.media.width * scale).round().clamp(1, widget.size),
                (widget.media.height * scale).round().clamp(1, widget.size),
              )
            : ThumbnailSize.square(widget.size),
        quality: 92,
      );
    } on Object {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Uint8List?>(
    future: _bytes,
    builder: (context, snapshot) {
      final scheme = Theme.of(context).colorScheme;
      return ColoredBox(
        color: scheme.surfaceContainerHighest,
        child: snapshot.data == null
            ? Center(
                child: Icon(
                  widget.media.kind == MediaKind.video
                      ? Icons.videocam_outlined
                      : Icons.image_outlined,
                  color: scheme.onSurfaceVariant,
                ),
              )
            : Image.memory(
                snapshot.data!,
                fit: widget.fit,
                gaplessPlayback: true,
                errorBuilder: (_, _, _) =>
                    const Icon(Icons.broken_image_outlined),
              ),
      );
    },
  );
}
