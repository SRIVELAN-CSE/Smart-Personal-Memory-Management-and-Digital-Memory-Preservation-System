import '../../../../core/models/memory_models.dart';

class EventTitleGenerator {
  static const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static String generateTitle({
    required String currentTitle,
    required bool titleConfirmed,
    required DateTime capturedAt,
    required List<MediaItem> media,
    MemoryPlace? place,
  }) {
    if (titleConfirmed && currentTitle.trim().isNotEmpty) {
      return currentTitle;
    }

    // 1. OCR (safe from PII)
    final validOcr = media.map((item) => item.ocrText).where((text) {
      if (text.trim().isEmpty) return false;
      if (RegExp(
        r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
      ).hasMatch(text)) {
        return false; // Email
      }
      if (RegExp(
        r'https?://|www\.[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
      ).hasMatch(text)) {
        return false; // URL
      }
      if (RegExp(r'[a-zA-Z0-9.\-_]{2,}@[a-zA-Z]{2,}').hasMatch(text)) {
        return false; // UPI
      }
      return true;
    }).firstOrNull;

    if (validOcr != null) {
      final compact = validOcr.replaceAll(RegExp(r'\s+'), ' ').trim();
      return compact.length > 44 ? '${compact.substring(0, 44)}...' : compact;
    }

    // 2. Place
    if (place != null && place.name.isNotEmpty) {
      return 'Memory at ${place.name}';
    }

    // 3. Fallback
    return 'Memory from ${capturedAt.day} ${months[capturedAt.month - 1]}';
  }
}
