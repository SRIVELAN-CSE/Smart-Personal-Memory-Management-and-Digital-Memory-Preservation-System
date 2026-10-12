import 'package:flutter/material.dart';

import '../models/memory_models.dart';
import '../utils/formatters.dart';

class MemoryLocation extends StatelessWidget {
  const MemoryLocation({
    required this.event,
    this.onEdit,
    this.showPhotoLocations = true,
    super.key,
  });

  final MemoryEvent event;
  final VoidCallback? onEdit;
  final bool showPhotoLocations;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final place = event.resolvedPlace;
    final location = event.primaryCaptureLocation;
    final locatedCount = event.media
        .where((item) => item.captureLocation != null)
        .length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Icon(
                place == null
                    ? Icons.location_off_outlined
                    : Icons.location_on_outlined,
                size: 20,
                color: place == null ? scheme.onSurfaceVariant : scheme.primary,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.locationLabel,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    place?.isConfirmed == true
                        ? 'Place confirmed by you'
                        : location != null
                        ? 'From the largest photo-location group in this event'
                        : 'No GPS location is available in these photos or videos.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  if (location != null &&
                      place?.isConfirmed != true &&
                      place?.name != location.label) ...[
                    const SizedBox(height: 4),
                    SelectableText(
                      location.label,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
            if (onEdit != null)
              TextButton(
                onPressed: onEdit,
                child: Text(place == null ? 'Add location' : 'Edit'),
              ),
          ],
        ),
        if (showPhotoLocations && locatedCount > 0) ...[
          const SizedBox(height: 8),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            title: const Text('Photo locations'),
            subtitle: Text(
              '$locatedCount of ${event.media.length} media items have GPS',
            ),
            children: [
              SizedBox(
                height: (event.media.length * 78.0).clamp(78.0, 260.0),
                child: ListView.builder(
                  primary: false,
                  itemCount: event.media.length,
                  itemBuilder: (context, index) {
                    final media = event.media[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        media.kind == MediaKind.image
                            ? Icons.photo_outlined
                            : Icons.videocam_outlined,
                      ),
                      title: Text(
                        '${media.kind == MediaKind.image ? 'Photo' : 'Video'} ${index + 1} · ${formatMemoryDate(media.capturedAt)}',
                      ),
                      subtitle: Text(
                        media.captureLocation?.label ?? 'Location unavailable',
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
