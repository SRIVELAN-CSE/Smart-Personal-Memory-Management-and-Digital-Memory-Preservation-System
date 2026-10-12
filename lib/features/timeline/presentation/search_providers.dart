import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../event_management/presentation/memory_controller.dart';
import '../domain/event_search_index.dart';

final eventSearchIndexProvider = Provider<EventSearchIndex>(
  (ref) => EventSearchIndex(
    ref.watch(memoryControllerProvider.select((s) => s.events)),
  ),
);
