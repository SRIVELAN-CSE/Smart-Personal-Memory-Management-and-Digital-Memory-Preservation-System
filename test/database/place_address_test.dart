import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/database/app_database.dart';
import 'package:smart_memory_preservation/core/database/memory_snapshot_repository.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';
import '../support/library_fixture.dart';

void main() {
  test('all optional address fields persist with manual context', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = MemorySnapshotRepository(database);
    final event = libraryFixture().events.single.copyWith(
      place: const MemoryPlace(
        id: 'place',
        name: 'Campus',
        latitude: 10.96,
        longitude: 78.08,
        isConfirmed: true,
        locality: 'College area',
        city: 'Karur',
        region: 'Tamil Nadu',
        country: 'India',
        formattedAddress: 'Campus, Karur, Tamil Nadu, India',
      ),
    );
    await repository.save(MemorySnapshot(events: [event]));
    final restored = (await repository.load()).events.single;
    expect(restored.story, event.story);
    expect(restored.place?.city, 'Karur');
    expect(restored.place?.locality, 'College area');
    expect(restored.place?.region, 'Tamil Nadu');
    expect(restored.place?.country, 'India');
    expect(restored.place?.formattedAddress, event.place!.formattedAddress);
  });
}
