import '../entities/cluster_media.dart';
import '../entities/clustering_result.dart';
import '../entities/similarity_breakdown.dart';
import 'clustering_config.dart';
import 'media_similarity_calculator.dart';

abstract interface class EventClusterer {
  ClusteringResult cluster(List<ClusterMedia> media, ClusteringConfig config);
}

/// A stable adjacent-media clusterer suitable for the offline MVP.
///
/// User-curated event reconciliation belongs in the application repository;
/// this class intentionally performs no I/O and generates no database IDs.
final class DeterministicEventClusterer implements EventClusterer {
  DeterministicEventClusterer({MediaSimilarityCalculator? similarityCalculator})
    : _similarityCalculator =
          similarityCalculator ??
          const DeterministicMediaSimilarityCalculator();

  final MediaSimilarityCalculator _similarityCalculator;

  @override
  ClusteringResult cluster(List<ClusterMedia> media, ClusteringConfig config) {
    config.validate();
    if (media.isEmpty) {
      return ClusteringResult(
        algorithmVersion: config.algorithmVersion,
        clusters: const [],
        boundaries: const [],
      );
    }

    final sorted = List<ClusterMedia>.of(media)..sort(_compareMedia);
    final clusters = <DetectedEventCluster>[];
    final boundaries = <ClusterBoundary>[];
    var current = <ClusterMedia>[sorted.first];

    for (var index = 1; index < sorted.length; index++) {
      final candidate = sorted[index];
      final previous = current.last;
      final decision = _decide(current.first, previous, candidate, config);
      if (decision.join) {
        current.add(candidate);
      } else {
        clusters.add(DetectedEventCluster(current));
        boundaries.add(
          ClusterBoundary(
            leftMediaId: previous.id,
            rightMediaId: candidate.id,
            reasonCode: decision.reasonCode,
            gap: decision.gap,
            similarity: decision.similarity,
          ),
        );
        current = <ClusterMedia>[candidate];
      }
    }
    clusters.add(DetectedEventCluster(current));

    return ClusteringResult(
      algorithmVersion: config.algorithmVersion,
      clusters: clusters,
      boundaries: boundaries,
    );
  }

  _JoinDecision _decide(
    ClusterMedia clusterFirst,
    ClusterMedia previous,
    ClusterMedia candidate,
    ClusteringConfig config,
  ) {
    final firstTime = clusterFirst.capturedAtUtc;
    final previousTime = previous.capturedAtUtc;
    final candidateTime = candidate.capturedAtUtc;
    if (firstTime == null || previousTime == null || candidateTime == null) {
      return const _JoinDecision(
        join: false,
        reasonCode: 'missing_capture_time',
      );
    }

    final gap = candidateTime.difference(previousTime).abs();
    if (gap > config.weakTimeThreshold) {
      return _JoinDecision(
        join: false,
        reasonCode: 'gap_exceeds_weak_time_threshold',
        gap: gap,
      );
    }

    final clusterSpan = candidateTime.difference(firstTime).abs();
    if (clusterSpan > config.maximumClusterSpan) {
      return _JoinDecision(
        join: false,
        reasonCode: 'maximum_cluster_span_exceeded',
        gap: gap,
      );
    }

    final similarity = _similarityCalculator.compare(
      previous,
      candidate,
      config,
    );
    if (gap <= config.strongTimeThreshold) {
      final join = similarity.combinedScore >= config.strongJoinThreshold;
      return _JoinDecision(
        join: join,
        reasonCode: join ? 'strong_window_join' : 'low_combined_similarity',
        gap: gap,
        similarity: similarity,
      );
    }

    final highEnough = similarity.combinedScore >= config.weakJoinThreshold;
    final join = highEnough && similarity.hasSupportingEvidence;
    return _JoinDecision(
      join: join,
      reasonCode: join
          ? 'weak_window_supported_join'
          : highEnough
          ? 'weak_window_lacks_supporting_evidence'
          : 'low_combined_similarity',
      gap: gap,
      similarity: similarity,
    );
  }

  static int _compareMedia(ClusterMedia left, ClusterMedia right) {
    final leftTime = left.capturedAtUtc;
    final rightTime = right.capturedAtUtc;
    if (leftTime == null && rightTime == null) {
      return left.id.compareTo(right.id);
    }
    if (leftTime == null) {
      return 1;
    }
    if (rightTime == null) {
      return -1;
    }
    final timeComparison = leftTime.compareTo(rightTime);
    return timeComparison == 0 ? left.id.compareTo(right.id) : timeComparison;
  }
}

final class _JoinDecision {
  const _JoinDecision({
    required this.join,
    required this.reasonCode,
    this.gap,
    this.similarity,
  });

  final bool join;
  final String reasonCode;
  final Duration? gap;
  final SimilarityBreakdown? similarity;
}
