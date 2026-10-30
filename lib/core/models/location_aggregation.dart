import 'dart:math' as math;

import 'capture_location.dart';

/// Select the densest 1 km neighbourhood, then its medoid. Sorted coordinates
/// break ties deterministically, independent of import order. Never averages
/// distant trips into an invented location. Duplicate samples retain weight.
CaptureLocation? representativeLocation(Iterable<CaptureLocation> samples) {
  final counts = <String, int>{};
  final unique = <String, CaptureLocation>{};
  for (final point in samples) {
    counts.update(point.key, (count) => count + 1, ifAbsent: () => 1);
    unique[point.key] = point;
  }
  final points = unique.values.toList()
    ..sort((a, b) {
      final latitude = a.latitude.compareTo(b.latitude);
      return latitude != 0 ? latitude : a.longitude.compareTo(b.longitude);
    });
  if (points.isEmpty) return null;
  var cluster = <CaptureLocation>[];
  var clusterCount = 0;
  for (final point in points) {
    final neighbours = points
        .where((other) => _distance(point, other) <= 1)
        .toList();
    final count = neighbours.fold<int>(
      0,
      (sum, point) => sum + counts[point.key]!,
    );
    if (count > clusterCount) {
      cluster = neighbours;
      clusterCount = count;
    }
  }
  var best = cluster.first;
  var bestDistance = double.infinity;
  for (final candidate in cluster) {
    final distance = cluster.fold<double>(
      0,
      (sum, point) => sum + _distance(candidate, point) * counts[point.key]!,
    );
    if (distance < bestDistance) {
      bestDistance = distance;
      best = candidate;
    }
  }
  return best;
}

double _distance(CaptureLocation a, CaptureLocation b) {
  const radians = math.pi / 180;
  final dLat = (b.latitude - a.latitude) * radians;
  final dLon = (b.longitude - a.longitude) * radians;
  final h =
      math.pow(math.sin(dLat / 2), 2) +
      math.cos(a.latitude * radians) *
          math.cos(b.latitude * radians) *
          math.pow(math.sin(dLon / 2), 2);
  return 6371 * 2 * math.asin(math.sqrt(h.clamp(0, 1)));
}
