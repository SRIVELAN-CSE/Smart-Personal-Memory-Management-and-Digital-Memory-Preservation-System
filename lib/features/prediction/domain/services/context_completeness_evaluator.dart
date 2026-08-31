import '../entities/factor_contribution.dart';
import '../entities/score_breakdown.dart';
import 'scoring_utils.dart';

enum MissingContextAction {
  confirmTitle,
  confirmPlace,
  tagPeople,
  addStory,
  addVoiceNote,
  selectCover,
}

final class ContextCompletenessInput {
  const ContextCompletenessInput({
    this.hasConfirmedTitle = false,
    this.hasConfirmedPlace = false,
    this.hasTaggedPeople = false,
    this.hasStory = false,
    this.hasVoiceNote = false,
    this.hasUserSelectedCover = false,
  });

  final bool hasConfirmedTitle;
  final bool hasConfirmedPlace;
  final bool hasTaggedPeople;
  final bool hasStory;
  final bool hasVoiceNote;
  final bool hasUserSelectedCover;
}

final class ContextCompletenessConfig {
  const ContextCompletenessConfig({
    this.algorithmVersion = 'context-completeness-rule-v1',
    this.confirmedTitleWeight = 1 / 6,
    this.confirmedPlaceWeight = 1 / 6,
    this.taggedPeopleWeight = 1 / 6,
    this.storyWeight = 1 / 6,
    this.voiceNoteWeight = 1 / 6,
    this.userSelectedCoverWeight = 1 / 6,
  });

  final String algorithmVersion;
  final double confirmedTitleWeight;
  final double confirmedPlaceWeight;
  final double taggedPeopleWeight;
  final double storyWeight;
  final double voiceNoteWeight;
  final double userSelectedCoverWeight;

  List<double> get weights => [
    confirmedTitleWeight,
    confirmedPlaceWeight,
    taggedPeopleWeight,
    storyWeight,
    voiceNoteWeight,
    userSelectedCoverWeight,
  ];
}

final class ContextCompletenessResult {
  ContextCompletenessResult({
    required this.breakdown,
    required List<MissingContextAction> missingActions,
  }) : missingActions = List<MissingContextAction>.unmodifiable(missingActions);

  final ScoreBreakdown breakdown;
  final List<MissingContextAction> missingActions;

  double get score => breakdown.score;
}

abstract interface class ContextCompletenessEvaluator {
  ContextCompletenessResult evaluate(
    ContextCompletenessInput input, {
    ContextCompletenessConfig config = const ContextCompletenessConfig(),
  });
}

final class RuleBasedContextCompletenessEvaluator
    implements ContextCompletenessEvaluator {
  const RuleBasedContextCompletenessEvaluator();

  @override
  ContextCompletenessResult evaluate(
    ContextCompletenessInput input, {
    ContextCompletenessConfig config = const ContextCompletenessConfig(),
  }) {
    validateNormalizedWeights(config.weights);
    final factors = <FactorContribution>[
      _factor(
        key: 'confirmed_title',
        present: input.hasConfirmedTitle,
        weight: config.confirmedTitleWeight,
      ),
      _factor(
        key: 'confirmed_place',
        present: input.hasConfirmedPlace,
        weight: config.confirmedPlaceWeight,
      ),
      _factor(
        key: 'tagged_people',
        present: input.hasTaggedPeople,
        weight: config.taggedPeopleWeight,
      ),
      _factor(
        key: 'story',
        present: input.hasStory,
        weight: config.storyWeight,
      ),
      _factor(
        key: 'voice_note',
        present: input.hasVoiceNote,
        weight: config.voiceNoteWeight,
      ),
      _factor(
        key: 'user_selected_cover',
        present: input.hasUserSelectedCover,
        weight: config.userSelectedCoverWeight,
      ),
    ];

    return ContextCompletenessResult(
      breakdown: ScoreBreakdown(
        algorithmVersion: config.algorithmVersion,
        contributions: factors,
      ),
      missingActions: [
        if (!input.hasConfirmedTitle) MissingContextAction.confirmTitle,
        if (!input.hasConfirmedPlace) MissingContextAction.confirmPlace,
        if (!input.hasTaggedPeople) MissingContextAction.tagPeople,
        if (!input.hasStory) MissingContextAction.addStory,
        if (!input.hasVoiceNote) MissingContextAction.addVoiceNote,
        if (!input.hasUserSelectedCover) MissingContextAction.selectCover,
      ],
    );
  }

  FactorContribution _factor({
    required String key,
    required bool present,
    required double weight,
  }) => FactorContribution(
    key: key,
    rawValue: booleanScore(present),
    normalizedValue: booleanScore(present),
    weight: weight,
    reasonCode: present ? '${key}_present' : '${key}_missing',
  );
}
