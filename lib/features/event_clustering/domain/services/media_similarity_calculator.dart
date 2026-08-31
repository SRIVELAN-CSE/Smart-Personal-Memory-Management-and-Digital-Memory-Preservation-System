import 'dart:math' as math;

import '../entities/cluster_media.dart';
import '../entities/similarity_breakdown.dart';
import 'clustering_config.dart';

abstract interface class MediaSimilarityCalculator {
  SimilarityBreakdown compare(
    ClusterMedia left,
    ClusterMedia right,
    ClusteringConfig config,
  );
}

final class DeterministicMediaSimilarityCalculator
    implements MediaSimilarityCalculator {
  const DeterministicMediaSimilarityCalculator();

  static const double _earthRadiusKm = 6371.0088;

  @override
  SimilarityBreakdown compare(
    ClusterMedia left,
    ClusterMedia right,
    ClusteringConfig config,
  ) {
    config.validate();
    final time = timeSimilarity(
      left.capturedAtUtc,
      right.capturedAtUtc,
      config,
    );
    final location = locationSimilarity(left, right, config);
    final ocr = ocrSimilarity(left.ocrText, right.ocrText, config);
    final visual = visualSimilarity(left, right);

    final signals = <_WeightedSignal>[
      if (time != null)
        _WeightedSignal(
          score: time,
          weight:
              config.timeWeight *
              math.min(
                left.captureTimeReliability,
                right.captureTimeReliability,
              ),
        ),
      if (location != null)
        _WeightedSignal(score: location, weight: config.locationWeight),
      if (ocr != null) _WeightedSignal(score: ocr, weight: config.ocrWeight),
      if (visual != null)
        _WeightedSignal(score: visual, weight: config.visualWeight),
    ].where((signal) => signal.weight > 0).toList(growable: false);

    final availableWeight = signals.fold<double>(
      0,
      (total, signal) => total + signal.weight,
    );
    final weightedTotal = signals.fold<double>(
      0,
      (total, signal) => total + signal.score * signal.weight,
    );
    final combined = availableWeight == 0
        ? 0.0
        : weightedTotal / availableWeight;
    final coverage = config.totalWeight == 0
        ? 0.0
        : availableWeight / config.totalWeight;

    final hasSupport =
        (location != null && location >= config.locationSupportThreshold) ||
        (ocr != null && ocr >= config.ocrSupportThreshold) ||
        (visual != null && visual >= config.visualSupportThreshold);

    final reasons = <String>[
      if (time == null) 'time_unavailable',
      if (time != null && time == 1) 'strong_time_relation',
      if (location != null && location >= config.locationSupportThreshold)
        'nearby_location',
      if (ocr != null && ocr >= config.ocrSupportThreshold)
        'ocr_keyword_overlap',
      if (visual != null && visual >= config.visualSupportThreshold)
        'visual_similarity',
    ];

    return SimilarityBreakdown(
      timeSimilarity: time,
      locationSimilarity: location,
      ocrSimilarity: ocr,
      visualSimilarity: visual,
      combinedScore: _unit(combined),
      evidenceCoverage: _unit(coverage),
      hasSupportingEvidence: hasSupport,
      reasonCodes: reasons,
    );
  }

  double? timeSimilarity(
    DateTime? left,
    DateTime? right,
    ClusteringConfig config,
  ) {
    if (left == null || right == null) {
      return null;
    }

    final gapMicros = left.difference(right).inMicroseconds.abs();
    final strongMicros = config.strongTimeThreshold.inMicroseconds;
    final weakMicros = config.weakTimeThreshold.inMicroseconds;
    if (gapMicros <= strongMicros) {
      return 1;
    }
    if (gapMicros >= weakMicros || weakMicros == strongMicros) {
      return 0;
    }
    return _unit((weakMicros - gapMicros) / (weakMicros - strongMicros));
  }

  double? locationSimilarity(
    ClusterMedia left,
    ClusterMedia right,
    ClusteringConfig config,
  ) {
    if (left.latitude == null ||
        left.longitude == null ||
        right.latitude == null ||
        right.longitude == null) {
      return null;
    }
    final distance = haversineDistanceKm(
      left.latitude!,
      left.longitude!,
      right.latitude!,
      right.longitude!,
    );
    return _unit(1 - distance / config.nearbyDistanceKm);
  }

  double? ocrSimilarity(
    String? leftText,
    String? rightText,
    ClusteringConfig config,
  ) {
    final left = _normalisedTokens(leftText, config);
    final right = _normalisedTokens(rightText, config);
    if (left == null || right == null) {
      return null;
    }
    final union = left.union(right);
    if (union.isEmpty) {
      return null;
    }
    return left.intersection(right).length / union.length;
  }

  double? visualSimilarity(ClusterMedia left, ClusterMedia right) {
    final leftVector = left.visualEmbedding;
    final rightVector = right.visualEmbedding;
    if (leftVector == null ||
        rightVector == null ||
        left.embeddingModelVersion != right.embeddingModelVersion ||
        leftVector.isEmpty ||
        leftVector.length != rightVector.length) {
      return null;
    }

    var dotProduct = 0.0;
    var leftMagnitude = 0.0;
    var rightMagnitude = 0.0;
    for (var index = 0; index < leftVector.length; index++) {
      dotProduct += leftVector[index] * rightVector[index];
      leftMagnitude += leftVector[index] * leftVector[index];
      rightMagnitude += rightVector[index] * rightVector[index];
    }
    if (leftMagnitude == 0 || rightMagnitude == 0) {
      return null;
    }
    return _unit(dotProduct / math.sqrt(leftMagnitude * rightMagnitude));
  }

  double haversineDistanceKm(
    double leftLatitude,
    double leftLongitude,
    double rightLatitude,
    double rightLongitude,
  ) {
    final latitudeDelta = _radians(rightLatitude - leftLatitude);
    final longitudeDelta = _radians(rightLongitude - leftLongitude);
    final leftLatitudeRadians = _radians(leftLatitude);
    final rightLatitudeRadians = _radians(rightLatitude);
    final haversine =
        math.pow(math.sin(latitudeDelta / 2), 2) +
        math.cos(leftLatitudeRadians) *
            math.cos(rightLatitudeRadians) *
            math.pow(math.sin(longitudeDelta / 2), 2);
    final centralAngle =
        2 * math.atan2(math.sqrt(haversine), math.sqrt(1 - haversine));
    return _earthRadiusKm * centralAngle;
  }

  Set<String>? _normalisedTokens(String? text, ClusteringConfig config) {
    if (text == null || text.trim().isEmpty) {
      return null;
    }
    final stopWords = config.ocrStopWords
        .map((word) => word.toLowerCase())
        .toSet();
    final tokens = text
        .toLowerCase()
        .split(RegExp('[^a-z0-9]+'))
        .where((token) => token.length >= 2 && !stopWords.contains(token))
        .toSet();
    return tokens.length < config.minimumOcrTokenCount ? null : tokens;
  }

  double _radians(double degrees) => degrees * math.pi / 180;

  double _unit(num value) => value.clamp(0.0, 1.0).toDouble();
}

final class _WeightedSignal {
  const _WeightedSignal({required this.score, required this.weight});

  final double score;
  final double weight;
}
