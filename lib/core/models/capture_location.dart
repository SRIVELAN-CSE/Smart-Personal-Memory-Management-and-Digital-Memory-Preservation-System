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
}
