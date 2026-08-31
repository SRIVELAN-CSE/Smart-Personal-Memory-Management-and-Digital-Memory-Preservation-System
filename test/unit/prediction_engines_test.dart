import 'package:flutter_test/flutter_test.dart';
import 'package:smart_memory_preservation/features/prediction/domain/entities/factor_contribution.dart';
import 'package:smart_memory_preservation/features/prediction/domain/entities/score_breakdown.dart';
import 'package:smart_memory_preservation/features/prediction/domain/services/context_completeness_evaluator.dart';
import 'package:smart_memory_preservation/features/prediction/domain/services/preservation_decision_engine.dart';
import 'package:smart_memory_preservation/features/prediction/domain/services/rediscovery_risk_predictor.dart';
import 'package:smart_memory_preservation/features/prediction/domain/services/sensitivity_gate.dart';
import 'package:smart_memory_preservation/features/prediction/domain/services/significance_predictor.dart';

void main() {
  group('significance predictor', () {
    const predictor = RuleBasedSignificancePredictor();

    test('normalizes every configured signal and retains contributions', () {
      final result = predictor.predict(
        const SignificanceInput(
          manualRating: 5,
          isFavourite: true,
          viewCount: 10,
          peopleTagCount: 5,
          hasStory: true,
          hasNote: true,
          hasVoiceNote: true,
          userCorrectionCount: 3,
        ),
      );

      expect(result.score, closeTo(1, 0.000001));
      expect(result.contributions, hasLength(6));
      expect(
        result.contributions.fold<double>(
          0,
          (sum, factor) => sum + factor.contribution,
        ),
        closeTo(result.score, 0.000001),
      );
    });

    test('an explicit important mark supplies the manual-priority signal', () {
      final result = predictor.predict(
        const SignificanceInput(isMarkedImportant: true),
      );

      expect(result.factor('manual_priority').normalizedValue, 1);
      expect(result.factor('manual_priority').contribution, 0.35);
      expect(
        result.factor('manual_priority').reasonCode,
        'explicitly_marked_important',
      );
    });
  });

  group('rediscovery-risk predictor', () {
    const predictor = RuleBasedRediscoveryRiskPredictor();

    test(
      'uses only the injected current time and produces expected factors',
      () {
        final result = predictor.predict(
          RediscoveryRiskInput(
            eventCreatedAtUtc: DateTime.utc(2024, 8, 31),
            lastViewedAtUtc: DateTime.utc(2025, 8, 31),
            nowUtc: DateTime.utc(2026, 8, 31),
          ),
        );

        expect(result.score, closeTo(0.85, 0.000001));
        expect(result.factor('staleness').normalizedValue, 1);
        expect(result.factor('low_view_count').normalizedValue, 1);
        expect(result.factor('event_age').normalizedValue, 1);
        expect(result.factor('never_reminded').normalizedValue, 1);
        expect(result.factor('reminder_dismissal_rate').normalizedValue, 0);
      },
    );

    test('reminder dismissal rate is bounded when counts are inconsistent', () {
      final result = predictor.predict(
        RediscoveryRiskInput(
          eventCreatedAtUtc: DateTime.utc(2026, 1, 1),
          lastViewedAtUtc: DateTime.utc(2026, 8, 1),
          nowUtc: DateTime.utc(2026, 8, 31),
          reminderShownCount: 1,
          reminderDismissedCount: 3,
        ),
      );

      expect(result.factor('reminder_dismissal_rate').normalizedValue, 1);
    });
  });

  group('context completeness', () {
    const evaluator = RuleBasedContextCompletenessEvaluator();

    test('returns a score and the exact missing actions', () {
      final result = evaluator.evaluate(
        const ContextCompletenessInput(
          hasConfirmedTitle: true,
          hasConfirmedPlace: true,
          hasTaggedPeople: true,
        ),
      );

      expect(result.score, closeTo(0.5, 0.000001));
      expect(result.missingActions, [
        MissingContextAction.addStory,
        MissingContextAction.addVoiceNote,
        MissingContextAction.selectCover,
      ]);
    });
  });

  group('preservation decision and sensitivity gate', () {
    const contextEvaluator = RuleBasedContextCompletenessEvaluator();
    const engine = ExplainablePreservationDecisionEngine();

    test('uses the required multiplicative formula and missing actions', () {
      final context = contextEvaluator.evaluate(
        const ContextCompletenessInput(
          hasConfirmedTitle: true,
          hasConfirmedPlace: true,
          hasTaggedPeople: true,
          hasUserSelectedCover: true,
        ),
      );
      final result = engine.evaluate(
        PreservationDecisionInput(
          significance: _score(0.8),
          rediscoveryRisk: _score(0.75),
          contextCompleteness: context,
          sensitivity: MemorySensitivity.safe,
        ),
      );

      expect(result.contextCompletenessScore, closeTo(2 / 3, 0.000001));
      expect(result.preservationNeed, closeTo(0.2, 0.000001));
      expect(result.recommendedActions, [
        PreservationAction.addStory,
        PreservationAction.addVoiceNote,
        PreservationAction.scheduleTimeCapsule,
      ]);
      expect(result.isProactivelySuppressed, isFalse);
    });

    test('a sensitive event is suppressed before recommendations', () {
      final result = engine.evaluate(
        PreservationDecisionInput(
          significance: _score(1),
          rediscoveryRisk: _score(1),
          contextCompleteness: contextEvaluator.evaluate(
            const ContextCompletenessInput(),
          ),
          sensitivity: MemorySensitivity.sensitive,
        ),
      );

      expect(result.preservationNeed, 0);
      expect(result.recommendedActions, isEmpty);
      expect(result.isProactivelySuppressed, isTrue);
      expect(result.sensitivity.allowsNotification, isFalse);
      expect(result.sensitivity.requiresNeutralNotification, isTrue);
    });

    test(
      'an explicit private reminder is allowed only with neutral wording',
      () {
        const gate = UserControlledSensitivityGate();
        final decision = gate.evaluate(
          MemorySensitivity.hidden,
          userExplicitlyRequestedReminder: true,
        );

        expect(decision.blocksProactiveSurfaces, isTrue);
        expect(decision.allowsNotification, isTrue);
        expect(decision.requiresNeutralNotification, isTrue);
      },
    );

    test('complete high-value, high-risk context recommends rediscovery', () {
      final result = engine.evaluate(
        PreservationDecisionInput(
          significance: _score(0.9),
          rediscoveryRisk: _score(0.8),
          contextCompleteness: contextEvaluator.evaluate(
            const ContextCompletenessInput(
              hasConfirmedTitle: true,
              hasConfirmedPlace: true,
              hasTaggedPeople: true,
              hasStory: true,
              hasVoiceNote: true,
              hasUserSelectedCover: true,
            ),
          ),
          sensitivity: MemorySensitivity.safe,
        ),
      );

      expect(result.preservationNeed, 0);
      expect(result.recommendedActions, [
        PreservationAction.revisit,
        PreservationAction.scheduleTimeCapsule,
      ]);
    });
  });
}

ScoreBreakdown _score(double value) => ScoreBreakdown(
  algorithmVersion: 'test-score-v1',
  contributions: [
    FactorContribution(
      key: 'test_factor',
      rawValue: value,
      normalizedValue: value,
      weight: 1,
      reasonCode: 'test_factor',
    ),
  ],
);
