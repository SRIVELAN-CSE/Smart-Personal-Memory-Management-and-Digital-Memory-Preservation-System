import '../../../timeline/domain/event_filter.dart';

/// Extracts structured entities (date ranges, names, places) from a
/// natural-language query without any external API calls.
class EntityExtractor {
  const EntityExtractor();

  static const _monthNames = {
    'january': 1,
    'february': 2,
    'march': 3,
    'april': 4,
    'may': 5,
    'june': 6,
    'july': 7,
    'august': 8,
    'september': 9,
    'october': 10,
    'november': 11,
    'december': 12,
    // Abbreviations
    'jan': 1,
    'feb': 2,
    'mar': 3,
    'apr': 4,
    'jun': 6,
    'jul': 7,
    'aug': 8,
    'sep': 9,
    'oct': 10,
    'nov': 11,
    'dec': 12,
  };

  /// Extracts a [DateRange] from [query], or returns null if none found.
  DateRange? extractDateRange(String query, {DateTime? at}) {
    final lower = query.toLowerCase();
    final now = at ?? DateTime.now();
    for (final preset in DatePreset.values) {
      if (RegExp('\\b${preset.label.toLowerCase()}\\b').hasMatch(lower)) {
        final range = EventDateRange.preset(preset, now);
        return DateRange(
          start: range.start,
          end: range.endExclusive.subtract(const Duration(microseconds: 1)),
        );
      }
    }

    // "this year"
    if (lower.contains('this year')) {
      return DateRange(
        start: DateTime(now.year, 1, 1),
        end: DateTime(
          now.year + 1,
          1,
          1,
        ).subtract(const Duration(microseconds: 1)),
      );
    }

    // "July 2026", "March 2025", etc.
    final yearMonthMatch = RegExp(
      r'\b(january|february|march|april|may|june|july|august|september|'
      r'october|november|december|jan|feb|mar|apr|jun|jul|aug|sep|oct|nov|dec)'
      r'\s+(20[0-9]{2})\b',
    ).firstMatch(lower);
    if (yearMonthMatch != null) {
      final month = _monthNames[yearMonthMatch.group(1)]!;
      final year = int.parse(yearMonthMatch.group(2)!);
      final start = DateTime(year, month, 1);
      final end = (month == 12)
          ? DateTime(year + 1, 1, 1).subtract(const Duration(microseconds: 1))
          : DateTime(
              year,
              month + 1,
              1,
            ).subtract(const Duration(microseconds: 1));
      return DateRange(start: start, end: end);
    }

    // "2026 July" or standalone month name
    final monthYearMatch = RegExp(
      r'\b(20[0-9]{2})\s+(january|february|march|april|may|june|july|'
      r'august|september|october|november|december)\b',
    ).firstMatch(lower);
    if (monthYearMatch != null) {
      final year = int.parse(monthYearMatch.group(1)!);
      final month = _monthNames[monthYearMatch.group(2)]!;
      final start = DateTime(year, month, 1);
      final end = (month == 12)
          ? DateTime(year + 1, 1, 1).subtract(const Duration(microseconds: 1))
          : DateTime(
              year,
              month + 1,
              1,
            ).subtract(const Duration(microseconds: 1));
      return DateRange(start: start, end: end);
    }

    // Standalone year "2026"
    final yearMatch = RegExp(r'\b(20[0-9]{2})\b').firstMatch(lower);
    if (yearMatch != null) {
      final year = int.parse(yearMatch.group(1)!);
      return DateRange(
        start: DateTime(year, 1, 1),
        end: DateTime(year + 1, 1, 1).subtract(const Duration(microseconds: 1)),
      );
    }

    // Standalone month name (current year assumed)
    for (final entry in _monthNames.entries) {
      if (RegExp('\\b${entry.key}\\b').hasMatch(lower)) {
        final month = entry.value;
        final year = now.year;
        final start = DateTime(year, month, 1);
        final end = (month == 12)
            ? DateTime(year + 1, 1, 1).subtract(const Duration(microseconds: 1))
            : DateTime(
                year,
                month + 1,
                1,
              ).subtract(const Duration(microseconds: 1));
        return DateRange(start: start, end: end);
      }
    }

    return null;
  }

  /// Extracts candidate person names from [query].
  ///
  /// Looks for words after "with", "about", "memories of", or
  /// capitalised tokens that are not common stop words.
  List<String> extractPersonNames(String query) {
    final names = <String>[];

    // "with Alice", "about Bob", "memories of Alice"
    final patterns = [
      RegExp(r'\bwith\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]+)?)\b'),
      RegExp(r'\babout\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]+)?)\b'),
      RegExp(r'\bof\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]+)?)\b'),
      RegExp(r'\bshow\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]+)?)\b'),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(query);
      if (match != null) {
        final candidate = match.group(1)!.trim();
        if (!_isStopWord(candidate.toLowerCase())) {
          names.add(candidate);
        }
      }
    }

    return names;
  }

  /// Extracts candidate place/keyword terms from [query] for place search.
  List<String> extractPlaceTerms(String query) {
    final terms = <String>[];
    // Remove common filler words then return remaining meaningful tokens
    final tokens = query
        .toLowerCase()
        .replaceAll(RegExp(r'[.,?!]'), '')
        .split(' ')
        .where((t) => t.length > 2 && !_isStopWord(t))
        .toList();
    terms.addAll(tokens);
    return terms;
  }

  /// Returns remaining keywords for a title/general search.
  List<String> extractSearchTerms(String query) {
    return query
        .toLowerCase()
        .replaceAll(RegExp(r'[.,?!]'), '')
        .split(' ')
        .where((t) => t.length > 2 && !_isStopWord(t))
        .toList();
  }

  bool _isStopWord(String word) => const {
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
    'events',
    'event',
  }.contains(word);
}

class DateRange {
  const DateRange({required this.start, required this.end});
  final DateTime start;
  final DateTime end;

  bool contains(DateTime dt) =>
      (dt.isAtSameMomentAs(start) || dt.isAfter(start)) &&
      (dt.isAtSameMomentAs(end) || dt.isBefore(end));

  @override
  String toString() => 'DateRange($start → $end)';
}
