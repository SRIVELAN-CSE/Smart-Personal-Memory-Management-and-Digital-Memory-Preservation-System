import '../../../core/models/memory_models.dart';
import 'event_filter.dart';

String normalizeSearch(String text) =>
    text.toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' ');

/// Built once per library revision. Reuses restored state, with no per-keystroke
/// database queries or duplicate copies of the library's media bytes.
class EventSearchIndex {
  EventSearchIndex(Iterable<MemoryEvent> events)
    : _entries = events.map(_SearchEntry.new).toList()
        ..sort((a, b) => b.event.startAt.compareTo(a.event.startAt));
  final List<_SearchEntry> _entries;

  List<MemoryEvent> search(
    EventFilter filter, {
    bool includeSensitive = false,
  }) {
    final terms = normalizeSearch(
      filter.query,
    ).split(' ').where((term) => term.isNotEmpty).toList();
    final person = normalizeSearch(filter.person);
    final location = normalizeSearch(filter.location);
    return [
      for (final row in _entries)
        if ((!row.event.isSensitive ||
                (includeSensitive && !filter.hasCriteria)) &&
            terms.every(row.text.contains) &&
            (filter.personId == null
                ? person.isEmpty ||
                      row.people.any((name) => name.contains(person))
                : row.event.people.any((p) => p.id == filter.personId)) &&
            (location.isEmpty || row.location.contains(location)) &&
            (filter.dates == null ||
                filter.dates!.overlaps(row.event.startAt, row.event.endAt)))
          row.event,
    ];
  }
}

class _SearchEntry {
  _SearchEntry(this.event) {
    people = event.people.map((p) => normalizeSearch(p.name)).toList();
    location = normalizeSearch(event.resolvedPlace?.searchText ?? '');
    text = '${normalizeSearch(event.title)} ${people.join(' ')} $location';
  }
  final MemoryEvent event;
  late final List<String> people;
  late final String location, text;
}
