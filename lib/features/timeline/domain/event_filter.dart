/// Calendar ranges are local-midnight, inclusive start / exclusive next-day end.
/// Events match when their capture interval overlaps the range.
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

class EventDateRange {
  const EventDateRange(this.start, this.endExclusive);
  final DateTime start;
  final DateTime endExclusive;

  factory EventDateRange.days(DateTime first, DateTime last) {
    final start = DateTime(first.year, first.month, first.day);
    final end = DateTime(last.year, last.month, last.day + 1);
    if (!end.isAfter(start)) throw ArgumentError('Invalid date range');
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
        DateTime(now.year, now.month, now.day - now.weekday - 6),
        DateTime(now.year, now.month, now.day - now.weekday + 1),
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

  bool overlaps(DateTime first, DateTime last) =>
      first.isBefore(endExclusive) && !last.isBefore(start);
}

class EventFilter {
  const EventFilter({
    this.query = '',
    this.personId,
    this.person = '',
    this.location = '',
    this.dates,
    this.dateLabel,
  });
  final String query;
  final String? personId;
  final String person;
  final String location;
  final EventDateRange? dates;
  final String? dateLabel;
  bool get hasCriteria =>
      query.trim().isNotEmpty ||
      personId != null ||
      person.trim().isNotEmpty ||
      location.trim().isNotEmpty ||
      dates != null;

  EventFilter copyWith({
    String? query,
    String? personId,
    String? person,
    String? location,
    EventDateRange? dates,
    String? dateLabel,
    bool clearPerson = false,
    bool clearDates = false,
  }) => EventFilter(
    query: query ?? this.query,
    personId: clearPerson ? null : personId ?? this.personId,
    person: clearPerson ? '' : person ?? this.person,
    location: location ?? this.location,
    dates: clearDates ? null : dates ?? this.dates,
    dateLabel: clearDates ? null : dateLabel ?? this.dateLabel,
  );

  Map<String, String> get parameters => {
    if (query.isNotEmpty) 'q': query,
    if (personId != null) 'personId': personId!,
    if (person.isNotEmpty) 'person': person,
    if (location.isNotEmpty) 'location': location,
    if (dates != null) 'from': dates!.start.toIso8601String(),
    if (dates != null) 'until': dates!.endExclusive.toIso8601String(),
    if (dateLabel != null) 'dateLabel': dateLabel!,
  };

  factory EventFilter.fromParameters(Map<String, String> p) {
    final start = DateTime.tryParse(p['from'] ?? '');
    final end = DateTime.tryParse(p['until'] ?? '');
    return EventFilter(
      query: p['q'] ?? '',
      personId: p['personId'],
      person: p['person'] ?? '',
      location: p['location'] ?? '',
      dates: start != null && end != null && end.isAfter(start)
          ? EventDateRange(start, end)
          : null,
      dateLabel: p['dateLabel'],
    );
  }
}
