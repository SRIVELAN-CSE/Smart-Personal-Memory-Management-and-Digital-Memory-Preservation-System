import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../event_management/presentation/memory_controller.dart';
import 'reminder_providers.dart';

class TimeCapsuleScreen extends ConsumerStatefulWidget {
  const TimeCapsuleScreen({required this.recommendationId, super.key});

  final String recommendationId;

  @override
  ConsumerState<TimeCapsuleScreen> createState() => _TimeCapsuleScreenState();
}

class _TimeCapsuleScreenState extends ConsumerState<TimeCapsuleScreen> {
  DateTime? _selected;
  var _saving = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(memoryControllerProvider);
    final recommendation = state.recommendations
        .where((item) => item.id == widget.recommendationId)
        .firstOrNull;
    final event = recommendation == null
        ? null
        : state.events
              .where((item) => item.id == recommendation.eventId)
              .firstOrNull;
    if (recommendation == null || event == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Memory not found')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Future time capsule')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Icon(
            Icons.schedule_send,
            size: 72,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 18),
          Text(
            'Revisit “${event.title}”',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          const Text(
            'Choose a future date. The notification always uses neutral wording and never includes titles, names, OCR text, places, or previews.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 26),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: Text(
                _selected == null
                    ? 'Choose a date'
                    : '${_selected!.day}/${_selected!.month}/${_selected!.year}',
              ),
              subtitle: const Text(
                'Inexact local reminder; delivery may be adjusted by Android power management.',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final now = DateTime.now();
                final value = await showDatePicker(
                  context: context,
                  firstDate: now.add(const Duration(days: 1)),
                  lastDate: DateTime(now.year + 20),
                  initialDate: _selected ?? now.add(const Duration(days: 365)),
                );
                if (mounted && value != null) {
                  setState(
                    () => _selected = DateTime(
                      value.year,
                      value.month,
                      value.day,
                      10,
                    ),
                  );
                }
              },
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(
              _error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: _selected == null || _saving
                ? null
                : () async {
                    setState(() {
                      _saving = true;
                      _error = null;
                    });
                    try {
                      final scheduled = await ref
                          .read(notificationGatewayProvider)
                          .scheduleNeutralReminder(
                            id: recommendation.id.hashCode & 0x7fffffff,
                            scheduledFor: _selected!,
                            eventId: event.id,
                          );
                      if (!mounted) return;
                      if (!scheduled) {
                        setState(() {
                          _saving = false;
                          _error =
                              'Notification permission was denied. Allow '
                              'notifications in Android settings and try again.';
                        });
                        return;
                      }
                      ref
                          .read(memoryControllerProvider.notifier)
                          .scheduleTimeCapsule(recommendation.id, _selected!);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Private time capsule scheduled.'),
                          ),
                        );
                        context.pop();
                      }
                    } on Object catch (error) {
                      if (mounted) {
                        setState(() {
                          _saving = false;
                          _error =
                              'Could not schedule the local notification: $error';
                        });
                      }
                    }
                  },
            icon: _saving
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.lock_clock_outlined),
            label: const Text('Schedule neutral reminder'),
          ),
          const SizedBox(height: 18),
          const ListTile(
            leading: Icon(Icons.notifications_none),
            title: Text('Lock-screen text'),
            subtitle: Text('“You have a memory ready to revisit.”'),
          ),
        ],
      ),
    );
  }
}
