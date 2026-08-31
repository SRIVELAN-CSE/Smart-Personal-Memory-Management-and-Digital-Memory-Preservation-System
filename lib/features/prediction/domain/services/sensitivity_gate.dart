enum MemorySensitivity { safe, hidden, sensitive }

final class SensitivityDecision {
  const SensitivityDecision({
    required this.score,
    required this.blocksProactiveSurfaces,
    required this.allowsNotification,
    required this.requiresNeutralNotification,
    required this.reasonCode,
  });

  final double score;
  final bool blocksProactiveSurfaces;
  final bool allowsNotification;
  final bool requiresNeutralNotification;
  final String reasonCode;
}

abstract interface class SensitivityGate {
  SensitivityDecision evaluate(
    MemorySensitivity sensitivity, {
    bool userExplicitlyRequestedReminder = false,
  });
}

/// A user-controlled privacy gate. Version 1 performs no content inference.
final class UserControlledSensitivityGate implements SensitivityGate {
  const UserControlledSensitivityGate();

  @override
  SensitivityDecision evaluate(
    MemorySensitivity sensitivity, {
    bool userExplicitlyRequestedReminder = false,
  }) {
    if (sensitivity == MemorySensitivity.safe) {
      return const SensitivityDecision(
        score: 0,
        blocksProactiveSurfaces: false,
        allowsNotification: true,
        requiresNeutralNotification: true,
        reasonCode: 'memory_marked_safe',
      );
    }

    return SensitivityDecision(
      score: 1,
      blocksProactiveSurfaces: true,
      allowsNotification: userExplicitlyRequestedReminder,
      requiresNeutralNotification: true,
      reasonCode: userExplicitlyRequestedReminder
          ? 'private_memory_explicit_neutral_reminder'
          : 'private_memory_proactive_notification_blocked',
    );
  }
}
