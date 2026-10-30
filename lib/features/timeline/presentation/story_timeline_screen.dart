import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_navigation.dart';
import '../../../core/widgets/library_status_banner.dart';
import '../../event_management/presentation/memory_controller.dart';
import '../domain/event_filter.dart';
import 'search_providers.dart';
import 'widgets/memory_event_card.dart';

class StoryTimelineScreen extends ConsumerStatefulWidget {
  const StoryTimelineScreen({
    this.personId,
    this.personName,
    this.location,
    super.key,
  });
  final String? personId, personName, location;
  @override
  ConsumerState<StoryTimelineScreen> createState() =>
      _StoryTimelineScreenState();
}

class _StoryTimelineScreenState extends ConsumerState<StoryTimelineScreen> {
  final _text = TextEditingController();
  Timer? _debounce;
  String _query = '';
  String? _personId;
  EventDateRange? _dates;
  DatePreset? _preset;
  bool _favourites = false;
  @override
  void initState() {
    super.initState();
    _readRoute();
  }

  void _readRoute() {
    _personId = widget.personId;
    _text.text =
        widget.location ??
        (widget.personId == null ? widget.personName ?? '' : '');
    _query = _text.text;
  }

  @override
  void didUpdateWidget(covariant StoryTimelineScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.personId != widget.personId ||
        oldWidget.personName != widget.personName ||
        oldWidget.location != widget.location) {
      _readRoute();
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _text.dispose();
    super.dispose();
  }

  void _changed(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _query = value);
    });
  }

  void _reset() {
    _debounce?.cancel();
    setState(() {
      _text.clear();
      _query = '';
      _personId = null;
      _dates = null;
      _preset = null;
      _favourites = false;
    });
  }

  Future<void> _filters() async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Filter memories',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                for (final preset in DatePreset.values)
                  ListTile(
                    leading: const Icon(Icons.calendar_today_outlined),
                    title: Text(preset.label),
                    trailing: _preset == preset
                        ? const Icon(Icons.check)
                        : null,
                    onTap: () => Navigator.pop(context, preset.name),
                  ),
                ListTile(
                  leading: const Icon(Icons.date_range),
                  title: const Text('Custom date range'),
                  onTap: () => Navigator.pop(context, 'custom'),
                ),
                ListTile(
                  leading: const Icon(Icons.filter_alt_off_outlined),
                  title: const Text('All dates'),
                  onTap: () => Navigator.pop(context, 'all'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (!mounted || choice == null) return;
    if (choice == 'custom') {
      final range = await showDateRangePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime(2200),
        initialDateRange: _dates == null
            ? null
            : DateTimeRange(
                start: _dates!.start,
                end: _dates!.endExclusive.subtract(
                  const Duration(microseconds: 1),
                ),
              ),
      );
      if (range != null && mounted) {
        setState(() {
          _preset = null;
          _dates = EventDateRange.custom(range.start, range.end);
        });
      }
    } else {
      setState(() {
        _preset = DatePreset.values.where((p) => p.name == choice).firstOrNull;
        _dates = _preset == null
            ? null
            : EventDateRange.preset(_preset!, DateTime.now());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(memoryControllerProvider);
    final filter = EventFilter(
      query: _query,
      personId: _personId,
      dates: _dates,
      favouritesOnly: _favourites,
    );
    final events = ref.watch(eventSearchIndexProvider).search(filter);
    final personLabel =
        state.events
            .expand((e) => e.people)
            .where((p) => p.id == _personId)
            .firstOrNull
            ?.name ??
        _personId;
    return AppNavigation(
      selectedIndex: 1,
      title: 'Story timeline',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/scan'),
        icon: const Icon(Icons.add_photo_alternate_outlined),
        label: const Text('Scan'),
      ),
      child: ResponsivePage(
        child: Column(
          children: [
            const LibraryStatusBanner(),
            Row(
              children: [
                IconButton.filledTonal(
                  key: const Key('timeline-filters'),
                  tooltip: 'Filter by date',
                  onPressed: _filters,
                  icon: Icon(
                    _dates == null
                        ? Icons.filter_alt_outlined
                        : Icons.filter_alt,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _text,
                    onChanged: _changed,
                    decoration: InputDecoration(
                      hintText: 'Title, person or location',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        tooltip: 'Clear search',
                        onPressed: () {
                          _text.clear();
                          _changed('');
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  FilterChip(
                    label: const Text('Favourites'),
                    avatar: const Icon(Icons.favorite_outline, size: 18),
                    selected: _favourites,
                    onSelected: (value) => setState(() => _favourites = value),
                  ),
                  if (_personId != null)
                    InputChip(
                      label: Text('Person: $personLabel'),
                      onDeleted: () => setState(() => _personId = null),
                    ),
                  if (_dates != null)
                    InputChip(
                      label: Text(_preset?.label ?? _dates!.label),
                      onDeleted: () => setState(() {
                        _dates = null;
                        _preset = null;
                      }),
                    ),
                  if (!filter.isEmpty)
                    TextButton(
                      onPressed: _reset,
                      child: const Text('Reset filters'),
                    ),
                ],
              ),
            ),
            Expanded(
              child: state.isRestoring
                  ? const Center(child: CircularProgressIndicator())
                  : state.restoreFailed
                  ? const Center(
                      child: Text(
                        'Retry loading your library before searching.',
                      ),
                    )
                  : events.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.search_off, size: 48),
                          const SizedBox(height: 12),
                          Text(
                            filter.isEmpty
                                ? 'Your story starts here'
                                : 'No events match these filters.',
                          ),
                          if (filter.isEmpty)
                            TextButton(
                              onPressed: () => context.push('/scan'),
                              child: const Text('Scan your gallery'),
                            ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      key: const Key('story-timeline-list'),
                      padding: const EdgeInsets.only(bottom: 88),
                      itemCount: events.length + 1,
                      separatorBuilder: (_, _) => const SizedBox(height: 16),
                      itemBuilder: (context, index) => index == 0
                          ? Text(
                              '${events.length} event stories • newest first',
                            )
                          : MemoryEventCard(event: events[index - 1]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
