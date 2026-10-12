import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';
import 'package:smart_memory_preservation/features/timeline/domain/event_filter.dart';
import 'package:smart_memory_preservation/features/timeline/domain/event_search_index.dart';
import '../support/library_fixture.dart';

void main() {
  final now = DateTime(2026, 1, 1, 15, 30);
  test('all presets use calendar boundaries, including year rollover', () {
    final expected = <DatePreset, (DateTime, DateTime)>{
      DatePreset.today: (DateTime(2026), DateTime(2026, 1, 2)),
      DatePreset.yesterday: (DateTime(2025, 12, 31), DateTime(2026)),
      DatePreset.last2Days: (DateTime(2025, 12, 31), DateTime(2026, 1, 2)),
      DatePreset.last7Days: (DateTime(2025, 12, 26), DateTime(2026, 1, 2)),
      DatePreset.last30Days: (DateTime(2025, 12, 3), DateTime(2026, 1, 2)),
      DatePreset.lastWeek: (DateTime(2025, 12, 22), DateTime(2025, 12, 29)),
      DatePreset.lastMonth: (DateTime(2025, 12), DateTime(2026)),
      DatePreset.lastYear: (DateTime(2025), DateTime(2026)),
    };
    for (final entry in expected.entries) {
      final range = EventDateRange.preset(entry.key, now);
      expect(
        (range.start, range.endExclusive),
        entry.value,
        reason: entry.key.name,
      );
    }
  });
  test('previous week Monday-Sunday, leap month and inclusive custom end', () {
    final monday = EventDateRange.preset(
      DatePreset.lastWeek,
      DateTime(2024, 3, 4),
    );
    expect(monday.start, DateTime(2024, 2, 26));
    expect(monday.endExclusive, DateTime(2024, 3, 4));
    final month = EventDateRange.preset(
      DatePreset.lastMonth,
      DateTime(2024, 3, 31),
    );
    expect(month.endExclusive.difference(month.start).inDays, 29);
    final range = EventDateRange.days(
      DateTime(2026, 8, 1),
      DateTime(2026, 8, 2),
    );
    expect(range.overlaps(DateTime(2026, 7, 31), DateTime(2026, 8, 1)), isTrue);
    expect(
      range.overlaps(
        DateTime(2026, 8, 2, 23, 59, 59, 999),
        DateTime(2026, 8, 3),
      ),
      isTrue,
    );
    expect(range.overlaps(DateTime(2026, 8, 3), DateTime(2026, 8, 4)), isFalse);
    expect(
      () => EventDateRange.days(DateTime(2026, 8, 3), DateTime(2026, 8, 1)),
      throwsArgumentError,
    );
  });
  final saved = libraryFixture().events.single.copyWith(
    place: const MemoryPlace(
      id: 'place',
      name: 'Campus hall',
      city: 'Karur',
      region: 'Tamil Nadu',
      country: 'India',
      isConfirmed: true,
    ),
  );
  test('title, tags and structured places support combined filters', () {
    final index = EventSearchIndex([saved]);
    expect(index.search(const EventFilter(query: 'SAVED  karur')).length, 1);
    expect(
      index.search(const EventFilter(person: 'asha', location: 'india')).length,
      1,
    );
    expect(index.search(const EventFilter(person: 'saved')), isEmpty);
    expect(
      index.search(const EventFilter(personId: 'not_a_person', person: 'Asha')),
      isEmpty,
    );
    expect(index.search(const EventFilter(location: 'Asha')), isEmpty);
    final filter = EventFilter(
      query: 'saved',
      personId: 'saved_person',
      person: 'Asha',
      location: 'karur',
      dates: EventDateRange.days(DateTime(2020), DateTime(2020)),
    );
    expect(index.search(filter), isEmpty);
    final cleared = filter.copyWith(clearDates: true);
    expect(index.search(cleared).length, 1);
    expect(cleared.personId, 'saved_person');
    expect(cleared.copyWith(clearPerson: true).location, 'karur');
    expect(
      EventFilter.fromParameters(cleared.parameters).parameters,
      cleared.parameters,
    );
  });
  test('hidden memories cannot be discovered through search criteria', () {
    final index = EventSearchIndex([
      saved.copyWith(sensitivity: SensitivityLevel.hidden),
    ]);
    expect(
      index.search(const EventFilter(query: 'saved'), includeSensitive: true),
      isEmpty,
    );
    expect(index.search(const EventFilter()), isEmpty);
  });
}
