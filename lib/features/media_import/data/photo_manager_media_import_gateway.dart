import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

import '../../../core/models/memory_models.dart';
import '../../preprocessing/domain/ocr_gateway.dart';
import '../domain/media_import_gateway.dart';

class PhotoManagerMediaImportGateway implements MediaImportGateway {
  const PhotoManagerMediaImportGateway({required OcrGateway ocrGateway})
    : _ocrGateway = ocrGateway;

  final OcrGateway _ocrGateway;

  static const _permissionOption = PermissionRequestOption(
    androidPermission: AndroidPermission(
      type: RequestType.common,
      mediaLocation: true,
    ),
  );

  @override
  Future<GalleryAccess> requestAccess() async {
    final state = await PhotoManager.requestPermissionExtend(
      requestOption: _permissionOption,
    );
    return _mapAccess(state);
  }

  @override
  Future<GalleryAccess> currentAccess() async {
    final state = await PhotoManager.getPermissionState(
      requestOption: _permissionOption,
    );
    return _mapAccess(state);
  }

  @override
  Future<void> openLimitedSelection() => PhotoManager.presentLimited();

  @override
  Future<List<MediaItem>> scan({
    Set<String> knownAssetIdentifiers = const {},
    void Function(MediaScanProgress progress)? onProgress,
  }) async {
    final access = await currentAccess();
    if (access == GalleryAccess.denied) {
      throw const MediaImportException(
        'Gallery access is unavailable. Demo mode remains available.',
      );
    }

    final paths = await PhotoManager.getAssetPathList(
      type: RequestType.common,
      onlyAll: true,
      filterOption: FilterOptionGroup(
        orders: const [
          OrderOption(type: OrderOptionType.createDate, asc: true),
        ],
      ),
    );
    if (paths.isEmpty) {
      onProgress?.call(
        const MediaScanProgress(
          processed: 0,
          total: 0,
          currentStage: 'No selected photos or videos found',
        ),
      );
      return const [];
    }

    final album = paths.first;
    final total = await album.assetCountAsync;
    final imported = <MediaItem>[];
    var processed = 0;
    const pageSize = 40;

    for (var page = 0; processed < total; page++) {
      final assets = await album.getAssetListPaged(page: page, size: pageSize);
      if (assets.isEmpty) break;
      for (final asset in assets) {
        processed++;
        if (knownAssetIdentifiers.contains(asset.id)) {
          onProgress?.call(
            MediaScanProgress(
              processed: processed,
              total: total,
              currentStage: 'Skipping media already imported',
            ),
          );
          continue;
        }

        try {
          onProgress?.call(
            MediaScanProgress(
              processed: processed,
              total: total,
              currentStage: 'Reading metadata and thumbnail ${asset.id}',
            ),
          );
          Uint8List? thumbnail;
          try {
            thumbnail = await asset.thumbnailDataWithSize(
              const ThumbnailSize.square(512),
              quality: 82,
            );
          } on Object {
            // Thumbnail failure must not prevent metadata-only import.
          }
          int? fileSize;
          try {
            fileSize = await asset.fileSize;
          } on Object {
            // Some provider-backed assets do not expose a byte size.
          }
          var ocrText = '';
          if (thumbnail != null && asset.type == AssetType.image) {
            try {
              ocrText = await _ocrGateway.recognizeThumbnail(thumbnail);
            } on Object {
              // OCR is a supporting signal. Metadata import must continue when
              // a damaged image or platform decoder cannot be recognized.
            }
          }

          imported.add(
            MediaItem(
              id: 'media_${_stableFingerprint(Uint8List.fromList(asset.id.codeUnits))}',
              assetIdentifier: asset.id,
              kind: asset.type == AssetType.video
                  ? MediaKind.video
                  : MediaKind.image,
              capturedAt: asset.createDateTime,
              width: asset.width,
              height: asset.height,
              duration: asset.videoDuration,
              fileSize: fileSize,
              latitude: asset.latitude,
              longitude: asset.longitude,
              ocrText: ocrText,
              fingerprint: thumbnail == null
                  ? ''
                  : _stableFingerprint(thumbnail),
              thumbnailBytes: thumbnail,
            ),
          );
        } on Object {
          onProgress?.call(
            MediaScanProgress(
              processed: processed,
              total: total,
              currentStage: 'Skipped one unreadable media item safely',
            ),
          );
        }
      }
    }
    return imported;
  }

  GalleryAccess _mapAccess(PermissionState state) {
    if (state.isAuth) return GalleryAccess.full;
    if (state.hasAccess) return GalleryAccess.limited;
    return GalleryAccess.denied;
  }

  String _stableFingerprint(Uint8List bytes) {
    var hash = 0x811c9dc5;
    for (final byte in bytes) {
      hash ^= byte;
      hash = (hash * 0x01000193) & 0xffffffff;
    }
    return hash.toRadixString(16).padLeft(8, '0');
  }
}

class MediaImportException implements Exception {
  const MediaImportException(this.message);

  final String message;

  @override
  String toString() => message;
}
