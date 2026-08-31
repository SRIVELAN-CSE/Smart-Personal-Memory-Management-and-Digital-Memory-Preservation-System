/// One auditable contribution to an explainable score.
final class FactorContribution {
  const FactorContribution({
    required this.key,
    required this.rawValue,
    required this.normalizedValue,
    required this.weight,
    required this.reasonCode,
  }) : assert(key != ''),
       assert(normalizedValue >= 0 && normalizedValue <= 1),
       assert(weight >= 0 && weight <= 1);

  final String key;
  final double rawValue;
  final double normalizedValue;
  final double weight;
  final String reasonCode;

  double get contribution => normalizedValue * weight;
}
