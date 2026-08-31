import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../models/memory_models.dart';

class MemoryCover extends StatelessWidget {
  const MemoryCover({
    required this.event,
    this.height = 190,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    super.key,
  });

  final MemoryEvent event;
  final double height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final cover = event.media
        .where((item) => item.id == event.coverMediaId)
        .firstOrNull;
    final media = cover ?? event.media.firstOrNull;
    final thumbnail = media?.thumbnailBytes;
    final scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (!event.isSensitive && thumbnail != null)
              Image.memory(thumbnail, fit: BoxFit.cover)
            else if (!event.isSensitive &&
                media != null &&
                !media.assetIdentifier.startsWith('demo://'))
              _GalleryAssetThumbnail(assetIdentifier: media.assetIdentifier)
            else
              _CoverFallback(isSensitive: event.isSensitive),
            if (event.isSensitive)
              ColoredBox(
                color: scheme.surface.withValues(alpha: 0.72),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.visibility_off_outlined,
                        color: scheme.primary,
                      ),
                      const SizedBox(height: 8),
                      const Text('Sensitive preview hidden'),
                    ],
                  ),
                ),
              ),
            Positioned(
              left: 12,
              top: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: scheme.scrim.withValues(alpha: 0.58),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  event.isDemo ? 'DEMO MEMORY' : 'ON-DEVICE MEMORY',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GalleryAssetThumbnail extends StatefulWidget {
  const _GalleryAssetThumbnail({required this.assetIdentifier});

  final String assetIdentifier;

  @override
  State<_GalleryAssetThumbnail> createState() => _GalleryAssetThumbnailState();
}

class _GalleryAssetThumbnailState extends State<_GalleryAssetThumbnail> {
  late Future<Uint8List?> _thumbnail;

  @override
  void initState() {
    super.initState();
    _thumbnail = _load();
  }

  @override
  void didUpdateWidget(covariant _GalleryAssetThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetIdentifier != widget.assetIdentifier) {
      _thumbnail = _load();
    }
  }

  Future<Uint8List?> _load() async {
    try {
      final asset = await AssetEntity.fromId(widget.assetIdentifier);
      return asset?.thumbnailDataWithSize(
        const ThumbnailSize.square(512),
        quality: 82,
      );
    } on Object {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _thumbnail,
      builder: (context, snapshot) {
        final bytes = snapshot.data;
        return bytes == null
            ? const _CoverFallback(isSensitive: false)
            : Image.memory(bytes, fit: BoxFit.cover);
      },
    );
  }
}

class _CoverFallback extends StatelessWidget {
  const _CoverFallback({required this.isSensitive});

  final bool isSensitive;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primaryContainer,
            scheme.tertiaryContainer,
            scheme.secondaryContainer,
          ],
        ),
      ),
      child: Icon(
        isSensitive ? Icons.lock_outline : Icons.photo_library_outlined,
        size: 60,
        color: scheme.onPrimaryContainer.withValues(alpha: 0.72),
      ),
    );
  }
}
