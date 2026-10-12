import '../../../core/models/memory_models.dart';
import '../../../routing/memory_destination.dart';

class MemoryGraphNode {
  const MemoryGraphNode(this.key, this.label, this.kind, this.target);
  final String key;
  final String label;
  final String kind;
  final MemoryDestination target;
}

/// Bounded graph with explicit targets. IDs are encoded, never split to route.
class MemoryGraphData {
  MemoryGraphData(List<MemoryEvent> events) {
    for (final event in events.where((e) => !e.isSensitive).take(8)) {
      final root = 'event/${Uri.encodeComponent(event.id)}';
      final eventTarget = MemoryDestination(
        type: MemoryTargetType.event,
        id: event.id,
        title: event.title,
      );
      nodes[root] = MemoryGraphNode(root, event.title, 'event', eventTarget);
      void add(
        String key,
        String label,
        String kind,
        MemoryDestination target,
      ) {
        nodes[key] = MemoryGraphNode(key, label, kind, target);
        edges.add((root, key));
      }

      for (final media in event.media.take(5)) {
        add(
          '$root/media/${Uri.encodeComponent(media.id)}',
          '${media.kind == MediaKind.image ? 'Photo' : 'Video'} ${event.media.indexOf(media) + 1}',
          'media',
          MemoryDestination(
            type: MemoryTargetType.media,
            id: media.id,
            eventId: event.id,
            title: media.kind.name,
          ),
        );
      }
      for (final person in event.people.take(5)) {
        add(
          'person/${Uri.encodeComponent(person.id)}',
          person.name,
          'person',
          MemoryDestination(
            type: MemoryTargetType.person,
            id: person.id,
            title: person.name,
          ),
        );
      }
      final place = event.resolvedPlace;
      add(
        place == null
            ? '$root/place'
            : 'place/${Uri.encodeComponent(place.id)}',
        event.locationLabel,
        'place',
        place == null
            ? eventTarget
            : MemoryDestination(
                type: MemoryTargetType.location,
                id: place.id,
                title: place.name,
              ),
      );
      if (event.hasStory) {
        add('$root/note', 'Personal story', 'note', eventTarget);
      }
      if (event.hasVoiceNote) {
        add('$root/voice', 'Voice note', 'voice', eventTarget);
      }
    }
  }
  final Map<String, MemoryGraphNode> nodes = {};
  final List<(String, String)> edges = [];
}
