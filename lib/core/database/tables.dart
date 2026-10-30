import 'package:drift/drift.dart';

mixin AuditColumns on Table {
  late final createdAt = dateTime().withDefault(currentDateAndTime)();
  late final updatedAt = dateTime().withDefault(currentDateAndTime)();
}

@TableIndex(name: 'scan_history_started_at_idx', columns: {#startedAt})
@TableIndex(name: 'scan_history_status_idx', columns: {#status})
@DataClassName('ScanHistoryRow')
class ScanHistory extends Table {
  @override
  String get tableName => 'scan_history';

  late final id = text()();
  late final startedAt = dateTime()();
  late final completedAt = dateTime().nullable()();
  late final status = text()();
  late final permissionMode = text()();
  late final resumeCursor = text().nullable()();
  late final discoveredCount = integer().withDefault(const Constant(0))();
  late final processedCount = integer().withDefault(const Constant(0))();
  late final importedCount = integer().withDefault(const Constant(0))();
  late final skippedCount = integer().withDefault(const Constant(0))();
  late final failedCount = integer().withDefault(const Constant(0))();
  late final errorSummary = text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(name: 'media_items_capture_at_idx', columns: {#captureAt})
@TableIndex(
  name: 'media_items_duplicate_fingerprint_idx',
  columns: {#duplicateFingerprint},
)
@TableIndex(name: 'media_items_last_viewed_at_idx', columns: {#lastViewedAt})
@TableIndex(name: 'media_items_scan_id_idx', columns: {#scanId})
@DataClassName('MediaItemRow')
class MediaItems extends Table with AuditColumns {
  @override
  String get tableName => 'media_items';

  late final id = text()();
  late final assetId = text().unique()();
  late final locationChecked = boolean().withDefault(const Constant(false))();
  late final assetUri = text().nullable()();
  late final mediaType = text()();
  late final mimeType = text().nullable()();
  late final captureAt = dateTime()();
  late final modifiedAt = dateTime().nullable()();
  late final latitude = real().nullable()();
  late final longitude = real().nullable()();
  late final width = integer().nullable()();
  late final height = integer().nullable()();
  late final durationMs = integer().nullable()();
  late final fileSizeBytes = integer().nullable()();
  late final ocrText = text().nullable()();
  late final normalizedOcrText = text().nullable()();
  late final duplicateFingerprint = text().nullable()();
  late final visualEmbedding = blob().nullable()();
  late final thumbnailKey = text().nullable()();
  late final lastViewedAt = dateTime().nullable()();
  late final viewCount = integer().withDefault(const Constant(0))();
  late final isAvailable = boolean().withDefault(const Constant(true))();
  late final isDemo = boolean().withDefault(const Constant(false))();
  late final importedAt = dateTime().withDefault(currentDateAndTime)();
  late final scanId = text().nullable().references(
    ScanHistory,
    #id,
    onDelete: KeyAction.setNull,
  )();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(name: 'places_name_idx', columns: {#name})
@DataClassName('PlaceRow')
class Places extends Table with AuditColumns {
  late final id = text()();
  late final name = text()();
  late final locality = text().nullable()();
  late final city = text().nullable()();
  late final state = text().nullable()();
  late final country = text().nullable()();
  late final formattedAddress = text().nullable()();
  late final latitude = real().nullable()();
  late final longitude = real().nullable()();
  late final isConfirmed = boolean().withDefault(const Constant(false))();
  late final isDemo = boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(name: 'events_start_at_idx', columns: {#startAt})
@TableIndex(name: 'events_last_viewed_at_idx', columns: {#lastViewedAt})
@TableIndex(
  name: 'events_attention_idx',
  columns: {#isSensitive, #isHidden, #lastViewedAt},
)
@DataClassName('MemoryEventRow')
class Events extends Table with AuditColumns {
  late final id = text()();
  late final generatedTitle = text()();
  late final confirmedTitle = text().nullable()();
  late final isTitleConfirmed = boolean().withDefault(const Constant(false))();
  late final description = text().nullable()();
  late final startAt = dateTime()();
  late final endAt = dateTime()();
  late final placeId = text().nullable().references(
    Places,
    #id,
    onDelete: KeyAction.setNull,
  )();
  late final coverMediaId = text().nullable().references(
    MediaItems,
    #id,
    onDelete: KeyAction.setNull,
  )();
  late final isCoverUserSelected = boolean().withDefault(
    const Constant(false),
  )();
  late final isFavourite = boolean().withDefault(const Constant(false))();
  late final manualRating = integer().nullable()();
  late final isImportant = boolean().withDefault(const Constant(false))();
  late final isSensitive = boolean().withDefault(const Constant(false))();
  late final isHidden = boolean().withDefault(const Constant(false))();
  late final viewCount = integer().withDefault(const Constant(0))();
  late final lastViewedAt = dateTime().nullable()();
  late final source = text().withDefault(const Constant('generated'))();
  late final clusteringVersion = text().nullable()();
  late final generatedAt = dateTime().withDefault(currentDateAndTime)();
  late final isDemo = boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'event_media_event_position_idx',
  columns: {#eventId, #position},
)
@TableIndex(name: 'event_media_media_id_idx', columns: {#mediaId})
@DataClassName('EventMediaRow')
class EventMedia extends Table {
  @override
  String get tableName => 'event_media';

  late final eventId = text().references(
    Events,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final mediaId = text().references(
    MediaItems,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final position = integer().withDefault(const Constant(0))();
  late final clusteringConfidence = real().nullable()();
  late final isUserConfirmed = boolean().withDefault(const Constant(false))();
  late final addedAt = dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {eventId, mediaId};
}

@TableIndex(name: 'persons_display_name_idx', columns: {#displayName})
@DataClassName('PersonRow')
class Persons extends Table with AuditColumns {
  late final id = text()();
  late final displayName = text()();
  late final isConfirmed = boolean().withDefault(const Constant(true))();
  late final isDemo = boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(name: 'event_persons_person_id_idx', columns: {#personId})
@DataClassName('EventPersonRow')
class EventPersons extends Table {
  @override
  String get tableName => 'event_persons';

  late final eventId = text().references(
    Events,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final personId = text().references(
    Persons,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final role = text().withDefault(const Constant('attendee'))();
  late final isUserConfirmed = boolean().withDefault(const Constant(true))();
  late final createdAt = dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {eventId, personId};
}

@TableIndex(name: 'media_persons_person_id_idx', columns: {#personId})
@DataClassName('MediaPersonRow')
class MediaPersons extends Table {
  @override
  String get tableName => 'media_persons';

  late final mediaId = text().references(
    MediaItems,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final personId = text().references(
    Persons,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final faceBoundsJson = text().nullable()();
  late final isUserConfirmed = boolean().withDefault(const Constant(true))();
  late final createdAt = dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {mediaId, personId};
}

@TableIndex(name: 'notes_event_id_idx', columns: {#eventId})
@DataClassName('NoteRow')
class Notes extends Table with AuditColumns {
  late final id = text()();
  late final eventId = text().references(
    Events,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final body = text()();
  late final noteType = text().withDefault(const Constant('note'))();
  late final isGenerated = boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(name: 'voice_notes_event_id_idx', columns: {#eventId})
@DataClassName('VoiceNoteRow')
class VoiceNotes extends Table with AuditColumns {
  @override
  String get tableName => 'voice_notes';

  late final id = text()();
  late final eventId = text().references(
    Events,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final filePath = text().unique()();
  late final durationMs = integer()();
  late final transcript = text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(name: 'graph_nodes_type_idx', columns: {#nodeType})
@DataClassName('GraphNodeRow')
class GraphNodes extends Table {
  @override
  String get tableName => 'graph_nodes';

  late final id = text()();
  late final nodeType = text()();
  late final entityId = text()();
  late final label = text()();
  late final metadataJson = text().withDefault(const Constant('{}'))();
  late final createdAt = dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {nodeType, entityId},
  ];
}

@TableIndex(name: 'graph_edges_source_idx', columns: {#sourceNodeId})
@TableIndex(name: 'graph_edges_target_idx', columns: {#targetNodeId})
@TableIndex(name: 'graph_edges_relation_idx', columns: {#relationType})
@DataClassName('GraphEdgeRow')
class GraphEdges extends Table {
  @override
  String get tableName => 'graph_edges';

  late final id = text()();
  late final sourceNodeId = text().references(
    GraphNodes,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final targetNodeId = text().references(
    GraphNodes,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final relationType = text()();
  late final weight = real().withDefault(const Constant(1.0))();
  late final metadataJson = text().withDefault(const Constant('{}'))();
  late final createdAt = dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {sourceNodeId, targetNodeId, relationType},
  ];
}

@TableIndex(
  name: 'significance_scores_event_evaluated_idx',
  columns: {#eventId, #evaluatedAt},
)
@DataClassName('SignificanceScoreRow')
class SignificanceScores extends Table {
  @override
  String get tableName => 'significance_scores';

  late final id = text()();
  late final eventId = text().references(
    Events,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final score = real()();
  late final factorsJson = text()();
  late final algorithmVersion = text()();
  late final isIllustrative = boolean().withDefault(const Constant(false))();
  late final evaluatedAt = dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'rediscovery_scores_event_evaluated_idx',
  columns: {#eventId, #evaluatedAt},
)
@DataClassName('RediscoveryScoreRow')
class RediscoveryScores extends Table {
  @override
  String get tableName => 'rediscovery_scores';

  late final id = text()();
  late final eventId = text().references(
    Events,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final score = real()();
  late final factorsJson = text()();
  late final algorithmVersion = text()();
  late final isIllustrative = boolean().withDefault(const Constant(false))();
  late final evaluatedAt = dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'context_scores_event_evaluated_idx',
  columns: {#eventId, #evaluatedAt},
)
@DataClassName('ContextScoreRow')
class ContextScores extends Table {
  @override
  String get tableName => 'context_scores';

  late final id = text()();
  late final eventId = text().references(
    Events,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final score = real()();
  late final factorsJson = text()();
  late final algorithmVersion = text()();
  late final isIllustrative = boolean().withDefault(const Constant(false))();
  late final evaluatedAt = dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'recommendations_status_created_idx',
  columns: {#status, #createdAt},
)
@TableIndex(
  name: 'recommendations_event_created_idx',
  columns: {#eventId, #createdAt},
)
@DataClassName('PreservationRecommendationRow')
class PreservationRecommendations extends Table with AuditColumns {
  @override
  String get tableName => 'preservation_recommendations';

  late final id = text()();
  late final eventId = text().references(
    Events,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final recommendationType = text()();
  late final explanation = text()();
  late final proposedAction = text()();
  late final actionPayloadJson = text().withDefault(const Constant('{}'))();
  late final preservationNeed = real()();
  late final sensitivityAtCreation = real().withDefault(const Constant(0.0))();
  late final isSafeForNotification = boolean().withDefault(
    const Constant(false),
  )();
  late final status = text().withDefault(const Constant('pending'))();
  late final actedAt = dateTime().nullable()();
  late final dismissedAt = dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'reminders_status_scheduled_idx',
  columns: {#status, #scheduledAt},
)
@TableIndex(name: 'reminders_event_id_idx', columns: {#eventId})
@DataClassName('ReminderRow')
class Reminders extends Table with AuditColumns {
  late final id = text()();
  late final eventId = text().references(
    Events,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final recommendationId = text().nullable().references(
    PreservationRecommendations,
    #id,
    onDelete: KeyAction.setNull,
  )();
  late final reminderType = text()();
  late final scheduledAt = dateTime()();
  late final neutralText = text()();
  late final notificationId = integer().nullable()();
  late final status = text().withDefault(const Constant('scheduled'))();
  late final deliveredAt = dateTime().nullable()();
  late final openedAt = dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'user_feedback_recommendation_idx',
  columns: {#recommendationId},
)
@TableIndex(name: 'user_feedback_event_idx', columns: {#eventId})
@DataClassName('UserFeedbackRow')
class UserFeedback extends Table {
  @override
  String get tableName => 'user_feedback';

  late final id = text()();
  late final eventId = text().references(
    Events,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final recommendationId = text().nullable().references(
    PreservationRecommendations,
    #id,
    onDelete: KeyAction.setNull,
  )();
  late final feedbackType = text()();
  late final note = text().nullable()();
  late final createdAt = dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('PrivacySettingsRow')
class PrivacySettings extends Table {
  @override
  String get tableName => 'privacy_settings';

  late final id = text()();
  late final galleryAccessMode = text().withDefault(
    const Constant('not_requested'),
  )();
  late final biometricLockEnabled = boolean().withDefault(
    const Constant(false),
  )();
  late final hideSensitivePreviews = boolean().withDefault(
    const Constant(true),
  )();
  late final neutralNotificationsOnly = boolean().withDefault(
    const Constant(true),
  )();
  late final analyticsEnabled = boolean().withDefault(const Constant(false))();
  late final cloudBackupEnabled = boolean().withDefault(
    const Constant(false),
  )();
  late final updatedAt = dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'event_interactions_event_occurred_idx',
  columns: {#eventId, #occurredAt},
)
@TableIndex(name: 'event_interactions_type_idx', columns: {#interactionType})
@DataClassName('EventInteractionRow')
class EventInteractions extends Table {
  @override
  String get tableName => 'event_interactions';

  late final id = text()();
  late final eventId = text().references(
    Events,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final interactionType = text()();
  late final source = text().withDefault(const Constant('user'))();
  late final occurredAt = dateTime()();
  late final metadataJson = text().withDefault(const Constant('{}'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'processing_jobs_status_retry_idx',
  columns: {#status, #nextAttemptAt},
)
@TableIndex(
  name: 'processing_jobs_media_type_idx',
  columns: {#mediaId, #jobType},
)
@DataClassName('ProcessingJobRow')
class ProcessingJobs extends Table with AuditColumns {
  @override
  String get tableName => 'processing_jobs';

  late final id = text()();
  late final mediaId = text().nullable().references(
    MediaItems,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final eventId = text().nullable().references(
    Events,
    #id,
    onDelete: KeyAction.cascade,
  )();
  late final jobType = text()();
  late final status = text().withDefault(const Constant('pending'))();
  late final attempts = integer().withDefault(const Constant(0))();
  late final progress = real().withDefault(const Constant(0.0))();
  late final nextAttemptAt = dateTime().nullable()();
  late final startedAt = dateTime().nullable()();
  late final completedAt = dateTime().nullable()();
  late final errorCode = text().nullable()();
  late final payloadJson = text().withDefault(const Constant('{}'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
