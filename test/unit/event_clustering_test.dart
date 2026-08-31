import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/features/event_clustering/domain/entities/cluster_media.dart';
import 'package:smart_memory_preservation/features/event_clustering/domain/services/clustering_config.dart';
import 'package:smart_memory_preservation/features/event_clustering/domain/services/event_clusterer.dart';
import 'package:smart_memory_preservation/features/event_clustering/domain/services/media_similarity_calculator.dart';

void main() {
  const config = ClusteringConfig();
  const similarityCalculator = DeterministicMediaSimilarityCalculator();
  final baseTime = DateTime.utc(2026, 7, 14, 9);

  group('deterministic media similarity', () {
    test(
      'time similarity follows the configured four-to-twelve-hour curve',
      () {
        expect(
          similarityCalculator.timeSimilarity(
            baseTime,
            baseTime.add(const Duration(hours: 4)),
            config,
          ),
          1,
        );
        expect(
          similarityCalculator.timeSimilarity(
            baseTime,
            baseTime.add(const Duration(hours: 8)),
            config,
          ),
          closeTo(0.5, 0.000001),
        );
        expect(
          similarityCalculator.timeSimilarity(
            baseTime,
            baseTime.add(const Duration(hours: 12)),
            config,
          ),
          0,
        );
      },
    );

    test(
      'location similarity uses Haversine distance and tolerates missing GPS',
      () {
        final left = _media('left', baseTime, latitude: 0, longitude: 0);
        final nearby = _media('nearby', baseTime, latitude: 0, longitude: 0.05);
        final missing = _media('missing', baseTime);

        final nearbyScore = similarityCalculator.locationSimilarity(
          left,
          nearby,
          config,
        );
        expect(nearbyScore, isNotNull);
        expect(nearbyScore!, greaterThan(0.4));
        expect(nearbyScore, lessThan(0.5));
        expect(
          similarityCalculator.locationSimilarity(left, missing, config),
          isNull,
        );
      },
    );

    test('OCR similarity is normalized-token Jaccard similarity', () {
      expect(
        similarityCalculator.ocrSimilarity(
          'Project review MKCE team',
          'MKCE project presentation',
          config,
        ),
        closeTo(0.4, 0.000001),
      );
      expect(
        similarityCalculator.ocrSimilarity(null, 'useful text', config),
        isNull,
      );
    });

    test('missing optional evidence is omitted rather than scored as zero', () {
      final result = similarityCalculator.compare(
        _media('a', baseTime),
        _media('b', baseTime.add(const Duration(hours: 2))),
        config,
      );

      expect(result.combinedScore, 1);
      expect(result.evidenceCoverage, closeTo(0.5, 0.000001));
      expect(result.locationSimilarity, isNull);
      expect(result.ocrSimilarity, isNull);
      expect(result.visualSimilarity, isNull);
      expect(result.hasSupportingEvidence, isFalse);
    });
  });

  group('deterministic event clustering', () {
    test(
      'stable-sorts input and creates a boundary after a large time gap',
      () {
        final clusterer = DeterministicEventClusterer();
        final result = clusterer.cluster([
          _media('c', baseTime.add(const Duration(hours: 20))),
          _media('b', baseTime.add(const Duration(hours: 2))),
          _media('a', baseTime),
        ], config);

        expect(result.clusters.map((cluster) => cluster.mediaIds), [
          ['a', 'b'],
          ['c'],
        ]);
        expect(result.boundaries, hasLength(1));
        expect(
          result.boundaries.single.reasonCode,
          'gap_exceeds_weak_time_threshold',
        );
      },
    );

    test('weak time relation requires non-time supporting evidence', () {
      final clusterer = DeterministicEventClusterer();
      final withoutSupport = clusterer.cluster([
        _media('a', baseTime),
        _media('b', baseTime.add(const Duration(hours: 6))),
      ], config);
      expect(withoutSupport.clusters, hasLength(2));
      expect(
        withoutSupport.boundaries.single.reasonCode,
        'weak_window_lacks_supporting_evidence',
      );

      final withLocationSupport = clusterer.cluster([
        _media('a', baseTime, latitude: 10, longitude: 77),
        _media(
          'b',
          baseTime.add(const Duration(hours: 6)),
          latitude: 10,
          longitude: 77,
        ),
      ], config);
      expect(withLocationSupport.clusters, hasLength(1));
      expect(withLocationSupport.clusters.single.mediaIds, ['a', 'b']);
    });

    test('missing capture time remains a safe singleton', () {
      final result = DeterministicEventClusterer().cluster([
        _media('known', baseTime),
        ClusterMedia(id: 'unknown', capturedAtUtc: null),
      ], config);

      expect(result.clusters, hasLength(2));
      expect(result.boundaries.single.reasonCode, 'missing_capture_time');
    });

    test('equal capture times use media ID as a stable tie-breaker', () {
      final result = DeterministicEventClusterer().cluster([
        _media('z', baseTime),
        _media('a', baseTime),
      ], config);

      expect(result.clusters.single.mediaIds, ['a', 'z']);
    });

    test('empty input has no clusters or boundaries', () {
      final result = DeterministicEventClusterer().cluster(const [], config);

      expect(result.clusters, isEmpty);
      expect(result.boundaries, isEmpty);
      expect(result.algorithmVersion, config.algorithmVersion);
    });
  });
}

ClusterMedia _media(
  String id,
  DateTime capturedAtUtc, {
  double? latitude,
  double? longitude,
}) => ClusterMedia(
  id: id,
  capturedAtUtc: capturedAtUtc,
  latitude: latitude,
  longitude: longitude,
);
