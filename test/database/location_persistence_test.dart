import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/database/app_database.dart';
import 'package:smart_memory_preservation/core/database/memory_snapshot_repository.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';
import '../support/library_fixture.dart';

void main() {
  test(
    'structured place and negative GPS check survive snapshot reload',
    () async {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);
      final repository = MemorySnapshotRepository(database);
      final source = libraryFixture().events.single;
      final checked = MediaItem(
        id: 'no-gps',
        assetIdentifier: 'no-gps',
        kind: MediaKind.image,
        capturedAt: source.startAt,
        width: 10,
        height: 10,
      ).withCaptureLocation(null);
      await repository.save(
        MemorySnapshot(
          events: [
            source.copyWith(
              place: const MemoryPlace(
                id: 'place',
                name: 'College, Karur',
                latitude: 10.96,
                longitude: 78.08,
                locality: 'College',
                city: 'Karur',
                state: 'Tamil Nadu',
                country: 'India',
                formattedAddress: 'College, Karur, Tamil Nadu, India',
                isConfirmed: true,
              ),
            ),
          ],
          unassignedMedia: [checked],
        ),
      );
      final loaded = await repository.load();
      final place = loaded.events.single.place!;
      expect(
        [
          place.locality,
          place.city,
          place.state,
          place.country,
          place.formattedAddress,
        ],
        [
          'College',
          'Karur',
          'Tamil Nadu',
          'India',
          'College, Karur, Tamil Nadu, India',
        ],
      );
      expect(place.latitude, 10.96);
      expect(loaded.unassignedMedia.single.locationChecked, isTrue);
      expect(loaded.unassignedMedia.single.captureLocation, isNull);
      expect(
        loaded.unassignedMedia.single.capturedAt.toUtc(),
        source.startAt.toUtc(),
      );
    },
  );
}
