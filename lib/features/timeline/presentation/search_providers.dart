import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../event_management/presentation/memory_controller.dart';
import '../domain/event_filter.dart';

final eventSearchIndexProvider = Provider<EventSearchIndex>(
  (ref) => EventSearchIndex(
    ref.watch(memoryControllerProvider.select((state) => state.events)),
  ),
);
