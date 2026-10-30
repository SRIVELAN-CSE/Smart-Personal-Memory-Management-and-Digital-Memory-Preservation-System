import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'memory_controller.dart';
import '../../../core/widgets/media_thumbnail.dart';

class EditEventScreen extends ConsumerStatefulWidget {
  const EditEventScreen({required this.eventId, super.key});

  final String eventId;

  @override
  ConsumerState<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends ConsumerState<EditEventScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _placeController;
  var _initialized = false;
  var _splitIndex = 1;

  @override
  void dispose() {
    if (_initialized) {
      _titleController.dispose();
      _descriptionController.dispose();
      _placeController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(memoryControllerProvider);
    final event = state.events
        .where((item) => item.id == widget.eventId)
        .firstOrNull;
    if (event == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Event not found')),
      );
    }
    if (!_initialized) {
      _initialized = true;
      _titleController = TextEditingController(text: event.title);
      _descriptionController = TextEditingController(text: event.description);
      _placeController = TextEditingController(
        text: event.resolvedPlace?.name == event.primaryCaptureLocation?.label
            ? null
            : event.resolvedPlace?.name,
      );
      _splitIndex = event.media.length > 1 ? event.media.length ~/ 2 : 1;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Correct event'),
        actions: [
          TextButton(
            onPressed: () {
              ref
                  .read(memoryControllerProvider.notifier)
                  .saveEventDetails(
                    eventId: event.id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    placeName: _placeController.text,
                  );
              context.pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Event title',
              prefixIcon: Icon(Icons.title),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            minLines: 2,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Event description',
              hintText: 'What kind of event was this?',
              prefixIcon: Icon(Icons.description_outlined),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _placeController,
            decoration: const InputDecoration(
              labelText: 'Place name',
              hintText: 'Add or correct where this event happened',
              helperText:
                  'Labels every item in this event. Original capture GPS is kept separately.',
              helperMaxLines: 2,
              prefixIcon: Icon(Icons.place_outlined),
            ),
          ),
          const SizedBox(height: 18),
          Text('Your rating', style: Theme.of(context).textTheme.titleMedium),
          Row(
            children: List.generate(
              5,
              (index) => IconButton(
                tooltip: '${index + 1} stars',
                onPressed: () => ref
                    .read(memoryControllerProvider.notifier)
                    .setRating(event.id, index + 1),
                icon: Icon(
                  index < event.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber.shade800,
                ),
              ),
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: event.isFavourite,
            onChanged: (_) => ref
                .read(memoryControllerProvider.notifier)
                .toggleFavourite(event.id),
            title: const Text('Favourite'),
            subtitle: const Text(
              'A user-controlled signal for application-level significance.',
            ),
            secondary: const Icon(Icons.favorite_outline),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: event.isImportant,
            onChanged: (_) => ref
                .read(memoryControllerProvider.notifier)
                .toggleImportant(event.id),
            title: const Text('Important'),
            subtitle: const Text(
              'An explicit user-controlled significance signal.',
            ),
            secondary: const Icon(Icons.priority_high_rounded),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: event.isSensitive,
            onChanged: (value) => ref
                .read(memoryControllerProvider.notifier)
                .setSensitive(event.id, value),
            title: const Text('Hide as sensitive'),
            subtitle: const Text(
              'Suppress previews and proactive notifications for this event.',
            ),
            secondary: const Icon(Icons.visibility_off_outlined),
          ),
          const Divider(height: 32),
          Text(
            'Cover photo',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 78,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: event.media.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final media = event.media[index];
                final selected = media.id == event.coverMediaId;
                return InkWell(
                  onTap: () => ref
                      .read(memoryControllerProvider.notifier)
                      .selectCover(event.id, media.id),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: 78,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: selected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: MediaThumbnail(media: media),
                          ),
                        ),
                        if (selected)
                          const Positioned(
                            right: 4,
                            top: 4,
                            child: Icon(Icons.check_circle, size: 20),
                          ),
                        if (event.media.length > 1)
                          Positioned(
                            left: 2,
                            bottom: 2,
                            child: IconButton.filledTonal(
                              tooltip: 'Remove from this event',
                              visualDensity: VisualDensity.compact,
                              iconSize: 16,
                              onPressed: () => ref
                                  .read(memoryControllerProvider.notifier)
                                  .removeMedia(event.id, media.id),
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (state.unassignedMedia.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Unassigned media',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            const Text(
              'Items removed from a derived group remain available here; gallery originals are unchanged.',
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.unassignedMedia.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final media = state.unassignedMedia[index];
                  return ActionChip(
                    avatar: Icon(
                      media.kind.name == 'video'
                          ? Icons.videocam_outlined
                          : Icons.photo_outlined,
                    ),
                    label: const Text('Add'),
                    onPressed: () => ref
                        .read(memoryControllerProvider.notifier)
                        .addMedia(event.id, media.id),
                  );
                },
              ),
            ),
          ],
          const Divider(height: 32),
          Text(
            'Split event',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            event.media.length <= 1
                ? 'At least two media items are required.'
                : 'Create a second event beginning at item ${_splitIndex + 1}.',
          ),
          if (event.media.length > 1) ...[
            Slider(
              min: 1,
              max: (event.media.length - 1).toDouble(),
              divisions: event.media.length - 1,
              value: _splitIndex.clamp(1, event.media.length - 1).toDouble(),
              label: 'After $_splitIndex items',
              onChanged: (value) => setState(() => _splitIndex = value.round()),
            ),
            OutlinedButton.icon(
              onPressed: () {
                ref
                    .read(memoryControllerProvider.notifier)
                    .splitEvent(event.id, _splitIndex);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Event split. Original gallery media was not changed.',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.call_split),
              label: const Text('Split derived event'),
            ),
          ],
          const Divider(height: 32),
          Text(
            'Merge related event',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          if (state.events.length <= 1)
            const Text('No other generated events are available to merge.')
          else
            ...state.events
                .where((item) => item.id != event.id)
                .map(
                  (other) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.merge_type),
                    title: Text(other.title),
                    trailing: TextButton(
                      onPressed: () => ref
                          .read(memoryControllerProvider.notifier)
                          .mergeEvents(event.id, other.id),
                      child: const Text('Merge'),
                    ),
                  ),
                ),
          const SizedBox(height: 20),
          Text(
            'Changes affect derived app data only. Original gallery photos and videos are never renamed, moved, split, merged, or deleted.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete this derived event?'),
                  content: const Text(
                    'The event, notes, scores, and links will be removed. Its gallery photos and videos will not be deleted.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Delete event'),
                    ),
                  ],
                ),
              );
              if (confirmed == true && context.mounted) {
                ref
                    .read(memoryControllerProvider.notifier)
                    .deleteEvent(event.id);
                context.go('/timeline');
              }
            },
            icon: const Icon(Icons.delete_outline),
            label: const Text('Delete derived event'),
          ),
        ],
      ),
    );
  }
}
