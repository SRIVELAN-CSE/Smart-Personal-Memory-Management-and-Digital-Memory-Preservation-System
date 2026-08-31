import 'cluster_media.dart';
import 'similarity_breakdown.dart';

final class DetectedEventCluster {
  DetectedEventCluster(List<ClusterMedia> media)
    : assert(media.isNotEmpty),
      media = List<ClusterMedia>.unmodifiable(media),
      startAtUtc = _firstTime(media),
      endAtUtc = _lastTime(media);

  final List<ClusterMedia> media;
  final DateTime? startAtUtc;
  final DateTime? endAtUtc;

  List<String> get mediaIds =>
      List<String>.unmodifiable(media.map((item) => item.id));

  static DateTime? _firstTime(List<ClusterMedia> media) {
    for (final item in media) {
      if (item.capturedAtUtc != null) {
        return item.capturedAtUtc;
      }
    }
    return null;
  }

  static DateTime? _lastTime(List<ClusterMedia> media) {
    for (final item in media.reversed) {
      if (item.capturedAtUtc != null) {
        return item.capturedAtUtc;
      }
    }
    return null;
  }
}

final class ClusterBoundary {
  const ClusterBoundary({
    required this.leftMediaId,
    required this.rightMediaId,
    required this.reasonCode,
    this.gap,
    this.similarity,
  });

  final String leftMediaId;
  final String rightMediaId;
  final String reasonCode;
  final Duration? gap;
  final SimilarityBreakdown? similarity;
}

final class ClusteringResult {
  ClusteringResult({
    required this.algorithmVersion,
    required List<DetectedEventCluster> clusters,
    required List<ClusterBoundary> boundaries,
  }) : clusters = List<DetectedEventCluster>.unmodifiable(clusters),
       boundaries = List<ClusterBoundary>.unmodifiable(boundaries);

  final String algorithmVersion;
  final List<DetectedEventCluster> clusters;
  final List<ClusterBoundary> boundaries;
}
