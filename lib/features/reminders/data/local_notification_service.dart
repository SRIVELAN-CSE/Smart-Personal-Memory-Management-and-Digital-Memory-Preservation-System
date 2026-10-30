import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../domain/notification_gateway.dart';

class LocalNotificationService implements NotificationGateway {
  LocalNotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  var _initialized = false;

  Future<void> _initialize() async {
    if (_initialized) return;
    tz_data.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } on Object {
      tz.setLocalLocation(tz.UTC);
    }
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_memory_notification'),
      ),
    );
    _initialized = true;
  }

  Future<bool> _requestPermission() async {
    final allowed = await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    return allowed ?? true;
  }

  @override
  Future<bool> scheduleNeutralReminder({
    required int id,
    required DateTime scheduledFor,
    required String eventId,
  }) async {
    await _initialize();
    if (!await _requestPermission()) return false;
    if (!scheduledFor.isAfter(DateTime.now())) {
      throw ArgumentError('Choose a future date for the reminder.');
    }
    await _plugin.zonedSchedule(
      id: id,
      title: 'Smart Memory',
      body: 'You have a memory ready to revisit.',
      scheduledDate: tz.TZDateTime.from(scheduledFor, tz.local),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'memory_capsules',
          'Memory capsules',
          channelDescription: 'Neutral reminders explicitly scheduled by you.',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          visibility: NotificationVisibility.secret,
          category: AndroidNotificationCategory.reminder,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: 'event:$eventId',
    );
    return true;
  }

  @override
  Future<void> cancelAll() async {
    await _initialize();
    await _plugin.cancelAll();
  }
}
