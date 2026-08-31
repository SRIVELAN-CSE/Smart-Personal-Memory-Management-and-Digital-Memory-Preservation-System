import 'package:drift/drift.dart';

import 'app_database.dart';

typedef DatabaseClock = DateTime Function();

class MemoryDatabaseRepository {
  MemoryDatabaseRepository(this._database, {DatabaseClock? clock})
    : _clock = clock ?? DateTime.now;

  final AppDatabase _database;
  final DatabaseClock _clock;

  Stream<List<MemoryEventRow>> watchTimeline({bool includeHidden = false}) {
    final query = _database.select(_database.events);
    if (!includeHidden) {
      query.where((event) => event.isHidden.equals(false));
    }
    query.orderBy([(event) => OrderingTerm.desc(event.startAt)]);
    return query.watch();
  }

  Stream<List<PreservationRecommendationRow>> watchRecommendationInbox() {
    final query = _database.select(_database.preservationRecommendations)
      ..where((recommendation) => recommendation.status.equals('pending'))
      ..orderBy([
        (recommendation) => OrderingTerm.desc(recommendation.createdAt),
      ]);
    return query.watch();
  }

  Future<MemoryEventRow?> getEvent(String eventId) {
    return (_database.select(
      _database.events,
    )..where((event) => event.id.equals(eventId))).getSingleOrNull();
  }

  Future<List<MediaItemRow>> getEventMedia(String eventId) async {
    final memberships =
        await (_database.select(_database.eventMedia)
              ..where((membership) => membership.eventId.equals(eventId))
              ..orderBy([
                (membership) => OrderingTerm.asc(membership.position),
              ]))
            .get();

    if (memberships.isEmpty) {
      return const [];
    }

    final ids = memberships.map((membership) => membership.mediaId).toList();
    final rows = await (_database.select(
      _database.mediaItems,
    )..where((media) => media.id.isIn(ids))).get();
    final byId = {for (final row in rows) row.id: row};
    return [
      for (final id in ids)
        if (byId[id] case final row?) row,
    ];
  }

  Future<void> confirmEventTitle({
    required String eventId,
    required String title,
  }) async {
    final normalizedTitle = title.trim();
    if (normalizedTitle.isEmpty) {
      throw ArgumentError.value(title, 'title', 'Title cannot be empty.');
    }

    final affected =
        await (_database.update(
          _database.events,
        )..where((event) => event.id.equals(eventId))).write(
          EventsCompanion(
            confirmedTitle: Value(normalizedTitle),
            isTitleConfirmed: const Value(true),
            updatedAt: Value(_clock().toUtc()),
          ),
        );
    if (affected != 1) {
      throw StateError('Event $eventId does not exist.');
    }
  }

  Future<void> setEventSensitivity({
    required String eventId,
    required bool isSensitive,
    bool hideEvent = false,
  }) async {
    final affected =
        await (_database.update(
          _database.events,
        )..where((event) => event.id.equals(eventId))).write(
          EventsCompanion(
            isSensitive: Value(isSensitive),
            isHidden: Value(hideEvent),
            updatedAt: Value(_clock().toUtc()),
          ),
        );
    if (affected != 1) {
      throw StateError('Event $eventId does not exist.');
    }
  }

  Future<void> recordEventView({
    required String eventId,
    required String interactionId,
    DateTime? viewedAt,
  }) {
    return _database.transaction(() async {
      final event = await (_database.select(
        _database.events,
      )..where((row) => row.id.equals(eventId))).getSingleOrNull();
      if (event == null) {
        throw StateError('Event $eventId does not exist.');
      }

      final occurredAt = (viewedAt ?? _clock()).toUtc();
      await (_database.update(
        _database.events,
      )..where((row) => row.id.equals(eventId))).write(
        EventsCompanion(
          viewCount: Value(event.viewCount + 1),
          lastViewedAt: Value(occurredAt),
          updatedAt: Value(occurredAt),
        ),
      );
      await _database
          .into(_database.eventInteractions)
          .insert(
            EventInteractionsCompanion.insert(
              id: interactionId,
              eventId: eventId,
              interactionType: 'view',
              occurredAt: occurredAt,
            ),
          );
    });
  }

  Future<void> ensurePrivacyDefaults() async {
    await _database
        .into(_database.privacySettings)
        .insert(
          PrivacySettingsCompanion.insert(id: 'default'),
          mode: InsertMode.insertOrIgnore,
        );
  }

  /// Deletes the event and its derived relationships through foreign-key
  /// cascades. Rows in [MediaItems] are deliberately retained because they are
  /// gallery references, not event-owned source media.
  Future<bool> deleteDerivedEvent(String eventId) async {
    return _database.transaction(() async {
      // Graph nodes use a polymorphic entityId and therefore cannot declare a
      // database-level foreign key to every possible entity table.
      await (_database.delete(_database.graphNodes)..where(
            (node) =>
                node.nodeType.equals('event') & node.entityId.equals(eventId),
          ))
          .go();

      final deleted = await (_database.delete(
        _database.events,
      )..where((event) => event.id.equals(eventId))).go();
      return deleted == 1;
    });
  }
}
