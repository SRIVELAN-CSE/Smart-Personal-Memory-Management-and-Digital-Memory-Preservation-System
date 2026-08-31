import '../../../core/models/memory_models.dart';

enum GalleryAccess { full, limited, denied }

class MediaScanProgress {
  const MediaScanProgress({
    required this.processed,
    required this.total,
    required this.currentStage,
  });

  final int processed;
  final int total;
  final String currentStage;

  double get fraction => total == 0 ? 0 : processed / total;
}

abstract interface class MediaImportGateway {
  Future<GalleryAccess> requestAccess();

  Future<GalleryAccess> currentAccess();

  Future<void> openLimitedSelection();

  Future<List<MediaItem>> scan({
    Set<String> knownAssetIdentifiers = const {},
    void Function(MediaScanProgress progress)? onProgress,
  });
}
