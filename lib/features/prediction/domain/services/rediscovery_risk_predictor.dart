import 'dart:math' as math;

import '../entities/factor_contribution.dart';
import '../entities/score_breakdown.dart';
import 'scoring_utils.dart';

final class RediscoveryRiskInput {
  RediscoveryRiskInput({
    required DateTime eventCreatedAtUtc,
    required DateTime? lastViewedAtUtc,
    required DateTime nowUtc,
    this.viewCount = 0,
    this.reminderShownCount = 0,
    this.reminderDismissedCount = 0,
  }) : assert(viewCount >= 0),
       assert(reminderShownCount >= 0),
       assert(reminderDismissedCount >= 0),
       eventCreatedAtUtc = eventCreatedAtUtc.toUtc(),
       lastViewedAtUtc = lastViewedAtUtc?.toUtc(),
       nowUtc = nowUtc.toUtc();

  final DateTime eventCreatedAtUtc;
  final DateTime? lastViewedAtUtc;
  final DateTime nowUtc;
  final int viewCount;
  final int reminderShownCount;
  final int reminderDismissedCount;
}

final class RediscoveryRiskConfig {
  const RediscoveryRiskConfig({
    this.algorithmVersion = 'rediscovery-risk-rule-v1',
    this.stalenessWeight = 0.40,
    this.lowViewCountWeight = 0.25,
    this.eventAgeWeight = 0.15,
    this.neverRemindedWeight = 0.05,
    this.reminderDismissalWeight = 0.15,
    this.daysForMaximumStaleness = 365,
    this.daysForMaximumEventAge = 730,
    this.viewsForLowRisk = 10,
  }) : assert(algorithmVersion != ''),
       assert(daysForMaximumStaleness > 0),
       assert(daysForMaximumEventAge > 0),
       assert(viewsForLowRisk > 0);

  final String algorithmVersion;
  final double stalenessWeight;
  final double lowViewCountWeight;
  final double eventAgeWeight;
  final double neverRemindedWeight;
  final double reminderDismissalWeight;
  final int daysForMaximumStaleness;
  final int daysForMaximumEventAge;
  final int viewsForLowRisk;

  List<double> get weights => [
    stalenessWeight,
    lowViewCountWeight,
    eventAgeWeight,
    neverRemindedWeight,
    reminderDismissalWeight,
  ];
}

abstract interface class RediscoveryRiskPredictor {
  ScoreBreakdown predict(
    RediscoveryRiskInput input, {
    RediscoveryRiskConfig config = const RediscoveryRiskConfig(),
  });
}

/// Estimates the chance that an event remains unopened inside this app.
/// The result is an explainable heuristic, not biological forgetting.
final class RuleBasedRediscoveryRiskPredictor
    implements RediscoveryRiskPredictor {
  const RuleBasedRediscoveryRiskPredictor();

  @override
  ScoreBreakdown predict(
    RediscoveryRiskInput input, {
    RediscoveryRiskConfig config = const RediscoveryRiskConfig(),
  }) {
    validateNormalizedWeights(config.weights);

    final eventAgeDays = _nonNegativeDays(
      input.nowUtc,
      input.eventCreatedAtUtc,
    );
    final lastRelevantView = input.lastViewedAtUtc ?? input.eventCreatedAtUtc;
    final daysSinceLastView = _nonNegativeDays(input.nowUtc, lastRelevantView);
    final staleness = unitScore(
      daysSinceLastView / config.daysForMaximumStaleness,
    );
    final viewSignal = unitScore(
      math.log(input.viewCount + 1) / math.log(config.viewsForLowRisk + 1),
    );
    final lowViewCount = 1 - viewSignal;
    final eventAge = unitScore(eventAgeDays / config.daysForMaximumEventAge);
    final neverReminded = input.reminderShownCount == 0 ? 1.0 : 0.0;
    final dismissalRate = input.reminderShownCount == 0
        ? 0.0
        : unitScore(input.reminderDismissedCount / input.reminderShownCount);

    return ScoreBreakdown(
      algorithmVersion: config.algorithmVersion,
      contributions: [
        FactorContribution(
          key: 'staleness',
          rawValue: daysSinceLastView,
          normalizedValue: staleness,
          weight: config.stalenessWeight,
          reasonCode: input.lastViewedAtUtc == null
              ? 'event_never_opened'
              : 'days_since_last_view',
        ),
        FactorContribution(
          key: 'low_view_count',
          rawValue: input.viewCount.toDouble(),
          normalizedValue: lowViewCount,
          weight: config.lowViewCountWeight,
          reasonCode: input.viewCount <= 1 ? 'viewed_rarely' : 'total_views',
        ),
        FactorContribution(
          key: 'event_age',
          rawValue: eventAgeDays,
          normalizedValue: eventAge,
          weight: config.eventAgeWeight,
          reasonCode: 'event_age_days',
        ),
        FactorContribution(
          key: 'never_reminded',
          rawValue: input.reminderShownCount.toDouble(),
          normalizedValue: neverReminded,
          weight: config.neverRemindedWeight,
          reasonCode: input.reminderShownCount == 0
              ? 'not_previously_reminded'
              : 'previously_reminded',
        ),
        FactorContribution(
          key: 'reminder_dismissal_rate',
          rawValue: input.reminderDismissedCount.toDouble(),
          normalizedValue: dismissalRate,
          weight: config.reminderDismissalWeight,
          reasonCode: input.reminderDismissedCount == 0
              ? 'no_reminders_dismissed'
              : 'reminders_dismissed',
        ),
      ],
    );
  }

  double _nonNegativeDays(DateTime later, DateTime earlier) => math
      .max(
        0,
        later.difference(earlier).inMicroseconds / Duration.microsecondsPerDay,
      )
      .toDouble();
}
