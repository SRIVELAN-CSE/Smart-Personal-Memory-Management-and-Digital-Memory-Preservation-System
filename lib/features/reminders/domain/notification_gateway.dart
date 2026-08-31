abstract interface class NotificationGateway {
  Future<bool> scheduleNeutralReminder({
    required int id,
    required DateTime scheduledFor,
    required String eventId,
  });

  Future<void> cancelAll();
}
