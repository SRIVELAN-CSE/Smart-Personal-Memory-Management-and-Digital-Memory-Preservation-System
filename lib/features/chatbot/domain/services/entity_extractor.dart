import '../../../timeline/domain/event_filter.dart';

/// Local, deterministic entity extraction. Date ranges share timeline semantics.
class EntityExtractor {
  const EntityExtractor();
  static const _months = [
    'january',
    'february',
    'march',
    'april',
    'may',
    'june',
    'july',
    'august',
    'september',
    'october',
    'november',
    'december',
  ];

  DateRange? extractDateRange(String query, {DateTime? now}) {
    final range = extractDates(query, now: now);
    return range == null
        ? null
        : DateRange(
            start: range.start,
            end: range.endExclusive.subtract(const Duration(microseconds: 1)),
          );
  }

  EventDateRange? extractDates(String query, {DateTime? now}) {
    final today = now ?? DateTime.now();
    final lower = query.toLowerCase();
    for (final preset in DatePreset.values) {
      if (RegExp(
        '\\b${RegExp.escape(preset.label.toLowerCase())}\\b',
      ).hasMatch(lower)) {
        return EventDateRange.preset(preset, today);
      }
    }
    if (RegExp(r'\bthis year\b').hasMatch(lower)) {
      return EventDateRange(DateTime(today.year), DateTime(today.year + 1));
    }
    final yearMatch = RegExp(
      r'\b(19\d{2}|20\d{2}|21\d{2})\b',
    ).firstMatch(lower);
    final year = yearMatch == null
        ? today.year
        : int.parse(yearMatch.group(1)!);
    for (var i = 0; i < _months.length; i++) {
      if (RegExp(
        '\\b(${_months[i]}|${_months[i].substring(0, 3)})\\b',
      ).hasMatch(lower)) {
        return EventDateRange(DateTime(year, i + 1), DateTime(year, i + 2));
      }
    }
    return yearMatch == null
        ? null
        : EventDateRange(DateTime(year), DateTime(year + 1));
  }

  String withoutDates(String query) {
    var result = query.toLowerCase();
    for (final preset in DatePreset.values) {
      result = result.replaceAll(
        RegExp('\\b${RegExp.escape(preset.label.toLowerCase())}\\b'),
        ' ',
      );
    }
    result = result.replaceAll(RegExp(r'\bthis year\b'), ' ');
    for (final month in _months) {
      result = result.replaceAll(
        RegExp('\\b($month|${month.substring(0, 3)})\\b'),
        ' ',
      );
    }
    return result.replaceAll(RegExp(r'\b(19\d{2}|20\d{2}|21\d{2})\b'), ' ');
  }

  List<String> extractPersonNames(String query) => RegExp(
    r'\b(?:with|about)\s+(.+?)(?=\s+and\b|[,?.]|$)',
    caseSensitive: false,
  ).allMatches(query).map((m) => m.group(1)!.trim()).toList();
  List<String> extractPlaceTerms(String query) => extractSearchTerms(query);
  List<String> extractSearchTerms(String query) => query
      .toLowerCase()
      .replaceAll(RegExp(r'[^\w\s\u0080-\uFFFF-]'), ' ')
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty && !_stopWords.contains(word))
      .toList();
  static const _stopWords = {
    'the',
    'and',
    'with',
    'show',
    'my',
    'me',
    'from',
    'for',
    'are',
    'was',
    'has',
    'have',
    'all',
    'its',
    'this',
    'that',
    'about',
    'memories',
    'memory',
    'photos',
    'photo',
    'pictures',
    'videos',
    'events',
    'event',
    'find',
    'at',
    'in',
    'of',
    'who',
    'attended',
    'which',
    'do',
    'i',
    'please',
    'open',
    'add',
    'write',
    'to',
    'a',
  };
}

class DateRange {
  const DateRange({required this.start, required this.end});
  final DateTime start;
  final DateTime end;
  bool contains(DateTime date) => !date.isBefore(start) && !date.isAfter(end);
}
