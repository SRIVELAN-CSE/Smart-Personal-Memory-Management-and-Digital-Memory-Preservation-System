import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/models/capture_location.dart';
import 'package:smart_memory_preservation/core/models/location_aggregation.dart';

void main() {
  test('largest nearby cluster wins over an unrelated first photo', () {
    final points = [
      (40.0, -73.0),
      (10.96, 78.08),
      (10.961, 78.081),
      (10.962, 78.082),
    ].map((p) => CaptureLocation.fromCoordinates(p.$1, p.$2)!).toList();
    final result = representativeLocation(points)!;
    expect(result.latitude, 10.961);
    expect(representativeLocation(points.reversed)!.key, result.key);
    expect(representativeLocation([]), isNull);
  });
  test('ties are independent of media order and longitude wraps', () {
    final points = [
      (10.0, 179.999),
      (10.0, -179.999),
      (40.0, 0.0),
    ].map((p) => CaptureLocation.fromCoordinates(p.$1, p.$2)!).toList();
    expect(representativeLocation(points)!.latitude, 10);
    expect(
      representativeLocation(points)!.key,
      representativeLocation(points.reversed)!.key,
    );
  });
}
