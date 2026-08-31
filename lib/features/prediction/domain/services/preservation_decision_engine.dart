import '../entities/score_breakdown.dart';
import 'context_completeness_evaluator.dart';
import 'scoring_utils.dart';
import 'sensitivity_gate.dart';

enum PreservationAction {
  confirmTitle,
  confirmPlace,
  tagPeople,
  addStory,
  addVoiceNote,
  selectCover,
  revisit,
  scheduleTimeCapsule,
}

final class PreservationDecisionInput {
  const PreservationDecisionInput({
    required this.significance,
    required this.rediscoveryRisk,
    required this.contextCompleteness,
    required this.sensitivity,
    this.userExplicitlyRequestedReminder = false,
  });

  final ScoreBreakdown significance;
  final ScoreBreakdown rediscoveryRisk;
  final ContextCompletenessResult contextCompleteness;
  final MemorySensitivity sensitivity;
  final bool userExplicitlyRequestedReminder;
}

final class PreservationDecisionConfig {
  const PreservationDecisionConfig({
    this.algorithmVersion = 'preservation-decision-rule-v1',
    this.minimumPreservationNeed = 0.15,
    this.highSignificanceThreshold = 0.70,
    this.highRediscoveryRiskThreshold = 0.60,
    this.maximumRecommendedActions = 3,
  }) : assert(algorithmVersion != ''),
       assert(minimumPreservationNeed >= 0 && minimumPreservationNeed <= 1),
       assert(highSignificanceThreshold >= 0 && highSignificanceThreshold <= 1),
       assert(
         highRediscoveryRiskThreshold >= 0 && highRediscoveryRiskThreshold <= 1,
       ),
       assert(maximumRecommendedActions > 0);

  final String algorithmVersion;
  final double minimumPreservationNeed;
  final double highSignificanceThreshold;
  final double highRediscoveryRiskThreshold;
  final int maximumRecommendedActions;
}

final class PreservationDecision {
  PreservationDecision({
    required this.algorithmVersion,
    required this.significanceScore,
    required this.rediscoveryRiskScore,
    required this.contextCompletenessScore,
    required this.preservationNeed,
    required this.sensitivity,
    required this.isProactivelySuppressed,
    required List<PreservationAction> recommendedActions,
    required List<String> reasonCodes,
  }) : recommendedActions = List<PreservationAction>.unmodifiable(
         recommendedActions,
       ),
       reasonCodes = List<String>.unmodifiable(reasonCodes);

  final String algorithmVersion;
  final double significanceScore;
  final double rediscoveryRiskScore;
  final double contextCompletenessScore;
  final double preservationNeed;
  final SensitivityDecision sensitivity;
  final bool isProactivelySuppressed;
  final List<PreservationAction> recommendedActions;
  final List<String> reasonCodes;
}

abstract interface class PreservationDecisionEngine {
  PreservationDecision evaluate(
    PreservationDecisionInput input, {
    PreservationDecisionConfig config = const PreservationDecisionConfig(),
  });
}

final class ExplainablePreservationDecisionEngine
    implements PreservationDecisionEngine {
  const ExplainablePreservationDecisionEngine({
    this.sensitivityGate = const UserControlledSensitivityGate(),
  });

  final SensitivityGate sensitivityGate;

  @override
  PreservationDecision evaluate(
    PreservationDecisionInput input, {
    PreservationDecisionConfig config = const PreservationDecisionConfig(),
  }) {
    final sensitivity = sensitivityGate.evaluate(
      input.sensitivity,
      userExplicitlyRequestedReminder: input.userExplicitlyRequestedReminder,
    );
    final significance = input.significance.score;
    final risk = input.rediscoveryRisk.score;
    final completeness = input.contextCompleteness.score;
    final need = unitScore(
      significance * risk * (1 - completeness) * (1 - sensitivity.score),
    );
    final isHighValue = significance >= config.highSignificanceThreshold;
    final isHighRisk = risk >= config.highRediscoveryRiskThreshold;

    final reasonCodes = <String>[
      if (isHighValue) 'high_application_significance',
      if (isHighRisk) 'high_rediscovery_risk',
      if (completeness < 1) 'incomplete_context',
      if (need >= config.minimumPreservationNeed)
        'preservation_need_threshold_met',
      if (sensitivity.blocksProactiveSurfaces) 'sensitivity_gate_applied',
    ];

    final actions = <PreservationAction>[];
    if (!sensitivity.blocksProactiveSurfaces) {
      if (need >= config.minimumPreservationNeed) {
        final missing = input.contextCompleteness.missingActions.toList()
          ..sort(
            (left, right) => _missingActionPriority(
              left,
            ).compareTo(_missingActionPriority(right)),
          );
        for (final action in missing) {
          _appendIfSpace(
            actions,
            _preservationAction(action),
            config.maximumRecommendedActions,
          );
        }
      }

      if (isHighValue && isHighRisk) {
        if (input.contextCompleteness.missingActions.isEmpty) {
          _appendIfSpace(
            actions,
            PreservationAction.revisit,
            config.maximumRecommendedActions,
          );
        }
        _appendIfSpace(
          actions,
          PreservationAction.scheduleTimeCapsule,
          config.maximumRecommendedActions,
        );
      }
    }

    return PreservationDecision(
      algorithmVersion: config.algorithmVersion,
      significanceScore: significance,
      rediscoveryRiskScore: risk,
      contextCompletenessScore: completeness,
      preservationNeed: need,
      sensitivity: sensitivity,
      isProactivelySuppressed: sensitivity.blocksProactiveSurfaces,
      recommendedActions: actions,
      reasonCodes: reasonCodes,
    );
  }

  void _appendIfSpace(
    List<PreservationAction> actions,
    PreservationAction action,
    int maximum,
  ) {
    if (actions.length < maximum && !actions.contains(action)) {
      actions.add(action);
    }
  }

  int _missingActionPriority(MissingContextAction action) => switch (action) {
    MissingContextAction.addStory => 0,
    MissingContextAction.addVoiceNote => 1,
    MissingContextAction.tagPeople => 2,
    MissingContextAction.confirmPlace => 3,
    MissingContextAction.confirmTitle => 4,
    MissingContextAction.selectCover => 5,
  };

  PreservationAction _preservationAction(MissingContextAction action) =>
      switch (action) {
        MissingContextAction.confirmTitle => PreservationAction.confirmTitle,
        MissingContextAction.confirmPlace => PreservationAction.confirmPlace,
        MissingContextAction.tagPeople => PreservationAction.tagPeople,
        MissingContextAction.addStory => PreservationAction.addStory,
        MissingContextAction.addVoiceNote => PreservationAction.addVoiceNote,
        MissingContextAction.selectCover => PreservationAction.selectCover,
      };
}
