import '../core/models/memory_models.dart';
import '../features/timeline/domain/event_filter.dart';

enum MemoryTargetType { event, media, person, location }

/// Shared structured navigation for graph and companion; labels never serve as
/// event IDs. Resolve again at tap time to reject deleted/hidden records.
class MemoryDestination {
  const MemoryDestination({
    required this.type,
    required this.id,
    required this.title,
    this.eventId,
  });
  final MemoryTargetType type;
  final String id;
  final String title;
  final String? eventId;

  ({String title, String route})? resolve(List<MemoryEvent> library) {
    final events = library.where((event) => !event.isSensitive);
    switch (type) {
      case MemoryTargetType.event:
        final event = events.where((e) => e.id == id).firstOrNull;
        return event == null
            ? null
            : (title: event.title, route: eventRoute(event.id));
      case MemoryTargetType.media:
        final event = events.where((e) => e.id == eventId).firstOrNull;
        final media = event?.media.where((m) => m.id == id).firstOrNull;
        return media == null
            ? null
            : (
                title:
                    '${media.kind == MediaKind.image ? 'Photo' : 'Video'} ${event!.media.indexOf(media) + 1} · ${event.title}',
                route: eventRoute(event.id, mediaId: media.id),
              );
      case MemoryTargetType.person:
        final person = events
            .expand((e) => e.people)
            .where((p) => p.id == id)
            .firstOrNull;
        return person == null
            ? null
            : (
                title: person.name,
                route: timelineRoute(
                  EventFilter(personId: person.id, person: person.name),
                ),
              );
      case MemoryTargetType.location:
        final place = events
            .map((e) => e.resolvedPlace)
            .whereType<MemoryPlace>()
            .where((p) => p.id == id)
            .firstOrNull;
        return place == null
            ? null
            : (
                title: place.name,
                route: timelineRoute(EventFilter(location: place.name)),
              );
    }
  }
}

String timelineRoute(EventFilter filter) => Uri(
  path: '/timeline',
  queryParameters: filter.parameters.isEmpty ? null : filter.parameters,
).toString();

String eventRoute(String id, {String? mediaId}) =>
    '/event/${Uri.encodeComponent(id)}${mediaId == null ? '' : '?${Uri(queryParameters: {'media': mediaId}).query}'}';
