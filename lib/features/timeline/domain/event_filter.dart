import '../../../core/models/memory_models.dart';

enum DatePreset {
  today('Today'),
  yesterday('Yesterday'),
  last2Days('Last 2 days'),
  last7Days('Last 7 days'),
  lastWeek('Last week'),
  last30Days('Last 30 days'),
  lastMonth('Last month'),
  lastYear('Last year');

  const DatePreset(this.label);
  final String label;
}

/// Local calendar days, with an exclusive next-midnight boundary. Constructing
/// calendar dates (not adding 24 hours) handles daylight-saving transitions.
class EventDateRange {
  const EventDateRange(this.start, this.endExclusive);
  factory EventDateRange.custom(DateTime first, DateTime last) {
    final start = DateTime(first.year, first.month, first.day);
    final end = DateTime(last.year, last.month, last.day + 1);
    if (!end.isAfter(start)) throw ArgumentError('End must follow start');
    return EventDateRange(start, end);
  }
  factory EventDateRange.preset(DatePreset preset, DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    return switch (preset) {
      DatePreset.today => EventDateRange(today, tomorrow),
      DatePreset.yesterday => EventDateRange(
        DateTime(now.year, now.month, now.day - 1),
        today,
      ),
      DatePreset.last2Days => EventDateRange(
        DateTime(now.year, now.month, now.day - 1),
        tomorrow,
      ),
      DatePreset.last7Days => EventDateRange(
        DateTime(now.year, now.month, now.day - 6),
        tomorrow,
      ),
      DatePreset.last30Days => EventDateRange(
        DateTime(now.year, now.month, now.day - 29),
        tomorrow,
      ),
      DatePreset.lastWeek => EventDateRange(
        DateTime(now.year, now.month, now.day - today.weekday - 6),
        DateTime(now.year, now.month, now.day - today.weekday + 1),
      ),
      DatePreset.lastMonth => EventDateRange(
        DateTime(now.year, now.month - 1),
        DateTime(now.year, now.month),
      ),
      DatePreset.lastYear => EventDateRange(
        DateTime(now.year - 1),
        DateTime(now.year),
      ),
    };
  }
  final DateTime start, endExclusive;
  bool overlaps(MemoryEvent event) =>
      event.startAt.isBefore(endExclusive) && !event.endAt.isBefore(start);
  String get label =>
      '${_date(start)} – ${_date(DateTime(endExclusive.year, endExclusive.month, endExclusive.day - 1))}';
  static String _date(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

class EventFilter {
  const EventFilter({
    this.query = '',
    this.personId,
    this.personName,
    this.location,
    this.dates,
    this.favouritesOnly = false,
  });
  final String query;
  final String? personId, personName, location;
  final EventDateRange? dates;
  final bool favouritesOnly;
  bool get isEmpty =>
      query.trim().isEmpty &&
      personId == null &&
      personName == null &&
      location == null &&
      dates == null &&
      !favouritesOnly;
}

/// A reusable projection of the already-loaded library. Built once when events
/// change, never reloads SQLite or reparses metadata on search keystrokes.
class EventSearchIndex {
  EventSearchIndex(Iterable<MemoryEvent> events)
    : _entries = [
        for (final event in events)
          _Entry(
            event,
            [
              event.title,
              ...event.people.map((p) => p.name),
              event.resolvedPlace?.searchText ?? '',
            ].join(' ').toLowerCase(),
            event.resolvedPlace?.searchText.toLowerCase() ?? '',
          ),
      ];
  final List<_Entry> _entries;
  List<MemoryEvent> search(EventFilter filter) {
    final terms = filter.query
        .toLowerCase()
        .trim()
        .split(RegExp(r'\s+'))
        .where((s) => s.isNotEmpty);
    final found = _entries
        .where((entry) {
          final event = entry.event;
          return terms.every(entry.text.contains) &&
              (!filter.favouritesOnly || event.isFavourite) &&
              (filter.personId == null ||
                  event.people.any((p) => p.id == filter.personId)) &&
              (filter.personName == null ||
                  event.people.any(
                    (p) => p.name.toLowerCase().contains(
                      filter.personName!.toLowerCase(),
                    ),
                  )) &&
              (filter.location == null ||
                  entry.location.contains(filter.location!.toLowerCase())) &&
              (filter.dates == null || filter.dates!.overlaps(event));
        })
        .map((entry) => entry.event)
        .toList();
    found.sort((a, b) {
      final date = b.startAt.compareTo(a.startAt);
      return date != 0 ? date : a.id.compareTo(b.id);
    });
    return found;
  }
}

class _Entry {
  const _Entry(this.event, this.text, this.location);
  final MemoryEvent event;
  final String text, location;
}
