import 'factor_contribution.dart';

/// A normalized score together with every factor needed to explain it.
final class ScoreBreakdown {
  ScoreBreakdown({
    required this.algorithmVersion,
    required List<FactorContribution> contributions,
  }) : assert(algorithmVersion != ''),
       contributions = List<FactorContribution>.unmodifiable(contributions),
       score = _score(contributions);

  final String algorithmVersion;
  final double score;
  final List<FactorContribution> contributions;

  FactorContribution factor(String key) =>
      contributions.firstWhere((factor) => factor.key == key);

  static double _score(List<FactorContribution> factors) {
    final value = factors
        .fold<double>(0, (total, factor) => total + factor.contribution)
        .clamp(0.0, 1.0)
        .toDouble();
    if (value < 0.000000000001) {
      return 0;
    }
    if (value > 0.999999999999) {
      return 1;
    }
    return value;
  }
}
