import '../../../core/models/memory_models.dart';
import '../../../core/models/memory_target.dart';

class MemoryGraphNode {
  const MemoryGraphNode(this.key, this.type, this.label, this.target);
  final String key, type, label;
  final MemoryTarget? target;
}

class MemoryGraphEdge {
  const MemoryGraphEdge(this.from, this.to, this.relation);
  final String from, to, relation;
}

class MemoryGraphProjection {
  MemoryGraphProjection(Iterable<MemoryEvent> events) {
    void link(String eventKey, MemoryGraphNode node, String relation) {
      nodes[node.key] = node;
      edges.add(MemoryGraphEdge(eventKey, node.key, relation));
    }

    for (final event in events.where((e) => !e.isSensitive).take(8)) {
      final key = 'event:${event.id}';
      final target = MemoryTarget(
        type: MemoryTargetType.event,
        id: event.id,
        title: event.title,
      );
      nodes[key] = MemoryGraphNode(key, 'event', event.title, target);
      for (final (index, media) in event.media.take(5).indexed) {
        link(
          key,
          MemoryGraphNode(
            'media:${Uri.encodeComponent(event.id)}:${Uri.encodeComponent(media.id)}',
            'media',
            '${media.kind == MediaKind.image ? 'Photo' : 'Video'} ${index + 1}',
            MemoryTarget(
              type: MemoryTargetType.media,
              id: media.id,
              eventId: event.id,
              title: 'Photo ${index + 1}',
            ),
          ),
          'contains',
        );
      }
      for (final person in event.people.take(5)) {
        link(
          key,
          MemoryGraphNode(
            'person:${person.id}',
            'person',
            person.name,
            MemoryTarget(
              type: MemoryTargetType.person,
              id: person.id,
              title: person.name,
            ),
          ),
          'tagged person',
        );
      }
      final place = event.resolvedPlace;
      if (place != null) {
        link(
          key,
          MemoryGraphNode(
            'place:${place.name.toLowerCase()}',
            'place',
            place.name,
            MemoryTarget(
              type: MemoryTargetType.location,
              id: place.name,
              title: place.name,
            ),
          ),
          'occurred at',
        );
      }
      if (place == null) {
        link(
          key,
          MemoryGraphNode(
            'unknown-place:${event.id}',
            'place',
            'Location unavailable',
            null,
          ),
          'location unknown',
        );
      }
      if (event.hasStory) {
        link(
          key,
          MemoryGraphNode('note:${event.id}', 'note', 'Personal story', target),
          'has story',
        );
      }
      if (event.hasVoiceNote) {
        link(
          key,
          MemoryGraphNode('voice:${event.id}', 'voice', 'Voice note', target),
          'has voice note',
        );
      }
    }
  }
  final Map<String, MemoryGraphNode> nodes = {};
  final List<MemoryGraphEdge> edges = [];
}
