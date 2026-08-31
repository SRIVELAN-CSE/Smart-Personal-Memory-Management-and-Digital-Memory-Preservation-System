import 'dart:math' as math;

import '../entities/factor_contribution.dart';
import '../entities/score_breakdown.dart';
import 'scoring_utils.dart';

final class SignificanceInput {
  const SignificanceInput({
    this.manualRating,
    this.isFavourite = false,
    this.isMarkedImportant = false,
    this.viewCount = 0,
    this.peopleTagCount = 0,
    this.hasStory = false,
    this.hasNote = false,
    this.hasVoiceNote = false,
    this.userCorrectionCount = 0,
  }) : assert(manualRating == null || (manualRating >= 1 && manualRating <= 5)),
       assert(viewCount >= 0),
       assert(peopleTagCount >= 0),
       assert(userCorrectionCount >= 0);

  final int? manualRating;
  final bool isFavourite;
  final bool isMarkedImportant;
  final int viewCount;
  final int peopleTagCount;
  final bool hasStory;
  final bool hasNote;
  final bool hasVoiceNote;
  final int userCorrectionCount;
}

final class SignificanceConfig {
  const SignificanceConfig({
    this.algorithmVersion = 'significance-rule-v1',
    this.manualPriorityWeight = 0.35,
    this.favouriteWeight = 0.20,
    this.revisitFrequencyWeight = 0.15,
    this.peopleTagsWeight = 0.10,
    this.addedContextWeight = 0.10,
    this.userCorrectionsWeight = 0.10,
    this.viewsForMaximumSignal = 10,
    this.peopleForMaximumSignal = 5,
    this.correctionsForMaximumSignal = 3,
  }) : assert(algorithmVersion != ''),
       assert(viewsForMaximumSignal > 0),
       assert(peopleForMaximumSignal > 0),
       assert(correctionsForMaximumSignal > 0);

  final String algorithmVersion;
  final double manualPriorityWeight;
  final double favouriteWeight;
  final double revisitFrequencyWeight;
  final double peopleTagsWeight;
  final double addedContextWeight;
  final double userCorrectionsWeight;
  final int viewsForMaximumSignal;
  final int peopleForMaximumSignal;
  final int correctionsForMaximumSignal;

  List<double> get weights => [
    manualPriorityWeight,
    favouriteWeight,
    revisitFrequencyWeight,
    peopleTagsWeight,
    addedContextWeight,
    userCorrectionsWeight,
  ];
}

abstract interface class SignificancePredictor {
  ScoreBreakdown predict(
    SignificanceInput input, {
    SignificanceConfig config = const SignificanceConfig(),
  });
}

/// Estimates application-level significance from explicit user interaction.
/// It does not infer emotion or biological importance.
final class RuleBasedSignificancePredictor implements SignificancePredictor {
  const RuleBasedSignificancePredictor();

  @override
  ScoreBreakdown predict(
    SignificanceInput input, {
    SignificanceConfig config = const SignificanceConfig(),
  }) {
    validateNormalizedWeights(config.weights);

    final rating = (input.manualRating ?? 0) / 5;
    final manualPriority = math
        .max(rating, booleanScore(input.isMarkedImportant))
        .toDouble();
    final revisitFrequency = unitScore(
      math.log(input.viewCount + 1) /
          math.log(config.viewsForMaximumSignal + 1),
    );
    final peopleTags = unitScore(
      input.peopleTagCount / config.peopleForMaximumSignal,
    );
    final contextCount =
        booleanScore(input.hasStory) +
        booleanScore(input.hasNote) +
        booleanScore(input.hasVoiceNote);
    final addedContext = contextCount / 3;
    final corrections = unitScore(
      input.userCorrectionCount / config.correctionsForMaximumSignal,
    );

    return ScoreBreakdown(
      algorithmVersion: config.algorithmVersion,
      contributions: [
        FactorContribution(
          key: 'manual_priority',
          rawValue: (input.manualRating ?? 0).toDouble(),
          normalizedValue: manualPriority,
          weight: config.manualPriorityWeight,
          reasonCode: input.isMarkedImportant
              ? 'explicitly_marked_important'
              : input.manualRating == null
              ? 'not_manually_rated'
              : 'manual_rating',
        ),
        FactorContribution(
          key: 'favourite',
          rawValue: booleanScore(input.isFavourite),
          normalizedValue: booleanScore(input.isFavourite),
          weight: config.favouriteWeight,
          reasonCode: input.isFavourite ? 'marked_favourite' : 'not_favourite',
        ),
        FactorContribution(
          key: 'revisit_frequency',
          rawValue: input.viewCount.toDouble(),
          normalizedValue: revisitFrequency,
          weight: config.revisitFrequencyWeight,
          reasonCode: input.viewCount == 0
              ? 'never_revisited'
              : 'revisit_count',
        ),
        FactorContribution(
          key: 'people_tags',
          rawValue: input.peopleTagCount.toDouble(),
          normalizedValue: peopleTags,
          weight: config.peopleTagsWeight,
          reasonCode: input.peopleTagCount == 0
              ? 'no_people_tagged'
              : 'people_tagged',
        ),
        FactorContribution(
          key: 'added_context',
          rawValue: contextCount,
          normalizedValue: addedContext,
          weight: config.addedContextWeight,
          reasonCode: contextCount == 0 ? 'no_added_context' : 'context_added',
        ),
        FactorContribution(
          key: 'user_corrections',
          rawValue: input.userCorrectionCount.toDouble(),
          normalizedValue: corrections,
          weight: config.userCorrectionsWeight,
          reasonCode: input.userCorrectionCount == 0
              ? 'no_user_corrections'
              : 'user_corrected_event',
        ),
      ],
    );
  }
}
