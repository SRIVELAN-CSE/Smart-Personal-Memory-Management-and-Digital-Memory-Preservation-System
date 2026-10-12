import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/features/chatbot/domain/services/entity_extractor.dart';

void main() {
  group('EntityExtractor', () {
    const extractor = EntityExtractor();

    group('extractDateRange', () {
      test('extracts month and year', () {
        final range = extractor.extractDateRange('memories from july 2026')!;
        expect(range.start.year, 2026);
        expect(range.start.month, 7);
        expect(range.start.day, 1);
        expect(range.end.year, 2026);
        expect(range.end.month, 7);
        expect(range.end.day, 31);
      });

      test('extracts standalone year', () {
        final range = extractor.extractDateRange('events in 2025')!;
        expect(range.start.year, 2025);
        expect(range.start.month, 1);
        expect(range.start.day, 1);
        expect(range.end.year, 2025);
        expect(range.end.month, 12);
        expect(range.end.day, 31);
      });

      test('extracts relative terms', () {
        final range = extractor.extractDateRange('last year')!;
        final now = DateTime.now();
        expect(range.start.year, now.year - 1);
      });
    });

    group('extractPersonNames', () {
      test('extracts names after with/about', () {
        final names = extractor.extractPersonNames(
          'memories with Alice and Bob',
        );
        expect(names, ['Alice']);
      });
    });

    group('extractPlaceTerms', () {
      test('removes stop words', () {
        final terms = extractor.extractPlaceTerms('show memories at the park');
        expect(terms, ['park']);
      });
    });
  });
}
