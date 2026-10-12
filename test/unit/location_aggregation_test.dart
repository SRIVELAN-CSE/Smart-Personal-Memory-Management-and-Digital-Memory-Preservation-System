import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/models/capture_location.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';
import '../support/library_fixture.dart';

void main() {
  test('largest GPS group wins over an unrelated first photo', () {
    final event = libraryFixture().events.single.copyWith(
      clearPlace: true,
      media: [
        photo('a', 40, 70),
        photo('b', 10.961, 78.081),
        photo('c', 10.962, 78.082),
        photo('d', 10.963, 78.083),
      ],
    );
    expect(event.primaryCaptureLocation?.latitude, 10.962);
    expect(event.resolvedPlace?.latitude, 10.962);
    expect(
      event
          .copyWith(media: event.media.reversed.toList())
          .primaryCaptureLocation
          ?.key,
      event.primaryCaptureLocation?.key,
    );
  });
  test('ties use capture time then ID; missing data has no invented place', () {
    final event = libraryFixture().events.single.copyWith(
      clearPlace: true,
      media: [photo('b', 30, 70), photo('a', 10, 70)],
    );
    expect(event.primaryCaptureLocation?.latitude, 10);
    expect(CaptureLocation.representative([]), isNull);
    expect(event.copyWith(media: []).locationLabel, 'Location unavailable');
  });
  test('confirmed place survives coordinate aggregation', () {
    final event = libraryFixture().events.single.copyWith(
      media: [photo('a', 40, 70)],
    );
    expect(event.locationLabel, 'Campus hall');
  });
}

MediaItem photo(String id, double lat, double lon) => MediaItem(
  id: id,
  assetIdentifier: id,
  kind: MediaKind.image,
  capturedAt: DateTime.utc(2026, 1, 1),
  width: 10,
  height: 10,
  latitude: lat,
  longitude: lon,
);
