final class ClusteringConfig {
  const ClusteringConfig({
    this.algorithmVersion = 'hybrid-adjacent-v1',
    this.strongTimeThreshold = const Duration(hours: 4),
    this.weakTimeThreshold = const Duration(hours: 12),
    this.maximumClusterSpan = const Duration(hours: 36),
    this.nearbyDistanceKm = 10,
    this.timeWeight = 0.50,
    this.locationWeight = 0.20,
    this.ocrWeight = 0.20,
    this.visualWeight = 0.10,
    this.strongJoinThreshold = 0.55,
    this.weakJoinThreshold = 0.65,
    this.locationSupportThreshold = 0.50,
    this.ocrSupportThreshold = 0.35,
    this.visualSupportThreshold = 0.75,
    this.minimumOcrTokenCount = 2,
    this.ocrStopWords = const {
      'a',
      'an',
      'and',
      'at',
      'in',
      'of',
      'on',
      'the',
      'to',
    },
  }) : assert(algorithmVersion != ''),
       assert(nearbyDistanceKm > 0),
       assert(timeWeight >= 0),
       assert(locationWeight >= 0),
       assert(ocrWeight >= 0),
       assert(visualWeight >= 0),
       assert(timeWeight + locationWeight + ocrWeight + visualWeight > 0),
       assert(strongJoinThreshold >= 0 && strongJoinThreshold <= 1),
       assert(weakJoinThreshold >= 0 && weakJoinThreshold <= 1),
       assert(locationSupportThreshold >= 0 && locationSupportThreshold <= 1),
       assert(ocrSupportThreshold >= 0 && ocrSupportThreshold <= 1),
       assert(visualSupportThreshold >= 0 && visualSupportThreshold <= 1),
       assert(minimumOcrTokenCount > 0);

  final String algorithmVersion;
  final Duration strongTimeThreshold;
  final Duration weakTimeThreshold;
  final Duration maximumClusterSpan;
  final double nearbyDistanceKm;
  final double timeWeight;
  final double locationWeight;
  final double ocrWeight;
  final double visualWeight;
  final double strongJoinThreshold;
  final double weakJoinThreshold;
  final double locationSupportThreshold;
  final double ocrSupportThreshold;
  final double visualSupportThreshold;
  final int minimumOcrTokenCount;
  final Set<String> ocrStopWords;

  double get totalWeight =>
      timeWeight + locationWeight + ocrWeight + visualWeight;

  void validate() {
    if (strongTimeThreshold > weakTimeThreshold) {
      throw ArgumentError(
        'strongTimeThreshold must not exceed weakTimeThreshold.',
      );
    }
    if (maximumClusterSpan < weakTimeThreshold) {
      throw ArgumentError(
        'maximumClusterSpan must be at least weakTimeThreshold.',
      );
    }
  }
}
