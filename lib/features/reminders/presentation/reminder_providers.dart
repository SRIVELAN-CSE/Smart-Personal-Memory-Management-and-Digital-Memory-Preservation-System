import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local_notification_service.dart';
import '../domain/notification_gateway.dart';

final notificationGatewayProvider = Provider<NotificationGateway>(
  (ref) => LocalNotificationService(),
);
