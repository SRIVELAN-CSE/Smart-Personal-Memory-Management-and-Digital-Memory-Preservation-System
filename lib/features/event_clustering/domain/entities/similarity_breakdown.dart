/// Explainable similarity values for a pair of media items.
///
/// A null component means the evidence was unavailable. It is different from a
/// score of zero, which means evidence was available and indicated no match.
final class SimilarityBreakdown {
  SimilarityBreakdown({
    required this.timeSimilarity,
    required this.locationSimilarity,
    required this.ocrSimilarity,
    required this.visualSimilarity,
    required this.combinedScore,
    required this.evidenceCoverage,
    required this.hasSupportingEvidence,
    required List<String> reasonCodes,
  }) : reasonCodes = List<String>.unmodifiable(reasonCodes);

  final double? timeSimilarity;
  final double? locationSimilarity;
  final double? ocrSimilarity;
  final double? visualSimilarity;
  final double combinedScore;
  final double evidenceCoverage;

  /// True when location, OCR, or visual evidence independently reaches its
  /// configured support threshold.
  final bool hasSupportingEvidence;
  final List<String> reasonCodes;
}
