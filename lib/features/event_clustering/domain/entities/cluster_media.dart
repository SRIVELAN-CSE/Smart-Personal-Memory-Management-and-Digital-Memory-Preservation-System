/// The immutable, platform-neutral media data used by event clustering.
///
/// Gallery handles, thumbnails, and plugin objects are deliberately excluded so
/// the clustering engine can be exercised with plain Dart tests.
final class ClusterMedia {
  ClusterMedia({
    required this.id,
    required DateTime? capturedAtUtc,
    this.captureTimeReliability = 1,
    this.latitude,
    this.longitude,
    this.ocrText,
    List<double>? visualEmbedding,
    this.embeddingModelVersion,
  }) : assert(id != ''),
       assert(captureTimeReliability >= 0 && captureTimeReliability <= 1),
       assert(latitude == null || (latitude >= -90 && latitude <= 90)),
       assert(longitude == null || (longitude >= -180 && longitude <= 180)),
       assert((latitude == null) == (longitude == null)),
       assert(
         visualEmbedding == null || embeddingModelVersion != null,
         'An embedding must identify the model that produced it.',
       ),
       capturedAtUtc = capturedAtUtc?.toUtc(),
       visualEmbedding = visualEmbedding == null
           ? null
           : List<double>.unmodifiable(visualEmbedding);

  final String id;
  final DateTime? capturedAtUtc;

  /// Confidence in [capturedAtUtc]. For example, an EXIF capture time can use
  /// `1`, while a fallback file-modified time can use a lower value.
  final double captureTimeReliability;
  final double? latitude;
  final double? longitude;
  final String? ocrText;
  final List<double>? visualEmbedding;
  final String? embeddingModelVersion;
}
