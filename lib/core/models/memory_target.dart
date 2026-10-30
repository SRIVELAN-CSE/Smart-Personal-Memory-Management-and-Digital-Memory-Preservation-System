import 'memory_models.dart';

enum MemoryTargetType { event, media, person, location }

/// Shared by the graph and chatbot. IDs are data, never parsed out of labels.
class MemoryTarget {
  const MemoryTarget({
    required this.type,
    required this.id,
    required this.title,
    this.eventId,
  });
  final MemoryTargetType type;
  final String id, title;
  final String? eventId;
  String get route => switch (type) {
    MemoryTargetType.event => '/event/${Uri.encodeComponent(id)}',
    MemoryTargetType.media =>
      '/event/${Uri.encodeComponent(eventId!)}?${Uri(queryParameters: {'media': id}).query}',
    MemoryTargetType.person => Uri(
      path: '/timeline',
      queryParameters: {'person': id},
    ).toString(),
    MemoryTargetType.location => Uri(
      path: '/timeline',
      queryParameters: {'location': id},
    ).toString(),
  };
  bool available(Iterable<MemoryEvent> events) => switch (type) {
    MemoryTargetType.event => events.any((e) => e.id == id && !e.isSensitive),
    MemoryTargetType.media => events.any(
      (e) =>
          e.id == eventId && !e.isSensitive && e.media.any((m) => m.id == id),
    ),
    MemoryTargetType.person => events.any(
      (e) => !e.isSensitive && e.people.any((p) => p.id == id),
    ),
    MemoryTargetType.location =>
      id.trim().isNotEmpty &&
          events.any(
            (e) =>
                !e.isSensitive &&
                (e.resolvedPlace?.searchText.toLowerCase().contains(
                      id.toLowerCase(),
                    ) ??
                    false),
          ),
  };
}
