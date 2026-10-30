import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/core/models/memory_models.dart';
import 'package:smart_memory_preservation/features/timeline/domain/event_filter.dart';
import '../support/library_fixture.dart';

void main() {
  test('all presets use local calendar boundaries', () {
    final now = DateTime(2026, 10, 26, 23, 59);
    final expected = {
      DatePreset.today: (DateTime(2026, 10, 26), DateTime(2026, 10, 27)),
      DatePreset.yesterday: (DateTime(2026, 10, 25), DateTime(2026, 10, 26)),
      DatePreset.last2Days: (DateTime(2026, 10, 25), DateTime(2026, 10, 27)),
      DatePreset.last7Days: (DateTime(2026, 10, 20), DateTime(2026, 10, 27)),
      DatePreset.lastWeek: (DateTime(2026, 10, 19), DateTime(2026, 10, 26)),
      DatePreset.last30Days: (DateTime(2026, 9, 27), DateTime(2026, 10, 27)),
      DatePreset.lastMonth: (DateTime(2026, 9), DateTime(2026, 10)),
      DatePreset.lastYear: (DateTime(2025), DateTime(2026)),
    };
    for (final entry in expected.entries) {
      final range = EventDateRange.preset(entry.key, now);
      expect(range.start, entry.value.$1);
      expect(range.endExclusive, entry.value.$2);
      expect(range.start.isUtc, isFalse);
    }
    final leap = EventDateRange.preset(
      DatePreset.lastMonth,
      DateTime(2024, 3, 31),
    );
    expect(leap.start, DateTime(2024, 2, 1));
    expect(leap.endExclusive, DateTime(2024, 3, 1));
    final january = EventDateRange.preset(
      DatePreset.lastWeek,
      DateTime(2026, 1, 1),
    );
    expect(january.start, DateTime(2025, 12, 22));
    expect(january.endExclusive, DateTime(2025, 12, 29));
  });
  test(
    'custom range includes last instant, excludes next midnight and overlaps events',
    () {
      final range = EventDateRange.custom(
        DateTime(2026, 8, 1, 12),
        DateTime(2026, 8, 2),
      );
      final event = libraryFixture().events.single;
      expect(
        range.overlaps(
          event.copyWith(
            startAt: DateTime(2026, 7, 31),
            endAt: DateTime(2026, 8, 1),
          ),
        ),
        isTrue,
      );
      expect(
        range.overlaps(
          event.copyWith(
            startAt: DateTime(2026, 8, 2, 23, 59, 59, 999, 999),
            endAt: DateTime(2026, 8, 3),
          ),
        ),
        isTrue,
      );
      expect(
        range.overlaps(
          event.copyWith(
            startAt: DateTime(2026, 8, 3),
            endAt: DateTime(2026, 8, 3),
          ),
        ),
        isFalse,
      );
      expect(
        () => EventDateRange.custom(DateTime(2026, 8, 3), DateTime(2026, 8, 2)),
        throwsArgumentError,
      );
    },
  );
  test(
    'title, actual person tags, structured place and dates combine and reset',
    () {
      final event = libraryFixture().events.single.copyWith(
        place: const MemoryPlace(
          id: 'p',
          name: 'Campus hall',
          city: 'Karur',
          locality: 'North',
          country: 'India',
          isConfirmed: true,
        ),
      );
      final index = EventSearchIndex([event]);
      expect(index.search(const EventFilter(query: 'gallery')), [event]);
      expect(index.search(const EventFilter(query: 'ASHA Karur')), [event]);
      expect(
        index.search(const EventFilter(personName: 'Asha', location: 'north')),
        [event],
      );
      expect(index.search(const EventFilter(personName: 'gallery')), isEmpty);
      expect(index.search(const EventFilter(personId: 'wrong')), isEmpty);
      expect(
        index.search(
          EventFilter(
            personId: 'saved_person',
            location: 'India',
            dates: EventDateRange.custom(
              DateTime(2026, 8, 1),
              DateTime(2026, 8, 1),
            ),
          ),
        ),
        [event],
      );
      expect(
        index.search(
          EventFilter(
            personId: 'saved_person',
            dates: EventDateRange.custom(
              DateTime(2025),
              DateTime(2025, 12, 31),
            ),
          ),
        ),
        isEmpty,
      );
      expect(index.search(const EventFilter()), [event]);
      expect(index.search(const EventFilter(query: "%' OR 1=1 --")), isEmpty);
    },
  );
}
