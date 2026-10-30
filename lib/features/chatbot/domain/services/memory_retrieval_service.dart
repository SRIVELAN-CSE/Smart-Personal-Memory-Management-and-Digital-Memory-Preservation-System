import '../../../../core/models/memory_models.dart';
import '../../../timeline/domain/event_filter.dart';
import '../entities/chat_message.dart';
import 'entity_extractor.dart';

class MemoryRetrievalService {
  const MemoryRetrievalService();
  List<MemoryEvent> retrieve({
    required String query,
    required ChatIntent intent,
    required List<MemoryEvent> events,
    DateTime? now,
  }) {
    if (intent == ChatIntent.help) return [];
    final safe = events.where((e) => !e.isSensitive).toList();
    var remaining = query.toLowerCase();
    final people = <String>{};
    final places = <String>{};
    for (final person in safe.expand((e) => e.people)) {
      if (person.name.trim().isNotEmpty && _mentioned(query, person.name)) {
        // Manual tags from different events may have different IDs for the
        // same name. A query names people; it must not require every tag ID.
        people.add(person.name.trim().toLowerCase());
        remaining = remaining.replaceAll(person.name.toLowerCase(), ' ');
      }
    }
    // An explicit unknown name must not fall back to a title-only match.
    final personPhrase = RegExp(
      r'\bwith\s+(.+?)(?=\s+(?:at|in|from|last|yesterday|today)\b|$)',
      caseSensitive: false,
    ).firstMatch(query)?.group(1)?.trim();
    final personName = people.isEmpty ? personPhrase : null;
    if (personName != null) {
      remaining = remaining.replaceAll(personName.toLowerCase(), ' ');
    }
    for (final event in safe) {
      final place = event.resolvedPlace;
      if (place == null) continue;
      for (final name in [
        place.name,
        place.locality,
        place.city,
        place.state,
        place.country,
      ]) {
        if (name != null && name.trim().isNotEmpty && _mentioned(query, name)) {
          places.add(name);
          remaining = remaining.replaceAll(name.toLowerCase(), ' ');
        }
      }
    }
    final placePhrase = RegExp(
      r'\b(?:at|in)\s+(.+?)(?=\s+(?:with|last|this|yesterday|today)\b|$)',
      caseSensitive: false,
    ).firstMatch(query)?.group(1)?.trim();
    final unknownPlace =
        places.isEmpty &&
            placePhrase != null &&
            const EntityExtractor().extractDateRange(placePhrase, at: now) ==
                null
        ? placePhrase
        : null;
    if (unknownPlace != null) {
      remaining = remaining.replaceAll(unknownPlace.toLowerCase(), ' ');
    }
    final range = const EntityExtractor().extractDateRange(remaining, at: now);
    if (range != null) {
      remaining = remaining.replaceAll(
        RegExp(
          r'\b(last (2 days|7 days|30 days|week|month|year)|today|yesterday|this year|20[0-9]{2}|january|february|march|april|may|june|july|august|september|october|november|december|jan|feb|mar|apr|jun|jul|aug|sep|oct|nov|dec)\b',
        ),
        ' ',
      );
    }
    final terms = remaining
        .replaceAll(RegExp(r'[^\p{L}\p{N}\s]', unicode: true), ' ')
        .split(RegExp(r'\s+'))
        .where((t) => t.isNotEmpty && !_filler.contains(t))
        .join(' ');
    final dateFilter = range == null
        ? null
        : EventDateRange(
            range.start,
            range.end.add(const Duration(microseconds: 1)),
          );
    var found = EventSearchIndex(safe).search(
      EventFilter(
        query: terms,
        dates: dateFilter,
        personName: personName,
        location: unknownPlace,
      ),
    );
    found = found
        .where(
          (event) =>
              (people.isEmpty ||
                  people.every(
                    (name) => event.people.any(
                      (p) => p.name.trim().toLowerCase() == name,
                    ),
                  )) &&
              (places.isEmpty ||
                  places.every(
                    (p) =>
                        event.resolvedPlace?.searchText.toLowerCase().contains(
                          p.toLowerCase(),
                        ) ??
                        false,
                  )) &&
              switch (intent) {
                ChatIntent.searchByPerson => event.people.isNotEmpty,
                ChatIntent.searchByPlace => event.resolvedPlace != null,
                ChatIntent.searchFavourite => event.isFavourite,
                ChatIntent.searchImportant =>
                  event.isImportant || event.scores.significance >= .7,
                ChatIntent.searchHighRisk => event.scores.rediscoveryRisk >= .6,
                ChatIntent.searchHighlyRated => event.rating >= 4,
                ChatIntent.searchMissingStory => !event.hasStory,
                ChatIntent.searchVoiceNotes => event.hasVoiceNote,
                _ => true,
              },
        )
        .toList();
    return found.take(20).toList();
  }

  bool _mentioned(String query, String name) => RegExp(
    '(?:^|[^\\p{L}\\p{N}])${RegExp.escape(name)}(?:\$|[^\\p{L}\\p{N}])',
    unicode: true,
    caseSensitive: false,
  ).hasMatch(query);
  static const _filler = {
    'show',
    'find',
    'search',
    'my',
    'me',
    'memories',
    'memory',
    'events',
    'event',
    'photos',
    'photo',
    'videos',
    'pictures',
    'from',
    'in',
    'on',
    'at',
    'with',
    'and',
    'the',
    'a',
    'an',
    'of',
    'for',
    'about',
    'all',
    'which',
    'who',
    'attended',
    'people',
    'location',
    'place',
    'city',
    'have',
    'has',
    'are',
    'is',
    'do',
    'i',
    'important',
    'high',
    'rediscovery',
    'risk',
    'favourite',
    'favorite',
    'favourites',
    'favorites',
    'can',
    'could',
    'you',
    'please',
    'get',
    'list',
    'what',
    'where',
    'when',
    'was',
    'were',
    'did',
    'taken',
    'captured',
    'saved',
    'without',
    'no',
    'stories',
    'note',
    'video',
    'picture',
    'images',
    'image',
    'this',
    'these',
    'that',
    'highly',
    'rated',
    'missing',
    'story',
    'voice',
    'notes',
    'recent',
    'open',
    'add',
    'write',
    'to',
    'remind',
    'explain',
    'preservation',
    'significance',
    'score',
    'why',
    'recommended',
  };
}
