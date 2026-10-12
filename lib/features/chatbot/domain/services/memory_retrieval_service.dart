import '../../../../core/models/memory_models.dart';
import '../../../../routing/memory_destination.dart';
import '../../../timeline/domain/event_filter.dart';
import '../../../timeline/domain/event_search_index.dart';
import '../entities/chat_message.dart';
import 'entity_extractor.dart';
import 'intent_detector.dart';

class RetrievedMemories {
  const RetrievedMemories(this.intent, this.events, this.targets);
  final ChatIntent intent;
  final List<MemoryEvent> events;
  final List<MemoryDestination> targets;
}

class MemoryRetrievalService {
  const MemoryRetrievalService();

  RetrievedMemories retrieve(
    String query,
    List<MemoryEvent> library, {
    DateTime? now,
    EventSearchIndex? index,
  }) {
    final visible = library.where((e) => !e.isSensitive).toList();
    final extractor = const EntityExtractor();
    var intent = const IntentDetector().detect(query);
    if (intent == ChatIntent.help) return RetrievedMemories(intent, [], []);
    final dates = extractor.extractDates(query, now: now);
    var terms = extractor.withoutDates(query);
    // Only known tags can establish a person filter. A matching title alone
    // cannot satisfy a request for memories with a named person.
    final people = visible.expand((e) => e.people).toList()
      ..sort((a, b) => b.name.length.compareTo(a.name.length));
    MemoryPerson? person;
    for (final candidate in people) {
      final name = normalizeSearch(candidate.name);
      if (name.isNotEmpty &&
          RegExp(
            '(^|\\s)${RegExp.escape(name)}(?=\\s|[?.!,]|\$)',
          ).hasMatch(normalizeSearch(terms))) {
        person = candidate;
        terms = terms.replaceAll(name, ' ');
        break;
      }
    }
    final requestedPerson = RegExp(
      r'\bwith\s+(.+?)(?=\s+(?:at|in|from)\b|[?.!,]|$)',
    ).firstMatch(terms)?.group(1)?.trim();
    if (person == null && requestedPerson != null) {
      terms = terms.replaceAll(requestedPerson, ' ');
    }
    var location = '';
    final locationMatch = RegExp(
      r'\b(?:at|in)\s+(.+?)(?=\s+(?:with|from)\b|[?.!?]|$)',
    ).firstMatch(terms);
    if (locationMatch != null) {
      location = extractor
          .extractSearchTerms(locationMatch.group(1)!)
          .join(' ');
      terms = terms.replaceRange(locationMatch.start, locationMatch.end, ' ');
    }
    // Remove command vocabulary, retaining any additional title/entity terms.
    terms = terms.replaceAll(
      RegExp(
        r'\b(favou?rites?|highly rated|missing (?:a )?story|voice notes?|high(?:-| )rediscovery risk|high(?:-| )risk|important|recent|latest)\b',
      ),
      ' ',
    );
    if ({
      ChatIntent.explainSignificance,
      ChatIntent.explainRediscovery,
      ChatIntent.explainPreservation,
      ChatIntent.explainRecommendation,
      ChatIntent.createReminder,
    }.contains(intent)) {
      terms = '';
    }
    if (intent == ChatIntent.startStory) {
      terms = terms.replaceAll(RegExp(r'\bstory\b'), ' ');
    }
    final filter = EventFilter(
      query: extractor.extractSearchTerms(terms).join(' '),
      personId: person?.id,
      person: person?.name ?? requestedPerson ?? '',
      location: location,
      dates: dates,
    );
    var events = (index ?? EventSearchIndex(visible)).search(filter);
    events = events
        .where(
          (event) => switch (intent) {
            ChatIntent.searchFavourite => event.isFavourite,
            ChatIntent.searchHighlyRated => event.rating >= 4,
            ChatIntent.searchImportant =>
              event.isImportant || event.scores.significance >= .7,
            ChatIntent.searchHighRisk => event.scores.rediscoveryRisk >= .6,
            ChatIntent.searchMissingStory => !event.hasStory,
            ChatIntent.searchVoiceNotes => event.hasVoiceNote,
            _ => true,
          },
        )
        .take(8)
        .toList();
    if (intent == ChatIntent.searchByTitle) {
      if (person != null || requestedPerson != null) {
        intent = ChatIntent.searchByPerson;
      } else if (location.isNotEmpty) {
        intent = ChatIntent.searchByPlace;
      } else if (dates != null) {
        intent = ChatIntent.searchByDate;
      }
    }
    final targets = <MemoryDestination>[];
    final seen = <(MemoryTargetType, String, String?)>{};
    void add(MemoryDestination target) {
      if (seen.add((target.type, target.id, target.eventId))) {
        targets.add(target);
      }
    }

    for (final event in events) {
      add(
        MemoryDestination(
          type: MemoryTargetType.event,
          id: event.id,
          title: event.title,
        ),
      );
      for (final media in event.media.take(3)) {
        add(
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
          MemoryDestination(
            type: MemoryTargetType.person,
            id: person.id,
            title: person.name,
          ),
        );
      }
      final place = event.resolvedPlace;
      if (place != null) {
        add(
          MemoryDestination(
            type: MemoryTargetType.location,
            id: place.id,
            title: place.name,
          ),
        );
      }
    }
    return RetrievedMemories(intent, events, targets);
  }
}
