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
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    _initialized = true;
  }

  @override
  Future<bool> scheduleNeutralReminder({
    required int id,
    required DateTime scheduledFor,
    required String eventId,
  }) async {
    await _initialize();
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
  Future<void> cancelAll() => _plugin.cancelAll();
}
