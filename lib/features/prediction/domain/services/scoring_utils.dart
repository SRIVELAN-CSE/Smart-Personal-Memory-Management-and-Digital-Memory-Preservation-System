double unitScore(num value) {
  final clamped = value.clamp(0.0, 1.0).toDouble();
  if (clamped < 0.000000000001) {
    return 0;
  }
  if (clamped > 0.999999999999) {
    return 1;
  }
  return clamped;
}

double booleanScore(bool value) => value ? 1 : 0;

void validateNormalizedWeights(Iterable<double> weights) {
  final values = weights.toList(growable: false);
  if (values.any((weight) => !weight.isFinite || weight < 0 || weight > 1)) {
    throw ArgumentError.value(
      values,
      'weights',
      'Each weight must be in [0, 1].',
    );
  }
  final total = values.fold<double>(0, (sum, value) => sum + value);
  if ((total - 1).abs() > 0.000001) {
    throw ArgumentError.value(total, 'weights', 'Weights must add up to 1.');
  }
}
