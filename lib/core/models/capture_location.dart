/// Coordinates embedded in gallery media, never the device's current location.
class CaptureLocation {
  const CaptureLocation._(this.latitude, this.longitude);

  final double latitude;
  final double longitude;

  static CaptureLocation? fromCoordinates(double? latitude, double? longitude) {
    if (latitude == null ||
        longitude == null ||
        !latitude.isFinite ||
        !longitude.isFinite ||
        latitude.abs() > 90 ||
        longitude.abs() > 180 ||
        (latitude == 0 && longitude == 0)) {
      // Gallery providers can report (0, 0) when GPS metadata is absent.
      return null;
    }
    return CaptureLocation._(latitude, longitude);
  }

  String get label =>
      '${latitude.abs().toStringAsFixed(5)}° ${latitude < 0 ? 'S' : 'N'}, '
      '${longitude.abs().toStringAsFixed(5)}° ${longitude < 0 ? 'W' : 'E'}';

  String get key => '$latitude,$longitude';

  /// Densest 0.01-degree grid cell (roughly 1.1 km north/south). Each photo
  /// casts one vote. Ties keep input order, which callers sort by capture time
  /// then media ID. Return the real coordinate nearest that cell's centroid,
  /// never a fabricated coordinate. O(n), including for large event groups.
  static CaptureLocation? representative(Iterable<CaptureLocation> points) {
    final cells = <(int, int), List<CaptureLocation>>{};
    for (final point in points) {
      final cell = (
        (point.latitude * 100).floor(),
        (point.longitude * 100).floor(),
      );
      (cells[cell] ??= []).add(point);
    }
    if (cells.isEmpty) return null;
    final cluster = cells.values.reduce((a, b) => a.length >= b.length ? a : b);
    final latitude =
        cluster.fold<double>(0, (sum, p) => sum + p.latitude) / cluster.length;
    final longitude =
        cluster.fold<double>(0, (sum, p) => sum + p.longitude) / cluster.length;
    double distance(CaptureLocation p) =>
        (p.latitude - latitude) * (p.latitude - latitude) +
        (p.longitude - longitude) * (p.longitude - longitude);
    return cluster.reduce((a, b) => distance(a) <= distance(b) ? a : b);
  }
}
