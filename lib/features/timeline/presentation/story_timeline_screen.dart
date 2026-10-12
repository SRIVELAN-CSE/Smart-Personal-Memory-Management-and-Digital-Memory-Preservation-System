import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_navigation.dart';
import '../../event_management/presentation/memory_controller.dart';
import '../domain/event_filter.dart';
import 'search_providers.dart';
import 'widgets/memory_event_card.dart';

class StoryTimelineScreen extends ConsumerStatefulWidget {
  const StoryTimelineScreen({
    this.initialFilter = const EventFilter(),
    super.key,
  });
  final EventFilter initialFilter;
  @override
  ConsumerState<StoryTimelineScreen> createState() => _StoryTimelineState();
}

class _StoryTimelineState extends ConsumerState<StoryTimelineScreen> {
  late EventFilter _filter;
  final _query = TextEditingController();
  final _person = TextEditingController();
  final _location = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _setFilter(widget.initialFilter);
  }

  @override
  void didUpdateWidget(covariant StoryTimelineScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (Uri(queryParameters: oldWidget.initialFilter.parameters).query !=
        Uri(queryParameters: widget.initialFilter.parameters).query) {
      _setFilter(widget.initialFilter);
    }
  }

  void _setFilter(EventFilter value) {
    _debounce?.cancel();
    _filter = value;
    _query.text = value.query;
    _person.text = value.person;
    _location.text = value.location;
  }

  void _textChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      if (!mounted) return;
      setState(() => _filter = _draft);
    });
  }

  EventFilter get _draft => EventFilter(
    query: _query.text,
    person: _person.text,
    location: _location.text,
    personId: _person.text == _filter.person ? _filter.personId : null,
    dates: _filter.dates,
    dateLabel: _filter.dateLabel,
  );
  void _change(EventFilter value) => setState(() => _setFilter(value));
  @override
  void dispose() {
    _debounce?.cancel();
    _query.dispose();
    _person.dispose();
    _location.dispose();
    super.dispose();
  }

  Future<void> _chooseDate(String selection) async {
    if (selection == 'all') {
      _change(_draft.copyWith(clearDates: true));
      return;
    }
    if (selection == 'custom') {
      final range = await showDateRangePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year + 20, 12, 31),
      );
      if (!mounted || range == null) return;
      _change(
        _draft.copyWith(
          dates: EventDateRange.days(range.start, range.end),
          dateLabel:
              '${formatCompactDate(range.start)} – ${formatCompactDate(range.end)}',
        ),
      );
    } else {
      final preset = DatePreset.values.byName(selection);
      _change(
        _draft.copyWith(
          dates: EventDateRange.preset(preset, DateTime.now()),
          dateLabel: preset.label,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final library = ref.watch(memoryControllerProvider);
    final events = ref
        .watch(eventSearchIndexProvider)
        .search(_filter, includeSensitive: true);
    return AppNavigation(
      selectedIndex: 1,
      title: 'Story timeline',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/scan'),
        icon: const Icon(Icons.add_photo_alternate_outlined),
        label: const Text('Scan'),
      ),
      child: ResponsivePage(
        child: CustomScrollView(
          key: const Key('story-timeline-list'),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  TextField(
                    controller: _query,
                    onChanged: (_) => _textChanged(),
                    decoration: InputDecoration(
                      labelText: 'Search memories',
                      hintText: 'Title, person or location',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        tooltip: 'Clear search',
                        icon: const Icon(Icons.close),
                        onPressed: () => _change(_draft.copyWith(query: '')),
                      ),
                    ),
                  ),
                  ExpansionTile(
                    title: const Text('Person, location and date filters'),
                    initiallyExpanded: _filter.hasCriteria,
                    tilePadding: EdgeInsets.zero,
                    children: [
                      TextField(
                        controller: _person,
                        onChanged: (_) => _textChanged(),
                        decoration: const InputDecoration(
                          labelText: 'Tagged person',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _location,
                        onChanged: (_) => _textChanged(),
                        decoration: const InputDecoration(
                          labelText: 'Location or city',
                          prefixIcon: Icon(Icons.place_outlined),
                        ),
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          PopupMenuButton<String>(
                            onSelected: _chooseDate,
                            tooltip: 'Choose date filter',
                            itemBuilder: (_) => [
                              const PopupMenuItem(
                                value: 'all',
                                child: Text('All dates'),
                              ),
                              for (final preset in DatePreset.values)
                                PopupMenuItem(
                                  value: preset.name,
                                  child: Text(preset.label),
                                ),
                              const PopupMenuItem(
                                value: 'custom',
                                child: Text('Custom date range'),
                              ),
                            ],
                            child: const Padding(
                              padding: EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Icon(Icons.date_range),
                                  SizedBox(width: 8),
                                  Text('Choose dates'),
                                ],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _change(const EventFilter()),
                            child: const Text('Reset filters'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (_filter.hasCriteria)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 6,
                        children: [
                          if (_filter.query.isNotEmpty)
                            InputChip(
                              label: Text(_filter.query),
                              onDeleted: () =>
                                  _change(_draft.copyWith(query: '')),
                            ),
                          if (_filter.person.isNotEmpty ||
                              _filter.personId != null)
                            InputChip(
                              label: Text(
                                'Person: ${_filter.person.isEmpty ? _filter.personId : _filter.person}',
                              ),
                              onDeleted: () =>
                                  _change(_draft.copyWith(clearPerson: true)),
                            ),
                          if (_filter.location.isNotEmpty)
                            InputChip(
                              label: Text(_filter.location),
                              onDeleted: () =>
                                  _change(_draft.copyWith(location: '')),
                            ),
                          if (_filter.dates != null)
                            InputChip(
                              label: Text(_filter.dateLabel ?? 'Custom dates'),
                              onDeleted: () =>
                                  _change(_draft.copyWith(clearDates: true)),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (library.isRestoring || library.restoreFailed || events.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: library.isRestoring
                    ? const Center(child: CircularProgressIndicator())
                    : library.restoreFailed
                    ? Center(
                        child: TextButton(
                          onPressed: () => ref
                              .read(memoryControllerProvider.notifier)
                              .retryRestore(),
                          child: const Text('Retry loading memories'),
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.search_off, size: 48),
                            const SizedBox(height: 12),
                            Text(
                              _filter.hasCriteria
                                  ? 'No memories match these filters.'
                                  : 'Your story starts here',
                            ),
                            if (_filter.hasCriteria)
                              TextButton(
                                onPressed: () => _change(const EventFilter()),
                                child: const Text('Clear all filters'),
                              )
                            else if (library.events.isEmpty)
                              TextButton(
                                onPressed: () => ref
                                    .read(memoryControllerProvider.notifier)
                                    .enableDemoMode(),
                                child: const Text('Load demo memory'),
                              ),
                          ],
                        ),
                      ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: index == 0
                        ? Text(
                            '${events.length} event ${events.length == 1 ? 'story' : 'stories'} • newest first',
                          )
                        : MemoryEventCard(event: events[index - 1]),
                  ),
                  childCount: events.length + 1,
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 72)),
          ],
        ),
      ),
    );
  }
}
