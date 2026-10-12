// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ScanHistoryTable extends ScanHistory
    with TableInfo<$ScanHistoryTable, ScanHistoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _permissionModeMeta = const VerificationMeta(
    'permissionMode',
  );
  @override
  late final GeneratedColumn<String> permissionMode = GeneratedColumn<String>(
    'permission_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resumeCursorMeta = const VerificationMeta(
    'resumeCursor',
  );
  @override
  late final GeneratedColumn<String> resumeCursor = GeneratedColumn<String>(
    'resume_cursor',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _discoveredCountMeta = const VerificationMeta(
    'discoveredCount',
  );
  @override
  late final GeneratedColumn<int> discoveredCount = GeneratedColumn<int>(
    'discovered_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _processedCountMeta = const VerificationMeta(
    'processedCount',
  );
  @override
  late final GeneratedColumn<int> processedCount = GeneratedColumn<int>(
    'processed_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _importedCountMeta = const VerificationMeta(
    'importedCount',
  );
  @override
  late final GeneratedColumn<int> importedCount = GeneratedColumn<int>(
    'imported_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _skippedCountMeta = const VerificationMeta(
    'skippedCount',
  );
  @override
  late final GeneratedColumn<int> skippedCount = GeneratedColumn<int>(
    'skipped_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _failedCountMeta = const VerificationMeta(
    'failedCount',
  );
  @override
  late final GeneratedColumn<int> failedCount = GeneratedColumn<int>(
    'failed_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _errorSummaryMeta = const VerificationMeta(
    'errorSummary',
  );
  @override
  late final GeneratedColumn<String> errorSummary = GeneratedColumn<String>(
    'error_summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    completedAt,
    status,
    permissionMode,
    resumeCursor,
    discoveredCount,
    processedCount,
    importedCount,
    skippedCount,
    failedCount,
    errorSummary,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scan_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScanHistoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('permission_mode')) {
      context.handle(
        _permissionModeMeta,
        permissionMode.isAcceptableOrUnknown(
          data['permission_mode']!,
          _permissionModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_permissionModeMeta);
    }
    if (data.containsKey('resume_cursor')) {
      context.handle(
        _resumeCursorMeta,
        resumeCursor.isAcceptableOrUnknown(
          data['resume_cursor']!,
          _resumeCursorMeta,
        ),
      );
    }
    if (data.containsKey('discovered_count')) {
      context.handle(
        _discoveredCountMeta,
        discoveredCount.isAcceptableOrUnknown(
          data['discovered_count']!,
          _discoveredCountMeta,
        ),
      );
    }
    if (data.containsKey('processed_count')) {
      context.handle(
        _processedCountMeta,
        processedCount.isAcceptableOrUnknown(
          data['processed_count']!,
          _processedCountMeta,
        ),
      );
    }
    if (data.containsKey('imported_count')) {
      context.handle(
        _importedCountMeta,
        importedCount.isAcceptableOrUnknown(
          data['imported_count']!,
          _importedCountMeta,
        ),
      );
    }
    if (data.containsKey('skipped_count')) {
      context.handle(
        _skippedCountMeta,
        skippedCount.isAcceptableOrUnknown(
          data['skipped_count']!,
          _skippedCountMeta,
        ),
      );
    }
    if (data.containsKey('failed_count')) {
      context.handle(
        _failedCountMeta,
        failedCount.isAcceptableOrUnknown(
          data['failed_count']!,
          _failedCountMeta,
        ),
      );
    }
    if (data.containsKey('error_summary')) {
      context.handle(
        _errorSummaryMeta,
        errorSummary.isAcceptableOrUnknown(
          data['error_summary']!,
          _errorSummaryMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScanHistoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanHistoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      permissionMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}permission_mode'],
      )!,
      resumeCursor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resume_cursor'],
      ),
      discoveredCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discovered_count'],
      )!,
      processedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}processed_count'],
      )!,
      importedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}imported_count'],
      )!,
      skippedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skipped_count'],
      )!,
      failedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}failed_count'],
      )!,
      errorSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_summary'],
      ),
    );
  }

  @override
  $ScanHistoryTable createAlias(String alias) {
    return $ScanHistoryTable(attachedDatabase, alias);
  }
}

class ScanHistoryRow extends DataClass implements Insertable<ScanHistoryRow> {
  final String id;
  final DateTime startedAt;
  final DateTime? completedAt;
  final String status;
  final String permissionMode;
  final String? resumeCursor;
  final int discoveredCount;
  final int processedCount;
  final int importedCount;
  final int skippedCount;
  final int failedCount;
  final String? errorSummary;
  const ScanHistoryRow({
    required this.id,
    required this.startedAt,
    this.completedAt,
    required this.status,
    required this.permissionMode,
    this.resumeCursor,
    required this.discoveredCount,
    required this.processedCount,
    required this.importedCount,
    required this.skippedCount,
    required this.failedCount,
    this.errorSummary,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['status'] = Variable<String>(status);
    map['permission_mode'] = Variable<String>(permissionMode);
    if (!nullToAbsent || resumeCursor != null) {
      map['resume_cursor'] = Variable<String>(resumeCursor);
    }
    map['discovered_count'] = Variable<int>(discoveredCount);
    map['processed_count'] = Variable<int>(processedCount);
    map['imported_count'] = Variable<int>(importedCount);
    map['skipped_count'] = Variable<int>(skippedCount);
    map['failed_count'] = Variable<int>(failedCount);
    if (!nullToAbsent || errorSummary != null) {
      map['error_summary'] = Variable<String>(errorSummary);
    }
    return map;
  }

  ScanHistoryCompanion toCompanion(bool nullToAbsent) {
    return ScanHistoryCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      status: Value(status),
      permissionMode: Value(permissionMode),
      resumeCursor: resumeCursor == null && nullToAbsent
          ? const Value.absent()
          : Value(resumeCursor),
      discoveredCount: Value(discoveredCount),
      processedCount: Value(processedCount),
      importedCount: Value(importedCount),
      skippedCount: Value(skippedCount),
      failedCount: Value(failedCount),
      errorSummary: errorSummary == null && nullToAbsent
          ? const Value.absent()
          : Value(errorSummary),
    );
  }

  factory ScanHistoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanHistoryRow(
      id: serializer.fromJson<String>(json['id']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      status: serializer.fromJson<String>(json['status']),
      permissionMode: serializer.fromJson<String>(json['permissionMode']),
      resumeCursor: serializer.fromJson<String?>(json['resumeCursor']),
      discoveredCount: serializer.fromJson<int>(json['discoveredCount']),
      processedCount: serializer.fromJson<int>(json['processedCount']),
      importedCount: serializer.fromJson<int>(json['importedCount']),
      skippedCount: serializer.fromJson<int>(json['skippedCount']),
      failedCount: serializer.fromJson<int>(json['failedCount']),
      errorSummary: serializer.fromJson<String?>(json['errorSummary']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'status': serializer.toJson<String>(status),
      'permissionMode': serializer.toJson<String>(permissionMode),
      'resumeCursor': serializer.toJson<String?>(resumeCursor),
      'discoveredCount': serializer.toJson<int>(discoveredCount),
      'processedCount': serializer.toJson<int>(processedCount),
      'importedCount': serializer.toJson<int>(importedCount),
      'skippedCount': serializer.toJson<int>(skippedCount),
      'failedCount': serializer.toJson<int>(failedCount),
      'errorSummary': serializer.toJson<String?>(errorSummary),
    };
  }

  ScanHistoryRow copyWith({
    String? id,
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    String? status,
    String? permissionMode,
    Value<String?> resumeCursor = const Value.absent(),
    int? discoveredCount,
    int? processedCount,
    int? importedCount,
    int? skippedCount,
    int? failedCount,
    Value<String?> errorSummary = const Value.absent(),
  }) => ScanHistoryRow(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    status: status ?? this.status,
    permissionMode: permissionMode ?? this.permissionMode,
    resumeCursor: resumeCursor.present ? resumeCursor.value : this.resumeCursor,
    discoveredCount: discoveredCount ?? this.discoveredCount,
    processedCount: processedCount ?? this.processedCount,
    importedCount: importedCount ?? this.importedCount,
    skippedCount: skippedCount ?? this.skippedCount,
    failedCount: failedCount ?? this.failedCount,
    errorSummary: errorSummary.present ? errorSummary.value : this.errorSummary,
  );
  ScanHistoryRow copyWithCompanion(ScanHistoryCompanion data) {
    return ScanHistoryRow(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      status: data.status.present ? data.status.value : this.status,
      permissionMode: data.permissionMode.present
          ? data.permissionMode.value
          : this.permissionMode,
      resumeCursor: data.resumeCursor.present
          ? data.resumeCursor.value
          : this.resumeCursor,
      discoveredCount: data.discoveredCount.present
          ? data.discoveredCount.value
          : this.discoveredCount,
      processedCount: data.processedCount.present
          ? data.processedCount.value
          : this.processedCount,
      importedCount: data.importedCount.present
          ? data.importedCount.value
          : this.importedCount,
      skippedCount: data.skippedCount.present
          ? data.skippedCount.value
          : this.skippedCount,
      failedCount: data.failedCount.present
          ? data.failedCount.value
          : this.failedCount,
      errorSummary: data.errorSummary.present
          ? data.errorSummary.value
          : this.errorSummary,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanHistoryRow(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status, ')
          ..write('permissionMode: $permissionMode, ')
          ..write('resumeCursor: $resumeCursor, ')
          ..write('discoveredCount: $discoveredCount, ')
          ..write('processedCount: $processedCount, ')
          ..write('importedCount: $importedCount, ')
          ..write('skippedCount: $skippedCount, ')
          ..write('failedCount: $failedCount, ')
          ..write('errorSummary: $errorSummary')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startedAt,
    completedAt,
    status,
    permissionMode,
    resumeCursor,
    discoveredCount,
    processedCount,
    importedCount,
    skippedCount,
    failedCount,
    errorSummary,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanHistoryRow &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.status == this.status &&
          other.permissionMode == this.permissionMode &&
          other.resumeCursor == this.resumeCursor &&
          other.discoveredCount == this.discoveredCount &&
          other.processedCount == this.processedCount &&
          other.importedCount == this.importedCount &&
          other.skippedCount == this.skippedCount &&
          other.failedCount == this.failedCount &&
          other.errorSummary == this.errorSummary);
}

class ScanHistoryCompanion extends UpdateCompanion<ScanHistoryRow> {
  final Value<String> id;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<String> status;
  final Value<String> permissionMode;
  final Value<String?> resumeCursor;
  final Value<int> discoveredCount;
  final Value<int> processedCount;
  final Value<int> importedCount;
  final Value<int> skippedCount;
  final Value<int> failedCount;
  final Value<String?> errorSummary;
  final Value<int> rowid;
  const ScanHistoryCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.permissionMode = const Value.absent(),
    this.resumeCursor = const Value.absent(),
    this.discoveredCount = const Value.absent(),
    this.processedCount = const Value.absent(),
    this.importedCount = const Value.absent(),
    this.skippedCount = const Value.absent(),
    this.failedCount = const Value.absent(),
    this.errorSummary = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScanHistoryCompanion.insert({
    required String id,
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    required String status,
    required String permissionMode,
    this.resumeCursor = const Value.absent(),
    this.discoveredCount = const Value.absent(),
    this.processedCount = const Value.absent(),
    this.importedCount = const Value.absent(),
    this.skippedCount = const Value.absent(),
    this.failedCount = const Value.absent(),
    this.errorSummary = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       startedAt = Value(startedAt),
       status = Value(status),
       permissionMode = Value(permissionMode);
  static Insertable<ScanHistoryRow> custom({
    Expression<String>? id,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? status,
    Expression<String>? permissionMode,
    Expression<String>? resumeCursor,
    Expression<int>? discoveredCount,
    Expression<int>? processedCount,
    Expression<int>? importedCount,
    Expression<int>? skippedCount,
    Expression<int>? failedCount,
    Expression<String>? errorSummary,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (status != null) 'status': status,
      if (permissionMode != null) 'permission_mode': permissionMode,
      if (resumeCursor != null) 'resume_cursor': resumeCursor,
      if (discoveredCount != null) 'discovered_count': discoveredCount,
      if (processedCount != null) 'processed_count': processedCount,
      if (importedCount != null) 'imported_count': importedCount,
      if (skippedCount != null) 'skipped_count': skippedCount,
      if (failedCount != null) 'failed_count': failedCount,
      if (errorSummary != null) 'error_summary': errorSummary,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScanHistoryCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<String>? status,
    Value<String>? permissionMode,
    Value<String?>? resumeCursor,
    Value<int>? discoveredCount,
    Value<int>? processedCount,
    Value<int>? importedCount,
    Value<int>? skippedCount,
    Value<int>? failedCount,
    Value<String?>? errorSummary,
    Value<int>? rowid,
  }) {
    return ScanHistoryCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      permissionMode: permissionMode ?? this.permissionMode,
      resumeCursor: resumeCursor ?? this.resumeCursor,
      discoveredCount: discoveredCount ?? this.discoveredCount,
      processedCount: processedCount ?? this.processedCount,
      importedCount: importedCount ?? this.importedCount,
      skippedCount: skippedCount ?? this.skippedCount,
      failedCount: failedCount ?? this.failedCount,
      errorSummary: errorSummary ?? this.errorSummary,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (permissionMode.present) {
      map['permission_mode'] = Variable<String>(permissionMode.value);
    }
    if (resumeCursor.present) {
      map['resume_cursor'] = Variable<String>(resumeCursor.value);
    }
    if (discoveredCount.present) {
      map['discovered_count'] = Variable<int>(discoveredCount.value);
    }
    if (processedCount.present) {
      map['processed_count'] = Variable<int>(processedCount.value);
    }
    if (importedCount.present) {
      map['imported_count'] = Variable<int>(importedCount.value);
    }
    if (skippedCount.present) {
      map['skipped_count'] = Variable<int>(skippedCount.value);
    }
    if (failedCount.present) {
      map['failed_count'] = Variable<int>(failedCount.value);
    }
    if (errorSummary.present) {
      map['error_summary'] = Variable<String>(errorSummary.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanHistoryCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status, ')
          ..write('permissionMode: $permissionMode, ')
          ..write('resumeCursor: $resumeCursor, ')
          ..write('discoveredCount: $discoveredCount, ')
          ..write('processedCount: $processedCount, ')
          ..write('importedCount: $importedCount, ')
          ..write('skippedCount: $skippedCount, ')
          ..write('failedCount: $failedCount, ')
          ..write('errorSummary: $errorSummary, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MediaItemsTable extends MediaItems
    with TableInfo<$MediaItemsTable, MediaItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetIdMeta = const VerificationMeta(
    'assetId',
  );
  @override
  late final GeneratedColumn<String> assetId = GeneratedColumn<String>(
    'asset_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _assetUriMeta = const VerificationMeta(
    'assetUri',
  );
  @override
  late final GeneratedColumn<String> assetUri = GeneratedColumn<String>(
    'asset_uri',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mediaTypeMeta = const VerificationMeta(
    'mediaType',
  );
  @override
  late final GeneratedColumn<String> mediaType = GeneratedColumn<String>(
    'media_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _captureAtMeta = const VerificationMeta(
    'captureAt',
  );
  @override
  late final GeneratedColumn<DateTime> captureAt = GeneratedColumn<DateTime>(
    'capture_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modifiedAtMeta = const VerificationMeta(
    'modifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
    'modified_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
    'width',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileSizeBytesMeta = const VerificationMeta(
    'fileSizeBytes',
  );
  @override
  late final GeneratedColumn<int> fileSizeBytes = GeneratedColumn<int>(
    'file_size_bytes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ocrTextMeta = const VerificationMeta(
    'ocrText',
  );
  @override
  late final GeneratedColumn<String> ocrText = GeneratedColumn<String>(
    'ocr_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _normalizedOcrTextMeta = const VerificationMeta(
    'normalizedOcrText',
  );
  @override
  late final GeneratedColumn<String> normalizedOcrText =
      GeneratedColumn<String>(
        'normalized_ocr_text',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _duplicateFingerprintMeta =
      const VerificationMeta('duplicateFingerprint');
  @override
  late final GeneratedColumn<String> duplicateFingerprint =
      GeneratedColumn<String>(
        'duplicate_fingerprint',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _visualEmbeddingMeta = const VerificationMeta(
    'visualEmbedding',
  );
  @override
  late final GeneratedColumn<Uint8List> visualEmbedding =
      GeneratedColumn<Uint8List>(
        'visual_embedding',
        aliasedName,
        true,
        type: DriftSqlType.blob,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _thumbnailKeyMeta = const VerificationMeta(
    'thumbnailKey',
  );
  @override
  late final GeneratedColumn<String> thumbnailKey = GeneratedColumn<String>(
    'thumbnail_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastViewedAtMeta = const VerificationMeta(
    'lastViewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastViewedAt = GeneratedColumn<DateTime>(
    'last_viewed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _viewCountMeta = const VerificationMeta(
    'viewCount',
  );
  @override
  late final GeneratedColumn<int> viewCount = GeneratedColumn<int>(
    'view_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isAvailableMeta = const VerificationMeta(
    'isAvailable',
  );
  @override
  late final GeneratedColumn<bool> isAvailable = GeneratedColumn<bool>(
    'is_available',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_available" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isDemoMeta = const VerificationMeta('isDemo');
  @override
  late final GeneratedColumn<bool> isDemo = GeneratedColumn<bool>(
    'is_demo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_demo" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _importedAtMeta = const VerificationMeta(
    'importedAt',
  );
  @override
  late final GeneratedColumn<DateTime> importedAt = GeneratedColumn<DateTime>(
    'imported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _scanIdMeta = const VerificationMeta('scanId');
  @override
  late final GeneratedColumn<String> scanId = GeneratedColumn<String>(
    'scan_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES scan_history (id) ON DELETE SET NULL',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    assetId,
    assetUri,
    mediaType,
    mimeType,
    captureAt,
    modifiedAt,
    latitude,
    longitude,
    width,
    height,
    durationMs,
    fileSizeBytes,
    ocrText,
    normalizedOcrText,
    duplicateFingerprint,
    visualEmbedding,
    thumbnailKey,
    lastViewedAt,
    viewCount,
    isAvailable,
    isDemo,
    importedAt,
    scanId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<MediaItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('asset_id')) {
      context.handle(
        _assetIdMeta,
        assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('asset_uri')) {
      context.handle(
        _assetUriMeta,
        assetUri.isAcceptableOrUnknown(data['asset_uri']!, _assetUriMeta),
      );
    }
    if (data.containsKey('media_type')) {
      context.handle(
        _mediaTypeMeta,
        mediaType.isAcceptableOrUnknown(data['media_type']!, _mediaTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mediaTypeMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    }
    if (data.containsKey('capture_at')) {
      context.handle(
        _captureAtMeta,
        captureAt.isAcceptableOrUnknown(data['capture_at']!, _captureAtMeta),
      );
    } else if (isInserting) {
      context.missing(_captureAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
        _modifiedAtMeta,
        modifiedAt.isAcceptableOrUnknown(data['modified_at']!, _modifiedAtMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    }
    if (data.containsKey('file_size_bytes')) {
      context.handle(
        _fileSizeBytesMeta,
        fileSizeBytes.isAcceptableOrUnknown(
          data['file_size_bytes']!,
          _fileSizeBytesMeta,
        ),
      );
    }
    if (data.containsKey('ocr_text')) {
      context.handle(
        _ocrTextMeta,
        ocrText.isAcceptableOrUnknown(data['ocr_text']!, _ocrTextMeta),
      );
    }
    if (data.containsKey('normalized_ocr_text')) {
      context.handle(
        _normalizedOcrTextMeta,
        normalizedOcrText.isAcceptableOrUnknown(
          data['normalized_ocr_text']!,
          _normalizedOcrTextMeta,
        ),
      );
    }
    if (data.containsKey('duplicate_fingerprint')) {
      context.handle(
        _duplicateFingerprintMeta,
        duplicateFingerprint.isAcceptableOrUnknown(
          data['duplicate_fingerprint']!,
          _duplicateFingerprintMeta,
        ),
      );
    }
    if (data.containsKey('visual_embedding')) {
      context.handle(
        _visualEmbeddingMeta,
        visualEmbedding.isAcceptableOrUnknown(
          data['visual_embedding']!,
          _visualEmbeddingMeta,
        ),
      );
    }
    if (data.containsKey('thumbnail_key')) {
      context.handle(
        _thumbnailKeyMeta,
        thumbnailKey.isAcceptableOrUnknown(
          data['thumbnail_key']!,
          _thumbnailKeyMeta,
        ),
      );
    }
    if (data.containsKey('last_viewed_at')) {
      context.handle(
        _lastViewedAtMeta,
        lastViewedAt.isAcceptableOrUnknown(
          data['last_viewed_at']!,
          _lastViewedAtMeta,
        ),
      );
    }
    if (data.containsKey('view_count')) {
      context.handle(
        _viewCountMeta,
        viewCount.isAcceptableOrUnknown(data['view_count']!, _viewCountMeta),
      );
    }
    if (data.containsKey('is_available')) {
      context.handle(
        _isAvailableMeta,
        isAvailable.isAcceptableOrUnknown(
          data['is_available']!,
          _isAvailableMeta,
        ),
      );
    }
    if (data.containsKey('is_demo')) {
      context.handle(
        _isDemoMeta,
        isDemo.isAcceptableOrUnknown(data['is_demo']!, _isDemoMeta),
      );
    }
    if (data.containsKey('imported_at')) {
      context.handle(
        _importedAtMeta,
        importedAt.isAcceptableOrUnknown(data['imported_at']!, _importedAtMeta),
      );
    }
    if (data.containsKey('scan_id')) {
      context.handle(
        _scanIdMeta,
        scanId.isAcceptableOrUnknown(data['scan_id']!, _scanIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaItemRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      assetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_id'],
      )!,
      assetUri: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_uri'],
      ),
      mediaType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_type'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      ),
      captureAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}capture_at'],
      )!,
      modifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}modified_at'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}width'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      ),
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      ),
      fileSizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size_bytes'],
      ),
      ocrText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ocr_text'],
      ),
      normalizedOcrText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_ocr_text'],
      ),
      duplicateFingerprint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}duplicate_fingerprint'],
      ),
      visualEmbedding: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}visual_embedding'],
      ),
      thumbnailKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_key'],
      ),
      lastViewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_viewed_at'],
      ),
      viewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}view_count'],
      )!,
      isAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_available'],
      )!,
      isDemo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_demo'],
      )!,
      importedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}imported_at'],
      )!,
      scanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scan_id'],
      ),
    );
  }

  @override
  $MediaItemsTable createAlias(String alias) {
    return $MediaItemsTable(attachedDatabase, alias);
  }
}

class MediaItemRow extends DataClass implements Insertable<MediaItemRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String assetId;
  final String? assetUri;
  final String mediaType;
  final String? mimeType;
  final DateTime captureAt;
  final DateTime? modifiedAt;
  final double? latitude;
  final double? longitude;
  final int? width;
  final int? height;
  final int? durationMs;
  final int? fileSizeBytes;
  final String? ocrText;
  final String? normalizedOcrText;
  final String? duplicateFingerprint;
  final Uint8List? visualEmbedding;
  final String? thumbnailKey;
  final DateTime? lastViewedAt;
  final int viewCount;
  final bool isAvailable;
  final bool isDemo;
  final DateTime importedAt;
  final String? scanId;
  const MediaItemRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.assetId,
    this.assetUri,
    required this.mediaType,
    this.mimeType,
    required this.captureAt,
    this.modifiedAt,
    this.latitude,
    this.longitude,
    this.width,
    this.height,
    this.durationMs,
    this.fileSizeBytes,
    this.ocrText,
    this.normalizedOcrText,
    this.duplicateFingerprint,
    this.visualEmbedding,
    this.thumbnailKey,
    this.lastViewedAt,
    required this.viewCount,
    required this.isAvailable,
    required this.isDemo,
    required this.importedAt,
    this.scanId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['asset_id'] = Variable<String>(assetId);
    if (!nullToAbsent || assetUri != null) {
      map['asset_uri'] = Variable<String>(assetUri);
    }
    map['media_type'] = Variable<String>(mediaType);
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    map['capture_at'] = Variable<DateTime>(captureAt);
    if (!nullToAbsent || modifiedAt != null) {
      map['modified_at'] = Variable<DateTime>(modifiedAt);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || width != null) {
      map['width'] = Variable<int>(width);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<int>(durationMs);
    }
    if (!nullToAbsent || fileSizeBytes != null) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes);
    }
    if (!nullToAbsent || ocrText != null) {
      map['ocr_text'] = Variable<String>(ocrText);
    }
    if (!nullToAbsent || normalizedOcrText != null) {
      map['normalized_ocr_text'] = Variable<String>(normalizedOcrText);
    }
    if (!nullToAbsent || duplicateFingerprint != null) {
      map['duplicate_fingerprint'] = Variable<String>(duplicateFingerprint);
    }
    if (!nullToAbsent || visualEmbedding != null) {
      map['visual_embedding'] = Variable<Uint8List>(visualEmbedding);
    }
    if (!nullToAbsent || thumbnailKey != null) {
      map['thumbnail_key'] = Variable<String>(thumbnailKey);
    }
    if (!nullToAbsent || lastViewedAt != null) {
      map['last_viewed_at'] = Variable<DateTime>(lastViewedAt);
    }
    map['view_count'] = Variable<int>(viewCount);
    map['is_available'] = Variable<bool>(isAvailable);
    map['is_demo'] = Variable<bool>(isDemo);
    map['imported_at'] = Variable<DateTime>(importedAt);
    if (!nullToAbsent || scanId != null) {
      map['scan_id'] = Variable<String>(scanId);
    }
    return map;
  }

  MediaItemsCompanion toCompanion(bool nullToAbsent) {
    return MediaItemsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      assetId: Value(assetId),
      assetUri: assetUri == null && nullToAbsent
          ? const Value.absent()
          : Value(assetUri),
      mediaType: Value(mediaType),
      mimeType: mimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(mimeType),
      captureAt: Value(captureAt),
      modifiedAt: modifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(modifiedAt),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      width: width == null && nullToAbsent
          ? const Value.absent()
          : Value(width),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
      fileSizeBytes: fileSizeBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(fileSizeBytes),
      ocrText: ocrText == null && nullToAbsent
          ? const Value.absent()
          : Value(ocrText),
      normalizedOcrText: normalizedOcrText == null && nullToAbsent
          ? const Value.absent()
          : Value(normalizedOcrText),
      duplicateFingerprint: duplicateFingerprint == null && nullToAbsent
          ? const Value.absent()
          : Value(duplicateFingerprint),
      visualEmbedding: visualEmbedding == null && nullToAbsent
          ? const Value.absent()
          : Value(visualEmbedding),
      thumbnailKey: thumbnailKey == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailKey),
      lastViewedAt: lastViewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastViewedAt),
      viewCount: Value(viewCount),
      isAvailable: Value(isAvailable),
      isDemo: Value(isDemo),
      importedAt: Value(importedAt),
      scanId: scanId == null && nullToAbsent
          ? const Value.absent()
          : Value(scanId),
    );
  }

  factory MediaItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaItemRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      assetId: serializer.fromJson<String>(json['assetId']),
      assetUri: serializer.fromJson<String?>(json['assetUri']),
      mediaType: serializer.fromJson<String>(json['mediaType']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      captureAt: serializer.fromJson<DateTime>(json['captureAt']),
      modifiedAt: serializer.fromJson<DateTime?>(json['modifiedAt']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      width: serializer.fromJson<int?>(json['width']),
      height: serializer.fromJson<int?>(json['height']),
      durationMs: serializer.fromJson<int?>(json['durationMs']),
      fileSizeBytes: serializer.fromJson<int?>(json['fileSizeBytes']),
      ocrText: serializer.fromJson<String?>(json['ocrText']),
      normalizedOcrText: serializer.fromJson<String?>(
        json['normalizedOcrText'],
      ),
      duplicateFingerprint: serializer.fromJson<String?>(
        json['duplicateFingerprint'],
      ),
      visualEmbedding: serializer.fromJson<Uint8List?>(json['visualEmbedding']),
      thumbnailKey: serializer.fromJson<String?>(json['thumbnailKey']),
      lastViewedAt: serializer.fromJson<DateTime?>(json['lastViewedAt']),
      viewCount: serializer.fromJson<int>(json['viewCount']),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
      isDemo: serializer.fromJson<bool>(json['isDemo']),
      importedAt: serializer.fromJson<DateTime>(json['importedAt']),
      scanId: serializer.fromJson<String?>(json['scanId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'assetId': serializer.toJson<String>(assetId),
      'assetUri': serializer.toJson<String?>(assetUri),
      'mediaType': serializer.toJson<String>(mediaType),
      'mimeType': serializer.toJson<String?>(mimeType),
      'captureAt': serializer.toJson<DateTime>(captureAt),
      'modifiedAt': serializer.toJson<DateTime?>(modifiedAt),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'width': serializer.toJson<int?>(width),
      'height': serializer.toJson<int?>(height),
      'durationMs': serializer.toJson<int?>(durationMs),
      'fileSizeBytes': serializer.toJson<int?>(fileSizeBytes),
      'ocrText': serializer.toJson<String?>(ocrText),
      'normalizedOcrText': serializer.toJson<String?>(normalizedOcrText),
      'duplicateFingerprint': serializer.toJson<String?>(duplicateFingerprint),
      'visualEmbedding': serializer.toJson<Uint8List?>(visualEmbedding),
      'thumbnailKey': serializer.toJson<String?>(thumbnailKey),
      'lastViewedAt': serializer.toJson<DateTime?>(lastViewedAt),
      'viewCount': serializer.toJson<int>(viewCount),
      'isAvailable': serializer.toJson<bool>(isAvailable),
      'isDemo': serializer.toJson<bool>(isDemo),
      'importedAt': serializer.toJson<DateTime>(importedAt),
      'scanId': serializer.toJson<String?>(scanId),
    };
  }

  MediaItemRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? assetId,
    Value<String?> assetUri = const Value.absent(),
    String? mediaType,
    Value<String?> mimeType = const Value.absent(),
    DateTime? captureAt,
    Value<DateTime?> modifiedAt = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<int?> width = const Value.absent(),
    Value<int?> height = const Value.absent(),
    Value<int?> durationMs = const Value.absent(),
    Value<int?> fileSizeBytes = const Value.absent(),
    Value<String?> ocrText = const Value.absent(),
    Value<String?> normalizedOcrText = const Value.absent(),
    Value<String?> duplicateFingerprint = const Value.absent(),
    Value<Uint8List?> visualEmbedding = const Value.absent(),
    Value<String?> thumbnailKey = const Value.absent(),
    Value<DateTime?> lastViewedAt = const Value.absent(),
    int? viewCount,
    bool? isAvailable,
    bool? isDemo,
    DateTime? importedAt,
    Value<String?> scanId = const Value.absent(),
  }) => MediaItemRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    assetId: assetId ?? this.assetId,
    assetUri: assetUri.present ? assetUri.value : this.assetUri,
    mediaType: mediaType ?? this.mediaType,
    mimeType: mimeType.present ? mimeType.value : this.mimeType,
    captureAt: captureAt ?? this.captureAt,
    modifiedAt: modifiedAt.present ? modifiedAt.value : this.modifiedAt,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    width: width.present ? width.value : this.width,
    height: height.present ? height.value : this.height,
    durationMs: durationMs.present ? durationMs.value : this.durationMs,
    fileSizeBytes: fileSizeBytes.present
        ? fileSizeBytes.value
        : this.fileSizeBytes,
    ocrText: ocrText.present ? ocrText.value : this.ocrText,
    normalizedOcrText: normalizedOcrText.present
        ? normalizedOcrText.value
        : this.normalizedOcrText,
    duplicateFingerprint: duplicateFingerprint.present
        ? duplicateFingerprint.value
        : this.duplicateFingerprint,
    visualEmbedding: visualEmbedding.present
        ? visualEmbedding.value
        : this.visualEmbedding,
    thumbnailKey: thumbnailKey.present ? thumbnailKey.value : this.thumbnailKey,
    lastViewedAt: lastViewedAt.present ? lastViewedAt.value : this.lastViewedAt,
    viewCount: viewCount ?? this.viewCount,
    isAvailable: isAvailable ?? this.isAvailable,
    isDemo: isDemo ?? this.isDemo,
    importedAt: importedAt ?? this.importedAt,
    scanId: scanId.present ? scanId.value : this.scanId,
  );
  MediaItemRow copyWithCompanion(MediaItemsCompanion data) {
    return MediaItemRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      assetUri: data.assetUri.present ? data.assetUri.value : this.assetUri,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      captureAt: data.captureAt.present ? data.captureAt.value : this.captureAt,
      modifiedAt: data.modifiedAt.present
          ? data.modifiedAt.value
          : this.modifiedAt,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      fileSizeBytes: data.fileSizeBytes.present
          ? data.fileSizeBytes.value
          : this.fileSizeBytes,
      ocrText: data.ocrText.present ? data.ocrText.value : this.ocrText,
      normalizedOcrText: data.normalizedOcrText.present
          ? data.normalizedOcrText.value
          : this.normalizedOcrText,
      duplicateFingerprint: data.duplicateFingerprint.present
          ? data.duplicateFingerprint.value
          : this.duplicateFingerprint,
      visualEmbedding: data.visualEmbedding.present
          ? data.visualEmbedding.value
          : this.visualEmbedding,
      thumbnailKey: data.thumbnailKey.present
          ? data.thumbnailKey.value
          : this.thumbnailKey,
      lastViewedAt: data.lastViewedAt.present
          ? data.lastViewedAt.value
          : this.lastViewedAt,
      viewCount: data.viewCount.present ? data.viewCount.value : this.viewCount,
      isAvailable: data.isAvailable.present
          ? data.isAvailable.value
          : this.isAvailable,
      isDemo: data.isDemo.present ? data.isDemo.value : this.isDemo,
      importedAt: data.importedAt.present
          ? data.importedAt.value
          : this.importedAt,
      scanId: data.scanId.present ? data.scanId.value : this.scanId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaItemRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('assetUri: $assetUri, ')
          ..write('mediaType: $mediaType, ')
          ..write('mimeType: $mimeType, ')
          ..write('captureAt: $captureAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('durationMs: $durationMs, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('ocrText: $ocrText, ')
          ..write('normalizedOcrText: $normalizedOcrText, ')
          ..write('duplicateFingerprint: $duplicateFingerprint, ')
          ..write('visualEmbedding: $visualEmbedding, ')
          ..write('thumbnailKey: $thumbnailKey, ')
          ..write('lastViewedAt: $lastViewedAt, ')
          ..write('viewCount: $viewCount, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('isDemo: $isDemo, ')
          ..write('importedAt: $importedAt, ')
          ..write('scanId: $scanId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    createdAt,
    updatedAt,
    id,
    assetId,
    assetUri,
    mediaType,
    mimeType,
    captureAt,
    modifiedAt,
    latitude,
    longitude,
    width,
    height,
    durationMs,
    fileSizeBytes,
    ocrText,
    normalizedOcrText,
    duplicateFingerprint,
    $driftBlobEquality.hash(visualEmbedding),
    thumbnailKey,
    lastViewedAt,
    viewCount,
    isAvailable,
    isDemo,
    importedAt,
    scanId,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaItemRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.assetId == this.assetId &&
          other.assetUri == this.assetUri &&
          other.mediaType == this.mediaType &&
          other.mimeType == this.mimeType &&
          other.captureAt == this.captureAt &&
          other.modifiedAt == this.modifiedAt &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.width == this.width &&
          other.height == this.height &&
          other.durationMs == this.durationMs &&
          other.fileSizeBytes == this.fileSizeBytes &&
          other.ocrText == this.ocrText &&
          other.normalizedOcrText == this.normalizedOcrText &&
          other.duplicateFingerprint == this.duplicateFingerprint &&
          $driftBlobEquality.equals(
            other.visualEmbedding,
            this.visualEmbedding,
          ) &&
          other.thumbnailKey == this.thumbnailKey &&
          other.lastViewedAt == this.lastViewedAt &&
          other.viewCount == this.viewCount &&
          other.isAvailable == this.isAvailable &&
          other.isDemo == this.isDemo &&
          other.importedAt == this.importedAt &&
          other.scanId == this.scanId);
}

class MediaItemsCompanion extends UpdateCompanion<MediaItemRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> assetId;
  final Value<String?> assetUri;
  final Value<String> mediaType;
  final Value<String?> mimeType;
  final Value<DateTime> captureAt;
  final Value<DateTime?> modifiedAt;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<int?> width;
  final Value<int?> height;
  final Value<int?> durationMs;
  final Value<int?> fileSizeBytes;
  final Value<String?> ocrText;
  final Value<String?> normalizedOcrText;
  final Value<String?> duplicateFingerprint;
  final Value<Uint8List?> visualEmbedding;
  final Value<String?> thumbnailKey;
  final Value<DateTime?> lastViewedAt;
  final Value<int> viewCount;
  final Value<bool> isAvailable;
  final Value<bool> isDemo;
  final Value<DateTime> importedAt;
  final Value<String?> scanId;
  final Value<int> rowid;
  const MediaItemsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.assetId = const Value.absent(),
    this.assetUri = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.captureAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.ocrText = const Value.absent(),
    this.normalizedOcrText = const Value.absent(),
    this.duplicateFingerprint = const Value.absent(),
    this.visualEmbedding = const Value.absent(),
    this.thumbnailKey = const Value.absent(),
    this.lastViewedAt = const Value.absent(),
    this.viewCount = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.isDemo = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.scanId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MediaItemsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String assetId,
    this.assetUri = const Value.absent(),
    required String mediaType,
    this.mimeType = const Value.absent(),
    required DateTime captureAt,
    this.modifiedAt = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.ocrText = const Value.absent(),
    this.normalizedOcrText = const Value.absent(),
    this.duplicateFingerprint = const Value.absent(),
    this.visualEmbedding = const Value.absent(),
    this.thumbnailKey = const Value.absent(),
    this.lastViewedAt = const Value.absent(),
    this.viewCount = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.isDemo = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.scanId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       assetId = Value(assetId),
       mediaType = Value(mediaType),
       captureAt = Value(captureAt);
  static Insertable<MediaItemRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? assetId,
    Expression<String>? assetUri,
    Expression<String>? mediaType,
    Expression<String>? mimeType,
    Expression<DateTime>? captureAt,
    Expression<DateTime>? modifiedAt,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<int>? width,
    Expression<int>? height,
    Expression<int>? durationMs,
    Expression<int>? fileSizeBytes,
    Expression<String>? ocrText,
    Expression<String>? normalizedOcrText,
    Expression<String>? duplicateFingerprint,
    Expression<Uint8List>? visualEmbedding,
    Expression<String>? thumbnailKey,
    Expression<DateTime>? lastViewedAt,
    Expression<int>? viewCount,
    Expression<bool>? isAvailable,
    Expression<bool>? isDemo,
    Expression<DateTime>? importedAt,
    Expression<String>? scanId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (assetId != null) 'asset_id': assetId,
      if (assetUri != null) 'asset_uri': assetUri,
      if (mediaType != null) 'media_type': mediaType,
      if (mimeType != null) 'mime_type': mimeType,
      if (captureAt != null) 'capture_at': captureAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (durationMs != null) 'duration_ms': durationMs,
      if (fileSizeBytes != null) 'file_size_bytes': fileSizeBytes,
      if (ocrText != null) 'ocr_text': ocrText,
      if (normalizedOcrText != null) 'normalized_ocr_text': normalizedOcrText,
      if (duplicateFingerprint != null)
        'duplicate_fingerprint': duplicateFingerprint,
      if (visualEmbedding != null) 'visual_embedding': visualEmbedding,
      if (thumbnailKey != null) 'thumbnail_key': thumbnailKey,
      if (lastViewedAt != null) 'last_viewed_at': lastViewedAt,
      if (viewCount != null) 'view_count': viewCount,
      if (isAvailable != null) 'is_available': isAvailable,
      if (isDemo != null) 'is_demo': isDemo,
      if (importedAt != null) 'imported_at': importedAt,
      if (scanId != null) 'scan_id': scanId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MediaItemsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? assetId,
    Value<String?>? assetUri,
    Value<String>? mediaType,
    Value<String?>? mimeType,
    Value<DateTime>? captureAt,
    Value<DateTime?>? modifiedAt,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<int?>? width,
    Value<int?>? height,
    Value<int?>? durationMs,
    Value<int?>? fileSizeBytes,
    Value<String?>? ocrText,
    Value<String?>? normalizedOcrText,
    Value<String?>? duplicateFingerprint,
    Value<Uint8List?>? visualEmbedding,
    Value<String?>? thumbnailKey,
    Value<DateTime?>? lastViewedAt,
    Value<int>? viewCount,
    Value<bool>? isAvailable,
    Value<bool>? isDemo,
    Value<DateTime>? importedAt,
    Value<String?>? scanId,
    Value<int>? rowid,
  }) {
    return MediaItemsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      assetUri: assetUri ?? this.assetUri,
      mediaType: mediaType ?? this.mediaType,
      mimeType: mimeType ?? this.mimeType,
      captureAt: captureAt ?? this.captureAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      width: width ?? this.width,
      height: height ?? this.height,
      durationMs: durationMs ?? this.durationMs,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      ocrText: ocrText ?? this.ocrText,
      normalizedOcrText: normalizedOcrText ?? this.normalizedOcrText,
      duplicateFingerprint: duplicateFingerprint ?? this.duplicateFingerprint,
      visualEmbedding: visualEmbedding ?? this.visualEmbedding,
      thumbnailKey: thumbnailKey ?? this.thumbnailKey,
      lastViewedAt: lastViewedAt ?? this.lastViewedAt,
      viewCount: viewCount ?? this.viewCount,
      isAvailable: isAvailable ?? this.isAvailable,
      isDemo: isDemo ?? this.isDemo,
      importedAt: importedAt ?? this.importedAt,
      scanId: scanId ?? this.scanId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<String>(assetId.value);
    }
    if (assetUri.present) {
      map['asset_uri'] = Variable<String>(assetUri.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(mediaType.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (captureAt.present) {
      map['capture_at'] = Variable<DateTime>(captureAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (fileSizeBytes.present) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes.value);
    }
    if (ocrText.present) {
      map['ocr_text'] = Variable<String>(ocrText.value);
    }
    if (normalizedOcrText.present) {
      map['normalized_ocr_text'] = Variable<String>(normalizedOcrText.value);
    }
    if (duplicateFingerprint.present) {
      map['duplicate_fingerprint'] = Variable<String>(
        duplicateFingerprint.value,
      );
    }
    if (visualEmbedding.present) {
      map['visual_embedding'] = Variable<Uint8List>(visualEmbedding.value);
    }
    if (thumbnailKey.present) {
      map['thumbnail_key'] = Variable<String>(thumbnailKey.value);
    }
    if (lastViewedAt.present) {
      map['last_viewed_at'] = Variable<DateTime>(lastViewedAt.value);
    }
    if (viewCount.present) {
      map['view_count'] = Variable<int>(viewCount.value);
    }
    if (isAvailable.present) {
      map['is_available'] = Variable<bool>(isAvailable.value);
    }
    if (isDemo.present) {
      map['is_demo'] = Variable<bool>(isDemo.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<DateTime>(importedAt.value);
    }
    if (scanId.present) {
      map['scan_id'] = Variable<String>(scanId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaItemsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('assetUri: $assetUri, ')
          ..write('mediaType: $mediaType, ')
          ..write('mimeType: $mimeType, ')
          ..write('captureAt: $captureAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('durationMs: $durationMs, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('ocrText: $ocrText, ')
          ..write('normalizedOcrText: $normalizedOcrText, ')
          ..write('duplicateFingerprint: $duplicateFingerprint, ')
          ..write('visualEmbedding: $visualEmbedding, ')
          ..write('thumbnailKey: $thumbnailKey, ')
          ..write('lastViewedAt: $lastViewedAt, ')
          ..write('viewCount: $viewCount, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('isDemo: $isDemo, ')
          ..write('importedAt: $importedAt, ')
          ..write('scanId: $scanId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlacesTable extends Places with TableInfo<$PlacesTable, PlaceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localityMeta = const VerificationMeta(
    'locality',
  );
  @override
  late final GeneratedColumn<String> locality = GeneratedColumn<String>(
    'locality',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _formattedAddressMeta = const VerificationMeta(
    'formattedAddress',
  );
  @override
  late final GeneratedColumn<String> formattedAddress = GeneratedColumn<String>(
    'formatted_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isConfirmedMeta = const VerificationMeta(
    'isConfirmed',
  );
  @override
  late final GeneratedColumn<bool> isConfirmed = GeneratedColumn<bool>(
    'is_confirmed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_confirmed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDemoMeta = const VerificationMeta('isDemo');
  @override
  late final GeneratedColumn<bool> isDemo = GeneratedColumn<bool>(
    'is_demo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_demo" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    name,
    latitude,
    longitude,
    locality,
    city,
    region,
    country,
    formattedAddress,
    isConfirmed,
    isDemo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'places';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('locality')) {
      context.handle(
        _localityMeta,
        locality.isAcceptableOrUnknown(data['locality']!, _localityMeta),
      );
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('formatted_address')) {
      context.handle(
        _formattedAddressMeta,
        formattedAddress.isAcceptableOrUnknown(
          data['formatted_address']!,
          _formattedAddressMeta,
        ),
      );
    }
    if (data.containsKey('is_confirmed')) {
      context.handle(
        _isConfirmedMeta,
        isConfirmed.isAcceptableOrUnknown(
          data['is_confirmed']!,
          _isConfirmedMeta,
        ),
      );
    }
    if (data.containsKey('is_demo')) {
      context.handle(
        _isDemoMeta,
        isDemo.isAcceptableOrUnknown(data['is_demo']!, _isDemoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaceRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      locality: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locality'],
      ),
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      ),
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
      formattedAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}formatted_address'],
      ),
      isConfirmed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_confirmed'],
      )!,
      isDemo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_demo'],
      )!,
    );
  }

  @override
  $PlacesTable createAlias(String alias) {
    return $PlacesTable(attachedDatabase, alias);
  }
}

class PlaceRow extends DataClass implements Insertable<PlaceRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String name;
  final double? latitude;
  final double? longitude;
  final String? locality;
  final String? city;
  final String? region;
  final String? country;
  final String? formattedAddress;
  final bool isConfirmed;
  final bool isDemo;
  const PlaceRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    this.latitude,
    this.longitude,
    this.locality,
    this.city,
    this.region,
    this.country,
    this.formattedAddress,
    required this.isConfirmed,
    required this.isDemo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || locality != null) {
      map['locality'] = Variable<String>(locality);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || formattedAddress != null) {
      map['formatted_address'] = Variable<String>(formattedAddress);
    }
    map['is_confirmed'] = Variable<bool>(isConfirmed);
    map['is_demo'] = Variable<bool>(isDemo);
    return map;
  }

  PlacesCompanion toCompanion(bool nullToAbsent) {
    return PlacesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      name: Value(name),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      locality: locality == null && nullToAbsent
          ? const Value.absent()
          : Value(locality),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      formattedAddress: formattedAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(formattedAddress),
      isConfirmed: Value(isConfirmed),
      isDemo: Value(isDemo),
    );
  }

  factory PlaceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaceRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      locality: serializer.fromJson<String?>(json['locality']),
      city: serializer.fromJson<String?>(json['city']),
      region: serializer.fromJson<String?>(json['region']),
      country: serializer.fromJson<String?>(json['country']),
      formattedAddress: serializer.fromJson<String?>(json['formattedAddress']),
      isConfirmed: serializer.fromJson<bool>(json['isConfirmed']),
      isDemo: serializer.fromJson<bool>(json['isDemo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'locality': serializer.toJson<String?>(locality),
      'city': serializer.toJson<String?>(city),
      'region': serializer.toJson<String?>(region),
      'country': serializer.toJson<String?>(country),
      'formattedAddress': serializer.toJson<String?>(formattedAddress),
      'isConfirmed': serializer.toJson<bool>(isConfirmed),
      'isDemo': serializer.toJson<bool>(isDemo),
    };
  }

  PlaceRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? name,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> locality = const Value.absent(),
    Value<String?> city = const Value.absent(),
    Value<String?> region = const Value.absent(),
    Value<String?> country = const Value.absent(),
    Value<String?> formattedAddress = const Value.absent(),
    bool? isConfirmed,
    bool? isDemo,
  }) => PlaceRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    locality: locality.present ? locality.value : this.locality,
    city: city.present ? city.value : this.city,
    region: region.present ? region.value : this.region,
    country: country.present ? country.value : this.country,
    formattedAddress: formattedAddress.present
        ? formattedAddress.value
        : this.formattedAddress,
    isConfirmed: isConfirmed ?? this.isConfirmed,
    isDemo: isDemo ?? this.isDemo,
  );
  PlaceRow copyWithCompanion(PlacesCompanion data) {
    return PlaceRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      locality: data.locality.present ? data.locality.value : this.locality,
      city: data.city.present ? data.city.value : this.city,
      region: data.region.present ? data.region.value : this.region,
      country: data.country.present ? data.country.value : this.country,
      formattedAddress: data.formattedAddress.present
          ? data.formattedAddress.value
          : this.formattedAddress,
      isConfirmed: data.isConfirmed.present
          ? data.isConfirmed.value
          : this.isConfirmed,
      isDemo: data.isDemo.present ? data.isDemo.value : this.isDemo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaceRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('locality: $locality, ')
          ..write('city: $city, ')
          ..write('region: $region, ')
          ..write('country: $country, ')
          ..write('formattedAddress: $formattedAddress, ')
          ..write('isConfirmed: $isConfirmed, ')
          ..write('isDemo: $isDemo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    name,
    latitude,
    longitude,
    locality,
    city,
    region,
    country,
    formattedAddress,
    isConfirmed,
    isDemo,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaceRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.locality == this.locality &&
          other.city == this.city &&
          other.region == this.region &&
          other.country == this.country &&
          other.formattedAddress == this.formattedAddress &&
          other.isConfirmed == this.isConfirmed &&
          other.isDemo == this.isDemo);
}

class PlacesCompanion extends UpdateCompanion<PlaceRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> locality;
  final Value<String?> city;
  final Value<String?> region;
  final Value<String?> country;
  final Value<String?> formattedAddress;
  final Value<bool> isConfirmed;
  final Value<bool> isDemo;
  final Value<int> rowid;
  const PlacesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.locality = const Value.absent(),
    this.city = const Value.absent(),
    this.region = const Value.absent(),
    this.country = const Value.absent(),
    this.formattedAddress = const Value.absent(),
    this.isConfirmed = const Value.absent(),
    this.isDemo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlacesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String name,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.locality = const Value.absent(),
    this.city = const Value.absent(),
    this.region = const Value.absent(),
    this.country = const Value.absent(),
    this.formattedAddress = const Value.absent(),
    this.isConfirmed = const Value.absent(),
    this.isDemo = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<PlaceRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? locality,
    Expression<String>? city,
    Expression<String>? region,
    Expression<String>? country,
    Expression<String>? formattedAddress,
    Expression<bool>? isConfirmed,
    Expression<bool>? isDemo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (locality != null) 'locality': locality,
      if (city != null) 'city': city,
      if (region != null) 'region': region,
      if (country != null) 'country': country,
      if (formattedAddress != null) 'formatted_address': formattedAddress,
      if (isConfirmed != null) 'is_confirmed': isConfirmed,
      if (isDemo != null) 'is_demo': isDemo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlacesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? name,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? locality,
    Value<String?>? city,
    Value<String?>? region,
    Value<String?>? country,
    Value<String?>? formattedAddress,
    Value<bool>? isConfirmed,
    Value<bool>? isDemo,
    Value<int>? rowid,
  }) {
    return PlacesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locality: locality ?? this.locality,
      city: city ?? this.city,
      region: region ?? this.region,
      country: country ?? this.country,
      formattedAddress: formattedAddress ?? this.formattedAddress,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      isDemo: isDemo ?? this.isDemo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (locality.present) {
      map['locality'] = Variable<String>(locality.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (formattedAddress.present) {
      map['formatted_address'] = Variable<String>(formattedAddress.value);
    }
    if (isConfirmed.present) {
      map['is_confirmed'] = Variable<bool>(isConfirmed.value);
    }
    if (isDemo.present) {
      map['is_demo'] = Variable<bool>(isDemo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlacesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('locality: $locality, ')
          ..write('city: $city, ')
          ..write('region: $region, ')
          ..write('country: $country, ')
          ..write('formattedAddress: $formattedAddress, ')
          ..write('isConfirmed: $isConfirmed, ')
          ..write('isDemo: $isDemo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, MemoryEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generatedTitleMeta = const VerificationMeta(
    'generatedTitle',
  );
  @override
  late final GeneratedColumn<String> generatedTitle = GeneratedColumn<String>(
    'generated_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confirmedTitleMeta = const VerificationMeta(
    'confirmedTitle',
  );
  @override
  late final GeneratedColumn<String> confirmedTitle = GeneratedColumn<String>(
    'confirmed_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isTitleConfirmedMeta = const VerificationMeta(
    'isTitleConfirmed',
  );
  @override
  late final GeneratedColumn<bool> isTitleConfirmed = GeneratedColumn<bool>(
    'is_title_confirmed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_title_confirmed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<DateTime> startAt = GeneratedColumn<DateTime>(
    'start_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<DateTime> endAt = GeneratedColumn<DateTime>(
    'end_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _placeIdMeta = const VerificationMeta(
    'placeId',
  );
  @override
  late final GeneratedColumn<String> placeId = GeneratedColumn<String>(
    'place_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES places (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _coverMediaIdMeta = const VerificationMeta(
    'coverMediaId',
  );
  @override
  late final GeneratedColumn<String> coverMediaId = GeneratedColumn<String>(
    'cover_media_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES media_items (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _isCoverUserSelectedMeta =
      const VerificationMeta('isCoverUserSelected');
  @override
  late final GeneratedColumn<bool> isCoverUserSelected = GeneratedColumn<bool>(
    'is_cover_user_selected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_cover_user_selected" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isFavouriteMeta = const VerificationMeta(
    'isFavourite',
  );
  @override
  late final GeneratedColumn<bool> isFavourite = GeneratedColumn<bool>(
    'is_favourite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favourite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _manualRatingMeta = const VerificationMeta(
    'manualRating',
  );
  @override
  late final GeneratedColumn<int> manualRating = GeneratedColumn<int>(
    'manual_rating',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isImportantMeta = const VerificationMeta(
    'isImportant',
  );
  @override
  late final GeneratedColumn<bool> isImportant = GeneratedColumn<bool>(
    'is_important',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_important" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isSensitiveMeta = const VerificationMeta(
    'isSensitive',
  );
  @override
  late final GeneratedColumn<bool> isSensitive = GeneratedColumn<bool>(
    'is_sensitive',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_sensitive" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isHiddenMeta = const VerificationMeta(
    'isHidden',
  );
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
    'is_hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_hidden" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _viewCountMeta = const VerificationMeta(
    'viewCount',
  );
  @override
  late final GeneratedColumn<int> viewCount = GeneratedColumn<int>(
    'view_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastViewedAtMeta = const VerificationMeta(
    'lastViewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastViewedAt = GeneratedColumn<DateTime>(
    'last_viewed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('generated'),
  );
  static const VerificationMeta _clusteringVersionMeta = const VerificationMeta(
    'clusteringVersion',
  );
  @override
  late final GeneratedColumn<String> clusteringVersion =
      GeneratedColumn<String>(
        'clustering_version',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDemoMeta = const VerificationMeta('isDemo');
  @override
  late final GeneratedColumn<bool> isDemo = GeneratedColumn<bool>(
    'is_demo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_demo" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    generatedTitle,
    confirmedTitle,
    isTitleConfirmed,
    description,
    startAt,
    endAt,
    placeId,
    coverMediaId,
    isCoverUserSelected,
    isFavourite,
    manualRating,
    isImportant,
    isSensitive,
    isHidden,
    viewCount,
    lastViewedAt,
    source,
    clusteringVersion,
    generatedAt,
    isDemo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemoryEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('generated_title')) {
      context.handle(
        _generatedTitleMeta,
        generatedTitle.isAcceptableOrUnknown(
          data['generated_title']!,
          _generatedTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedTitleMeta);
    }
    if (data.containsKey('confirmed_title')) {
      context.handle(
        _confirmedTitleMeta,
        confirmedTitle.isAcceptableOrUnknown(
          data['confirmed_title']!,
          _confirmedTitleMeta,
        ),
      );
    }
    if (data.containsKey('is_title_confirmed')) {
      context.handle(
        _isTitleConfirmedMeta,
        isTitleConfirmed.isAcceptableOrUnknown(
          data['is_title_confirmed']!,
          _isTitleConfirmedMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startAtMeta);
    }
    if (data.containsKey('end_at')) {
      context.handle(
        _endAtMeta,
        endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endAtMeta);
    }
    if (data.containsKey('place_id')) {
      context.handle(
        _placeIdMeta,
        placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta),
      );
    }
    if (data.containsKey('cover_media_id')) {
      context.handle(
        _coverMediaIdMeta,
        coverMediaId.isAcceptableOrUnknown(
          data['cover_media_id']!,
          _coverMediaIdMeta,
        ),
      );
    }
    if (data.containsKey('is_cover_user_selected')) {
      context.handle(
        _isCoverUserSelectedMeta,
        isCoverUserSelected.isAcceptableOrUnknown(
          data['is_cover_user_selected']!,
          _isCoverUserSelectedMeta,
        ),
      );
    }
    if (data.containsKey('is_favourite')) {
      context.handle(
        _isFavouriteMeta,
        isFavourite.isAcceptableOrUnknown(
          data['is_favourite']!,
          _isFavouriteMeta,
        ),
      );
    }
    if (data.containsKey('manual_rating')) {
      context.handle(
        _manualRatingMeta,
        manualRating.isAcceptableOrUnknown(
          data['manual_rating']!,
          _manualRatingMeta,
        ),
      );
    }
    if (data.containsKey('is_important')) {
      context.handle(
        _isImportantMeta,
        isImportant.isAcceptableOrUnknown(
          data['is_important']!,
          _isImportantMeta,
        ),
      );
    }
    if (data.containsKey('is_sensitive')) {
      context.handle(
        _isSensitiveMeta,
        isSensitive.isAcceptableOrUnknown(
          data['is_sensitive']!,
          _isSensitiveMeta,
        ),
      );
    }
    if (data.containsKey('is_hidden')) {
      context.handle(
        _isHiddenMeta,
        isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta),
      );
    }
    if (data.containsKey('view_count')) {
      context.handle(
        _viewCountMeta,
        viewCount.isAcceptableOrUnknown(data['view_count']!, _viewCountMeta),
      );
    }
    if (data.containsKey('last_viewed_at')) {
      context.handle(
        _lastViewedAtMeta,
        lastViewedAt.isAcceptableOrUnknown(
          data['last_viewed_at']!,
          _lastViewedAtMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('clustering_version')) {
      context.handle(
        _clusteringVersionMeta,
        clusteringVersion.isAcceptableOrUnknown(
          data['clustering_version']!,
          _clusteringVersionMeta,
        ),
      );
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    }
    if (data.containsKey('is_demo')) {
      context.handle(
        _isDemoMeta,
        isDemo.isAcceptableOrUnknown(data['is_demo']!, _isDemoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemoryEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoryEventRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      generatedTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}generated_title'],
      )!,
      confirmedTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}confirmed_title'],
      ),
      isTitleConfirmed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_title_confirmed'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_at'],
      )!,
      endAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_at'],
      )!,
      placeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}place_id'],
      ),
      coverMediaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_media_id'],
      ),
      isCoverUserSelected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_cover_user_selected'],
      )!,
      isFavourite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favourite'],
      )!,
      manualRating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}manual_rating'],
      ),
      isImportant: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_important'],
      )!,
      isSensitive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_sensitive'],
      )!,
      isHidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_hidden'],
      )!,
      viewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}view_count'],
      )!,
      lastViewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_viewed_at'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      clusteringVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clustering_version'],
      ),
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
      isDemo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_demo'],
      )!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class MemoryEventRow extends DataClass implements Insertable<MemoryEventRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String generatedTitle;
  final String? confirmedTitle;
  final bool isTitleConfirmed;
  final String? description;
  final DateTime startAt;
  final DateTime endAt;
  final String? placeId;
  final String? coverMediaId;
  final bool isCoverUserSelected;
  final bool isFavourite;
  final int? manualRating;
  final bool isImportant;
  final bool isSensitive;
  final bool isHidden;
  final int viewCount;
  final DateTime? lastViewedAt;
  final String source;
  final String? clusteringVersion;
  final DateTime generatedAt;
  final bool isDemo;
  const MemoryEventRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.generatedTitle,
    this.confirmedTitle,
    required this.isTitleConfirmed,
    this.description,
    required this.startAt,
    required this.endAt,
    this.placeId,
    this.coverMediaId,
    required this.isCoverUserSelected,
    required this.isFavourite,
    this.manualRating,
    required this.isImportant,
    required this.isSensitive,
    required this.isHidden,
    required this.viewCount,
    this.lastViewedAt,
    required this.source,
    this.clusteringVersion,
    required this.generatedAt,
    required this.isDemo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['generated_title'] = Variable<String>(generatedTitle);
    if (!nullToAbsent || confirmedTitle != null) {
      map['confirmed_title'] = Variable<String>(confirmedTitle);
    }
    map['is_title_confirmed'] = Variable<bool>(isTitleConfirmed);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['start_at'] = Variable<DateTime>(startAt);
    map['end_at'] = Variable<DateTime>(endAt);
    if (!nullToAbsent || placeId != null) {
      map['place_id'] = Variable<String>(placeId);
    }
    if (!nullToAbsent || coverMediaId != null) {
      map['cover_media_id'] = Variable<String>(coverMediaId);
    }
    map['is_cover_user_selected'] = Variable<bool>(isCoverUserSelected);
    map['is_favourite'] = Variable<bool>(isFavourite);
    if (!nullToAbsent || manualRating != null) {
      map['manual_rating'] = Variable<int>(manualRating);
    }
    map['is_important'] = Variable<bool>(isImportant);
    map['is_sensitive'] = Variable<bool>(isSensitive);
    map['is_hidden'] = Variable<bool>(isHidden);
    map['view_count'] = Variable<int>(viewCount);
    if (!nullToAbsent || lastViewedAt != null) {
      map['last_viewed_at'] = Variable<DateTime>(lastViewedAt);
    }
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || clusteringVersion != null) {
      map['clustering_version'] = Variable<String>(clusteringVersion);
    }
    map['generated_at'] = Variable<DateTime>(generatedAt);
    map['is_demo'] = Variable<bool>(isDemo);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      generatedTitle: Value(generatedTitle),
      confirmedTitle: confirmedTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(confirmedTitle),
      isTitleConfirmed: Value(isTitleConfirmed),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      startAt: Value(startAt),
      endAt: Value(endAt),
      placeId: placeId == null && nullToAbsent
          ? const Value.absent()
          : Value(placeId),
      coverMediaId: coverMediaId == null && nullToAbsent
          ? const Value.absent()
          : Value(coverMediaId),
      isCoverUserSelected: Value(isCoverUserSelected),
      isFavourite: Value(isFavourite),
      manualRating: manualRating == null && nullToAbsent
          ? const Value.absent()
          : Value(manualRating),
      isImportant: Value(isImportant),
      isSensitive: Value(isSensitive),
      isHidden: Value(isHidden),
      viewCount: Value(viewCount),
      lastViewedAt: lastViewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastViewedAt),
      source: Value(source),
      clusteringVersion: clusteringVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(clusteringVersion),
      generatedAt: Value(generatedAt),
      isDemo: Value(isDemo),
    );
  }

  factory MemoryEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoryEventRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      generatedTitle: serializer.fromJson<String>(json['generatedTitle']),
      confirmedTitle: serializer.fromJson<String?>(json['confirmedTitle']),
      isTitleConfirmed: serializer.fromJson<bool>(json['isTitleConfirmed']),
      description: serializer.fromJson<String?>(json['description']),
      startAt: serializer.fromJson<DateTime>(json['startAt']),
      endAt: serializer.fromJson<DateTime>(json['endAt']),
      placeId: serializer.fromJson<String?>(json['placeId']),
      coverMediaId: serializer.fromJson<String?>(json['coverMediaId']),
      isCoverUserSelected: serializer.fromJson<bool>(
        json['isCoverUserSelected'],
      ),
      isFavourite: serializer.fromJson<bool>(json['isFavourite']),
      manualRating: serializer.fromJson<int?>(json['manualRating']),
      isImportant: serializer.fromJson<bool>(json['isImportant']),
      isSensitive: serializer.fromJson<bool>(json['isSensitive']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
      viewCount: serializer.fromJson<int>(json['viewCount']),
      lastViewedAt: serializer.fromJson<DateTime?>(json['lastViewedAt']),
      source: serializer.fromJson<String>(json['source']),
      clusteringVersion: serializer.fromJson<String?>(
        json['clusteringVersion'],
      ),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
      isDemo: serializer.fromJson<bool>(json['isDemo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'generatedTitle': serializer.toJson<String>(generatedTitle),
      'confirmedTitle': serializer.toJson<String?>(confirmedTitle),
      'isTitleConfirmed': serializer.toJson<bool>(isTitleConfirmed),
      'description': serializer.toJson<String?>(description),
      'startAt': serializer.toJson<DateTime>(startAt),
      'endAt': serializer.toJson<DateTime>(endAt),
      'placeId': serializer.toJson<String?>(placeId),
      'coverMediaId': serializer.toJson<String?>(coverMediaId),
      'isCoverUserSelected': serializer.toJson<bool>(isCoverUserSelected),
      'isFavourite': serializer.toJson<bool>(isFavourite),
      'manualRating': serializer.toJson<int?>(manualRating),
      'isImportant': serializer.toJson<bool>(isImportant),
      'isSensitive': serializer.toJson<bool>(isSensitive),
      'isHidden': serializer.toJson<bool>(isHidden),
      'viewCount': serializer.toJson<int>(viewCount),
      'lastViewedAt': serializer.toJson<DateTime?>(lastViewedAt),
      'source': serializer.toJson<String>(source),
      'clusteringVersion': serializer.toJson<String?>(clusteringVersion),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
      'isDemo': serializer.toJson<bool>(isDemo),
    };
  }

  MemoryEventRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? generatedTitle,
    Value<String?> confirmedTitle = const Value.absent(),
    bool? isTitleConfirmed,
    Value<String?> description = const Value.absent(),
    DateTime? startAt,
    DateTime? endAt,
    Value<String?> placeId = const Value.absent(),
    Value<String?> coverMediaId = const Value.absent(),
    bool? isCoverUserSelected,
    bool? isFavourite,
    Value<int?> manualRating = const Value.absent(),
    bool? isImportant,
    bool? isSensitive,
    bool? isHidden,
    int? viewCount,
    Value<DateTime?> lastViewedAt = const Value.absent(),
    String? source,
    Value<String?> clusteringVersion = const Value.absent(),
    DateTime? generatedAt,
    bool? isDemo,
  }) => MemoryEventRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    generatedTitle: generatedTitle ?? this.generatedTitle,
    confirmedTitle: confirmedTitle.present
        ? confirmedTitle.value
        : this.confirmedTitle,
    isTitleConfirmed: isTitleConfirmed ?? this.isTitleConfirmed,
    description: description.present ? description.value : this.description,
    startAt: startAt ?? this.startAt,
    endAt: endAt ?? this.endAt,
    placeId: placeId.present ? placeId.value : this.placeId,
    coverMediaId: coverMediaId.present ? coverMediaId.value : this.coverMediaId,
    isCoverUserSelected: isCoverUserSelected ?? this.isCoverUserSelected,
    isFavourite: isFavourite ?? this.isFavourite,
    manualRating: manualRating.present ? manualRating.value : this.manualRating,
    isImportant: isImportant ?? this.isImportant,
    isSensitive: isSensitive ?? this.isSensitive,
    isHidden: isHidden ?? this.isHidden,
    viewCount: viewCount ?? this.viewCount,
    lastViewedAt: lastViewedAt.present ? lastViewedAt.value : this.lastViewedAt,
    source: source ?? this.source,
    clusteringVersion: clusteringVersion.present
        ? clusteringVersion.value
        : this.clusteringVersion,
    generatedAt: generatedAt ?? this.generatedAt,
    isDemo: isDemo ?? this.isDemo,
  );
  MemoryEventRow copyWithCompanion(EventsCompanion data) {
    return MemoryEventRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      generatedTitle: data.generatedTitle.present
          ? data.generatedTitle.value
          : this.generatedTitle,
      confirmedTitle: data.confirmedTitle.present
          ? data.confirmedTitle.value
          : this.confirmedTitle,
      isTitleConfirmed: data.isTitleConfirmed.present
          ? data.isTitleConfirmed.value
          : this.isTitleConfirmed,
      description: data.description.present
          ? data.description.value
          : this.description,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
      placeId: data.placeId.present ? data.placeId.value : this.placeId,
      coverMediaId: data.coverMediaId.present
          ? data.coverMediaId.value
          : this.coverMediaId,
      isCoverUserSelected: data.isCoverUserSelected.present
          ? data.isCoverUserSelected.value
          : this.isCoverUserSelected,
      isFavourite: data.isFavourite.present
          ? data.isFavourite.value
          : this.isFavourite,
      manualRating: data.manualRating.present
          ? data.manualRating.value
          : this.manualRating,
      isImportant: data.isImportant.present
          ? data.isImportant.value
          : this.isImportant,
      isSensitive: data.isSensitive.present
          ? data.isSensitive.value
          : this.isSensitive,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
      viewCount: data.viewCount.present ? data.viewCount.value : this.viewCount,
      lastViewedAt: data.lastViewedAt.present
          ? data.lastViewedAt.value
          : this.lastViewedAt,
      source: data.source.present ? data.source.value : this.source,
      clusteringVersion: data.clusteringVersion.present
          ? data.clusteringVersion.value
          : this.clusteringVersion,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
      isDemo: data.isDemo.present ? data.isDemo.value : this.isDemo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemoryEventRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('generatedTitle: $generatedTitle, ')
          ..write('confirmedTitle: $confirmedTitle, ')
          ..write('isTitleConfirmed: $isTitleConfirmed, ')
          ..write('description: $description, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('placeId: $placeId, ')
          ..write('coverMediaId: $coverMediaId, ')
          ..write('isCoverUserSelected: $isCoverUserSelected, ')
          ..write('isFavourite: $isFavourite, ')
          ..write('manualRating: $manualRating, ')
          ..write('isImportant: $isImportant, ')
          ..write('isSensitive: $isSensitive, ')
          ..write('isHidden: $isHidden, ')
          ..write('viewCount: $viewCount, ')
          ..write('lastViewedAt: $lastViewedAt, ')
          ..write('source: $source, ')
          ..write('clusteringVersion: $clusteringVersion, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('isDemo: $isDemo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    createdAt,
    updatedAt,
    id,
    generatedTitle,
    confirmedTitle,
    isTitleConfirmed,
    description,
    startAt,
    endAt,
    placeId,
    coverMediaId,
    isCoverUserSelected,
    isFavourite,
    manualRating,
    isImportant,
    isSensitive,
    isHidden,
    viewCount,
    lastViewedAt,
    source,
    clusteringVersion,
    generatedAt,
    isDemo,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoryEventRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.generatedTitle == this.generatedTitle &&
          other.confirmedTitle == this.confirmedTitle &&
          other.isTitleConfirmed == this.isTitleConfirmed &&
          other.description == this.description &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt &&
          other.placeId == this.placeId &&
          other.coverMediaId == this.coverMediaId &&
          other.isCoverUserSelected == this.isCoverUserSelected &&
          other.isFavourite == this.isFavourite &&
          other.manualRating == this.manualRating &&
          other.isImportant == this.isImportant &&
          other.isSensitive == this.isSensitive &&
          other.isHidden == this.isHidden &&
          other.viewCount == this.viewCount &&
          other.lastViewedAt == this.lastViewedAt &&
          other.source == this.source &&
          other.clusteringVersion == this.clusteringVersion &&
          other.generatedAt == this.generatedAt &&
          other.isDemo == this.isDemo);
}

class EventsCompanion extends UpdateCompanion<MemoryEventRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> generatedTitle;
  final Value<String?> confirmedTitle;
  final Value<bool> isTitleConfirmed;
  final Value<String?> description;
  final Value<DateTime> startAt;
  final Value<DateTime> endAt;
  final Value<String?> placeId;
  final Value<String?> coverMediaId;
  final Value<bool> isCoverUserSelected;
  final Value<bool> isFavourite;
  final Value<int?> manualRating;
  final Value<bool> isImportant;
  final Value<bool> isSensitive;
  final Value<bool> isHidden;
  final Value<int> viewCount;
  final Value<DateTime?> lastViewedAt;
  final Value<String> source;
  final Value<String?> clusteringVersion;
  final Value<DateTime> generatedAt;
  final Value<bool> isDemo;
  final Value<int> rowid;
  const EventsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.generatedTitle = const Value.absent(),
    this.confirmedTitle = const Value.absent(),
    this.isTitleConfirmed = const Value.absent(),
    this.description = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    this.placeId = const Value.absent(),
    this.coverMediaId = const Value.absent(),
    this.isCoverUserSelected = const Value.absent(),
    this.isFavourite = const Value.absent(),
    this.manualRating = const Value.absent(),
    this.isImportant = const Value.absent(),
    this.isSensitive = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.viewCount = const Value.absent(),
    this.lastViewedAt = const Value.absent(),
    this.source = const Value.absent(),
    this.clusteringVersion = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.isDemo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String generatedTitle,
    this.confirmedTitle = const Value.absent(),
    this.isTitleConfirmed = const Value.absent(),
    this.description = const Value.absent(),
    required DateTime startAt,
    required DateTime endAt,
    this.placeId = const Value.absent(),
    this.coverMediaId = const Value.absent(),
    this.isCoverUserSelected = const Value.absent(),
    this.isFavourite = const Value.absent(),
    this.manualRating = const Value.absent(),
    this.isImportant = const Value.absent(),
    this.isSensitive = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.viewCount = const Value.absent(),
    this.lastViewedAt = const Value.absent(),
    this.source = const Value.absent(),
    this.clusteringVersion = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.isDemo = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       generatedTitle = Value(generatedTitle),
       startAt = Value(startAt),
       endAt = Value(endAt);
  static Insertable<MemoryEventRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? generatedTitle,
    Expression<String>? confirmedTitle,
    Expression<bool>? isTitleConfirmed,
    Expression<String>? description,
    Expression<DateTime>? startAt,
    Expression<DateTime>? endAt,
    Expression<String>? placeId,
    Expression<String>? coverMediaId,
    Expression<bool>? isCoverUserSelected,
    Expression<bool>? isFavourite,
    Expression<int>? manualRating,
    Expression<bool>? isImportant,
    Expression<bool>? isSensitive,
    Expression<bool>? isHidden,
    Expression<int>? viewCount,
    Expression<DateTime>? lastViewedAt,
    Expression<String>? source,
    Expression<String>? clusteringVersion,
    Expression<DateTime>? generatedAt,
    Expression<bool>? isDemo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (generatedTitle != null) 'generated_title': generatedTitle,
      if (confirmedTitle != null) 'confirmed_title': confirmedTitle,
      if (isTitleConfirmed != null) 'is_title_confirmed': isTitleConfirmed,
      if (description != null) 'description': description,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
      if (placeId != null) 'place_id': placeId,
      if (coverMediaId != null) 'cover_media_id': coverMediaId,
      if (isCoverUserSelected != null)
        'is_cover_user_selected': isCoverUserSelected,
      if (isFavourite != null) 'is_favourite': isFavourite,
      if (manualRating != null) 'manual_rating': manualRating,
      if (isImportant != null) 'is_important': isImportant,
      if (isSensitive != null) 'is_sensitive': isSensitive,
      if (isHidden != null) 'is_hidden': isHidden,
      if (viewCount != null) 'view_count': viewCount,
      if (lastViewedAt != null) 'last_viewed_at': lastViewedAt,
      if (source != null) 'source': source,
      if (clusteringVersion != null) 'clustering_version': clusteringVersion,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (isDemo != null) 'is_demo': isDemo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? generatedTitle,
    Value<String?>? confirmedTitle,
    Value<bool>? isTitleConfirmed,
    Value<String?>? description,
    Value<DateTime>? startAt,
    Value<DateTime>? endAt,
    Value<String?>? placeId,
    Value<String?>? coverMediaId,
    Value<bool>? isCoverUserSelected,
    Value<bool>? isFavourite,
    Value<int?>? manualRating,
    Value<bool>? isImportant,
    Value<bool>? isSensitive,
    Value<bool>? isHidden,
    Value<int>? viewCount,
    Value<DateTime?>? lastViewedAt,
    Value<String>? source,
    Value<String?>? clusteringVersion,
    Value<DateTime>? generatedAt,
    Value<bool>? isDemo,
    Value<int>? rowid,
  }) {
    return EventsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      generatedTitle: generatedTitle ?? this.generatedTitle,
      confirmedTitle: confirmedTitle ?? this.confirmedTitle,
      isTitleConfirmed: isTitleConfirmed ?? this.isTitleConfirmed,
      description: description ?? this.description,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      placeId: placeId ?? this.placeId,
      coverMediaId: coverMediaId ?? this.coverMediaId,
      isCoverUserSelected: isCoverUserSelected ?? this.isCoverUserSelected,
      isFavourite: isFavourite ?? this.isFavourite,
      manualRating: manualRating ?? this.manualRating,
      isImportant: isImportant ?? this.isImportant,
      isSensitive: isSensitive ?? this.isSensitive,
      isHidden: isHidden ?? this.isHidden,
      viewCount: viewCount ?? this.viewCount,
      lastViewedAt: lastViewedAt ?? this.lastViewedAt,
      source: source ?? this.source,
      clusteringVersion: clusteringVersion ?? this.clusteringVersion,
      generatedAt: generatedAt ?? this.generatedAt,
      isDemo: isDemo ?? this.isDemo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (generatedTitle.present) {
      map['generated_title'] = Variable<String>(generatedTitle.value);
    }
    if (confirmedTitle.present) {
      map['confirmed_title'] = Variable<String>(confirmedTitle.value);
    }
    if (isTitleConfirmed.present) {
      map['is_title_confirmed'] = Variable<bool>(isTitleConfirmed.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<DateTime>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<DateTime>(endAt.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<String>(placeId.value);
    }
    if (coverMediaId.present) {
      map['cover_media_id'] = Variable<String>(coverMediaId.value);
    }
    if (isCoverUserSelected.present) {
      map['is_cover_user_selected'] = Variable<bool>(isCoverUserSelected.value);
    }
    if (isFavourite.present) {
      map['is_favourite'] = Variable<bool>(isFavourite.value);
    }
    if (manualRating.present) {
      map['manual_rating'] = Variable<int>(manualRating.value);
    }
    if (isImportant.present) {
      map['is_important'] = Variable<bool>(isImportant.value);
    }
    if (isSensitive.present) {
      map['is_sensitive'] = Variable<bool>(isSensitive.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
    }
    if (viewCount.present) {
      map['view_count'] = Variable<int>(viewCount.value);
    }
    if (lastViewedAt.present) {
      map['last_viewed_at'] = Variable<DateTime>(lastViewedAt.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (clusteringVersion.present) {
      map['clustering_version'] = Variable<String>(clusteringVersion.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (isDemo.present) {
      map['is_demo'] = Variable<bool>(isDemo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('generatedTitle: $generatedTitle, ')
          ..write('confirmedTitle: $confirmedTitle, ')
          ..write('isTitleConfirmed: $isTitleConfirmed, ')
          ..write('description: $description, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('placeId: $placeId, ')
          ..write('coverMediaId: $coverMediaId, ')
          ..write('isCoverUserSelected: $isCoverUserSelected, ')
          ..write('isFavourite: $isFavourite, ')
          ..write('manualRating: $manualRating, ')
          ..write('isImportant: $isImportant, ')
          ..write('isSensitive: $isSensitive, ')
          ..write('isHidden: $isHidden, ')
          ..write('viewCount: $viewCount, ')
          ..write('lastViewedAt: $lastViewedAt, ')
          ..write('source: $source, ')
          ..write('clusteringVersion: $clusteringVersion, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('isDemo: $isDemo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventMediaTable extends EventMedia
    with TableInfo<$EventMediaTable, EventMediaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventMediaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _mediaIdMeta = const VerificationMeta(
    'mediaId',
  );
  @override
  late final GeneratedColumn<String> mediaId = GeneratedColumn<String>(
    'media_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES media_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _clusteringConfidenceMeta =
      const VerificationMeta('clusteringConfidence');
  @override
  late final GeneratedColumn<double> clusteringConfidence =
      GeneratedColumn<double>(
        'clustering_confidence',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isUserConfirmedMeta = const VerificationMeta(
    'isUserConfirmed',
  );
  @override
  late final GeneratedColumn<bool> isUserConfirmed = GeneratedColumn<bool>(
    'is_user_confirmed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_user_confirmed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    eventId,
    mediaId,
    position,
    clusteringConfidence,
    isUserConfirmed,
    addedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_media';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventMediaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('media_id')) {
      context.handle(
        _mediaIdMeta,
        mediaId.isAcceptableOrUnknown(data['media_id']!, _mediaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mediaIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('clustering_confidence')) {
      context.handle(
        _clusteringConfidenceMeta,
        clusteringConfidence.isAcceptableOrUnknown(
          data['clustering_confidence']!,
          _clusteringConfidenceMeta,
        ),
      );
    }
    if (data.containsKey('is_user_confirmed')) {
      context.handle(
        _isUserConfirmedMeta,
        isUserConfirmed.isAcceptableOrUnknown(
          data['is_user_confirmed']!,
          _isUserConfirmedMeta,
        ),
      );
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {eventId, mediaId};
  @override
  EventMediaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventMediaRow(
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      mediaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      clusteringConfidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}clustering_confidence'],
      ),
      isUserConfirmed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_user_confirmed'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at'],
      )!,
    );
  }

  @override
  $EventMediaTable createAlias(String alias) {
    return $EventMediaTable(attachedDatabase, alias);
  }
}

class EventMediaRow extends DataClass implements Insertable<EventMediaRow> {
  final String eventId;
  final String mediaId;
  final int position;
  final double? clusteringConfidence;
  final bool isUserConfirmed;
  final DateTime addedAt;
  const EventMediaRow({
    required this.eventId,
    required this.mediaId,
    required this.position,
    this.clusteringConfidence,
    required this.isUserConfirmed,
    required this.addedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event_id'] = Variable<String>(eventId);
    map['media_id'] = Variable<String>(mediaId);
    map['position'] = Variable<int>(position);
    if (!nullToAbsent || clusteringConfidence != null) {
      map['clustering_confidence'] = Variable<double>(clusteringConfidence);
    }
    map['is_user_confirmed'] = Variable<bool>(isUserConfirmed);
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  EventMediaCompanion toCompanion(bool nullToAbsent) {
    return EventMediaCompanion(
      eventId: Value(eventId),
      mediaId: Value(mediaId),
      position: Value(position),
      clusteringConfidence: clusteringConfidence == null && nullToAbsent
          ? const Value.absent()
          : Value(clusteringConfidence),
      isUserConfirmed: Value(isUserConfirmed),
      addedAt: Value(addedAt),
    );
  }

  factory EventMediaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventMediaRow(
      eventId: serializer.fromJson<String>(json['eventId']),
      mediaId: serializer.fromJson<String>(json['mediaId']),
      position: serializer.fromJson<int>(json['position']),
      clusteringConfidence: serializer.fromJson<double?>(
        json['clusteringConfidence'],
      ),
      isUserConfirmed: serializer.fromJson<bool>(json['isUserConfirmed']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'eventId': serializer.toJson<String>(eventId),
      'mediaId': serializer.toJson<String>(mediaId),
      'position': serializer.toJson<int>(position),
      'clusteringConfidence': serializer.toJson<double?>(clusteringConfidence),
      'isUserConfirmed': serializer.toJson<bool>(isUserConfirmed),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  EventMediaRow copyWith({
    String? eventId,
    String? mediaId,
    int? position,
    Value<double?> clusteringConfidence = const Value.absent(),
    bool? isUserConfirmed,
    DateTime? addedAt,
  }) => EventMediaRow(
    eventId: eventId ?? this.eventId,
    mediaId: mediaId ?? this.mediaId,
    position: position ?? this.position,
    clusteringConfidence: clusteringConfidence.present
        ? clusteringConfidence.value
        : this.clusteringConfidence,
    isUserConfirmed: isUserConfirmed ?? this.isUserConfirmed,
    addedAt: addedAt ?? this.addedAt,
  );
  EventMediaRow copyWithCompanion(EventMediaCompanion data) {
    return EventMediaRow(
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      mediaId: data.mediaId.present ? data.mediaId.value : this.mediaId,
      position: data.position.present ? data.position.value : this.position,
      clusteringConfidence: data.clusteringConfidence.present
          ? data.clusteringConfidence.value
          : this.clusteringConfidence,
      isUserConfirmed: data.isUserConfirmed.present
          ? data.isUserConfirmed.value
          : this.isUserConfirmed,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventMediaRow(')
          ..write('eventId: $eventId, ')
          ..write('mediaId: $mediaId, ')
          ..write('position: $position, ')
          ..write('clusteringConfidence: $clusteringConfidence, ')
          ..write('isUserConfirmed: $isUserConfirmed, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    eventId,
    mediaId,
    position,
    clusteringConfidence,
    isUserConfirmed,
    addedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventMediaRow &&
          other.eventId == this.eventId &&
          other.mediaId == this.mediaId &&
          other.position == this.position &&
          other.clusteringConfidence == this.clusteringConfidence &&
          other.isUserConfirmed == this.isUserConfirmed &&
          other.addedAt == this.addedAt);
}

class EventMediaCompanion extends UpdateCompanion<EventMediaRow> {
  final Value<String> eventId;
  final Value<String> mediaId;
  final Value<int> position;
  final Value<double?> clusteringConfidence;
  final Value<bool> isUserConfirmed;
  final Value<DateTime> addedAt;
  final Value<int> rowid;
  const EventMediaCompanion({
    this.eventId = const Value.absent(),
    this.mediaId = const Value.absent(),
    this.position = const Value.absent(),
    this.clusteringConfidence = const Value.absent(),
    this.isUserConfirmed = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventMediaCompanion.insert({
    required String eventId,
    required String mediaId,
    this.position = const Value.absent(),
    this.clusteringConfidence = const Value.absent(),
    this.isUserConfirmed = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : eventId = Value(eventId),
       mediaId = Value(mediaId);
  static Insertable<EventMediaRow> custom({
    Expression<String>? eventId,
    Expression<String>? mediaId,
    Expression<int>? position,
    Expression<double>? clusteringConfidence,
    Expression<bool>? isUserConfirmed,
    Expression<DateTime>? addedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (eventId != null) 'event_id': eventId,
      if (mediaId != null) 'media_id': mediaId,
      if (position != null) 'position': position,
      if (clusteringConfidence != null)
        'clustering_confidence': clusteringConfidence,
      if (isUserConfirmed != null) 'is_user_confirmed': isUserConfirmed,
      if (addedAt != null) 'added_at': addedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventMediaCompanion copyWith({
    Value<String>? eventId,
    Value<String>? mediaId,
    Value<int>? position,
    Value<double?>? clusteringConfidence,
    Value<bool>? isUserConfirmed,
    Value<DateTime>? addedAt,
    Value<int>? rowid,
  }) {
    return EventMediaCompanion(
      eventId: eventId ?? this.eventId,
      mediaId: mediaId ?? this.mediaId,
      position: position ?? this.position,
      clusteringConfidence: clusteringConfidence ?? this.clusteringConfidence,
      isUserConfirmed: isUserConfirmed ?? this.isUserConfirmed,
      addedAt: addedAt ?? this.addedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (mediaId.present) {
      map['media_id'] = Variable<String>(mediaId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (clusteringConfidence.present) {
      map['clustering_confidence'] = Variable<double>(
        clusteringConfidence.value,
      );
    }
    if (isUserConfirmed.present) {
      map['is_user_confirmed'] = Variable<bool>(isUserConfirmed.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventMediaCompanion(')
          ..write('eventId: $eventId, ')
          ..write('mediaId: $mediaId, ')
          ..write('position: $position, ')
          ..write('clusteringConfidence: $clusteringConfidence, ')
          ..write('isUserConfirmed: $isUserConfirmed, ')
          ..write('addedAt: $addedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PersonsTable extends Persons with TableInfo<$PersonsTable, PersonRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isConfirmedMeta = const VerificationMeta(
    'isConfirmed',
  );
  @override
  late final GeneratedColumn<bool> isConfirmed = GeneratedColumn<bool>(
    'is_confirmed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_confirmed" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isDemoMeta = const VerificationMeta('isDemo');
  @override
  late final GeneratedColumn<bool> isDemo = GeneratedColumn<bool>(
    'is_demo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_demo" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    displayName,
    isConfirmed,
    isDemo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'persons';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('is_confirmed')) {
      context.handle(
        _isConfirmedMeta,
        isConfirmed.isAcceptableOrUnknown(
          data['is_confirmed']!,
          _isConfirmedMeta,
        ),
      );
    }
    if (data.containsKey('is_demo')) {
      context.handle(
        _isDemoMeta,
        isDemo.isAcceptableOrUnknown(data['is_demo']!, _isDemoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      isConfirmed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_confirmed'],
      )!,
      isDemo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_demo'],
      )!,
    );
  }

  @override
  $PersonsTable createAlias(String alias) {
    return $PersonsTable(attachedDatabase, alias);
  }
}

class PersonRow extends DataClass implements Insertable<PersonRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String displayName;
  final bool isConfirmed;
  final bool isDemo;
  const PersonRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.displayName,
    required this.isConfirmed,
    required this.isDemo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['display_name'] = Variable<String>(displayName);
    map['is_confirmed'] = Variable<bool>(isConfirmed);
    map['is_demo'] = Variable<bool>(isDemo);
    return map;
  }

  PersonsCompanion toCompanion(bool nullToAbsent) {
    return PersonsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      displayName: Value(displayName),
      isConfirmed: Value(isConfirmed),
      isDemo: Value(isDemo),
    );
  }

  factory PersonRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      isConfirmed: serializer.fromJson<bool>(json['isConfirmed']),
      isDemo: serializer.fromJson<bool>(json['isDemo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String>(displayName),
      'isConfirmed': serializer.toJson<bool>(isConfirmed),
      'isDemo': serializer.toJson<bool>(isDemo),
    };
  }

  PersonRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? displayName,
    bool? isConfirmed,
    bool? isDemo,
  }) => PersonRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    isConfirmed: isConfirmed ?? this.isConfirmed,
    isDemo: isDemo ?? this.isDemo,
  );
  PersonRow copyWithCompanion(PersonsCompanion data) {
    return PersonRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      isConfirmed: data.isConfirmed.present
          ? data.isConfirmed.value
          : this.isConfirmed,
      isDemo: data.isDemo.present ? data.isDemo.value : this.isDemo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('isConfirmed: $isConfirmed, ')
          ..write('isDemo: $isDemo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, id, displayName, isConfirmed, isDemo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.isConfirmed == this.isConfirmed &&
          other.isDemo == this.isDemo);
}

class PersonsCompanion extends UpdateCompanion<PersonRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> displayName;
  final Value<bool> isConfirmed;
  final Value<bool> isDemo;
  final Value<int> rowid;
  const PersonsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.isConfirmed = const Value.absent(),
    this.isDemo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PersonsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String displayName,
    this.isConfirmed = const Value.absent(),
    this.isDemo = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       displayName = Value(displayName);
  static Insertable<PersonRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<bool>? isConfirmed,
    Expression<bool>? isDemo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (isConfirmed != null) 'is_confirmed': isConfirmed,
      if (isDemo != null) 'is_demo': isDemo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PersonsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? displayName,
    Value<bool>? isConfirmed,
    Value<bool>? isDemo,
    Value<int>? rowid,
  }) {
    return PersonsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      isDemo: isDemo ?? this.isDemo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (isConfirmed.present) {
      map['is_confirmed'] = Variable<bool>(isConfirmed.value);
    }
    if (isDemo.present) {
      map['is_demo'] = Variable<bool>(isDemo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('isConfirmed: $isConfirmed, ')
          ..write('isDemo: $isDemo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventPersonsTable extends EventPersons
    with TableInfo<$EventPersonsTable, EventPersonRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventPersonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _personIdMeta = const VerificationMeta(
    'personId',
  );
  @override
  late final GeneratedColumn<String> personId = GeneratedColumn<String>(
    'person_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES persons (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('attendee'),
  );
  static const VerificationMeta _isUserConfirmedMeta = const VerificationMeta(
    'isUserConfirmed',
  );
  @override
  late final GeneratedColumn<bool> isUserConfirmed = GeneratedColumn<bool>(
    'is_user_confirmed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_user_confirmed" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    eventId,
    personId,
    role,
    isUserConfirmed,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_persons';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventPersonRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(
        _personIdMeta,
        personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('is_user_confirmed')) {
      context.handle(
        _isUserConfirmedMeta,
        isUserConfirmed.isAcceptableOrUnknown(
          data['is_user_confirmed']!,
          _isUserConfirmedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {eventId, personId};
  @override
  EventPersonRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventPersonRow(
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      personId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}person_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      isUserConfirmed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_user_confirmed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EventPersonsTable createAlias(String alias) {
    return $EventPersonsTable(attachedDatabase, alias);
  }
}

class EventPersonRow extends DataClass implements Insertable<EventPersonRow> {
  final String eventId;
  final String personId;
  final String role;
  final bool isUserConfirmed;
  final DateTime createdAt;
  const EventPersonRow({
    required this.eventId,
    required this.personId,
    required this.role,
    required this.isUserConfirmed,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event_id'] = Variable<String>(eventId);
    map['person_id'] = Variable<String>(personId);
    map['role'] = Variable<String>(role);
    map['is_user_confirmed'] = Variable<bool>(isUserConfirmed);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EventPersonsCompanion toCompanion(bool nullToAbsent) {
    return EventPersonsCompanion(
      eventId: Value(eventId),
      personId: Value(personId),
      role: Value(role),
      isUserConfirmed: Value(isUserConfirmed),
      createdAt: Value(createdAt),
    );
  }

  factory EventPersonRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventPersonRow(
      eventId: serializer.fromJson<String>(json['eventId']),
      personId: serializer.fromJson<String>(json['personId']),
      role: serializer.fromJson<String>(json['role']),
      isUserConfirmed: serializer.fromJson<bool>(json['isUserConfirmed']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'eventId': serializer.toJson<String>(eventId),
      'personId': serializer.toJson<String>(personId),
      'role': serializer.toJson<String>(role),
      'isUserConfirmed': serializer.toJson<bool>(isUserConfirmed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  EventPersonRow copyWith({
    String? eventId,
    String? personId,
    String? role,
    bool? isUserConfirmed,
    DateTime? createdAt,
  }) => EventPersonRow(
    eventId: eventId ?? this.eventId,
    personId: personId ?? this.personId,
    role: role ?? this.role,
    isUserConfirmed: isUserConfirmed ?? this.isUserConfirmed,
    createdAt: createdAt ?? this.createdAt,
  );
  EventPersonRow copyWithCompanion(EventPersonsCompanion data) {
    return EventPersonRow(
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      personId: data.personId.present ? data.personId.value : this.personId,
      role: data.role.present ? data.role.value : this.role,
      isUserConfirmed: data.isUserConfirmed.present
          ? data.isUserConfirmed.value
          : this.isUserConfirmed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventPersonRow(')
          ..write('eventId: $eventId, ')
          ..write('personId: $personId, ')
          ..write('role: $role, ')
          ..write('isUserConfirmed: $isUserConfirmed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(eventId, personId, role, isUserConfirmed, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventPersonRow &&
          other.eventId == this.eventId &&
          other.personId == this.personId &&
          other.role == this.role &&
          other.isUserConfirmed == this.isUserConfirmed &&
          other.createdAt == this.createdAt);
}

class EventPersonsCompanion extends UpdateCompanion<EventPersonRow> {
  final Value<String> eventId;
  final Value<String> personId;
  final Value<String> role;
  final Value<bool> isUserConfirmed;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const EventPersonsCompanion({
    this.eventId = const Value.absent(),
    this.personId = const Value.absent(),
    this.role = const Value.absent(),
    this.isUserConfirmed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventPersonsCompanion.insert({
    required String eventId,
    required String personId,
    this.role = const Value.absent(),
    this.isUserConfirmed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : eventId = Value(eventId),
       personId = Value(personId);
  static Insertable<EventPersonRow> custom({
    Expression<String>? eventId,
    Expression<String>? personId,
    Expression<String>? role,
    Expression<bool>? isUserConfirmed,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (eventId != null) 'event_id': eventId,
      if (personId != null) 'person_id': personId,
      if (role != null) 'role': role,
      if (isUserConfirmed != null) 'is_user_confirmed': isUserConfirmed,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventPersonsCompanion copyWith({
    Value<String>? eventId,
    Value<String>? personId,
    Value<String>? role,
    Value<bool>? isUserConfirmed,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return EventPersonsCompanion(
      eventId: eventId ?? this.eventId,
      personId: personId ?? this.personId,
      role: role ?? this.role,
      isUserConfirmed: isUserConfirmed ?? this.isUserConfirmed,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<String>(personId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (isUserConfirmed.present) {
      map['is_user_confirmed'] = Variable<bool>(isUserConfirmed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventPersonsCompanion(')
          ..write('eventId: $eventId, ')
          ..write('personId: $personId, ')
          ..write('role: $role, ')
          ..write('isUserConfirmed: $isUserConfirmed, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MediaPersonsTable extends MediaPersons
    with TableInfo<$MediaPersonsTable, MediaPersonRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaPersonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mediaIdMeta = const VerificationMeta(
    'mediaId',
  );
  @override
  late final GeneratedColumn<String> mediaId = GeneratedColumn<String>(
    'media_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES media_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _personIdMeta = const VerificationMeta(
    'personId',
  );
  @override
  late final GeneratedColumn<String> personId = GeneratedColumn<String>(
    'person_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES persons (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _faceBoundsJsonMeta = const VerificationMeta(
    'faceBoundsJson',
  );
  @override
  late final GeneratedColumn<String> faceBoundsJson = GeneratedColumn<String>(
    'face_bounds_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isUserConfirmedMeta = const VerificationMeta(
    'isUserConfirmed',
  );
  @override
  late final GeneratedColumn<bool> isUserConfirmed = GeneratedColumn<bool>(
    'is_user_confirmed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_user_confirmed" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    mediaId,
    personId,
    faceBoundsJson,
    isUserConfirmed,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_persons';
  @override
  VerificationContext validateIntegrity(
    Insertable<MediaPersonRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('media_id')) {
      context.handle(
        _mediaIdMeta,
        mediaId.isAcceptableOrUnknown(data['media_id']!, _mediaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mediaIdMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(
        _personIdMeta,
        personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    if (data.containsKey('face_bounds_json')) {
      context.handle(
        _faceBoundsJsonMeta,
        faceBoundsJson.isAcceptableOrUnknown(
          data['face_bounds_json']!,
          _faceBoundsJsonMeta,
        ),
      );
    }
    if (data.containsKey('is_user_confirmed')) {
      context.handle(
        _isUserConfirmedMeta,
        isUserConfirmed.isAcceptableOrUnknown(
          data['is_user_confirmed']!,
          _isUserConfirmedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mediaId, personId};
  @override
  MediaPersonRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaPersonRow(
      mediaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_id'],
      )!,
      personId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}person_id'],
      )!,
      faceBoundsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}face_bounds_json'],
      ),
      isUserConfirmed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_user_confirmed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MediaPersonsTable createAlias(String alias) {
    return $MediaPersonsTable(attachedDatabase, alias);
  }
}

class MediaPersonRow extends DataClass implements Insertable<MediaPersonRow> {
  final String mediaId;
  final String personId;
  final String? faceBoundsJson;
  final bool isUserConfirmed;
  final DateTime createdAt;
  const MediaPersonRow({
    required this.mediaId,
    required this.personId,
    this.faceBoundsJson,
    required this.isUserConfirmed,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['media_id'] = Variable<String>(mediaId);
    map['person_id'] = Variable<String>(personId);
    if (!nullToAbsent || faceBoundsJson != null) {
      map['face_bounds_json'] = Variable<String>(faceBoundsJson);
    }
    map['is_user_confirmed'] = Variable<bool>(isUserConfirmed);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MediaPersonsCompanion toCompanion(bool nullToAbsent) {
    return MediaPersonsCompanion(
      mediaId: Value(mediaId),
      personId: Value(personId),
      faceBoundsJson: faceBoundsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(faceBoundsJson),
      isUserConfirmed: Value(isUserConfirmed),
      createdAt: Value(createdAt),
    );
  }

  factory MediaPersonRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaPersonRow(
      mediaId: serializer.fromJson<String>(json['mediaId']),
      personId: serializer.fromJson<String>(json['personId']),
      faceBoundsJson: serializer.fromJson<String?>(json['faceBoundsJson']),
      isUserConfirmed: serializer.fromJson<bool>(json['isUserConfirmed']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mediaId': serializer.toJson<String>(mediaId),
      'personId': serializer.toJson<String>(personId),
      'faceBoundsJson': serializer.toJson<String?>(faceBoundsJson),
      'isUserConfirmed': serializer.toJson<bool>(isUserConfirmed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MediaPersonRow copyWith({
    String? mediaId,
    String? personId,
    Value<String?> faceBoundsJson = const Value.absent(),
    bool? isUserConfirmed,
    DateTime? createdAt,
  }) => MediaPersonRow(
    mediaId: mediaId ?? this.mediaId,
    personId: personId ?? this.personId,
    faceBoundsJson: faceBoundsJson.present
        ? faceBoundsJson.value
        : this.faceBoundsJson,
    isUserConfirmed: isUserConfirmed ?? this.isUserConfirmed,
    createdAt: createdAt ?? this.createdAt,
  );
  MediaPersonRow copyWithCompanion(MediaPersonsCompanion data) {
    return MediaPersonRow(
      mediaId: data.mediaId.present ? data.mediaId.value : this.mediaId,
      personId: data.personId.present ? data.personId.value : this.personId,
      faceBoundsJson: data.faceBoundsJson.present
          ? data.faceBoundsJson.value
          : this.faceBoundsJson,
      isUserConfirmed: data.isUserConfirmed.present
          ? data.isUserConfirmed.value
          : this.isUserConfirmed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaPersonRow(')
          ..write('mediaId: $mediaId, ')
          ..write('personId: $personId, ')
          ..write('faceBoundsJson: $faceBoundsJson, ')
          ..write('isUserConfirmed: $isUserConfirmed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    mediaId,
    personId,
    faceBoundsJson,
    isUserConfirmed,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaPersonRow &&
          other.mediaId == this.mediaId &&
          other.personId == this.personId &&
          other.faceBoundsJson == this.faceBoundsJson &&
          other.isUserConfirmed == this.isUserConfirmed &&
          other.createdAt == this.createdAt);
}

class MediaPersonsCompanion extends UpdateCompanion<MediaPersonRow> {
  final Value<String> mediaId;
  final Value<String> personId;
  final Value<String?> faceBoundsJson;
  final Value<bool> isUserConfirmed;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MediaPersonsCompanion({
    this.mediaId = const Value.absent(),
    this.personId = const Value.absent(),
    this.faceBoundsJson = const Value.absent(),
    this.isUserConfirmed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MediaPersonsCompanion.insert({
    required String mediaId,
    required String personId,
    this.faceBoundsJson = const Value.absent(),
    this.isUserConfirmed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : mediaId = Value(mediaId),
       personId = Value(personId);
  static Insertable<MediaPersonRow> custom({
    Expression<String>? mediaId,
    Expression<String>? personId,
    Expression<String>? faceBoundsJson,
    Expression<bool>? isUserConfirmed,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mediaId != null) 'media_id': mediaId,
      if (personId != null) 'person_id': personId,
      if (faceBoundsJson != null) 'face_bounds_json': faceBoundsJson,
      if (isUserConfirmed != null) 'is_user_confirmed': isUserConfirmed,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MediaPersonsCompanion copyWith({
    Value<String>? mediaId,
    Value<String>? personId,
    Value<String?>? faceBoundsJson,
    Value<bool>? isUserConfirmed,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return MediaPersonsCompanion(
      mediaId: mediaId ?? this.mediaId,
      personId: personId ?? this.personId,
      faceBoundsJson: faceBoundsJson ?? this.faceBoundsJson,
      isUserConfirmed: isUserConfirmed ?? this.isUserConfirmed,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mediaId.present) {
      map['media_id'] = Variable<String>(mediaId.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<String>(personId.value);
    }
    if (faceBoundsJson.present) {
      map['face_bounds_json'] = Variable<String>(faceBoundsJson.value);
    }
    if (isUserConfirmed.present) {
      map['is_user_confirmed'] = Variable<bool>(isUserConfirmed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaPersonsCompanion(')
          ..write('mediaId: $mediaId, ')
          ..write('personId: $personId, ')
          ..write('faceBoundsJson: $faceBoundsJson, ')
          ..write('isUserConfirmed: $isUserConfirmed, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, NoteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteTypeMeta = const VerificationMeta(
    'noteType',
  );
  @override
  late final GeneratedColumn<String> noteType = GeneratedColumn<String>(
    'note_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('note'),
  );
  static const VerificationMeta _isGeneratedMeta = const VerificationMeta(
    'isGenerated',
  );
  @override
  late final GeneratedColumn<bool> isGenerated = GeneratedColumn<bool>(
    'is_generated',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_generated" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    eventId,
    body,
    noteType,
    isGenerated,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<NoteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('note_type')) {
      context.handle(
        _noteTypeMeta,
        noteType.isAcceptableOrUnknown(data['note_type']!, _noteTypeMeta),
      );
    }
    if (data.containsKey('is_generated')) {
      context.handle(
        _isGeneratedMeta,
        isGenerated.isAcceptableOrUnknown(
          data['is_generated']!,
          _isGeneratedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      noteType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note_type'],
      )!,
      isGenerated: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_generated'],
      )!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class NoteRow extends DataClass implements Insertable<NoteRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String eventId;
  final String body;
  final String noteType;
  final bool isGenerated;
  const NoteRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.eventId,
    required this.body,
    required this.noteType,
    required this.isGenerated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    map['body'] = Variable<String>(body);
    map['note_type'] = Variable<String>(noteType);
    map['is_generated'] = Variable<bool>(isGenerated);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      eventId: Value(eventId),
      body: Value(body),
      noteType: Value(noteType),
      isGenerated: Value(isGenerated),
    );
  }

  factory NoteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      body: serializer.fromJson<String>(json['body']),
      noteType: serializer.fromJson<String>(json['noteType']),
      isGenerated: serializer.fromJson<bool>(json['isGenerated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'body': serializer.toJson<String>(body),
      'noteType': serializer.toJson<String>(noteType),
      'isGenerated': serializer.toJson<bool>(isGenerated),
    };
  }

  NoteRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? eventId,
    String? body,
    String? noteType,
    bool? isGenerated,
  }) => NoteRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    body: body ?? this.body,
    noteType: noteType ?? this.noteType,
    isGenerated: isGenerated ?? this.isGenerated,
  );
  NoteRow copyWithCompanion(NotesCompanion data) {
    return NoteRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      body: data.body.present ? data.body.value : this.body,
      noteType: data.noteType.present ? data.noteType.value : this.noteType,
      isGenerated: data.isGenerated.present
          ? data.isGenerated.value
          : this.isGenerated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NoteRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('body: $body, ')
          ..write('noteType: $noteType, ')
          ..write('isGenerated: $isGenerated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    eventId,
    body,
    noteType,
    isGenerated,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.body == this.body &&
          other.noteType == this.noteType &&
          other.isGenerated == this.isGenerated);
}

class NotesCompanion extends UpdateCompanion<NoteRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> eventId;
  final Value<String> body;
  final Value<String> noteType;
  final Value<bool> isGenerated;
  final Value<int> rowid;
  const NotesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.body = const Value.absent(),
    this.noteType = const Value.absent(),
    this.isGenerated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String eventId,
    required String body,
    this.noteType = const Value.absent(),
    this.isGenerated = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventId = Value(eventId),
       body = Value(body);
  static Insertable<NoteRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<String>? body,
    Expression<String>? noteType,
    Expression<bool>? isGenerated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (body != null) 'body': body,
      if (noteType != null) 'note_type': noteType,
      if (isGenerated != null) 'is_generated': isGenerated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? eventId,
    Value<String>? body,
    Value<String>? noteType,
    Value<bool>? isGenerated,
    Value<int>? rowid,
  }) {
    return NotesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      body: body ?? this.body,
      noteType: noteType ?? this.noteType,
      isGenerated: isGenerated ?? this.isGenerated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (noteType.present) {
      map['note_type'] = Variable<String>(noteType.value);
    }
    if (isGenerated.present) {
      map['is_generated'] = Variable<bool>(isGenerated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('body: $body, ')
          ..write('noteType: $noteType, ')
          ..write('isGenerated: $isGenerated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VoiceNotesTable extends VoiceNotes
    with TableInfo<$VoiceNotesTable, VoiceNoteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VoiceNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transcriptMeta = const VerificationMeta(
    'transcript',
  );
  @override
  late final GeneratedColumn<String> transcript = GeneratedColumn<String>(
    'transcript',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    eventId,
    filePath,
    durationMs,
    transcript,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'voice_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<VoiceNoteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMsMeta);
    }
    if (data.containsKey('transcript')) {
      context.handle(
        _transcriptMeta,
        transcript.isAcceptableOrUnknown(data['transcript']!, _transcriptMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VoiceNoteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VoiceNoteRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      )!,
      transcript: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transcript'],
      ),
    );
  }

  @override
  $VoiceNotesTable createAlias(String alias) {
    return $VoiceNotesTable(attachedDatabase, alias);
  }
}

class VoiceNoteRow extends DataClass implements Insertable<VoiceNoteRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String eventId;
  final String filePath;
  final int durationMs;
  final String? transcript;
  const VoiceNoteRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.eventId,
    required this.filePath,
    required this.durationMs,
    this.transcript,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    map['file_path'] = Variable<String>(filePath);
    map['duration_ms'] = Variable<int>(durationMs);
    if (!nullToAbsent || transcript != null) {
      map['transcript'] = Variable<String>(transcript);
    }
    return map;
  }

  VoiceNotesCompanion toCompanion(bool nullToAbsent) {
    return VoiceNotesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      eventId: Value(eventId),
      filePath: Value(filePath),
      durationMs: Value(durationMs),
      transcript: transcript == null && nullToAbsent
          ? const Value.absent()
          : Value(transcript),
    );
  }

  factory VoiceNoteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VoiceNoteRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      filePath: serializer.fromJson<String>(json['filePath']),
      durationMs: serializer.fromJson<int>(json['durationMs']),
      transcript: serializer.fromJson<String?>(json['transcript']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'filePath': serializer.toJson<String>(filePath),
      'durationMs': serializer.toJson<int>(durationMs),
      'transcript': serializer.toJson<String?>(transcript),
    };
  }

  VoiceNoteRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? eventId,
    String? filePath,
    int? durationMs,
    Value<String?> transcript = const Value.absent(),
  }) => VoiceNoteRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    filePath: filePath ?? this.filePath,
    durationMs: durationMs ?? this.durationMs,
    transcript: transcript.present ? transcript.value : this.transcript,
  );
  VoiceNoteRow copyWithCompanion(VoiceNotesCompanion data) {
    return VoiceNoteRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      transcript: data.transcript.present
          ? data.transcript.value
          : this.transcript,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VoiceNoteRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('filePath: $filePath, ')
          ..write('durationMs: $durationMs, ')
          ..write('transcript: $transcript')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    eventId,
    filePath,
    durationMs,
    transcript,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VoiceNoteRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.filePath == this.filePath &&
          other.durationMs == this.durationMs &&
          other.transcript == this.transcript);
}

class VoiceNotesCompanion extends UpdateCompanion<VoiceNoteRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> eventId;
  final Value<String> filePath;
  final Value<int> durationMs;
  final Value<String?> transcript;
  final Value<int> rowid;
  const VoiceNotesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.filePath = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.transcript = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VoiceNotesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String eventId,
    required String filePath,
    required int durationMs,
    this.transcript = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventId = Value(eventId),
       filePath = Value(filePath),
       durationMs = Value(durationMs);
  static Insertable<VoiceNoteRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<String>? filePath,
    Expression<int>? durationMs,
    Expression<String>? transcript,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (filePath != null) 'file_path': filePath,
      if (durationMs != null) 'duration_ms': durationMs,
      if (transcript != null) 'transcript': transcript,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VoiceNotesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? eventId,
    Value<String>? filePath,
    Value<int>? durationMs,
    Value<String?>? transcript,
    Value<int>? rowid,
  }) {
    return VoiceNotesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      filePath: filePath ?? this.filePath,
      durationMs: durationMs ?? this.durationMs,
      transcript: transcript ?? this.transcript,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (transcript.present) {
      map['transcript'] = Variable<String>(transcript.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VoiceNotesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('filePath: $filePath, ')
          ..write('durationMs: $durationMs, ')
          ..write('transcript: $transcript, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GraphNodesTable extends GraphNodes
    with TableInfo<$GraphNodesTable, GraphNodeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GraphNodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nodeTypeMeta = const VerificationMeta(
    'nodeType',
  );
  @override
  late final GeneratedColumn<String> nodeType = GeneratedColumn<String>(
    'node_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nodeType,
    entityId,
    label,
    metadataJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'graph_nodes';
  @override
  VerificationContext validateIntegrity(
    Insertable<GraphNodeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('node_type')) {
      context.handle(
        _nodeTypeMeta,
        nodeType.isAcceptableOrUnknown(data['node_type']!, _nodeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_nodeTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {nodeType, entityId},
  ];
  @override
  GraphNodeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GraphNodeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nodeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}node_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GraphNodesTable createAlias(String alias) {
    return $GraphNodesTable(attachedDatabase, alias);
  }
}

class GraphNodeRow extends DataClass implements Insertable<GraphNodeRow> {
  final String id;
  final String nodeType;
  final String entityId;
  final String label;
  final String metadataJson;
  final DateTime createdAt;
  const GraphNodeRow({
    required this.id,
    required this.nodeType,
    required this.entityId,
    required this.label,
    required this.metadataJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['node_type'] = Variable<String>(nodeType);
    map['entity_id'] = Variable<String>(entityId);
    map['label'] = Variable<String>(label);
    map['metadata_json'] = Variable<String>(metadataJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GraphNodesCompanion toCompanion(bool nullToAbsent) {
    return GraphNodesCompanion(
      id: Value(id),
      nodeType: Value(nodeType),
      entityId: Value(entityId),
      label: Value(label),
      metadataJson: Value(metadataJson),
      createdAt: Value(createdAt),
    );
  }

  factory GraphNodeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GraphNodeRow(
      id: serializer.fromJson<String>(json['id']),
      nodeType: serializer.fromJson<String>(json['nodeType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      label: serializer.fromJson<String>(json['label']),
      metadataJson: serializer.fromJson<String>(json['metadataJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nodeType': serializer.toJson<String>(nodeType),
      'entityId': serializer.toJson<String>(entityId),
      'label': serializer.toJson<String>(label),
      'metadataJson': serializer.toJson<String>(metadataJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GraphNodeRow copyWith({
    String? id,
    String? nodeType,
    String? entityId,
    String? label,
    String? metadataJson,
    DateTime? createdAt,
  }) => GraphNodeRow(
    id: id ?? this.id,
    nodeType: nodeType ?? this.nodeType,
    entityId: entityId ?? this.entityId,
    label: label ?? this.label,
    metadataJson: metadataJson ?? this.metadataJson,
    createdAt: createdAt ?? this.createdAt,
  );
  GraphNodeRow copyWithCompanion(GraphNodesCompanion data) {
    return GraphNodeRow(
      id: data.id.present ? data.id.value : this.id,
      nodeType: data.nodeType.present ? data.nodeType.value : this.nodeType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      label: data.label.present ? data.label.value : this.label,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GraphNodeRow(')
          ..write('id: $id, ')
          ..write('nodeType: $nodeType, ')
          ..write('entityId: $entityId, ')
          ..write('label: $label, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nodeType, entityId, label, metadataJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GraphNodeRow &&
          other.id == this.id &&
          other.nodeType == this.nodeType &&
          other.entityId == this.entityId &&
          other.label == this.label &&
          other.metadataJson == this.metadataJson &&
          other.createdAt == this.createdAt);
}

class GraphNodesCompanion extends UpdateCompanion<GraphNodeRow> {
  final Value<String> id;
  final Value<String> nodeType;
  final Value<String> entityId;
  final Value<String> label;
  final Value<String> metadataJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const GraphNodesCompanion({
    this.id = const Value.absent(),
    this.nodeType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.label = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GraphNodesCompanion.insert({
    required String id,
    required String nodeType,
    required String entityId,
    required String label,
    this.metadataJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nodeType = Value(nodeType),
       entityId = Value(entityId),
       label = Value(label);
  static Insertable<GraphNodeRow> custom({
    Expression<String>? id,
    Expression<String>? nodeType,
    Expression<String>? entityId,
    Expression<String>? label,
    Expression<String>? metadataJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nodeType != null) 'node_type': nodeType,
      if (entityId != null) 'entity_id': entityId,
      if (label != null) 'label': label,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GraphNodesCompanion copyWith({
    Value<String>? id,
    Value<String>? nodeType,
    Value<String>? entityId,
    Value<String>? label,
    Value<String>? metadataJson,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return GraphNodesCompanion(
      id: id ?? this.id,
      nodeType: nodeType ?? this.nodeType,
      entityId: entityId ?? this.entityId,
      label: label ?? this.label,
      metadataJson: metadataJson ?? this.metadataJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nodeType.present) {
      map['node_type'] = Variable<String>(nodeType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GraphNodesCompanion(')
          ..write('id: $id, ')
          ..write('nodeType: $nodeType, ')
          ..write('entityId: $entityId, ')
          ..write('label: $label, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GraphEdgesTable extends GraphEdges
    with TableInfo<$GraphEdgesTable, GraphEdgeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GraphEdgesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceNodeIdMeta = const VerificationMeta(
    'sourceNodeId',
  );
  @override
  late final GeneratedColumn<String> sourceNodeId = GeneratedColumn<String>(
    'source_node_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES graph_nodes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _targetNodeIdMeta = const VerificationMeta(
    'targetNodeId',
  );
  @override
  late final GeneratedColumn<String> targetNodeId = GeneratedColumn<String>(
    'target_node_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES graph_nodes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _relationTypeMeta = const VerificationMeta(
    'relationType',
  );
  @override
  late final GeneratedColumn<String> relationType = GeneratedColumn<String>(
    'relation_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceNodeId,
    targetNodeId,
    relationType,
    weight,
    metadataJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'graph_edges';
  @override
  VerificationContext validateIntegrity(
    Insertable<GraphEdgeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_node_id')) {
      context.handle(
        _sourceNodeIdMeta,
        sourceNodeId.isAcceptableOrUnknown(
          data['source_node_id']!,
          _sourceNodeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceNodeIdMeta);
    }
    if (data.containsKey('target_node_id')) {
      context.handle(
        _targetNodeIdMeta,
        targetNodeId.isAcceptableOrUnknown(
          data['target_node_id']!,
          _targetNodeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetNodeIdMeta);
    }
    if (data.containsKey('relation_type')) {
      context.handle(
        _relationTypeMeta,
        relationType.isAcceptableOrUnknown(
          data['relation_type']!,
          _relationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relationTypeMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {sourceNodeId, targetNodeId, relationType},
  ];
  @override
  GraphEdgeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GraphEdgeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sourceNodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_node_id'],
      )!,
      targetNodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_node_id'],
      )!,
      relationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relation_type'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GraphEdgesTable createAlias(String alias) {
    return $GraphEdgesTable(attachedDatabase, alias);
  }
}

class GraphEdgeRow extends DataClass implements Insertable<GraphEdgeRow> {
  final String id;
  final String sourceNodeId;
  final String targetNodeId;
  final String relationType;
  final double weight;
  final String metadataJson;
  final DateTime createdAt;
  const GraphEdgeRow({
    required this.id,
    required this.sourceNodeId,
    required this.targetNodeId,
    required this.relationType,
    required this.weight,
    required this.metadataJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source_node_id'] = Variable<String>(sourceNodeId);
    map['target_node_id'] = Variable<String>(targetNodeId);
    map['relation_type'] = Variable<String>(relationType);
    map['weight'] = Variable<double>(weight);
    map['metadata_json'] = Variable<String>(metadataJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GraphEdgesCompanion toCompanion(bool nullToAbsent) {
    return GraphEdgesCompanion(
      id: Value(id),
      sourceNodeId: Value(sourceNodeId),
      targetNodeId: Value(targetNodeId),
      relationType: Value(relationType),
      weight: Value(weight),
      metadataJson: Value(metadataJson),
      createdAt: Value(createdAt),
    );
  }

  factory GraphEdgeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GraphEdgeRow(
      id: serializer.fromJson<String>(json['id']),
      sourceNodeId: serializer.fromJson<String>(json['sourceNodeId']),
      targetNodeId: serializer.fromJson<String>(json['targetNodeId']),
      relationType: serializer.fromJson<String>(json['relationType']),
      weight: serializer.fromJson<double>(json['weight']),
      metadataJson: serializer.fromJson<String>(json['metadataJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sourceNodeId': serializer.toJson<String>(sourceNodeId),
      'targetNodeId': serializer.toJson<String>(targetNodeId),
      'relationType': serializer.toJson<String>(relationType),
      'weight': serializer.toJson<double>(weight),
      'metadataJson': serializer.toJson<String>(metadataJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GraphEdgeRow copyWith({
    String? id,
    String? sourceNodeId,
    String? targetNodeId,
    String? relationType,
    double? weight,
    String? metadataJson,
    DateTime? createdAt,
  }) => GraphEdgeRow(
    id: id ?? this.id,
    sourceNodeId: sourceNodeId ?? this.sourceNodeId,
    targetNodeId: targetNodeId ?? this.targetNodeId,
    relationType: relationType ?? this.relationType,
    weight: weight ?? this.weight,
    metadataJson: metadataJson ?? this.metadataJson,
    createdAt: createdAt ?? this.createdAt,
  );
  GraphEdgeRow copyWithCompanion(GraphEdgesCompanion data) {
    return GraphEdgeRow(
      id: data.id.present ? data.id.value : this.id,
      sourceNodeId: data.sourceNodeId.present
          ? data.sourceNodeId.value
          : this.sourceNodeId,
      targetNodeId: data.targetNodeId.present
          ? data.targetNodeId.value
          : this.targetNodeId,
      relationType: data.relationType.present
          ? data.relationType.value
          : this.relationType,
      weight: data.weight.present ? data.weight.value : this.weight,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GraphEdgeRow(')
          ..write('id: $id, ')
          ..write('sourceNodeId: $sourceNodeId, ')
          ..write('targetNodeId: $targetNodeId, ')
          ..write('relationType: $relationType, ')
          ..write('weight: $weight, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceNodeId,
    targetNodeId,
    relationType,
    weight,
    metadataJson,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GraphEdgeRow &&
          other.id == this.id &&
          other.sourceNodeId == this.sourceNodeId &&
          other.targetNodeId == this.targetNodeId &&
          other.relationType == this.relationType &&
          other.weight == this.weight &&
          other.metadataJson == this.metadataJson &&
          other.createdAt == this.createdAt);
}

class GraphEdgesCompanion extends UpdateCompanion<GraphEdgeRow> {
  final Value<String> id;
  final Value<String> sourceNodeId;
  final Value<String> targetNodeId;
  final Value<String> relationType;
  final Value<double> weight;
  final Value<String> metadataJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const GraphEdgesCompanion({
    this.id = const Value.absent(),
    this.sourceNodeId = const Value.absent(),
    this.targetNodeId = const Value.absent(),
    this.relationType = const Value.absent(),
    this.weight = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GraphEdgesCompanion.insert({
    required String id,
    required String sourceNodeId,
    required String targetNodeId,
    required String relationType,
    this.weight = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sourceNodeId = Value(sourceNodeId),
       targetNodeId = Value(targetNodeId),
       relationType = Value(relationType);
  static Insertable<GraphEdgeRow> custom({
    Expression<String>? id,
    Expression<String>? sourceNodeId,
    Expression<String>? targetNodeId,
    Expression<String>? relationType,
    Expression<double>? weight,
    Expression<String>? metadataJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceNodeId != null) 'source_node_id': sourceNodeId,
      if (targetNodeId != null) 'target_node_id': targetNodeId,
      if (relationType != null) 'relation_type': relationType,
      if (weight != null) 'weight': weight,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GraphEdgesCompanion copyWith({
    Value<String>? id,
    Value<String>? sourceNodeId,
    Value<String>? targetNodeId,
    Value<String>? relationType,
    Value<double>? weight,
    Value<String>? metadataJson,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return GraphEdgesCompanion(
      id: id ?? this.id,
      sourceNodeId: sourceNodeId ?? this.sourceNodeId,
      targetNodeId: targetNodeId ?? this.targetNodeId,
      relationType: relationType ?? this.relationType,
      weight: weight ?? this.weight,
      metadataJson: metadataJson ?? this.metadataJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sourceNodeId.present) {
      map['source_node_id'] = Variable<String>(sourceNodeId.value);
    }
    if (targetNodeId.present) {
      map['target_node_id'] = Variable<String>(targetNodeId.value);
    }
    if (relationType.present) {
      map['relation_type'] = Variable<String>(relationType.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GraphEdgesCompanion(')
          ..write('id: $id, ')
          ..write('sourceNodeId: $sourceNodeId, ')
          ..write('targetNodeId: $targetNodeId, ')
          ..write('relationType: $relationType, ')
          ..write('weight: $weight, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SignificanceScoresTable extends SignificanceScores
    with TableInfo<$SignificanceScoresTable, SignificanceScoreRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SignificanceScoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _factorsJsonMeta = const VerificationMeta(
    'factorsJson',
  );
  @override
  late final GeneratedColumn<String> factorsJson = GeneratedColumn<String>(
    'factors_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _algorithmVersionMeta = const VerificationMeta(
    'algorithmVersion',
  );
  @override
  late final GeneratedColumn<String> algorithmVersion = GeneratedColumn<String>(
    'algorithm_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isIllustrativeMeta = const VerificationMeta(
    'isIllustrative',
  );
  @override
  late final GeneratedColumn<bool> isIllustrative = GeneratedColumn<bool>(
    'is_illustrative',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_illustrative" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _evaluatedAtMeta = const VerificationMeta(
    'evaluatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> evaluatedAt = GeneratedColumn<DateTime>(
    'evaluated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    score,
    factorsJson,
    algorithmVersion,
    isIllustrative,
    evaluatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'significance_scores';
  @override
  VerificationContext validateIntegrity(
    Insertable<SignificanceScoreRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('factors_json')) {
      context.handle(
        _factorsJsonMeta,
        factorsJson.isAcceptableOrUnknown(
          data['factors_json']!,
          _factorsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_factorsJsonMeta);
    }
    if (data.containsKey('algorithm_version')) {
      context.handle(
        _algorithmVersionMeta,
        algorithmVersion.isAcceptableOrUnknown(
          data['algorithm_version']!,
          _algorithmVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_algorithmVersionMeta);
    }
    if (data.containsKey('is_illustrative')) {
      context.handle(
        _isIllustrativeMeta,
        isIllustrative.isAcceptableOrUnknown(
          data['is_illustrative']!,
          _isIllustrativeMeta,
        ),
      );
    }
    if (data.containsKey('evaluated_at')) {
      context.handle(
        _evaluatedAtMeta,
        evaluatedAt.isAcceptableOrUnknown(
          data['evaluated_at']!,
          _evaluatedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SignificanceScoreRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SignificanceScoreRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      )!,
      factorsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}factors_json'],
      )!,
      algorithmVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}algorithm_version'],
      )!,
      isIllustrative: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_illustrative'],
      )!,
      evaluatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}evaluated_at'],
      )!,
    );
  }

  @override
  $SignificanceScoresTable createAlias(String alias) {
    return $SignificanceScoresTable(attachedDatabase, alias);
  }
}

class SignificanceScoreRow extends DataClass
    implements Insertable<SignificanceScoreRow> {
  final String id;
  final String eventId;
  final double score;
  final String factorsJson;
  final String algorithmVersion;
  final bool isIllustrative;
  final DateTime evaluatedAt;
  const SignificanceScoreRow({
    required this.id,
    required this.eventId,
    required this.score,
    required this.factorsJson,
    required this.algorithmVersion,
    required this.isIllustrative,
    required this.evaluatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    map['score'] = Variable<double>(score);
    map['factors_json'] = Variable<String>(factorsJson);
    map['algorithm_version'] = Variable<String>(algorithmVersion);
    map['is_illustrative'] = Variable<bool>(isIllustrative);
    map['evaluated_at'] = Variable<DateTime>(evaluatedAt);
    return map;
  }

  SignificanceScoresCompanion toCompanion(bool nullToAbsent) {
    return SignificanceScoresCompanion(
      id: Value(id),
      eventId: Value(eventId),
      score: Value(score),
      factorsJson: Value(factorsJson),
      algorithmVersion: Value(algorithmVersion),
      isIllustrative: Value(isIllustrative),
      evaluatedAt: Value(evaluatedAt),
    );
  }

  factory SignificanceScoreRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SignificanceScoreRow(
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      score: serializer.fromJson<double>(json['score']),
      factorsJson: serializer.fromJson<String>(json['factorsJson']),
      algorithmVersion: serializer.fromJson<String>(json['algorithmVersion']),
      isIllustrative: serializer.fromJson<bool>(json['isIllustrative']),
      evaluatedAt: serializer.fromJson<DateTime>(json['evaluatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'score': serializer.toJson<double>(score),
      'factorsJson': serializer.toJson<String>(factorsJson),
      'algorithmVersion': serializer.toJson<String>(algorithmVersion),
      'isIllustrative': serializer.toJson<bool>(isIllustrative),
      'evaluatedAt': serializer.toJson<DateTime>(evaluatedAt),
    };
  }

  SignificanceScoreRow copyWith({
    String? id,
    String? eventId,
    double? score,
    String? factorsJson,
    String? algorithmVersion,
    bool? isIllustrative,
    DateTime? evaluatedAt,
  }) => SignificanceScoreRow(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    score: score ?? this.score,
    factorsJson: factorsJson ?? this.factorsJson,
    algorithmVersion: algorithmVersion ?? this.algorithmVersion,
    isIllustrative: isIllustrative ?? this.isIllustrative,
    evaluatedAt: evaluatedAt ?? this.evaluatedAt,
  );
  SignificanceScoreRow copyWithCompanion(SignificanceScoresCompanion data) {
    return SignificanceScoreRow(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      score: data.score.present ? data.score.value : this.score,
      factorsJson: data.factorsJson.present
          ? data.factorsJson.value
          : this.factorsJson,
      algorithmVersion: data.algorithmVersion.present
          ? data.algorithmVersion.value
          : this.algorithmVersion,
      isIllustrative: data.isIllustrative.present
          ? data.isIllustrative.value
          : this.isIllustrative,
      evaluatedAt: data.evaluatedAt.present
          ? data.evaluatedAt.value
          : this.evaluatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SignificanceScoreRow(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('score: $score, ')
          ..write('factorsJson: $factorsJson, ')
          ..write('algorithmVersion: $algorithmVersion, ')
          ..write('isIllustrative: $isIllustrative, ')
          ..write('evaluatedAt: $evaluatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventId,
    score,
    factorsJson,
    algorithmVersion,
    isIllustrative,
    evaluatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignificanceScoreRow &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.score == this.score &&
          other.factorsJson == this.factorsJson &&
          other.algorithmVersion == this.algorithmVersion &&
          other.isIllustrative == this.isIllustrative &&
          other.evaluatedAt == this.evaluatedAt);
}

class SignificanceScoresCompanion
    extends UpdateCompanion<SignificanceScoreRow> {
  final Value<String> id;
  final Value<String> eventId;
  final Value<double> score;
  final Value<String> factorsJson;
  final Value<String> algorithmVersion;
  final Value<bool> isIllustrative;
  final Value<DateTime> evaluatedAt;
  final Value<int> rowid;
  const SignificanceScoresCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.score = const Value.absent(),
    this.factorsJson = const Value.absent(),
    this.algorithmVersion = const Value.absent(),
    this.isIllustrative = const Value.absent(),
    this.evaluatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SignificanceScoresCompanion.insert({
    required String id,
    required String eventId,
    required double score,
    required String factorsJson,
    required String algorithmVersion,
    this.isIllustrative = const Value.absent(),
    this.evaluatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventId = Value(eventId),
       score = Value(score),
       factorsJson = Value(factorsJson),
       algorithmVersion = Value(algorithmVersion);
  static Insertable<SignificanceScoreRow> custom({
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<double>? score,
    Expression<String>? factorsJson,
    Expression<String>? algorithmVersion,
    Expression<bool>? isIllustrative,
    Expression<DateTime>? evaluatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (score != null) 'score': score,
      if (factorsJson != null) 'factors_json': factorsJson,
      if (algorithmVersion != null) 'algorithm_version': algorithmVersion,
      if (isIllustrative != null) 'is_illustrative': isIllustrative,
      if (evaluatedAt != null) 'evaluated_at': evaluatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SignificanceScoresCompanion copyWith({
    Value<String>? id,
    Value<String>? eventId,
    Value<double>? score,
    Value<String>? factorsJson,
    Value<String>? algorithmVersion,
    Value<bool>? isIllustrative,
    Value<DateTime>? evaluatedAt,
    Value<int>? rowid,
  }) {
    return SignificanceScoresCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      score: score ?? this.score,
      factorsJson: factorsJson ?? this.factorsJson,
      algorithmVersion: algorithmVersion ?? this.algorithmVersion,
      isIllustrative: isIllustrative ?? this.isIllustrative,
      evaluatedAt: evaluatedAt ?? this.evaluatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (factorsJson.present) {
      map['factors_json'] = Variable<String>(factorsJson.value);
    }
    if (algorithmVersion.present) {
      map['algorithm_version'] = Variable<String>(algorithmVersion.value);
    }
    if (isIllustrative.present) {
      map['is_illustrative'] = Variable<bool>(isIllustrative.value);
    }
    if (evaluatedAt.present) {
      map['evaluated_at'] = Variable<DateTime>(evaluatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SignificanceScoresCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('score: $score, ')
          ..write('factorsJson: $factorsJson, ')
          ..write('algorithmVersion: $algorithmVersion, ')
          ..write('isIllustrative: $isIllustrative, ')
          ..write('evaluatedAt: $evaluatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RediscoveryScoresTable extends RediscoveryScores
    with TableInfo<$RediscoveryScoresTable, RediscoveryScoreRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RediscoveryScoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _factorsJsonMeta = const VerificationMeta(
    'factorsJson',
  );
  @override
  late final GeneratedColumn<String> factorsJson = GeneratedColumn<String>(
    'factors_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _algorithmVersionMeta = const VerificationMeta(
    'algorithmVersion',
  );
  @override
  late final GeneratedColumn<String> algorithmVersion = GeneratedColumn<String>(
    'algorithm_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isIllustrativeMeta = const VerificationMeta(
    'isIllustrative',
  );
  @override
  late final GeneratedColumn<bool> isIllustrative = GeneratedColumn<bool>(
    'is_illustrative',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_illustrative" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _evaluatedAtMeta = const VerificationMeta(
    'evaluatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> evaluatedAt = GeneratedColumn<DateTime>(
    'evaluated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    score,
    factorsJson,
    algorithmVersion,
    isIllustrative,
    evaluatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rediscovery_scores';
  @override
  VerificationContext validateIntegrity(
    Insertable<RediscoveryScoreRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('factors_json')) {
      context.handle(
        _factorsJsonMeta,
        factorsJson.isAcceptableOrUnknown(
          data['factors_json']!,
          _factorsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_factorsJsonMeta);
    }
    if (data.containsKey('algorithm_version')) {
      context.handle(
        _algorithmVersionMeta,
        algorithmVersion.isAcceptableOrUnknown(
          data['algorithm_version']!,
          _algorithmVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_algorithmVersionMeta);
    }
    if (data.containsKey('is_illustrative')) {
      context.handle(
        _isIllustrativeMeta,
        isIllustrative.isAcceptableOrUnknown(
          data['is_illustrative']!,
          _isIllustrativeMeta,
        ),
      );
    }
    if (data.containsKey('evaluated_at')) {
      context.handle(
        _evaluatedAtMeta,
        evaluatedAt.isAcceptableOrUnknown(
          data['evaluated_at']!,
          _evaluatedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RediscoveryScoreRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RediscoveryScoreRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      )!,
      factorsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}factors_json'],
      )!,
      algorithmVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}algorithm_version'],
      )!,
      isIllustrative: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_illustrative'],
      )!,
      evaluatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}evaluated_at'],
      )!,
    );
  }

  @override
  $RediscoveryScoresTable createAlias(String alias) {
    return $RediscoveryScoresTable(attachedDatabase, alias);
  }
}

class RediscoveryScoreRow extends DataClass
    implements Insertable<RediscoveryScoreRow> {
  final String id;
  final String eventId;
  final double score;
  final String factorsJson;
  final String algorithmVersion;
  final bool isIllustrative;
  final DateTime evaluatedAt;
  const RediscoveryScoreRow({
    required this.id,
    required this.eventId,
    required this.score,
    required this.factorsJson,
    required this.algorithmVersion,
    required this.isIllustrative,
    required this.evaluatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    map['score'] = Variable<double>(score);
    map['factors_json'] = Variable<String>(factorsJson);
    map['algorithm_version'] = Variable<String>(algorithmVersion);
    map['is_illustrative'] = Variable<bool>(isIllustrative);
    map['evaluated_at'] = Variable<DateTime>(evaluatedAt);
    return map;
  }

  RediscoveryScoresCompanion toCompanion(bool nullToAbsent) {
    return RediscoveryScoresCompanion(
      id: Value(id),
      eventId: Value(eventId),
      score: Value(score),
      factorsJson: Value(factorsJson),
      algorithmVersion: Value(algorithmVersion),
      isIllustrative: Value(isIllustrative),
      evaluatedAt: Value(evaluatedAt),
    );
  }

  factory RediscoveryScoreRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RediscoveryScoreRow(
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      score: serializer.fromJson<double>(json['score']),
      factorsJson: serializer.fromJson<String>(json['factorsJson']),
      algorithmVersion: serializer.fromJson<String>(json['algorithmVersion']),
      isIllustrative: serializer.fromJson<bool>(json['isIllustrative']),
      evaluatedAt: serializer.fromJson<DateTime>(json['evaluatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'score': serializer.toJson<double>(score),
      'factorsJson': serializer.toJson<String>(factorsJson),
      'algorithmVersion': serializer.toJson<String>(algorithmVersion),
      'isIllustrative': serializer.toJson<bool>(isIllustrative),
      'evaluatedAt': serializer.toJson<DateTime>(evaluatedAt),
    };
  }

  RediscoveryScoreRow copyWith({
    String? id,
    String? eventId,
    double? score,
    String? factorsJson,
    String? algorithmVersion,
    bool? isIllustrative,
    DateTime? evaluatedAt,
  }) => RediscoveryScoreRow(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    score: score ?? this.score,
    factorsJson: factorsJson ?? this.factorsJson,
    algorithmVersion: algorithmVersion ?? this.algorithmVersion,
    isIllustrative: isIllustrative ?? this.isIllustrative,
    evaluatedAt: evaluatedAt ?? this.evaluatedAt,
  );
  RediscoveryScoreRow copyWithCompanion(RediscoveryScoresCompanion data) {
    return RediscoveryScoreRow(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      score: data.score.present ? data.score.value : this.score,
      factorsJson: data.factorsJson.present
          ? data.factorsJson.value
          : this.factorsJson,
      algorithmVersion: data.algorithmVersion.present
          ? data.algorithmVersion.value
          : this.algorithmVersion,
      isIllustrative: data.isIllustrative.present
          ? data.isIllustrative.value
          : this.isIllustrative,
      evaluatedAt: data.evaluatedAt.present
          ? data.evaluatedAt.value
          : this.evaluatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RediscoveryScoreRow(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('score: $score, ')
          ..write('factorsJson: $factorsJson, ')
          ..write('algorithmVersion: $algorithmVersion, ')
          ..write('isIllustrative: $isIllustrative, ')
          ..write('evaluatedAt: $evaluatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventId,
    score,
    factorsJson,
    algorithmVersion,
    isIllustrative,
    evaluatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RediscoveryScoreRow &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.score == this.score &&
          other.factorsJson == this.factorsJson &&
          other.algorithmVersion == this.algorithmVersion &&
          other.isIllustrative == this.isIllustrative &&
          other.evaluatedAt == this.evaluatedAt);
}

class RediscoveryScoresCompanion extends UpdateCompanion<RediscoveryScoreRow> {
  final Value<String> id;
  final Value<String> eventId;
  final Value<double> score;
  final Value<String> factorsJson;
  final Value<String> algorithmVersion;
  final Value<bool> isIllustrative;
  final Value<DateTime> evaluatedAt;
  final Value<int> rowid;
  const RediscoveryScoresCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.score = const Value.absent(),
    this.factorsJson = const Value.absent(),
    this.algorithmVersion = const Value.absent(),
    this.isIllustrative = const Value.absent(),
    this.evaluatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RediscoveryScoresCompanion.insert({
    required String id,
    required String eventId,
    required double score,
    required String factorsJson,
    required String algorithmVersion,
    this.isIllustrative = const Value.absent(),
    this.evaluatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventId = Value(eventId),
       score = Value(score),
       factorsJson = Value(factorsJson),
       algorithmVersion = Value(algorithmVersion);
  static Insertable<RediscoveryScoreRow> custom({
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<double>? score,
    Expression<String>? factorsJson,
    Expression<String>? algorithmVersion,
    Expression<bool>? isIllustrative,
    Expression<DateTime>? evaluatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (score != null) 'score': score,
      if (factorsJson != null) 'factors_json': factorsJson,
      if (algorithmVersion != null) 'algorithm_version': algorithmVersion,
      if (isIllustrative != null) 'is_illustrative': isIllustrative,
      if (evaluatedAt != null) 'evaluated_at': evaluatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RediscoveryScoresCompanion copyWith({
    Value<String>? id,
    Value<String>? eventId,
    Value<double>? score,
    Value<String>? factorsJson,
    Value<String>? algorithmVersion,
    Value<bool>? isIllustrative,
    Value<DateTime>? evaluatedAt,
    Value<int>? rowid,
  }) {
    return RediscoveryScoresCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      score: score ?? this.score,
      factorsJson: factorsJson ?? this.factorsJson,
      algorithmVersion: algorithmVersion ?? this.algorithmVersion,
      isIllustrative: isIllustrative ?? this.isIllustrative,
      evaluatedAt: evaluatedAt ?? this.evaluatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (factorsJson.present) {
      map['factors_json'] = Variable<String>(factorsJson.value);
    }
    if (algorithmVersion.present) {
      map['algorithm_version'] = Variable<String>(algorithmVersion.value);
    }
    if (isIllustrative.present) {
      map['is_illustrative'] = Variable<bool>(isIllustrative.value);
    }
    if (evaluatedAt.present) {
      map['evaluated_at'] = Variable<DateTime>(evaluatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RediscoveryScoresCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('score: $score, ')
          ..write('factorsJson: $factorsJson, ')
          ..write('algorithmVersion: $algorithmVersion, ')
          ..write('isIllustrative: $isIllustrative, ')
          ..write('evaluatedAt: $evaluatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContextScoresTable extends ContextScores
    with TableInfo<$ContextScoresTable, ContextScoreRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContextScoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _factorsJsonMeta = const VerificationMeta(
    'factorsJson',
  );
  @override
  late final GeneratedColumn<String> factorsJson = GeneratedColumn<String>(
    'factors_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _algorithmVersionMeta = const VerificationMeta(
    'algorithmVersion',
  );
  @override
  late final GeneratedColumn<String> algorithmVersion = GeneratedColumn<String>(
    'algorithm_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isIllustrativeMeta = const VerificationMeta(
    'isIllustrative',
  );
  @override
  late final GeneratedColumn<bool> isIllustrative = GeneratedColumn<bool>(
    'is_illustrative',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_illustrative" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _evaluatedAtMeta = const VerificationMeta(
    'evaluatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> evaluatedAt = GeneratedColumn<DateTime>(
    'evaluated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    score,
    factorsJson,
    algorithmVersion,
    isIllustrative,
    evaluatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'context_scores';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContextScoreRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('factors_json')) {
      context.handle(
        _factorsJsonMeta,
        factorsJson.isAcceptableOrUnknown(
          data['factors_json']!,
          _factorsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_factorsJsonMeta);
    }
    if (data.containsKey('algorithm_version')) {
      context.handle(
        _algorithmVersionMeta,
        algorithmVersion.isAcceptableOrUnknown(
          data['algorithm_version']!,
          _algorithmVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_algorithmVersionMeta);
    }
    if (data.containsKey('is_illustrative')) {
      context.handle(
        _isIllustrativeMeta,
        isIllustrative.isAcceptableOrUnknown(
          data['is_illustrative']!,
          _isIllustrativeMeta,
        ),
      );
    }
    if (data.containsKey('evaluated_at')) {
      context.handle(
        _evaluatedAtMeta,
        evaluatedAt.isAcceptableOrUnknown(
          data['evaluated_at']!,
          _evaluatedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContextScoreRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContextScoreRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      )!,
      factorsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}factors_json'],
      )!,
      algorithmVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}algorithm_version'],
      )!,
      isIllustrative: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_illustrative'],
      )!,
      evaluatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}evaluated_at'],
      )!,
    );
  }

  @override
  $ContextScoresTable createAlias(String alias) {
    return $ContextScoresTable(attachedDatabase, alias);
  }
}

class ContextScoreRow extends DataClass implements Insertable<ContextScoreRow> {
  final String id;
  final String eventId;
  final double score;
  final String factorsJson;
  final String algorithmVersion;
  final bool isIllustrative;
  final DateTime evaluatedAt;
  const ContextScoreRow({
    required this.id,
    required this.eventId,
    required this.score,
    required this.factorsJson,
    required this.algorithmVersion,
    required this.isIllustrative,
    required this.evaluatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    map['score'] = Variable<double>(score);
    map['factors_json'] = Variable<String>(factorsJson);
    map['algorithm_version'] = Variable<String>(algorithmVersion);
    map['is_illustrative'] = Variable<bool>(isIllustrative);
    map['evaluated_at'] = Variable<DateTime>(evaluatedAt);
    return map;
  }

  ContextScoresCompanion toCompanion(bool nullToAbsent) {
    return ContextScoresCompanion(
      id: Value(id),
      eventId: Value(eventId),
      score: Value(score),
      factorsJson: Value(factorsJson),
      algorithmVersion: Value(algorithmVersion),
      isIllustrative: Value(isIllustrative),
      evaluatedAt: Value(evaluatedAt),
    );
  }

  factory ContextScoreRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContextScoreRow(
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      score: serializer.fromJson<double>(json['score']),
      factorsJson: serializer.fromJson<String>(json['factorsJson']),
      algorithmVersion: serializer.fromJson<String>(json['algorithmVersion']),
      isIllustrative: serializer.fromJson<bool>(json['isIllustrative']),
      evaluatedAt: serializer.fromJson<DateTime>(json['evaluatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'score': serializer.toJson<double>(score),
      'factorsJson': serializer.toJson<String>(factorsJson),
      'algorithmVersion': serializer.toJson<String>(algorithmVersion),
      'isIllustrative': serializer.toJson<bool>(isIllustrative),
      'evaluatedAt': serializer.toJson<DateTime>(evaluatedAt),
    };
  }

  ContextScoreRow copyWith({
    String? id,
    String? eventId,
    double? score,
    String? factorsJson,
    String? algorithmVersion,
    bool? isIllustrative,
    DateTime? evaluatedAt,
  }) => ContextScoreRow(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    score: score ?? this.score,
    factorsJson: factorsJson ?? this.factorsJson,
    algorithmVersion: algorithmVersion ?? this.algorithmVersion,
    isIllustrative: isIllustrative ?? this.isIllustrative,
    evaluatedAt: evaluatedAt ?? this.evaluatedAt,
  );
  ContextScoreRow copyWithCompanion(ContextScoresCompanion data) {
    return ContextScoreRow(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      score: data.score.present ? data.score.value : this.score,
      factorsJson: data.factorsJson.present
          ? data.factorsJson.value
          : this.factorsJson,
      algorithmVersion: data.algorithmVersion.present
          ? data.algorithmVersion.value
          : this.algorithmVersion,
      isIllustrative: data.isIllustrative.present
          ? data.isIllustrative.value
          : this.isIllustrative,
      evaluatedAt: data.evaluatedAt.present
          ? data.evaluatedAt.value
          : this.evaluatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContextScoreRow(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('score: $score, ')
          ..write('factorsJson: $factorsJson, ')
          ..write('algorithmVersion: $algorithmVersion, ')
          ..write('isIllustrative: $isIllustrative, ')
          ..write('evaluatedAt: $evaluatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventId,
    score,
    factorsJson,
    algorithmVersion,
    isIllustrative,
    evaluatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContextScoreRow &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.score == this.score &&
          other.factorsJson == this.factorsJson &&
          other.algorithmVersion == this.algorithmVersion &&
          other.isIllustrative == this.isIllustrative &&
          other.evaluatedAt == this.evaluatedAt);
}

class ContextScoresCompanion extends UpdateCompanion<ContextScoreRow> {
  final Value<String> id;
  final Value<String> eventId;
  final Value<double> score;
  final Value<String> factorsJson;
  final Value<String> algorithmVersion;
  final Value<bool> isIllustrative;
  final Value<DateTime> evaluatedAt;
  final Value<int> rowid;
  const ContextScoresCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.score = const Value.absent(),
    this.factorsJson = const Value.absent(),
    this.algorithmVersion = const Value.absent(),
    this.isIllustrative = const Value.absent(),
    this.evaluatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContextScoresCompanion.insert({
    required String id,
    required String eventId,
    required double score,
    required String factorsJson,
    required String algorithmVersion,
    this.isIllustrative = const Value.absent(),
    this.evaluatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventId = Value(eventId),
       score = Value(score),
       factorsJson = Value(factorsJson),
       algorithmVersion = Value(algorithmVersion);
  static Insertable<ContextScoreRow> custom({
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<double>? score,
    Expression<String>? factorsJson,
    Expression<String>? algorithmVersion,
    Expression<bool>? isIllustrative,
    Expression<DateTime>? evaluatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (score != null) 'score': score,
      if (factorsJson != null) 'factors_json': factorsJson,
      if (algorithmVersion != null) 'algorithm_version': algorithmVersion,
      if (isIllustrative != null) 'is_illustrative': isIllustrative,
      if (evaluatedAt != null) 'evaluated_at': evaluatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContextScoresCompanion copyWith({
    Value<String>? id,
    Value<String>? eventId,
    Value<double>? score,
    Value<String>? factorsJson,
    Value<String>? algorithmVersion,
    Value<bool>? isIllustrative,
    Value<DateTime>? evaluatedAt,
    Value<int>? rowid,
  }) {
    return ContextScoresCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      score: score ?? this.score,
      factorsJson: factorsJson ?? this.factorsJson,
      algorithmVersion: algorithmVersion ?? this.algorithmVersion,
      isIllustrative: isIllustrative ?? this.isIllustrative,
      evaluatedAt: evaluatedAt ?? this.evaluatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (factorsJson.present) {
      map['factors_json'] = Variable<String>(factorsJson.value);
    }
    if (algorithmVersion.present) {
      map['algorithm_version'] = Variable<String>(algorithmVersion.value);
    }
    if (isIllustrative.present) {
      map['is_illustrative'] = Variable<bool>(isIllustrative.value);
    }
    if (evaluatedAt.present) {
      map['evaluated_at'] = Variable<DateTime>(evaluatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContextScoresCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('score: $score, ')
          ..write('factorsJson: $factorsJson, ')
          ..write('algorithmVersion: $algorithmVersion, ')
          ..write('isIllustrative: $isIllustrative, ')
          ..write('evaluatedAt: $evaluatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PreservationRecommendationsTable extends PreservationRecommendations
    with
        TableInfo<
          $PreservationRecommendationsTable,
          PreservationRecommendationRow
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreservationRecommendationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _recommendationTypeMeta =
      const VerificationMeta('recommendationType');
  @override
  late final GeneratedColumn<String> recommendationType =
      GeneratedColumn<String>(
        'recommendation_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _explanationMeta = const VerificationMeta(
    'explanation',
  );
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
    'explanation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proposedActionMeta = const VerificationMeta(
    'proposedAction',
  );
  @override
  late final GeneratedColumn<String> proposedAction = GeneratedColumn<String>(
    'proposed_action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionPayloadJsonMeta = const VerificationMeta(
    'actionPayloadJson',
  );
  @override
  late final GeneratedColumn<String> actionPayloadJson =
      GeneratedColumn<String>(
        'action_payload_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  static const VerificationMeta _preservationNeedMeta = const VerificationMeta(
    'preservationNeed',
  );
  @override
  late final GeneratedColumn<double> preservationNeed = GeneratedColumn<double>(
    'preservation_need',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sensitivityAtCreationMeta =
      const VerificationMeta('sensitivityAtCreation');
  @override
  late final GeneratedColumn<double> sensitivityAtCreation =
      GeneratedColumn<double>(
        'sensitivity_at_creation',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _isSafeForNotificationMeta =
      const VerificationMeta('isSafeForNotification');
  @override
  late final GeneratedColumn<bool> isSafeForNotification =
      GeneratedColumn<bool>(
        'is_safe_for_notification',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_safe_for_notification" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _actedAtMeta = const VerificationMeta(
    'actedAt',
  );
  @override
  late final GeneratedColumn<DateTime> actedAt = GeneratedColumn<DateTime>(
    'acted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dismissedAtMeta = const VerificationMeta(
    'dismissedAt',
  );
  @override
  late final GeneratedColumn<DateTime> dismissedAt = GeneratedColumn<DateTime>(
    'dismissed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    eventId,
    recommendationType,
    explanation,
    proposedAction,
    actionPayloadJson,
    preservationNeed,
    sensitivityAtCreation,
    isSafeForNotification,
    status,
    actedAt,
    dismissedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'preservation_recommendations';
  @override
  VerificationContext validateIntegrity(
    Insertable<PreservationRecommendationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('recommendation_type')) {
      context.handle(
        _recommendationTypeMeta,
        recommendationType.isAcceptableOrUnknown(
          data['recommendation_type']!,
          _recommendationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recommendationTypeMeta);
    }
    if (data.containsKey('explanation')) {
      context.handle(
        _explanationMeta,
        explanation.isAcceptableOrUnknown(
          data['explanation']!,
          _explanationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_explanationMeta);
    }
    if (data.containsKey('proposed_action')) {
      context.handle(
        _proposedActionMeta,
        proposedAction.isAcceptableOrUnknown(
          data['proposed_action']!,
          _proposedActionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proposedActionMeta);
    }
    if (data.containsKey('action_payload_json')) {
      context.handle(
        _actionPayloadJsonMeta,
        actionPayloadJson.isAcceptableOrUnknown(
          data['action_payload_json']!,
          _actionPayloadJsonMeta,
        ),
      );
    }
    if (data.containsKey('preservation_need')) {
      context.handle(
        _preservationNeedMeta,
        preservationNeed.isAcceptableOrUnknown(
          data['preservation_need']!,
          _preservationNeedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_preservationNeedMeta);
    }
    if (data.containsKey('sensitivity_at_creation')) {
      context.handle(
        _sensitivityAtCreationMeta,
        sensitivityAtCreation.isAcceptableOrUnknown(
          data['sensitivity_at_creation']!,
          _sensitivityAtCreationMeta,
        ),
      );
    }
    if (data.containsKey('is_safe_for_notification')) {
      context.handle(
        _isSafeForNotificationMeta,
        isSafeForNotification.isAcceptableOrUnknown(
          data['is_safe_for_notification']!,
          _isSafeForNotificationMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('acted_at')) {
      context.handle(
        _actedAtMeta,
        actedAt.isAcceptableOrUnknown(data['acted_at']!, _actedAtMeta),
      );
    }
    if (data.containsKey('dismissed_at')) {
      context.handle(
        _dismissedAtMeta,
        dismissedAt.isAcceptableOrUnknown(
          data['dismissed_at']!,
          _dismissedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PreservationRecommendationRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PreservationRecommendationRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      recommendationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recommendation_type'],
      )!,
      explanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explanation'],
      )!,
      proposedAction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proposed_action'],
      )!,
      actionPayloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action_payload_json'],
      )!,
      preservationNeed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}preservation_need'],
      )!,
      sensitivityAtCreation: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sensitivity_at_creation'],
      )!,
      isSafeForNotification: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_safe_for_notification'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      actedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}acted_at'],
      ),
      dismissedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dismissed_at'],
      ),
    );
  }

  @override
  $PreservationRecommendationsTable createAlias(String alias) {
    return $PreservationRecommendationsTable(attachedDatabase, alias);
  }
}

class PreservationRecommendationRow extends DataClass
    implements Insertable<PreservationRecommendationRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String eventId;
  final String recommendationType;
  final String explanation;
  final String proposedAction;
  final String actionPayloadJson;
  final double preservationNeed;
  final double sensitivityAtCreation;
  final bool isSafeForNotification;
  final String status;
  final DateTime? actedAt;
  final DateTime? dismissedAt;
  const PreservationRecommendationRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.eventId,
    required this.recommendationType,
    required this.explanation,
    required this.proposedAction,
    required this.actionPayloadJson,
    required this.preservationNeed,
    required this.sensitivityAtCreation,
    required this.isSafeForNotification,
    required this.status,
    this.actedAt,
    this.dismissedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    map['recommendation_type'] = Variable<String>(recommendationType);
    map['explanation'] = Variable<String>(explanation);
    map['proposed_action'] = Variable<String>(proposedAction);
    map['action_payload_json'] = Variable<String>(actionPayloadJson);
    map['preservation_need'] = Variable<double>(preservationNeed);
    map['sensitivity_at_creation'] = Variable<double>(sensitivityAtCreation);
    map['is_safe_for_notification'] = Variable<bool>(isSafeForNotification);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || actedAt != null) {
      map['acted_at'] = Variable<DateTime>(actedAt);
    }
    if (!nullToAbsent || dismissedAt != null) {
      map['dismissed_at'] = Variable<DateTime>(dismissedAt);
    }
    return map;
  }

  PreservationRecommendationsCompanion toCompanion(bool nullToAbsent) {
    return PreservationRecommendationsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      eventId: Value(eventId),
      recommendationType: Value(recommendationType),
      explanation: Value(explanation),
      proposedAction: Value(proposedAction),
      actionPayloadJson: Value(actionPayloadJson),
      preservationNeed: Value(preservationNeed),
      sensitivityAtCreation: Value(sensitivityAtCreation),
      isSafeForNotification: Value(isSafeForNotification),
      status: Value(status),
      actedAt: actedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(actedAt),
      dismissedAt: dismissedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dismissedAt),
    );
  }

  factory PreservationRecommendationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PreservationRecommendationRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      recommendationType: serializer.fromJson<String>(
        json['recommendationType'],
      ),
      explanation: serializer.fromJson<String>(json['explanation']),
      proposedAction: serializer.fromJson<String>(json['proposedAction']),
      actionPayloadJson: serializer.fromJson<String>(json['actionPayloadJson']),
      preservationNeed: serializer.fromJson<double>(json['preservationNeed']),
      sensitivityAtCreation: serializer.fromJson<double>(
        json['sensitivityAtCreation'],
      ),
      isSafeForNotification: serializer.fromJson<bool>(
        json['isSafeForNotification'],
      ),
      status: serializer.fromJson<String>(json['status']),
      actedAt: serializer.fromJson<DateTime?>(json['actedAt']),
      dismissedAt: serializer.fromJson<DateTime?>(json['dismissedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'recommendationType': serializer.toJson<String>(recommendationType),
      'explanation': serializer.toJson<String>(explanation),
      'proposedAction': serializer.toJson<String>(proposedAction),
      'actionPayloadJson': serializer.toJson<String>(actionPayloadJson),
      'preservationNeed': serializer.toJson<double>(preservationNeed),
      'sensitivityAtCreation': serializer.toJson<double>(sensitivityAtCreation),
      'isSafeForNotification': serializer.toJson<bool>(isSafeForNotification),
      'status': serializer.toJson<String>(status),
      'actedAt': serializer.toJson<DateTime?>(actedAt),
      'dismissedAt': serializer.toJson<DateTime?>(dismissedAt),
    };
  }

  PreservationRecommendationRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? eventId,
    String? recommendationType,
    String? explanation,
    String? proposedAction,
    String? actionPayloadJson,
    double? preservationNeed,
    double? sensitivityAtCreation,
    bool? isSafeForNotification,
    String? status,
    Value<DateTime?> actedAt = const Value.absent(),
    Value<DateTime?> dismissedAt = const Value.absent(),
  }) => PreservationRecommendationRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    recommendationType: recommendationType ?? this.recommendationType,
    explanation: explanation ?? this.explanation,
    proposedAction: proposedAction ?? this.proposedAction,
    actionPayloadJson: actionPayloadJson ?? this.actionPayloadJson,
    preservationNeed: preservationNeed ?? this.preservationNeed,
    sensitivityAtCreation: sensitivityAtCreation ?? this.sensitivityAtCreation,
    isSafeForNotification: isSafeForNotification ?? this.isSafeForNotification,
    status: status ?? this.status,
    actedAt: actedAt.present ? actedAt.value : this.actedAt,
    dismissedAt: dismissedAt.present ? dismissedAt.value : this.dismissedAt,
  );
  PreservationRecommendationRow copyWithCompanion(
    PreservationRecommendationsCompanion data,
  ) {
    return PreservationRecommendationRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      recommendationType: data.recommendationType.present
          ? data.recommendationType.value
          : this.recommendationType,
      explanation: data.explanation.present
          ? data.explanation.value
          : this.explanation,
      proposedAction: data.proposedAction.present
          ? data.proposedAction.value
          : this.proposedAction,
      actionPayloadJson: data.actionPayloadJson.present
          ? data.actionPayloadJson.value
          : this.actionPayloadJson,
      preservationNeed: data.preservationNeed.present
          ? data.preservationNeed.value
          : this.preservationNeed,
      sensitivityAtCreation: data.sensitivityAtCreation.present
          ? data.sensitivityAtCreation.value
          : this.sensitivityAtCreation,
      isSafeForNotification: data.isSafeForNotification.present
          ? data.isSafeForNotification.value
          : this.isSafeForNotification,
      status: data.status.present ? data.status.value : this.status,
      actedAt: data.actedAt.present ? data.actedAt.value : this.actedAt,
      dismissedAt: data.dismissedAt.present
          ? data.dismissedAt.value
          : this.dismissedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PreservationRecommendationRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('recommendationType: $recommendationType, ')
          ..write('explanation: $explanation, ')
          ..write('proposedAction: $proposedAction, ')
          ..write('actionPayloadJson: $actionPayloadJson, ')
          ..write('preservationNeed: $preservationNeed, ')
          ..write('sensitivityAtCreation: $sensitivityAtCreation, ')
          ..write('isSafeForNotification: $isSafeForNotification, ')
          ..write('status: $status, ')
          ..write('actedAt: $actedAt, ')
          ..write('dismissedAt: $dismissedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    eventId,
    recommendationType,
    explanation,
    proposedAction,
    actionPayloadJson,
    preservationNeed,
    sensitivityAtCreation,
    isSafeForNotification,
    status,
    actedAt,
    dismissedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PreservationRecommendationRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.recommendationType == this.recommendationType &&
          other.explanation == this.explanation &&
          other.proposedAction == this.proposedAction &&
          other.actionPayloadJson == this.actionPayloadJson &&
          other.preservationNeed == this.preservationNeed &&
          other.sensitivityAtCreation == this.sensitivityAtCreation &&
          other.isSafeForNotification == this.isSafeForNotification &&
          other.status == this.status &&
          other.actedAt == this.actedAt &&
          other.dismissedAt == this.dismissedAt);
}

class PreservationRecommendationsCompanion
    extends UpdateCompanion<PreservationRecommendationRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> eventId;
  final Value<String> recommendationType;
  final Value<String> explanation;
  final Value<String> proposedAction;
  final Value<String> actionPayloadJson;
  final Value<double> preservationNeed;
  final Value<double> sensitivityAtCreation;
  final Value<bool> isSafeForNotification;
  final Value<String> status;
  final Value<DateTime?> actedAt;
  final Value<DateTime?> dismissedAt;
  final Value<int> rowid;
  const PreservationRecommendationsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.recommendationType = const Value.absent(),
    this.explanation = const Value.absent(),
    this.proposedAction = const Value.absent(),
    this.actionPayloadJson = const Value.absent(),
    this.preservationNeed = const Value.absent(),
    this.sensitivityAtCreation = const Value.absent(),
    this.isSafeForNotification = const Value.absent(),
    this.status = const Value.absent(),
    this.actedAt = const Value.absent(),
    this.dismissedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PreservationRecommendationsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String eventId,
    required String recommendationType,
    required String explanation,
    required String proposedAction,
    this.actionPayloadJson = const Value.absent(),
    required double preservationNeed,
    this.sensitivityAtCreation = const Value.absent(),
    this.isSafeForNotification = const Value.absent(),
    this.status = const Value.absent(),
    this.actedAt = const Value.absent(),
    this.dismissedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventId = Value(eventId),
       recommendationType = Value(recommendationType),
       explanation = Value(explanation),
       proposedAction = Value(proposedAction),
       preservationNeed = Value(preservationNeed);
  static Insertable<PreservationRecommendationRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<String>? recommendationType,
    Expression<String>? explanation,
    Expression<String>? proposedAction,
    Expression<String>? actionPayloadJson,
    Expression<double>? preservationNeed,
    Expression<double>? sensitivityAtCreation,
    Expression<bool>? isSafeForNotification,
    Expression<String>? status,
    Expression<DateTime>? actedAt,
    Expression<DateTime>? dismissedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (recommendationType != null) 'recommendation_type': recommendationType,
      if (explanation != null) 'explanation': explanation,
      if (proposedAction != null) 'proposed_action': proposedAction,
      if (actionPayloadJson != null) 'action_payload_json': actionPayloadJson,
      if (preservationNeed != null) 'preservation_need': preservationNeed,
      if (sensitivityAtCreation != null)
        'sensitivity_at_creation': sensitivityAtCreation,
      if (isSafeForNotification != null)
        'is_safe_for_notification': isSafeForNotification,
      if (status != null) 'status': status,
      if (actedAt != null) 'acted_at': actedAt,
      if (dismissedAt != null) 'dismissed_at': dismissedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PreservationRecommendationsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? eventId,
    Value<String>? recommendationType,
    Value<String>? explanation,
    Value<String>? proposedAction,
    Value<String>? actionPayloadJson,
    Value<double>? preservationNeed,
    Value<double>? sensitivityAtCreation,
    Value<bool>? isSafeForNotification,
    Value<String>? status,
    Value<DateTime?>? actedAt,
    Value<DateTime?>? dismissedAt,
    Value<int>? rowid,
  }) {
    return PreservationRecommendationsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      recommendationType: recommendationType ?? this.recommendationType,
      explanation: explanation ?? this.explanation,
      proposedAction: proposedAction ?? this.proposedAction,
      actionPayloadJson: actionPayloadJson ?? this.actionPayloadJson,
      preservationNeed: preservationNeed ?? this.preservationNeed,
      sensitivityAtCreation:
          sensitivityAtCreation ?? this.sensitivityAtCreation,
      isSafeForNotification:
          isSafeForNotification ?? this.isSafeForNotification,
      status: status ?? this.status,
      actedAt: actedAt ?? this.actedAt,
      dismissedAt: dismissedAt ?? this.dismissedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (recommendationType.present) {
      map['recommendation_type'] = Variable<String>(recommendationType.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (proposedAction.present) {
      map['proposed_action'] = Variable<String>(proposedAction.value);
    }
    if (actionPayloadJson.present) {
      map['action_payload_json'] = Variable<String>(actionPayloadJson.value);
    }
    if (preservationNeed.present) {
      map['preservation_need'] = Variable<double>(preservationNeed.value);
    }
    if (sensitivityAtCreation.present) {
      map['sensitivity_at_creation'] = Variable<double>(
        sensitivityAtCreation.value,
      );
    }
    if (isSafeForNotification.present) {
      map['is_safe_for_notification'] = Variable<bool>(
        isSafeForNotification.value,
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (actedAt.present) {
      map['acted_at'] = Variable<DateTime>(actedAt.value);
    }
    if (dismissedAt.present) {
      map['dismissed_at'] = Variable<DateTime>(dismissedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreservationRecommendationsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('recommendationType: $recommendationType, ')
          ..write('explanation: $explanation, ')
          ..write('proposedAction: $proposedAction, ')
          ..write('actionPayloadJson: $actionPayloadJson, ')
          ..write('preservationNeed: $preservationNeed, ')
          ..write('sensitivityAtCreation: $sensitivityAtCreation, ')
          ..write('isSafeForNotification: $isSafeForNotification, ')
          ..write('status: $status, ')
          ..write('actedAt: $actedAt, ')
          ..write('dismissedAt: $dismissedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, ReminderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _recommendationIdMeta = const VerificationMeta(
    'recommendationId',
  );
  @override
  late final GeneratedColumn<String> recommendationId = GeneratedColumn<String>(
    'recommendation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES preservation_recommendations (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _reminderTypeMeta = const VerificationMeta(
    'reminderType',
  );
  @override
  late final GeneratedColumn<String> reminderType = GeneratedColumn<String>(
    'reminder_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _neutralTextMeta = const VerificationMeta(
    'neutralText',
  );
  @override
  late final GeneratedColumn<String> neutralText = GeneratedColumn<String>(
    'neutral_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notificationIdMeta = const VerificationMeta(
    'notificationId',
  );
  @override
  late final GeneratedColumn<int> notificationId = GeneratedColumn<int>(
    'notification_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('scheduled'),
  );
  static const VerificationMeta _deliveredAtMeta = const VerificationMeta(
    'deliveredAt',
  );
  @override
  late final GeneratedColumn<DateTime> deliveredAt = GeneratedColumn<DateTime>(
    'delivered_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _openedAtMeta = const VerificationMeta(
    'openedAt',
  );
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
    'opened_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    eventId,
    recommendationId,
    reminderType,
    scheduledAt,
    neutralText,
    notificationId,
    status,
    deliveredAt,
    openedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('recommendation_id')) {
      context.handle(
        _recommendationIdMeta,
        recommendationId.isAcceptableOrUnknown(
          data['recommendation_id']!,
          _recommendationIdMeta,
        ),
      );
    }
    if (data.containsKey('reminder_type')) {
      context.handle(
        _reminderTypeMeta,
        reminderType.isAcceptableOrUnknown(
          data['reminder_type']!,
          _reminderTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reminderTypeMeta);
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('neutral_text')) {
      context.handle(
        _neutralTextMeta,
        neutralText.isAcceptableOrUnknown(
          data['neutral_text']!,
          _neutralTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_neutralTextMeta);
    }
    if (data.containsKey('notification_id')) {
      context.handle(
        _notificationIdMeta,
        notificationId.isAcceptableOrUnknown(
          data['notification_id']!,
          _notificationIdMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('delivered_at')) {
      context.handle(
        _deliveredAtMeta,
        deliveredAt.isAcceptableOrUnknown(
          data['delivered_at']!,
          _deliveredAtMeta,
        ),
      );
    }
    if (data.containsKey('opened_at')) {
      context.handle(
        _openedAtMeta,
        openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      recommendationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recommendation_id'],
      ),
      reminderType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_type'],
      )!,
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      )!,
      neutralText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}neutral_text'],
      )!,
      notificationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      deliveredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}delivered_at'],
      ),
      openedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}opened_at'],
      ),
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class ReminderRow extends DataClass implements Insertable<ReminderRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String eventId;
  final String? recommendationId;
  final String reminderType;
  final DateTime scheduledAt;
  final String neutralText;
  final int? notificationId;
  final String status;
  final DateTime? deliveredAt;
  final DateTime? openedAt;
  const ReminderRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.eventId,
    this.recommendationId,
    required this.reminderType,
    required this.scheduledAt,
    required this.neutralText,
    this.notificationId,
    required this.status,
    this.deliveredAt,
    this.openedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    if (!nullToAbsent || recommendationId != null) {
      map['recommendation_id'] = Variable<String>(recommendationId);
    }
    map['reminder_type'] = Variable<String>(reminderType);
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    map['neutral_text'] = Variable<String>(neutralText);
    if (!nullToAbsent || notificationId != null) {
      map['notification_id'] = Variable<int>(notificationId);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || deliveredAt != null) {
      map['delivered_at'] = Variable<DateTime>(deliveredAt);
    }
    if (!nullToAbsent || openedAt != null) {
      map['opened_at'] = Variable<DateTime>(openedAt);
    }
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      eventId: Value(eventId),
      recommendationId: recommendationId == null && nullToAbsent
          ? const Value.absent()
          : Value(recommendationId),
      reminderType: Value(reminderType),
      scheduledAt: Value(scheduledAt),
      neutralText: Value(neutralText),
      notificationId: notificationId == null && nullToAbsent
          ? const Value.absent()
          : Value(notificationId),
      status: Value(status),
      deliveredAt: deliveredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveredAt),
      openedAt: openedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(openedAt),
    );
  }

  factory ReminderRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      recommendationId: serializer.fromJson<String?>(json['recommendationId']),
      reminderType: serializer.fromJson<String>(json['reminderType']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      neutralText: serializer.fromJson<String>(json['neutralText']),
      notificationId: serializer.fromJson<int?>(json['notificationId']),
      status: serializer.fromJson<String>(json['status']),
      deliveredAt: serializer.fromJson<DateTime?>(json['deliveredAt']),
      openedAt: serializer.fromJson<DateTime?>(json['openedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'recommendationId': serializer.toJson<String?>(recommendationId),
      'reminderType': serializer.toJson<String>(reminderType),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'neutralText': serializer.toJson<String>(neutralText),
      'notificationId': serializer.toJson<int?>(notificationId),
      'status': serializer.toJson<String>(status),
      'deliveredAt': serializer.toJson<DateTime?>(deliveredAt),
      'openedAt': serializer.toJson<DateTime?>(openedAt),
    };
  }

  ReminderRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? eventId,
    Value<String?> recommendationId = const Value.absent(),
    String? reminderType,
    DateTime? scheduledAt,
    String? neutralText,
    Value<int?> notificationId = const Value.absent(),
    String? status,
    Value<DateTime?> deliveredAt = const Value.absent(),
    Value<DateTime?> openedAt = const Value.absent(),
  }) => ReminderRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    recommendationId: recommendationId.present
        ? recommendationId.value
        : this.recommendationId,
    reminderType: reminderType ?? this.reminderType,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    neutralText: neutralText ?? this.neutralText,
    notificationId: notificationId.present
        ? notificationId.value
        : this.notificationId,
    status: status ?? this.status,
    deliveredAt: deliveredAt.present ? deliveredAt.value : this.deliveredAt,
    openedAt: openedAt.present ? openedAt.value : this.openedAt,
  );
  ReminderRow copyWithCompanion(RemindersCompanion data) {
    return ReminderRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      recommendationId: data.recommendationId.present
          ? data.recommendationId.value
          : this.recommendationId,
      reminderType: data.reminderType.present
          ? data.reminderType.value
          : this.reminderType,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      neutralText: data.neutralText.present
          ? data.neutralText.value
          : this.neutralText,
      notificationId: data.notificationId.present
          ? data.notificationId.value
          : this.notificationId,
      status: data.status.present ? data.status.value : this.status,
      deliveredAt: data.deliveredAt.present
          ? data.deliveredAt.value
          : this.deliveredAt,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('recommendationId: $recommendationId, ')
          ..write('reminderType: $reminderType, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('neutralText: $neutralText, ')
          ..write('notificationId: $notificationId, ')
          ..write('status: $status, ')
          ..write('deliveredAt: $deliveredAt, ')
          ..write('openedAt: $openedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    eventId,
    recommendationId,
    reminderType,
    scheduledAt,
    neutralText,
    notificationId,
    status,
    deliveredAt,
    openedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.recommendationId == this.recommendationId &&
          other.reminderType == this.reminderType &&
          other.scheduledAt == this.scheduledAt &&
          other.neutralText == this.neutralText &&
          other.notificationId == this.notificationId &&
          other.status == this.status &&
          other.deliveredAt == this.deliveredAt &&
          other.openedAt == this.openedAt);
}

class RemindersCompanion extends UpdateCompanion<ReminderRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> eventId;
  final Value<String?> recommendationId;
  final Value<String> reminderType;
  final Value<DateTime> scheduledAt;
  final Value<String> neutralText;
  final Value<int?> notificationId;
  final Value<String> status;
  final Value<DateTime?> deliveredAt;
  final Value<DateTime?> openedAt;
  final Value<int> rowid;
  const RemindersCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.recommendationId = const Value.absent(),
    this.reminderType = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.neutralText = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.status = const Value.absent(),
    this.deliveredAt = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String eventId,
    this.recommendationId = const Value.absent(),
    required String reminderType,
    required DateTime scheduledAt,
    required String neutralText,
    this.notificationId = const Value.absent(),
    this.status = const Value.absent(),
    this.deliveredAt = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventId = Value(eventId),
       reminderType = Value(reminderType),
       scheduledAt = Value(scheduledAt),
       neutralText = Value(neutralText);
  static Insertable<ReminderRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<String>? recommendationId,
    Expression<String>? reminderType,
    Expression<DateTime>? scheduledAt,
    Expression<String>? neutralText,
    Expression<int>? notificationId,
    Expression<String>? status,
    Expression<DateTime>? deliveredAt,
    Expression<DateTime>? openedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (recommendationId != null) 'recommendation_id': recommendationId,
      if (reminderType != null) 'reminder_type': reminderType,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (neutralText != null) 'neutral_text': neutralText,
      if (notificationId != null) 'notification_id': notificationId,
      if (status != null) 'status': status,
      if (deliveredAt != null) 'delivered_at': deliveredAt,
      if (openedAt != null) 'opened_at': openedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? eventId,
    Value<String?>? recommendationId,
    Value<String>? reminderType,
    Value<DateTime>? scheduledAt,
    Value<String>? neutralText,
    Value<int?>? notificationId,
    Value<String>? status,
    Value<DateTime?>? deliveredAt,
    Value<DateTime?>? openedAt,
    Value<int>? rowid,
  }) {
    return RemindersCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      recommendationId: recommendationId ?? this.recommendationId,
      reminderType: reminderType ?? this.reminderType,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      neutralText: neutralText ?? this.neutralText,
      notificationId: notificationId ?? this.notificationId,
      status: status ?? this.status,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      openedAt: openedAt ?? this.openedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (recommendationId.present) {
      map['recommendation_id'] = Variable<String>(recommendationId.value);
    }
    if (reminderType.present) {
      map['reminder_type'] = Variable<String>(reminderType.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (neutralText.present) {
      map['neutral_text'] = Variable<String>(neutralText.value);
    }
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (deliveredAt.present) {
      map['delivered_at'] = Variable<DateTime>(deliveredAt.value);
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('recommendationId: $recommendationId, ')
          ..write('reminderType: $reminderType, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('neutralText: $neutralText, ')
          ..write('notificationId: $notificationId, ')
          ..write('status: $status, ')
          ..write('deliveredAt: $deliveredAt, ')
          ..write('openedAt: $openedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserFeedbackTable extends UserFeedback
    with TableInfo<$UserFeedbackTable, UserFeedbackRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserFeedbackTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _recommendationIdMeta = const VerificationMeta(
    'recommendationId',
  );
  @override
  late final GeneratedColumn<String> recommendationId = GeneratedColumn<String>(
    'recommendation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES preservation_recommendations (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _feedbackTypeMeta = const VerificationMeta(
    'feedbackType',
  );
  @override
  late final GeneratedColumn<String> feedbackType = GeneratedColumn<String>(
    'feedback_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    recommendationId,
    feedbackType,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_feedback';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserFeedbackRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('recommendation_id')) {
      context.handle(
        _recommendationIdMeta,
        recommendationId.isAcceptableOrUnknown(
          data['recommendation_id']!,
          _recommendationIdMeta,
        ),
      );
    }
    if (data.containsKey('feedback_type')) {
      context.handle(
        _feedbackTypeMeta,
        feedbackType.isAcceptableOrUnknown(
          data['feedback_type']!,
          _feedbackTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_feedbackTypeMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserFeedbackRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserFeedbackRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      recommendationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recommendation_id'],
      ),
      feedbackType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feedback_type'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UserFeedbackTable createAlias(String alias) {
    return $UserFeedbackTable(attachedDatabase, alias);
  }
}

class UserFeedbackRow extends DataClass implements Insertable<UserFeedbackRow> {
  final String id;
  final String eventId;
  final String? recommendationId;
  final String feedbackType;
  final String? note;
  final DateTime createdAt;
  const UserFeedbackRow({
    required this.id,
    required this.eventId,
    this.recommendationId,
    required this.feedbackType,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    if (!nullToAbsent || recommendationId != null) {
      map['recommendation_id'] = Variable<String>(recommendationId);
    }
    map['feedback_type'] = Variable<String>(feedbackType);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UserFeedbackCompanion toCompanion(bool nullToAbsent) {
    return UserFeedbackCompanion(
      id: Value(id),
      eventId: Value(eventId),
      recommendationId: recommendationId == null && nullToAbsent
          ? const Value.absent()
          : Value(recommendationId),
      feedbackType: Value(feedbackType),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory UserFeedbackRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserFeedbackRow(
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      recommendationId: serializer.fromJson<String?>(json['recommendationId']),
      feedbackType: serializer.fromJson<String>(json['feedbackType']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'recommendationId': serializer.toJson<String?>(recommendationId),
      'feedbackType': serializer.toJson<String>(feedbackType),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserFeedbackRow copyWith({
    String? id,
    String? eventId,
    Value<String?> recommendationId = const Value.absent(),
    String? feedbackType,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => UserFeedbackRow(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    recommendationId: recommendationId.present
        ? recommendationId.value
        : this.recommendationId,
    feedbackType: feedbackType ?? this.feedbackType,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  UserFeedbackRow copyWithCompanion(UserFeedbackCompanion data) {
    return UserFeedbackRow(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      recommendationId: data.recommendationId.present
          ? data.recommendationId.value
          : this.recommendationId,
      feedbackType: data.feedbackType.present
          ? data.feedbackType.value
          : this.feedbackType,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserFeedbackRow(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('recommendationId: $recommendationId, ')
          ..write('feedbackType: $feedbackType, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, eventId, recommendationId, feedbackType, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserFeedbackRow &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.recommendationId == this.recommendationId &&
          other.feedbackType == this.feedbackType &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class UserFeedbackCompanion extends UpdateCompanion<UserFeedbackRow> {
  final Value<String> id;
  final Value<String> eventId;
  final Value<String?> recommendationId;
  final Value<String> feedbackType;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UserFeedbackCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.recommendationId = const Value.absent(),
    this.feedbackType = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserFeedbackCompanion.insert({
    required String id,
    required String eventId,
    this.recommendationId = const Value.absent(),
    required String feedbackType,
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventId = Value(eventId),
       feedbackType = Value(feedbackType);
  static Insertable<UserFeedbackRow> custom({
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<String>? recommendationId,
    Expression<String>? feedbackType,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (recommendationId != null) 'recommendation_id': recommendationId,
      if (feedbackType != null) 'feedback_type': feedbackType,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserFeedbackCompanion copyWith({
    Value<String>? id,
    Value<String>? eventId,
    Value<String?>? recommendationId,
    Value<String>? feedbackType,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return UserFeedbackCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      recommendationId: recommendationId ?? this.recommendationId,
      feedbackType: feedbackType ?? this.feedbackType,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (recommendationId.present) {
      map['recommendation_id'] = Variable<String>(recommendationId.value);
    }
    if (feedbackType.present) {
      map['feedback_type'] = Variable<String>(feedbackType.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserFeedbackCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('recommendationId: $recommendationId, ')
          ..write('feedbackType: $feedbackType, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PrivacySettingsTable extends PrivacySettings
    with TableInfo<$PrivacySettingsTable, PrivacySettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrivacySettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _galleryAccessModeMeta = const VerificationMeta(
    'galleryAccessMode',
  );
  @override
  late final GeneratedColumn<String> galleryAccessMode =
      GeneratedColumn<String>(
        'gallery_access_mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('not_requested'),
      );
  static const VerificationMeta _biometricLockEnabledMeta =
      const VerificationMeta('biometricLockEnabled');
  @override
  late final GeneratedColumn<bool> biometricLockEnabled = GeneratedColumn<bool>(
    'biometric_lock_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("biometric_lock_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hideSensitivePreviewsMeta =
      const VerificationMeta('hideSensitivePreviews');
  @override
  late final GeneratedColumn<bool> hideSensitivePreviews =
      GeneratedColumn<bool>(
        'hide_sensitive_previews',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("hide_sensitive_previews" IN (0, 1))',
        ),
        defaultValue: const Constant(true),
      );
  static const VerificationMeta _neutralNotificationsOnlyMeta =
      const VerificationMeta('neutralNotificationsOnly');
  @override
  late final GeneratedColumn<bool> neutralNotificationsOnly =
      GeneratedColumn<bool>(
        'neutral_notifications_only',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("neutral_notifications_only" IN (0, 1))',
        ),
        defaultValue: const Constant(true),
      );
  static const VerificationMeta _analyticsEnabledMeta = const VerificationMeta(
    'analyticsEnabled',
  );
  @override
  late final GeneratedColumn<bool> analyticsEnabled = GeneratedColumn<bool>(
    'analytics_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("analytics_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _cloudBackupEnabledMeta =
      const VerificationMeta('cloudBackupEnabled');
  @override
  late final GeneratedColumn<bool> cloudBackupEnabled = GeneratedColumn<bool>(
    'cloud_backup_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cloud_backup_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    galleryAccessMode,
    biometricLockEnabled,
    hideSensitivePreviews,
    neutralNotificationsOnly,
    analyticsEnabled,
    cloudBackupEnabled,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'privacy_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrivacySettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('gallery_access_mode')) {
      context.handle(
        _galleryAccessModeMeta,
        galleryAccessMode.isAcceptableOrUnknown(
          data['gallery_access_mode']!,
          _galleryAccessModeMeta,
        ),
      );
    }
    if (data.containsKey('biometric_lock_enabled')) {
      context.handle(
        _biometricLockEnabledMeta,
        biometricLockEnabled.isAcceptableOrUnknown(
          data['biometric_lock_enabled']!,
          _biometricLockEnabledMeta,
        ),
      );
    }
    if (data.containsKey('hide_sensitive_previews')) {
      context.handle(
        _hideSensitivePreviewsMeta,
        hideSensitivePreviews.isAcceptableOrUnknown(
          data['hide_sensitive_previews']!,
          _hideSensitivePreviewsMeta,
        ),
      );
    }
    if (data.containsKey('neutral_notifications_only')) {
      context.handle(
        _neutralNotificationsOnlyMeta,
        neutralNotificationsOnly.isAcceptableOrUnknown(
          data['neutral_notifications_only']!,
          _neutralNotificationsOnlyMeta,
        ),
      );
    }
    if (data.containsKey('analytics_enabled')) {
      context.handle(
        _analyticsEnabledMeta,
        analyticsEnabled.isAcceptableOrUnknown(
          data['analytics_enabled']!,
          _analyticsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('cloud_backup_enabled')) {
      context.handle(
        _cloudBackupEnabledMeta,
        cloudBackupEnabled.isAcceptableOrUnknown(
          data['cloud_backup_enabled']!,
          _cloudBackupEnabledMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrivacySettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrivacySettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      galleryAccessMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gallery_access_mode'],
      )!,
      biometricLockEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}biometric_lock_enabled'],
      )!,
      hideSensitivePreviews: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}hide_sensitive_previews'],
      )!,
      neutralNotificationsOnly: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}neutral_notifications_only'],
      )!,
      analyticsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}analytics_enabled'],
      )!,
      cloudBackupEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cloud_backup_enabled'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PrivacySettingsTable createAlias(String alias) {
    return $PrivacySettingsTable(attachedDatabase, alias);
  }
}

class PrivacySettingsRow extends DataClass
    implements Insertable<PrivacySettingsRow> {
  final String id;
  final String galleryAccessMode;
  final bool biometricLockEnabled;
  final bool hideSensitivePreviews;
  final bool neutralNotificationsOnly;
  final bool analyticsEnabled;
  final bool cloudBackupEnabled;
  final DateTime updatedAt;
  const PrivacySettingsRow({
    required this.id,
    required this.galleryAccessMode,
    required this.biometricLockEnabled,
    required this.hideSensitivePreviews,
    required this.neutralNotificationsOnly,
    required this.analyticsEnabled,
    required this.cloudBackupEnabled,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['gallery_access_mode'] = Variable<String>(galleryAccessMode);
    map['biometric_lock_enabled'] = Variable<bool>(biometricLockEnabled);
    map['hide_sensitive_previews'] = Variable<bool>(hideSensitivePreviews);
    map['neutral_notifications_only'] = Variable<bool>(
      neutralNotificationsOnly,
    );
    map['analytics_enabled'] = Variable<bool>(analyticsEnabled);
    map['cloud_backup_enabled'] = Variable<bool>(cloudBackupEnabled);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PrivacySettingsCompanion toCompanion(bool nullToAbsent) {
    return PrivacySettingsCompanion(
      id: Value(id),
      galleryAccessMode: Value(galleryAccessMode),
      biometricLockEnabled: Value(biometricLockEnabled),
      hideSensitivePreviews: Value(hideSensitivePreviews),
      neutralNotificationsOnly: Value(neutralNotificationsOnly),
      analyticsEnabled: Value(analyticsEnabled),
      cloudBackupEnabled: Value(cloudBackupEnabled),
      updatedAt: Value(updatedAt),
    );
  }

  factory PrivacySettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrivacySettingsRow(
      id: serializer.fromJson<String>(json['id']),
      galleryAccessMode: serializer.fromJson<String>(json['galleryAccessMode']),
      biometricLockEnabled: serializer.fromJson<bool>(
        json['biometricLockEnabled'],
      ),
      hideSensitivePreviews: serializer.fromJson<bool>(
        json['hideSensitivePreviews'],
      ),
      neutralNotificationsOnly: serializer.fromJson<bool>(
        json['neutralNotificationsOnly'],
      ),
      analyticsEnabled: serializer.fromJson<bool>(json['analyticsEnabled']),
      cloudBackupEnabled: serializer.fromJson<bool>(json['cloudBackupEnabled']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'galleryAccessMode': serializer.toJson<String>(galleryAccessMode),
      'biometricLockEnabled': serializer.toJson<bool>(biometricLockEnabled),
      'hideSensitivePreviews': serializer.toJson<bool>(hideSensitivePreviews),
      'neutralNotificationsOnly': serializer.toJson<bool>(
        neutralNotificationsOnly,
      ),
      'analyticsEnabled': serializer.toJson<bool>(analyticsEnabled),
      'cloudBackupEnabled': serializer.toJson<bool>(cloudBackupEnabled),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PrivacySettingsRow copyWith({
    String? id,
    String? galleryAccessMode,
    bool? biometricLockEnabled,
    bool? hideSensitivePreviews,
    bool? neutralNotificationsOnly,
    bool? analyticsEnabled,
    bool? cloudBackupEnabled,
    DateTime? updatedAt,
  }) => PrivacySettingsRow(
    id: id ?? this.id,
    galleryAccessMode: galleryAccessMode ?? this.galleryAccessMode,
    biometricLockEnabled: biometricLockEnabled ?? this.biometricLockEnabled,
    hideSensitivePreviews: hideSensitivePreviews ?? this.hideSensitivePreviews,
    neutralNotificationsOnly:
        neutralNotificationsOnly ?? this.neutralNotificationsOnly,
    analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
    cloudBackupEnabled: cloudBackupEnabled ?? this.cloudBackupEnabled,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PrivacySettingsRow copyWithCompanion(PrivacySettingsCompanion data) {
    return PrivacySettingsRow(
      id: data.id.present ? data.id.value : this.id,
      galleryAccessMode: data.galleryAccessMode.present
          ? data.galleryAccessMode.value
          : this.galleryAccessMode,
      biometricLockEnabled: data.biometricLockEnabled.present
          ? data.biometricLockEnabled.value
          : this.biometricLockEnabled,
      hideSensitivePreviews: data.hideSensitivePreviews.present
          ? data.hideSensitivePreviews.value
          : this.hideSensitivePreviews,
      neutralNotificationsOnly: data.neutralNotificationsOnly.present
          ? data.neutralNotificationsOnly.value
          : this.neutralNotificationsOnly,
      analyticsEnabled: data.analyticsEnabled.present
          ? data.analyticsEnabled.value
          : this.analyticsEnabled,
      cloudBackupEnabled: data.cloudBackupEnabled.present
          ? data.cloudBackupEnabled.value
          : this.cloudBackupEnabled,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrivacySettingsRow(')
          ..write('id: $id, ')
          ..write('galleryAccessMode: $galleryAccessMode, ')
          ..write('biometricLockEnabled: $biometricLockEnabled, ')
          ..write('hideSensitivePreviews: $hideSensitivePreviews, ')
          ..write('neutralNotificationsOnly: $neutralNotificationsOnly, ')
          ..write('analyticsEnabled: $analyticsEnabled, ')
          ..write('cloudBackupEnabled: $cloudBackupEnabled, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    galleryAccessMode,
    biometricLockEnabled,
    hideSensitivePreviews,
    neutralNotificationsOnly,
    analyticsEnabled,
    cloudBackupEnabled,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrivacySettingsRow &&
          other.id == this.id &&
          other.galleryAccessMode == this.galleryAccessMode &&
          other.biometricLockEnabled == this.biometricLockEnabled &&
          other.hideSensitivePreviews == this.hideSensitivePreviews &&
          other.neutralNotificationsOnly == this.neutralNotificationsOnly &&
          other.analyticsEnabled == this.analyticsEnabled &&
          other.cloudBackupEnabled == this.cloudBackupEnabled &&
          other.updatedAt == this.updatedAt);
}

class PrivacySettingsCompanion extends UpdateCompanion<PrivacySettingsRow> {
  final Value<String> id;
  final Value<String> galleryAccessMode;
  final Value<bool> biometricLockEnabled;
  final Value<bool> hideSensitivePreviews;
  final Value<bool> neutralNotificationsOnly;
  final Value<bool> analyticsEnabled;
  final Value<bool> cloudBackupEnabled;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PrivacySettingsCompanion({
    this.id = const Value.absent(),
    this.galleryAccessMode = const Value.absent(),
    this.biometricLockEnabled = const Value.absent(),
    this.hideSensitivePreviews = const Value.absent(),
    this.neutralNotificationsOnly = const Value.absent(),
    this.analyticsEnabled = const Value.absent(),
    this.cloudBackupEnabled = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrivacySettingsCompanion.insert({
    required String id,
    this.galleryAccessMode = const Value.absent(),
    this.biometricLockEnabled = const Value.absent(),
    this.hideSensitivePreviews = const Value.absent(),
    this.neutralNotificationsOnly = const Value.absent(),
    this.analyticsEnabled = const Value.absent(),
    this.cloudBackupEnabled = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<PrivacySettingsRow> custom({
    Expression<String>? id,
    Expression<String>? galleryAccessMode,
    Expression<bool>? biometricLockEnabled,
    Expression<bool>? hideSensitivePreviews,
    Expression<bool>? neutralNotificationsOnly,
    Expression<bool>? analyticsEnabled,
    Expression<bool>? cloudBackupEnabled,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (galleryAccessMode != null) 'gallery_access_mode': galleryAccessMode,
      if (biometricLockEnabled != null)
        'biometric_lock_enabled': biometricLockEnabled,
      if (hideSensitivePreviews != null)
        'hide_sensitive_previews': hideSensitivePreviews,
      if (neutralNotificationsOnly != null)
        'neutral_notifications_only': neutralNotificationsOnly,
      if (analyticsEnabled != null) 'analytics_enabled': analyticsEnabled,
      if (cloudBackupEnabled != null)
        'cloud_backup_enabled': cloudBackupEnabled,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrivacySettingsCompanion copyWith({
    Value<String>? id,
    Value<String>? galleryAccessMode,
    Value<bool>? biometricLockEnabled,
    Value<bool>? hideSensitivePreviews,
    Value<bool>? neutralNotificationsOnly,
    Value<bool>? analyticsEnabled,
    Value<bool>? cloudBackupEnabled,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PrivacySettingsCompanion(
      id: id ?? this.id,
      galleryAccessMode: galleryAccessMode ?? this.galleryAccessMode,
      biometricLockEnabled: biometricLockEnabled ?? this.biometricLockEnabled,
      hideSensitivePreviews:
          hideSensitivePreviews ?? this.hideSensitivePreviews,
      neutralNotificationsOnly:
          neutralNotificationsOnly ?? this.neutralNotificationsOnly,
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
      cloudBackupEnabled: cloudBackupEnabled ?? this.cloudBackupEnabled,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (galleryAccessMode.present) {
      map['gallery_access_mode'] = Variable<String>(galleryAccessMode.value);
    }
    if (biometricLockEnabled.present) {
      map['biometric_lock_enabled'] = Variable<bool>(
        biometricLockEnabled.value,
      );
    }
    if (hideSensitivePreviews.present) {
      map['hide_sensitive_previews'] = Variable<bool>(
        hideSensitivePreviews.value,
      );
    }
    if (neutralNotificationsOnly.present) {
      map['neutral_notifications_only'] = Variable<bool>(
        neutralNotificationsOnly.value,
      );
    }
    if (analyticsEnabled.present) {
      map['analytics_enabled'] = Variable<bool>(analyticsEnabled.value);
    }
    if (cloudBackupEnabled.present) {
      map['cloud_backup_enabled'] = Variable<bool>(cloudBackupEnabled.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrivacySettingsCompanion(')
          ..write('id: $id, ')
          ..write('galleryAccessMode: $galleryAccessMode, ')
          ..write('biometricLockEnabled: $biometricLockEnabled, ')
          ..write('hideSensitivePreviews: $hideSensitivePreviews, ')
          ..write('neutralNotificationsOnly: $neutralNotificationsOnly, ')
          ..write('analyticsEnabled: $analyticsEnabled, ')
          ..write('cloudBackupEnabled: $cloudBackupEnabled, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventInteractionsTable extends EventInteractions
    with TableInfo<$EventInteractionsTable, EventInteractionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventInteractionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _interactionTypeMeta = const VerificationMeta(
    'interactionType',
  );
  @override
  late final GeneratedColumn<String> interactionType = GeneratedColumn<String>(
    'interaction_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('user'),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    interactionType,
    source,
    occurredAt,
    metadataJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_interactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventInteractionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('interaction_type')) {
      context.handle(
        _interactionTypeMeta,
        interactionType.isAcceptableOrUnknown(
          data['interaction_type']!,
          _interactionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_interactionTypeMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventInteractionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventInteractionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      interactionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}interaction_type'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      )!,
    );
  }

  @override
  $EventInteractionsTable createAlias(String alias) {
    return $EventInteractionsTable(attachedDatabase, alias);
  }
}

class EventInteractionRow extends DataClass
    implements Insertable<EventInteractionRow> {
  final String id;
  final String eventId;
  final String interactionType;
  final String source;
  final DateTime occurredAt;
  final String metadataJson;
  const EventInteractionRow({
    required this.id,
    required this.eventId,
    required this.interactionType,
    required this.source,
    required this.occurredAt,
    required this.metadataJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    map['interaction_type'] = Variable<String>(interactionType);
    map['source'] = Variable<String>(source);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['metadata_json'] = Variable<String>(metadataJson);
    return map;
  }

  EventInteractionsCompanion toCompanion(bool nullToAbsent) {
    return EventInteractionsCompanion(
      id: Value(id),
      eventId: Value(eventId),
      interactionType: Value(interactionType),
      source: Value(source),
      occurredAt: Value(occurredAt),
      metadataJson: Value(metadataJson),
    );
  }

  factory EventInteractionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventInteractionRow(
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      interactionType: serializer.fromJson<String>(json['interactionType']),
      source: serializer.fromJson<String>(json['source']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      metadataJson: serializer.fromJson<String>(json['metadataJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'interactionType': serializer.toJson<String>(interactionType),
      'source': serializer.toJson<String>(source),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'metadataJson': serializer.toJson<String>(metadataJson),
    };
  }

  EventInteractionRow copyWith({
    String? id,
    String? eventId,
    String? interactionType,
    String? source,
    DateTime? occurredAt,
    String? metadataJson,
  }) => EventInteractionRow(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    interactionType: interactionType ?? this.interactionType,
    source: source ?? this.source,
    occurredAt: occurredAt ?? this.occurredAt,
    metadataJson: metadataJson ?? this.metadataJson,
  );
  EventInteractionRow copyWithCompanion(EventInteractionsCompanion data) {
    return EventInteractionRow(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      interactionType: data.interactionType.present
          ? data.interactionType.value
          : this.interactionType,
      source: data.source.present ? data.source.value : this.source,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventInteractionRow(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('interactionType: $interactionType, ')
          ..write('source: $source, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('metadataJson: $metadataJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventId,
    interactionType,
    source,
    occurredAt,
    metadataJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventInteractionRow &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.interactionType == this.interactionType &&
          other.source == this.source &&
          other.occurredAt == this.occurredAt &&
          other.metadataJson == this.metadataJson);
}

class EventInteractionsCompanion extends UpdateCompanion<EventInteractionRow> {
  final Value<String> id;
  final Value<String> eventId;
  final Value<String> interactionType;
  final Value<String> source;
  final Value<DateTime> occurredAt;
  final Value<String> metadataJson;
  final Value<int> rowid;
  const EventInteractionsCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.interactionType = const Value.absent(),
    this.source = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventInteractionsCompanion.insert({
    required String id,
    required String eventId,
    required String interactionType,
    this.source = const Value.absent(),
    required DateTime occurredAt,
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventId = Value(eventId),
       interactionType = Value(interactionType),
       occurredAt = Value(occurredAt);
  static Insertable<EventInteractionRow> custom({
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<String>? interactionType,
    Expression<String>? source,
    Expression<DateTime>? occurredAt,
    Expression<String>? metadataJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (interactionType != null) 'interaction_type': interactionType,
      if (source != null) 'source': source,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventInteractionsCompanion copyWith({
    Value<String>? id,
    Value<String>? eventId,
    Value<String>? interactionType,
    Value<String>? source,
    Value<DateTime>? occurredAt,
    Value<String>? metadataJson,
    Value<int>? rowid,
  }) {
    return EventInteractionsCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      interactionType: interactionType ?? this.interactionType,
      source: source ?? this.source,
      occurredAt: occurredAt ?? this.occurredAt,
      metadataJson: metadataJson ?? this.metadataJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (interactionType.present) {
      map['interaction_type'] = Variable<String>(interactionType.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventInteractionsCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('interactionType: $interactionType, ')
          ..write('source: $source, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProcessingJobsTable extends ProcessingJobs
    with TableInfo<$ProcessingJobsTable, ProcessingJobRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProcessingJobsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediaIdMeta = const VerificationMeta(
    'mediaId',
  );
  @override
  late final GeneratedColumn<String> mediaId = GeneratedColumn<String>(
    'media_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES media_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _jobTypeMeta = const VerificationMeta(
    'jobType',
  );
  @override
  late final GeneratedColumn<String> jobType = GeneratedColumn<String>(
    'job_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _nextAttemptAtMeta = const VerificationMeta(
    'nextAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextAttemptAt =
      GeneratedColumn<DateTime>(
        'next_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorCodeMeta = const VerificationMeta(
    'errorCode',
  );
  @override
  late final GeneratedColumn<String> errorCode = GeneratedColumn<String>(
    'error_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    mediaId,
    eventId,
    jobType,
    status,
    attempts,
    progress,
    nextAttemptAt,
    startedAt,
    completedAt,
    errorCode,
    payloadJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'processing_jobs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProcessingJobRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('media_id')) {
      context.handle(
        _mediaIdMeta,
        mediaId.isAcceptableOrUnknown(data['media_id']!, _mediaIdMeta),
      );
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    }
    if (data.containsKey('job_type')) {
      context.handle(
        _jobTypeMeta,
        jobType.isAcceptableOrUnknown(data['job_type']!, _jobTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_jobTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('next_attempt_at')) {
      context.handle(
        _nextAttemptAtMeta,
        nextAttemptAt.isAcceptableOrUnknown(
          data['next_attempt_at']!,
          _nextAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('error_code')) {
      context.handle(
        _errorCodeMeta,
        errorCode.isAcceptableOrUnknown(data['error_code']!, _errorCodeMeta),
      );
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProcessingJobRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProcessingJobRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      mediaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_id'],
      ),
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      ),
      jobType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progress'],
      )!,
      nextAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_attempt_at'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      errorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_code'],
      ),
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
    );
  }

  @override
  $ProcessingJobsTable createAlias(String alias) {
    return $ProcessingJobsTable(attachedDatabase, alias);
  }
}

class ProcessingJobRow extends DataClass
    implements Insertable<ProcessingJobRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String? mediaId;
  final String? eventId;
  final String jobType;
  final String status;
  final int attempts;
  final double progress;
  final DateTime? nextAttemptAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final String? errorCode;
  final String payloadJson;
  const ProcessingJobRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    this.mediaId,
    this.eventId,
    required this.jobType,
    required this.status,
    required this.attempts,
    required this.progress,
    this.nextAttemptAt,
    this.startedAt,
    this.completedAt,
    this.errorCode,
    required this.payloadJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || mediaId != null) {
      map['media_id'] = Variable<String>(mediaId);
    }
    if (!nullToAbsent || eventId != null) {
      map['event_id'] = Variable<String>(eventId);
    }
    map['job_type'] = Variable<String>(jobType);
    map['status'] = Variable<String>(status);
    map['attempts'] = Variable<int>(attempts);
    map['progress'] = Variable<double>(progress);
    if (!nullToAbsent || nextAttemptAt != null) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt);
    }
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || errorCode != null) {
      map['error_code'] = Variable<String>(errorCode);
    }
    map['payload_json'] = Variable<String>(payloadJson);
    return map;
  }

  ProcessingJobsCompanion toCompanion(bool nullToAbsent) {
    return ProcessingJobsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      mediaId: mediaId == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaId),
      eventId: eventId == null && nullToAbsent
          ? const Value.absent()
          : Value(eventId),
      jobType: Value(jobType),
      status: Value(status),
      attempts: Value(attempts),
      progress: Value(progress),
      nextAttemptAt: nextAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextAttemptAt),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      errorCode: errorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(errorCode),
      payloadJson: Value(payloadJson),
    );
  }

  factory ProcessingJobRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProcessingJobRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      mediaId: serializer.fromJson<String?>(json['mediaId']),
      eventId: serializer.fromJson<String?>(json['eventId']),
      jobType: serializer.fromJson<String>(json['jobType']),
      status: serializer.fromJson<String>(json['status']),
      attempts: serializer.fromJson<int>(json['attempts']),
      progress: serializer.fromJson<double>(json['progress']),
      nextAttemptAt: serializer.fromJson<DateTime?>(json['nextAttemptAt']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      errorCode: serializer.fromJson<String?>(json['errorCode']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'mediaId': serializer.toJson<String?>(mediaId),
      'eventId': serializer.toJson<String?>(eventId),
      'jobType': serializer.toJson<String>(jobType),
      'status': serializer.toJson<String>(status),
      'attempts': serializer.toJson<int>(attempts),
      'progress': serializer.toJson<double>(progress),
      'nextAttemptAt': serializer.toJson<DateTime?>(nextAttemptAt),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'errorCode': serializer.toJson<String?>(errorCode),
      'payloadJson': serializer.toJson<String>(payloadJson),
    };
  }

  ProcessingJobRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    Value<String?> mediaId = const Value.absent(),
    Value<String?> eventId = const Value.absent(),
    String? jobType,
    String? status,
    int? attempts,
    double? progress,
    Value<DateTime?> nextAttemptAt = const Value.absent(),
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    Value<String?> errorCode = const Value.absent(),
    String? payloadJson,
  }) => ProcessingJobRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    mediaId: mediaId.present ? mediaId.value : this.mediaId,
    eventId: eventId.present ? eventId.value : this.eventId,
    jobType: jobType ?? this.jobType,
    status: status ?? this.status,
    attempts: attempts ?? this.attempts,
    progress: progress ?? this.progress,
    nextAttemptAt: nextAttemptAt.present
        ? nextAttemptAt.value
        : this.nextAttemptAt,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    errorCode: errorCode.present ? errorCode.value : this.errorCode,
    payloadJson: payloadJson ?? this.payloadJson,
  );
  ProcessingJobRow copyWithCompanion(ProcessingJobsCompanion data) {
    return ProcessingJobRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      mediaId: data.mediaId.present ? data.mediaId.value : this.mediaId,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      jobType: data.jobType.present ? data.jobType.value : this.jobType,
      status: data.status.present ? data.status.value : this.status,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      progress: data.progress.present ? data.progress.value : this.progress,
      nextAttemptAt: data.nextAttemptAt.present
          ? data.nextAttemptAt.value
          : this.nextAttemptAt,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      errorCode: data.errorCode.present ? data.errorCode.value : this.errorCode,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProcessingJobRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('mediaId: $mediaId, ')
          ..write('eventId: $eventId, ')
          ..write('jobType: $jobType, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('progress: $progress, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('errorCode: $errorCode, ')
          ..write('payloadJson: $payloadJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    mediaId,
    eventId,
    jobType,
    status,
    attempts,
    progress,
    nextAttemptAt,
    startedAt,
    completedAt,
    errorCode,
    payloadJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProcessingJobRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.mediaId == this.mediaId &&
          other.eventId == this.eventId &&
          other.jobType == this.jobType &&
          other.status == this.status &&
          other.attempts == this.attempts &&
          other.progress == this.progress &&
          other.nextAttemptAt == this.nextAttemptAt &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.errorCode == this.errorCode &&
          other.payloadJson == this.payloadJson);
}

class ProcessingJobsCompanion extends UpdateCompanion<ProcessingJobRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String?> mediaId;
  final Value<String?> eventId;
  final Value<String> jobType;
  final Value<String> status;
  final Value<int> attempts;
  final Value<double> progress;
  final Value<DateTime?> nextAttemptAt;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> completedAt;
  final Value<String?> errorCode;
  final Value<String> payloadJson;
  final Value<int> rowid;
  const ProcessingJobsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.mediaId = const Value.absent(),
    this.eventId = const Value.absent(),
    this.jobType = const Value.absent(),
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.progress = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProcessingJobsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    this.mediaId = const Value.absent(),
    this.eventId = const Value.absent(),
    required String jobType,
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.progress = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       jobType = Value(jobType);
  static Insertable<ProcessingJobRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? mediaId,
    Expression<String>? eventId,
    Expression<String>? jobType,
    Expression<String>? status,
    Expression<int>? attempts,
    Expression<double>? progress,
    Expression<DateTime>? nextAttemptAt,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? errorCode,
    Expression<String>? payloadJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (mediaId != null) 'media_id': mediaId,
      if (eventId != null) 'event_id': eventId,
      if (jobType != null) 'job_type': jobType,
      if (status != null) 'status': status,
      if (attempts != null) 'attempts': attempts,
      if (progress != null) 'progress': progress,
      if (nextAttemptAt != null) 'next_attempt_at': nextAttemptAt,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (errorCode != null) 'error_code': errorCode,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProcessingJobsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String?>? mediaId,
    Value<String?>? eventId,
    Value<String>? jobType,
    Value<String>? status,
    Value<int>? attempts,
    Value<double>? progress,
    Value<DateTime?>? nextAttemptAt,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? completedAt,
    Value<String?>? errorCode,
    Value<String>? payloadJson,
    Value<int>? rowid,
  }) {
    return ProcessingJobsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      mediaId: mediaId ?? this.mediaId,
      eventId: eventId ?? this.eventId,
      jobType: jobType ?? this.jobType,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      progress: progress ?? this.progress,
      nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      errorCode: errorCode ?? this.errorCode,
      payloadJson: payloadJson ?? this.payloadJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mediaId.present) {
      map['media_id'] = Variable<String>(mediaId.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (jobType.present) {
      map['job_type'] = Variable<String>(jobType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (nextAttemptAt.present) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (errorCode.present) {
      map['error_code'] = Variable<String>(errorCode.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProcessingJobsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('mediaId: $mediaId, ')
          ..write('eventId: $eventId, ')
          ..write('jobType: $jobType, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('progress: $progress, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('errorCode: $errorCode, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ScanHistoryTable scanHistory = $ScanHistoryTable(this);
  late final $MediaItemsTable mediaItems = $MediaItemsTable(this);
  late final $PlacesTable places = $PlacesTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $EventMediaTable eventMedia = $EventMediaTable(this);
  late final $PersonsTable persons = $PersonsTable(this);
  late final $EventPersonsTable eventPersons = $EventPersonsTable(this);
  late final $MediaPersonsTable mediaPersons = $MediaPersonsTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $VoiceNotesTable voiceNotes = $VoiceNotesTable(this);
  late final $GraphNodesTable graphNodes = $GraphNodesTable(this);
  late final $GraphEdgesTable graphEdges = $GraphEdgesTable(this);
  late final $SignificanceScoresTable significanceScores =
      $SignificanceScoresTable(this);
  late final $RediscoveryScoresTable rediscoveryScores =
      $RediscoveryScoresTable(this);
  late final $ContextScoresTable contextScores = $ContextScoresTable(this);
  late final $PreservationRecommendationsTable preservationRecommendations =
      $PreservationRecommendationsTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $UserFeedbackTable userFeedback = $UserFeedbackTable(this);
  late final $PrivacySettingsTable privacySettings = $PrivacySettingsTable(
    this,
  );
  late final $EventInteractionsTable eventInteractions =
      $EventInteractionsTable(this);
  late final $ProcessingJobsTable processingJobs = $ProcessingJobsTable(this);
  late final Index scanHistoryStartedAtIdx = Index(
    'scan_history_started_at_idx',
    'CREATE INDEX scan_history_started_at_idx ON scan_history (started_at)',
  );
  late final Index scanHistoryStatusIdx = Index(
    'scan_history_status_idx',
    'CREATE INDEX scan_history_status_idx ON scan_history (status)',
  );
  late final Index mediaItemsCaptureAtIdx = Index(
    'media_items_capture_at_idx',
    'CREATE INDEX media_items_capture_at_idx ON media_items (capture_at)',
  );
  late final Index mediaItemsDuplicateFingerprintIdx = Index(
    'media_items_duplicate_fingerprint_idx',
    'CREATE INDEX media_items_duplicate_fingerprint_idx ON media_items (duplicate_fingerprint)',
  );
  late final Index mediaItemsLastViewedAtIdx = Index(
    'media_items_last_viewed_at_idx',
    'CREATE INDEX media_items_last_viewed_at_idx ON media_items (last_viewed_at)',
  );
  late final Index mediaItemsScanIdIdx = Index(
    'media_items_scan_id_idx',
    'CREATE INDEX media_items_scan_id_idx ON media_items (scan_id)',
  );
  late final Index placesNameIdx = Index(
    'places_name_idx',
    'CREATE INDEX places_name_idx ON places (name)',
  );
  late final Index eventsStartAtIdx = Index(
    'events_start_at_idx',
    'CREATE INDEX events_start_at_idx ON events (start_at)',
  );
  late final Index eventsLastViewedAtIdx = Index(
    'events_last_viewed_at_idx',
    'CREATE INDEX events_last_viewed_at_idx ON events (last_viewed_at)',
  );
  late final Index eventsAttentionIdx = Index(
    'events_attention_idx',
    'CREATE INDEX events_attention_idx ON events (is_sensitive, is_hidden, last_viewed_at)',
  );
  late final Index eventMediaEventPositionIdx = Index(
    'event_media_event_position_idx',
    'CREATE INDEX event_media_event_position_idx ON event_media (event_id, position)',
  );
  late final Index eventMediaMediaIdIdx = Index(
    'event_media_media_id_idx',
    'CREATE INDEX event_media_media_id_idx ON event_media (media_id)',
  );
  late final Index personsDisplayNameIdx = Index(
    'persons_display_name_idx',
    'CREATE INDEX persons_display_name_idx ON persons (display_name)',
  );
  late final Index eventPersonsPersonIdIdx = Index(
    'event_persons_person_id_idx',
    'CREATE INDEX event_persons_person_id_idx ON event_persons (person_id)',
  );
  late final Index mediaPersonsPersonIdIdx = Index(
    'media_persons_person_id_idx',
    'CREATE INDEX media_persons_person_id_idx ON media_persons (person_id)',
  );
  late final Index notesEventIdIdx = Index(
    'notes_event_id_idx',
    'CREATE INDEX notes_event_id_idx ON notes (event_id)',
  );
  late final Index voiceNotesEventIdIdx = Index(
    'voice_notes_event_id_idx',
    'CREATE INDEX voice_notes_event_id_idx ON voice_notes (event_id)',
  );
  late final Index graphNodesTypeIdx = Index(
    'graph_nodes_type_idx',
    'CREATE INDEX graph_nodes_type_idx ON graph_nodes (node_type)',
  );
  late final Index graphEdgesSourceIdx = Index(
    'graph_edges_source_idx',
    'CREATE INDEX graph_edges_source_idx ON graph_edges (source_node_id)',
  );
  late final Index graphEdgesTargetIdx = Index(
    'graph_edges_target_idx',
    'CREATE INDEX graph_edges_target_idx ON graph_edges (target_node_id)',
  );
  late final Index graphEdgesRelationIdx = Index(
    'graph_edges_relation_idx',
    'CREATE INDEX graph_edges_relation_idx ON graph_edges (relation_type)',
  );
  late final Index significanceScoresEventEvaluatedIdx = Index(
    'significance_scores_event_evaluated_idx',
    'CREATE INDEX significance_scores_event_evaluated_idx ON significance_scores (event_id, evaluated_at)',
  );
  late final Index rediscoveryScoresEventEvaluatedIdx = Index(
    'rediscovery_scores_event_evaluated_idx',
    'CREATE INDEX rediscovery_scores_event_evaluated_idx ON rediscovery_scores (event_id, evaluated_at)',
  );
  late final Index contextScoresEventEvaluatedIdx = Index(
    'context_scores_event_evaluated_idx',
    'CREATE INDEX context_scores_event_evaluated_idx ON context_scores (event_id, evaluated_at)',
  );
  late final Index recommendationsStatusCreatedIdx = Index(
    'recommendations_status_created_idx',
    'CREATE INDEX recommendations_status_created_idx ON preservation_recommendations (status, created_at)',
  );
  late final Index recommendationsEventCreatedIdx = Index(
    'recommendations_event_created_idx',
    'CREATE INDEX recommendations_event_created_idx ON preservation_recommendations (event_id, created_at)',
  );
  late final Index remindersStatusScheduledIdx = Index(
    'reminders_status_scheduled_idx',
    'CREATE INDEX reminders_status_scheduled_idx ON reminders (status, scheduled_at)',
  );
  late final Index remindersEventIdIdx = Index(
    'reminders_event_id_idx',
    'CREATE INDEX reminders_event_id_idx ON reminders (event_id)',
  );
  late final Index userFeedbackRecommendationIdx = Index(
    'user_feedback_recommendation_idx',
    'CREATE INDEX user_feedback_recommendation_idx ON user_feedback (recommendation_id)',
  );
  late final Index userFeedbackEventIdx = Index(
    'user_feedback_event_idx',
    'CREATE INDEX user_feedback_event_idx ON user_feedback (event_id)',
  );
  late final Index eventInteractionsEventOccurredIdx = Index(
    'event_interactions_event_occurred_idx',
    'CREATE INDEX event_interactions_event_occurred_idx ON event_interactions (event_id, occurred_at)',
  );
  late final Index eventInteractionsTypeIdx = Index(
    'event_interactions_type_idx',
    'CREATE INDEX event_interactions_type_idx ON event_interactions (interaction_type)',
  );
  late final Index processingJobsStatusRetryIdx = Index(
    'processing_jobs_status_retry_idx',
    'CREATE INDEX processing_jobs_status_retry_idx ON processing_jobs (status, next_attempt_at)',
  );
  late final Index processingJobsMediaTypeIdx = Index(
    'processing_jobs_media_type_idx',
    'CREATE INDEX processing_jobs_media_type_idx ON processing_jobs (media_id, job_type)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    scanHistory,
    mediaItems,
    places,
    events,
    eventMedia,
    persons,
    eventPersons,
    mediaPersons,
    notes,
    voiceNotes,
    graphNodes,
    graphEdges,
    significanceScores,
    rediscoveryScores,
    contextScores,
    preservationRecommendations,
    reminders,
    userFeedback,
    privacySettings,
    eventInteractions,
    processingJobs,
    scanHistoryStartedAtIdx,
    scanHistoryStatusIdx,
    mediaItemsCaptureAtIdx,
    mediaItemsDuplicateFingerprintIdx,
    mediaItemsLastViewedAtIdx,
    mediaItemsScanIdIdx,
    placesNameIdx,
    eventsStartAtIdx,
    eventsLastViewedAtIdx,
    eventsAttentionIdx,
    eventMediaEventPositionIdx,
    eventMediaMediaIdIdx,
    personsDisplayNameIdx,
    eventPersonsPersonIdIdx,
    mediaPersonsPersonIdIdx,
    notesEventIdIdx,
    voiceNotesEventIdIdx,
    graphNodesTypeIdx,
    graphEdgesSourceIdx,
    graphEdgesTargetIdx,
    graphEdgesRelationIdx,
    significanceScoresEventEvaluatedIdx,
    rediscoveryScoresEventEvaluatedIdx,
    contextScoresEventEvaluatedIdx,
    recommendationsStatusCreatedIdx,
    recommendationsEventCreatedIdx,
    remindersStatusScheduledIdx,
    remindersEventIdIdx,
    userFeedbackRecommendationIdx,
    userFeedbackEventIdx,
    eventInteractionsEventOccurredIdx,
    eventInteractionsTypeIdx,
    processingJobsStatusRetryIdx,
    processingJobsMediaTypeIdx,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'scan_history',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('media_items', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'places',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('events', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'media_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('events', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_media', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'media_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_media', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_persons', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'persons',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_persons', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'media_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('media_persons', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'persons',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('media_persons', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('notes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('voice_notes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'graph_nodes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('graph_edges', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'graph_nodes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('graph_edges', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('significance_scores', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('rediscovery_scores', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('context_scores', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('preservation_recommendations', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reminders', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'preservation_recommendations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reminders', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_feedback', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'preservation_recommendations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_feedback', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_interactions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'media_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('processing_jobs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('processing_jobs', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ScanHistoryTableCreateCompanionBuilder =
    ScanHistoryCompanion Function({
      required String id,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
      required String status,
      required String permissionMode,
      Value<String?> resumeCursor,
      Value<int> discoveredCount,
      Value<int> processedCount,
      Value<int> importedCount,
      Value<int> skippedCount,
      Value<int> failedCount,
      Value<String?> errorSummary,
      Value<int> rowid,
    });
typedef $$ScanHistoryTableUpdateCompanionBuilder =
    ScanHistoryCompanion Function({
      Value<String> id,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<String> status,
      Value<String> permissionMode,
      Value<String?> resumeCursor,
      Value<int> discoveredCount,
      Value<int> processedCount,
      Value<int> importedCount,
      Value<int> skippedCount,
      Value<int> failedCount,
      Value<String?> errorSummary,
      Value<int> rowid,
    });

final class $$ScanHistoryTableReferences
    extends BaseReferences<_$AppDatabase, $ScanHistoryTable, ScanHistoryRow> {
  $$ScanHistoryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MediaItemsTable, List<MediaItemRow>>
  _mediaItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mediaItems,
    aliasName: $_aliasNameGenerator(db.scanHistory.id, db.mediaItems.scanId),
  );

  $$MediaItemsTableProcessedTableManager get mediaItemsRefs {
    final manager = $$MediaItemsTableTableManager(
      $_db,
      $_db.mediaItems,
    ).filter((f) => f.scanId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mediaItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ScanHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $ScanHistoryTable> {
  $$ScanHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get permissionMode => $composableBuilder(
    column: $table.permissionMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resumeCursor => $composableBuilder(
    column: $table.resumeCursor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discoveredCount => $composableBuilder(
    column: $table.discoveredCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get processedCount => $composableBuilder(
    column: $table.processedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get importedCount => $composableBuilder(
    column: $table.importedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get skippedCount => $composableBuilder(
    column: $table.skippedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get failedCount => $composableBuilder(
    column: $table.failedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorSummary => $composableBuilder(
    column: $table.errorSummary,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> mediaItemsRefs(
    Expression<bool> Function($$MediaItemsTableFilterComposer f) f,
  ) {
    final $$MediaItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.scanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableFilterComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ScanHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $ScanHistoryTable> {
  $$ScanHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get permissionMode => $composableBuilder(
    column: $table.permissionMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resumeCursor => $composableBuilder(
    column: $table.resumeCursor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discoveredCount => $composableBuilder(
    column: $table.discoveredCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get processedCount => $composableBuilder(
    column: $table.processedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get importedCount => $composableBuilder(
    column: $table.importedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get skippedCount => $composableBuilder(
    column: $table.skippedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get failedCount => $composableBuilder(
    column: $table.failedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorSummary => $composableBuilder(
    column: $table.errorSummary,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScanHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScanHistoryTable> {
  $$ScanHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get permissionMode => $composableBuilder(
    column: $table.permissionMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resumeCursor => $composableBuilder(
    column: $table.resumeCursor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get discoveredCount => $composableBuilder(
    column: $table.discoveredCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get processedCount => $composableBuilder(
    column: $table.processedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get importedCount => $composableBuilder(
    column: $table.importedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get skippedCount => $composableBuilder(
    column: $table.skippedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get failedCount => $composableBuilder(
    column: $table.failedCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorSummary => $composableBuilder(
    column: $table.errorSummary,
    builder: (column) => column,
  );

  Expression<T> mediaItemsRefs<T extends Object>(
    Expression<T> Function($$MediaItemsTableAnnotationComposer a) f,
  ) {
    final $$MediaItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.scanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ScanHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScanHistoryTable,
          ScanHistoryRow,
          $$ScanHistoryTableFilterComposer,
          $$ScanHistoryTableOrderingComposer,
          $$ScanHistoryTableAnnotationComposer,
          $$ScanHistoryTableCreateCompanionBuilder,
          $$ScanHistoryTableUpdateCompanionBuilder,
          (ScanHistoryRow, $$ScanHistoryTableReferences),
          ScanHistoryRow,
          PrefetchHooks Function({bool mediaItemsRefs})
        > {
  $$ScanHistoryTableTableManager(_$AppDatabase db, $ScanHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScanHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScanHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScanHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> permissionMode = const Value.absent(),
                Value<String?> resumeCursor = const Value.absent(),
                Value<int> discoveredCount = const Value.absent(),
                Value<int> processedCount = const Value.absent(),
                Value<int> importedCount = const Value.absent(),
                Value<int> skippedCount = const Value.absent(),
                Value<int> failedCount = const Value.absent(),
                Value<String?> errorSummary = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScanHistoryCompanion(
                id: id,
                startedAt: startedAt,
                completedAt: completedAt,
                status: status,
                permissionMode: permissionMode,
                resumeCursor: resumeCursor,
                discoveredCount: discoveredCount,
                processedCount: processedCount,
                importedCount: importedCount,
                skippedCount: skippedCount,
                failedCount: failedCount,
                errorSummary: errorSummary,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                required String status,
                required String permissionMode,
                Value<String?> resumeCursor = const Value.absent(),
                Value<int> discoveredCount = const Value.absent(),
                Value<int> processedCount = const Value.absent(),
                Value<int> importedCount = const Value.absent(),
                Value<int> skippedCount = const Value.absent(),
                Value<int> failedCount = const Value.absent(),
                Value<String?> errorSummary = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScanHistoryCompanion.insert(
                id: id,
                startedAt: startedAt,
                completedAt: completedAt,
                status: status,
                permissionMode: permissionMode,
                resumeCursor: resumeCursor,
                discoveredCount: discoveredCount,
                processedCount: processedCount,
                importedCount: importedCount,
                skippedCount: skippedCount,
                failedCount: failedCount,
                errorSummary: errorSummary,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ScanHistoryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mediaItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (mediaItemsRefs) db.mediaItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mediaItemsRefs)
                    await $_getPrefetchedData<
                      ScanHistoryRow,
                      $ScanHistoryTable,
                      MediaItemRow
                    >(
                      currentTable: table,
                      referencedTable: $$ScanHistoryTableReferences
                          ._mediaItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ScanHistoryTableReferences(
                            db,
                            table,
                            p0,
                          ).mediaItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.scanId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ScanHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScanHistoryTable,
      ScanHistoryRow,
      $$ScanHistoryTableFilterComposer,
      $$ScanHistoryTableOrderingComposer,
      $$ScanHistoryTableAnnotationComposer,
      $$ScanHistoryTableCreateCompanionBuilder,
      $$ScanHistoryTableUpdateCompanionBuilder,
      (ScanHistoryRow, $$ScanHistoryTableReferences),
      ScanHistoryRow,
      PrefetchHooks Function({bool mediaItemsRefs})
    >;
typedef $$MediaItemsTableCreateCompanionBuilder =
    MediaItemsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String assetId,
      Value<String?> assetUri,
      required String mediaType,
      Value<String?> mimeType,
      required DateTime captureAt,
      Value<DateTime?> modifiedAt,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<int?> width,
      Value<int?> height,
      Value<int?> durationMs,
      Value<int?> fileSizeBytes,
      Value<String?> ocrText,
      Value<String?> normalizedOcrText,
      Value<String?> duplicateFingerprint,
      Value<Uint8List?> visualEmbedding,
      Value<String?> thumbnailKey,
      Value<DateTime?> lastViewedAt,
      Value<int> viewCount,
      Value<bool> isAvailable,
      Value<bool> isDemo,
      Value<DateTime> importedAt,
      Value<String?> scanId,
      Value<int> rowid,
    });
typedef $$MediaItemsTableUpdateCompanionBuilder =
    MediaItemsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> assetId,
      Value<String?> assetUri,
      Value<String> mediaType,
      Value<String?> mimeType,
      Value<DateTime> captureAt,
      Value<DateTime?> modifiedAt,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<int?> width,
      Value<int?> height,
      Value<int?> durationMs,
      Value<int?> fileSizeBytes,
      Value<String?> ocrText,
      Value<String?> normalizedOcrText,
      Value<String?> duplicateFingerprint,
      Value<Uint8List?> visualEmbedding,
      Value<String?> thumbnailKey,
      Value<DateTime?> lastViewedAt,
      Value<int> viewCount,
      Value<bool> isAvailable,
      Value<bool> isDemo,
      Value<DateTime> importedAt,
      Value<String?> scanId,
      Value<int> rowid,
    });

final class $$MediaItemsTableReferences
    extends BaseReferences<_$AppDatabase, $MediaItemsTable, MediaItemRow> {
  $$MediaItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ScanHistoryTable _scanIdTable(_$AppDatabase db) =>
      db.scanHistory.createAlias(
        $_aliasNameGenerator(db.mediaItems.scanId, db.scanHistory.id),
      );

  $$ScanHistoryTableProcessedTableManager? get scanId {
    final $_column = $_itemColumn<String>('scan_id');
    if ($_column == null) return null;
    final manager = $$ScanHistoryTableTableManager(
      $_db,
      $_db.scanHistory,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_scanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$EventsTable, List<MemoryEventRow>>
  _eventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.events,
    aliasName: $_aliasNameGenerator(db.mediaItems.id, db.events.coverMediaId),
  );

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.coverMediaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventMediaTable, List<EventMediaRow>>
  _eventMediaRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventMedia,
    aliasName: $_aliasNameGenerator(db.mediaItems.id, db.eventMedia.mediaId),
  );

  $$EventMediaTableProcessedTableManager get eventMediaRefs {
    final manager = $$EventMediaTableTableManager(
      $_db,
      $_db.eventMedia,
    ).filter((f) => f.mediaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventMediaRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MediaPersonsTable, List<MediaPersonRow>>
  _mediaPersonsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mediaPersons,
    aliasName: $_aliasNameGenerator(db.mediaItems.id, db.mediaPersons.mediaId),
  );

  $$MediaPersonsTableProcessedTableManager get mediaPersonsRefs {
    final manager = $$MediaPersonsTableTableManager(
      $_db,
      $_db.mediaPersons,
    ).filter((f) => f.mediaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mediaPersonsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProcessingJobsTable, List<ProcessingJobRow>>
  _processingJobsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.processingJobs,
    aliasName: $_aliasNameGenerator(
      db.mediaItems.id,
      db.processingJobs.mediaId,
    ),
  );

  $$ProcessingJobsTableProcessedTableManager get processingJobsRefs {
    final manager = $$ProcessingJobsTableTableManager(
      $_db,
      $_db.processingJobs,
    ).filter((f) => f.mediaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_processingJobsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MediaItemsTableFilterComposer
    extends Composer<_$AppDatabase, $MediaItemsTable> {
  $$MediaItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetId => $composableBuilder(
    column: $table.assetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetUri => $composableBuilder(
    column: $table.assetUri,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get captureAt => $composableBuilder(
    column: $table.captureAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ocrText => $composableBuilder(
    column: $table.ocrText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedOcrText => $composableBuilder(
    column: $table.normalizedOcrText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get duplicateFingerprint => $composableBuilder(
    column: $table.duplicateFingerprint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get visualEmbedding => $composableBuilder(
    column: $table.visualEmbedding,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailKey => $composableBuilder(
    column: $table.thumbnailKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastViewedAt => $composableBuilder(
    column: $table.lastViewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get viewCount => $composableBuilder(
    column: $table.viewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDemo => $composableBuilder(
    column: $table.isDemo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ScanHistoryTableFilterComposer get scanId {
    final $$ScanHistoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scanId,
      referencedTable: $db.scanHistory,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanHistoryTableFilterComposer(
            $db: $db,
            $table: $db.scanHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> eventsRefs(
    Expression<bool> Function($$EventsTableFilterComposer f) f,
  ) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.coverMediaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventMediaRefs(
    Expression<bool> Function($$EventMediaTableFilterComposer f) f,
  ) {
    final $$EventMediaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventMedia,
      getReferencedColumn: (t) => t.mediaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventMediaTableFilterComposer(
            $db: $db,
            $table: $db.eventMedia,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mediaPersonsRefs(
    Expression<bool> Function($$MediaPersonsTableFilterComposer f) f,
  ) {
    final $$MediaPersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mediaPersons,
      getReferencedColumn: (t) => t.mediaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaPersonsTableFilterComposer(
            $db: $db,
            $table: $db.mediaPersons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> processingJobsRefs(
    Expression<bool> Function($$ProcessingJobsTableFilterComposer f) f,
  ) {
    final $$ProcessingJobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.processingJobs,
      getReferencedColumn: (t) => t.mediaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProcessingJobsTableFilterComposer(
            $db: $db,
            $table: $db.processingJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MediaItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $MediaItemsTable> {
  $$MediaItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetId => $composableBuilder(
    column: $table.assetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetUri => $composableBuilder(
    column: $table.assetUri,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get captureAt => $composableBuilder(
    column: $table.captureAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ocrText => $composableBuilder(
    column: $table.ocrText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedOcrText => $composableBuilder(
    column: $table.normalizedOcrText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get duplicateFingerprint => $composableBuilder(
    column: $table.duplicateFingerprint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get visualEmbedding => $composableBuilder(
    column: $table.visualEmbedding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailKey => $composableBuilder(
    column: $table.thumbnailKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastViewedAt => $composableBuilder(
    column: $table.lastViewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get viewCount => $composableBuilder(
    column: $table.viewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDemo => $composableBuilder(
    column: $table.isDemo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ScanHistoryTableOrderingComposer get scanId {
    final $$ScanHistoryTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scanId,
      referencedTable: $db.scanHistory,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanHistoryTableOrderingComposer(
            $db: $db,
            $table: $db.scanHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MediaItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MediaItemsTable> {
  $$MediaItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get assetId =>
      $composableBuilder(column: $table.assetId, builder: (column) => column);

  GeneratedColumn<String> get assetUri =>
      $composableBuilder(column: $table.assetUri, builder: (column) => column);

  GeneratedColumn<String> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<DateTime> get captureAt =>
      $composableBuilder(column: $table.captureAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<int> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ocrText =>
      $composableBuilder(column: $table.ocrText, builder: (column) => column);

  GeneratedColumn<String> get normalizedOcrText => $composableBuilder(
    column: $table.normalizedOcrText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get duplicateFingerprint => $composableBuilder(
    column: $table.duplicateFingerprint,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get visualEmbedding => $composableBuilder(
    column: $table.visualEmbedding,
    builder: (column) => column,
  );

  GeneratedColumn<String> get thumbnailKey => $composableBuilder(
    column: $table.thumbnailKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastViewedAt => $composableBuilder(
    column: $table.lastViewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get viewCount =>
      $composableBuilder(column: $table.viewCount, builder: (column) => column);

  GeneratedColumn<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDemo =>
      $composableBuilder(column: $table.isDemo, builder: (column) => column);

  GeneratedColumn<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => column,
  );

  $$ScanHistoryTableAnnotationComposer get scanId {
    final $$ScanHistoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scanId,
      referencedTable: $db.scanHistory,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanHistoryTableAnnotationComposer(
            $db: $db,
            $table: $db.scanHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> eventsRefs<T extends Object>(
    Expression<T> Function($$EventsTableAnnotationComposer a) f,
  ) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.coverMediaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventMediaRefs<T extends Object>(
    Expression<T> Function($$EventMediaTableAnnotationComposer a) f,
  ) {
    final $$EventMediaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventMedia,
      getReferencedColumn: (t) => t.mediaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventMediaTableAnnotationComposer(
            $db: $db,
            $table: $db.eventMedia,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mediaPersonsRefs<T extends Object>(
    Expression<T> Function($$MediaPersonsTableAnnotationComposer a) f,
  ) {
    final $$MediaPersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mediaPersons,
      getReferencedColumn: (t) => t.mediaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaPersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaPersons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> processingJobsRefs<T extends Object>(
    Expression<T> Function($$ProcessingJobsTableAnnotationComposer a) f,
  ) {
    final $$ProcessingJobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.processingJobs,
      getReferencedColumn: (t) => t.mediaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProcessingJobsTableAnnotationComposer(
            $db: $db,
            $table: $db.processingJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MediaItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MediaItemsTable,
          MediaItemRow,
          $$MediaItemsTableFilterComposer,
          $$MediaItemsTableOrderingComposer,
          $$MediaItemsTableAnnotationComposer,
          $$MediaItemsTableCreateCompanionBuilder,
          $$MediaItemsTableUpdateCompanionBuilder,
          (MediaItemRow, $$MediaItemsTableReferences),
          MediaItemRow,
          PrefetchHooks Function({
            bool scanId,
            bool eventsRefs,
            bool eventMediaRefs,
            bool mediaPersonsRefs,
            bool processingJobsRefs,
          })
        > {
  $$MediaItemsTableTableManager(_$AppDatabase db, $MediaItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> assetId = const Value.absent(),
                Value<String?> assetUri = const Value.absent(),
                Value<String> mediaType = const Value.absent(),
                Value<String?> mimeType = const Value.absent(),
                Value<DateTime> captureAt = const Value.absent(),
                Value<DateTime?> modifiedAt = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<int?> width = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<int?> durationMs = const Value.absent(),
                Value<int?> fileSizeBytes = const Value.absent(),
                Value<String?> ocrText = const Value.absent(),
                Value<String?> normalizedOcrText = const Value.absent(),
                Value<String?> duplicateFingerprint = const Value.absent(),
                Value<Uint8List?> visualEmbedding = const Value.absent(),
                Value<String?> thumbnailKey = const Value.absent(),
                Value<DateTime?> lastViewedAt = const Value.absent(),
                Value<int> viewCount = const Value.absent(),
                Value<bool> isAvailable = const Value.absent(),
                Value<bool> isDemo = const Value.absent(),
                Value<DateTime> importedAt = const Value.absent(),
                Value<String?> scanId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MediaItemsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                assetId: assetId,
                assetUri: assetUri,
                mediaType: mediaType,
                mimeType: mimeType,
                captureAt: captureAt,
                modifiedAt: modifiedAt,
                latitude: latitude,
                longitude: longitude,
                width: width,
                height: height,
                durationMs: durationMs,
                fileSizeBytes: fileSizeBytes,
                ocrText: ocrText,
                normalizedOcrText: normalizedOcrText,
                duplicateFingerprint: duplicateFingerprint,
                visualEmbedding: visualEmbedding,
                thumbnailKey: thumbnailKey,
                lastViewedAt: lastViewedAt,
                viewCount: viewCount,
                isAvailable: isAvailable,
                isDemo: isDemo,
                importedAt: importedAt,
                scanId: scanId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String assetId,
                Value<String?> assetUri = const Value.absent(),
                required String mediaType,
                Value<String?> mimeType = const Value.absent(),
                required DateTime captureAt,
                Value<DateTime?> modifiedAt = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<int?> width = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<int?> durationMs = const Value.absent(),
                Value<int?> fileSizeBytes = const Value.absent(),
                Value<String?> ocrText = const Value.absent(),
                Value<String?> normalizedOcrText = const Value.absent(),
                Value<String?> duplicateFingerprint = const Value.absent(),
                Value<Uint8List?> visualEmbedding = const Value.absent(),
                Value<String?> thumbnailKey = const Value.absent(),
                Value<DateTime?> lastViewedAt = const Value.absent(),
                Value<int> viewCount = const Value.absent(),
                Value<bool> isAvailable = const Value.absent(),
                Value<bool> isDemo = const Value.absent(),
                Value<DateTime> importedAt = const Value.absent(),
                Value<String?> scanId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MediaItemsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                assetId: assetId,
                assetUri: assetUri,
                mediaType: mediaType,
                mimeType: mimeType,
                captureAt: captureAt,
                modifiedAt: modifiedAt,
                latitude: latitude,
                longitude: longitude,
                width: width,
                height: height,
                durationMs: durationMs,
                fileSizeBytes: fileSizeBytes,
                ocrText: ocrText,
                normalizedOcrText: normalizedOcrText,
                duplicateFingerprint: duplicateFingerprint,
                visualEmbedding: visualEmbedding,
                thumbnailKey: thumbnailKey,
                lastViewedAt: lastViewedAt,
                viewCount: viewCount,
                isAvailable: isAvailable,
                isDemo: isDemo,
                importedAt: importedAt,
                scanId: scanId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MediaItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                scanId = false,
                eventsRefs = false,
                eventMediaRefs = false,
                mediaPersonsRefs = false,
                processingJobsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventsRefs) db.events,
                    if (eventMediaRefs) db.eventMedia,
                    if (mediaPersonsRefs) db.mediaPersons,
                    if (processingJobsRefs) db.processingJobs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (scanId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.scanId,
                                    referencedTable: $$MediaItemsTableReferences
                                        ._scanIdTable(db),
                                    referencedColumn:
                                        $$MediaItemsTableReferences
                                            ._scanIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventsRefs)
                        await $_getPrefetchedData<
                          MediaItemRow,
                          $MediaItemsTable,
                          MemoryEventRow
                        >(
                          currentTable: table,
                          referencedTable: $$MediaItemsTableReferences
                              ._eventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MediaItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.coverMediaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventMediaRefs)
                        await $_getPrefetchedData<
                          MediaItemRow,
                          $MediaItemsTable,
                          EventMediaRow
                        >(
                          currentTable: table,
                          referencedTable: $$MediaItemsTableReferences
                              ._eventMediaRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MediaItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventMediaRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mediaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mediaPersonsRefs)
                        await $_getPrefetchedData<
                          MediaItemRow,
                          $MediaItemsTable,
                          MediaPersonRow
                        >(
                          currentTable: table,
                          referencedTable: $$MediaItemsTableReferences
                              ._mediaPersonsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MediaItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).mediaPersonsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mediaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (processingJobsRefs)
                        await $_getPrefetchedData<
                          MediaItemRow,
                          $MediaItemsTable,
                          ProcessingJobRow
                        >(
                          currentTable: table,
                          referencedTable: $$MediaItemsTableReferences
                              ._processingJobsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MediaItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).processingJobsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mediaId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MediaItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MediaItemsTable,
      MediaItemRow,
      $$MediaItemsTableFilterComposer,
      $$MediaItemsTableOrderingComposer,
      $$MediaItemsTableAnnotationComposer,
      $$MediaItemsTableCreateCompanionBuilder,
      $$MediaItemsTableUpdateCompanionBuilder,
      (MediaItemRow, $$MediaItemsTableReferences),
      MediaItemRow,
      PrefetchHooks Function({
        bool scanId,
        bool eventsRefs,
        bool eventMediaRefs,
        bool mediaPersonsRefs,
        bool processingJobsRefs,
      })
    >;
typedef $$PlacesTableCreateCompanionBuilder =
    PlacesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String name,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> locality,
      Value<String?> city,
      Value<String?> region,
      Value<String?> country,
      Value<String?> formattedAddress,
      Value<bool> isConfirmed,
      Value<bool> isDemo,
      Value<int> rowid,
    });
typedef $$PlacesTableUpdateCompanionBuilder =
    PlacesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> name,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> locality,
      Value<String?> city,
      Value<String?> region,
      Value<String?> country,
      Value<String?> formattedAddress,
      Value<bool> isConfirmed,
      Value<bool> isDemo,
      Value<int> rowid,
    });

final class $$PlacesTableReferences
    extends BaseReferences<_$AppDatabase, $PlacesTable, PlaceRow> {
  $$PlacesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EventsTable, List<MemoryEventRow>>
  _eventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.events,
    aliasName: $_aliasNameGenerator(db.places.id, db.events.placeId),
  );

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.placeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlacesTableFilterComposer
    extends Composer<_$AppDatabase, $PlacesTable> {
  $$PlacesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locality => $composableBuilder(
    column: $table.locality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formattedAddress => $composableBuilder(
    column: $table.formattedAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isConfirmed => $composableBuilder(
    column: $table.isConfirmed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDemo => $composableBuilder(
    column: $table.isDemo,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> eventsRefs(
    Expression<bool> Function($$EventsTableFilterComposer f) f,
  ) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.placeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlacesTableOrderingComposer
    extends Composer<_$AppDatabase, $PlacesTable> {
  $$PlacesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locality => $composableBuilder(
    column: $table.locality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formattedAddress => $composableBuilder(
    column: $table.formattedAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isConfirmed => $composableBuilder(
    column: $table.isConfirmed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDemo => $composableBuilder(
    column: $table.isDemo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlacesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlacesTable> {
  $$PlacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get locality =>
      $composableBuilder(column: $table.locality, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get formattedAddress => $composableBuilder(
    column: $table.formattedAddress,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isConfirmed => $composableBuilder(
    column: $table.isConfirmed,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDemo =>
      $composableBuilder(column: $table.isDemo, builder: (column) => column);

  Expression<T> eventsRefs<T extends Object>(
    Expression<T> Function($$EventsTableAnnotationComposer a) f,
  ) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.placeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlacesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlacesTable,
          PlaceRow,
          $$PlacesTableFilterComposer,
          $$PlacesTableOrderingComposer,
          $$PlacesTableAnnotationComposer,
          $$PlacesTableCreateCompanionBuilder,
          $$PlacesTableUpdateCompanionBuilder,
          (PlaceRow, $$PlacesTableReferences),
          PlaceRow,
          PrefetchHooks Function({bool eventsRefs})
        > {
  $$PlacesTableTableManager(_$AppDatabase db, $PlacesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> locality = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> formattedAddress = const Value.absent(),
                Value<bool> isConfirmed = const Value.absent(),
                Value<bool> isDemo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlacesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                name: name,
                latitude: latitude,
                longitude: longitude,
                locality: locality,
                city: city,
                region: region,
                country: country,
                formattedAddress: formattedAddress,
                isConfirmed: isConfirmed,
                isDemo: isDemo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String name,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> locality = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> formattedAddress = const Value.absent(),
                Value<bool> isConfirmed = const Value.absent(),
                Value<bool> isDemo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlacesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                name: name,
                latitude: latitude,
                longitude: longitude,
                locality: locality,
                city: city,
                region: region,
                country: country,
                formattedAddress: formattedAddress,
                isConfirmed: isConfirmed,
                isDemo: isDemo,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PlacesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({eventsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (eventsRefs) db.events],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (eventsRefs)
                    await $_getPrefetchedData<
                      PlaceRow,
                      $PlacesTable,
                      MemoryEventRow
                    >(
                      currentTable: table,
                      referencedTable: $$PlacesTableReferences._eventsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$PlacesTableReferences(db, table, p0).eventsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.placeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PlacesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlacesTable,
      PlaceRow,
      $$PlacesTableFilterComposer,
      $$PlacesTableOrderingComposer,
      $$PlacesTableAnnotationComposer,
      $$PlacesTableCreateCompanionBuilder,
      $$PlacesTableUpdateCompanionBuilder,
      (PlaceRow, $$PlacesTableReferences),
      PlaceRow,
      PrefetchHooks Function({bool eventsRefs})
    >;
typedef $$EventsTableCreateCompanionBuilder =
    EventsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String generatedTitle,
      Value<String?> confirmedTitle,
      Value<bool> isTitleConfirmed,
      Value<String?> description,
      required DateTime startAt,
      required DateTime endAt,
      Value<String?> placeId,
      Value<String?> coverMediaId,
      Value<bool> isCoverUserSelected,
      Value<bool> isFavourite,
      Value<int?> manualRating,
      Value<bool> isImportant,
      Value<bool> isSensitive,
      Value<bool> isHidden,
      Value<int> viewCount,
      Value<DateTime?> lastViewedAt,
      Value<String> source,
      Value<String?> clusteringVersion,
      Value<DateTime> generatedAt,
      Value<bool> isDemo,
      Value<int> rowid,
    });
typedef $$EventsTableUpdateCompanionBuilder =
    EventsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> generatedTitle,
      Value<String?> confirmedTitle,
      Value<bool> isTitleConfirmed,
      Value<String?> description,
      Value<DateTime> startAt,
      Value<DateTime> endAt,
      Value<String?> placeId,
      Value<String?> coverMediaId,
      Value<bool> isCoverUserSelected,
      Value<bool> isFavourite,
      Value<int?> manualRating,
      Value<bool> isImportant,
      Value<bool> isSensitive,
      Value<bool> isHidden,
      Value<int> viewCount,
      Value<DateTime?> lastViewedAt,
      Value<String> source,
      Value<String?> clusteringVersion,
      Value<DateTime> generatedAt,
      Value<bool> isDemo,
      Value<int> rowid,
    });

final class $$EventsTableReferences
    extends BaseReferences<_$AppDatabase, $EventsTable, MemoryEventRow> {
  $$EventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlacesTable _placeIdTable(_$AppDatabase db) => db.places.createAlias(
    $_aliasNameGenerator(db.events.placeId, db.places.id),
  );

  $$PlacesTableProcessedTableManager? get placeId {
    final $_column = $_itemColumn<String>('place_id');
    if ($_column == null) return null;
    final manager = $$PlacesTableTableManager(
      $_db,
      $_db.places,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_placeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MediaItemsTable _coverMediaIdTable(_$AppDatabase db) =>
      db.mediaItems.createAlias(
        $_aliasNameGenerator(db.events.coverMediaId, db.mediaItems.id),
      );

  $$MediaItemsTableProcessedTableManager? get coverMediaId {
    final $_column = $_itemColumn<String>('cover_media_id');
    if ($_column == null) return null;
    final manager = $$MediaItemsTableTableManager(
      $_db,
      $_db.mediaItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coverMediaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$EventMediaTable, List<EventMediaRow>>
  _eventMediaRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventMedia,
    aliasName: $_aliasNameGenerator(db.events.id, db.eventMedia.eventId),
  );

  $$EventMediaTableProcessedTableManager get eventMediaRefs {
    final manager = $$EventMediaTableTableManager(
      $_db,
      $_db.eventMedia,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventMediaRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventPersonsTable, List<EventPersonRow>>
  _eventPersonsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventPersons,
    aliasName: $_aliasNameGenerator(db.events.id, db.eventPersons.eventId),
  );

  $$EventPersonsTableProcessedTableManager get eventPersonsRefs {
    final manager = $$EventPersonsTableTableManager(
      $_db,
      $_db.eventPersons,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventPersonsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$NotesTable, List<NoteRow>> _notesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.notes,
    aliasName: $_aliasNameGenerator(db.events.id, db.notes.eventId),
  );

  $$NotesTableProcessedTableManager get notesRefs {
    final manager = $$NotesTableTableManager(
      $_db,
      $_db.notes,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_notesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VoiceNotesTable, List<VoiceNoteRow>>
  _voiceNotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.voiceNotes,
    aliasName: $_aliasNameGenerator(db.events.id, db.voiceNotes.eventId),
  );

  $$VoiceNotesTableProcessedTableManager get voiceNotesRefs {
    final manager = $$VoiceNotesTableTableManager(
      $_db,
      $_db.voiceNotes,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_voiceNotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SignificanceScoresTable,
    List<SignificanceScoreRow>
  >
  _significanceScoresRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.significanceScores,
        aliasName: $_aliasNameGenerator(
          db.events.id,
          db.significanceScores.eventId,
        ),
      );

  $$SignificanceScoresTableProcessedTableManager get significanceScoresRefs {
    final manager = $$SignificanceScoresTableTableManager(
      $_db,
      $_db.significanceScores,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _significanceScoresRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RediscoveryScoresTable, List<RediscoveryScoreRow>>
  _rediscoveryScoresRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.rediscoveryScores,
        aliasName: $_aliasNameGenerator(
          db.events.id,
          db.rediscoveryScores.eventId,
        ),
      );

  $$RediscoveryScoresTableProcessedTableManager get rediscoveryScoresRefs {
    final manager = $$RediscoveryScoresTableTableManager(
      $_db,
      $_db.rediscoveryScores,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _rediscoveryScoresRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ContextScoresTable, List<ContextScoreRow>>
  _contextScoresRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contextScores,
    aliasName: $_aliasNameGenerator(db.events.id, db.contextScores.eventId),
  );

  $$ContextScoresTableProcessedTableManager get contextScoresRefs {
    final manager = $$ContextScoresTableTableManager(
      $_db,
      $_db.contextScores,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contextScoresRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PreservationRecommendationsTable,
    List<PreservationRecommendationRow>
  >
  _preservationRecommendationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.preservationRecommendations,
        aliasName: $_aliasNameGenerator(
          db.events.id,
          db.preservationRecommendations.eventId,
        ),
      );

  $$PreservationRecommendationsTableProcessedTableManager
  get preservationRecommendationsRefs {
    final manager = $$PreservationRecommendationsTableTableManager(
      $_db,
      $_db.preservationRecommendations,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _preservationRecommendationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RemindersTable, List<ReminderRow>>
  _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminders,
    aliasName: $_aliasNameGenerator(db.events.id, db.reminders.eventId),
  );

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager(
      $_db,
      $_db.reminders,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UserFeedbackTable, List<UserFeedbackRow>>
  _userFeedbackRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userFeedback,
    aliasName: $_aliasNameGenerator(db.events.id, db.userFeedback.eventId),
  );

  $$UserFeedbackTableProcessedTableManager get userFeedbackRefs {
    final manager = $$UserFeedbackTableTableManager(
      $_db,
      $_db.userFeedback,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userFeedbackRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventInteractionsTable, List<EventInteractionRow>>
  _eventInteractionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.eventInteractions,
        aliasName: $_aliasNameGenerator(
          db.events.id,
          db.eventInteractions.eventId,
        ),
      );

  $$EventInteractionsTableProcessedTableManager get eventInteractionsRefs {
    final manager = $$EventInteractionsTableTableManager(
      $_db,
      $_db.eventInteractions,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventInteractionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProcessingJobsTable, List<ProcessingJobRow>>
  _processingJobsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.processingJobs,
    aliasName: $_aliasNameGenerator(db.events.id, db.processingJobs.eventId),
  );

  $$ProcessingJobsTableProcessedTableManager get processingJobsRefs {
    final manager = $$ProcessingJobsTableTableManager(
      $_db,
      $_db.processingJobs,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_processingJobsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EventsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get generatedTitle => $composableBuilder(
    column: $table.generatedTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get confirmedTitle => $composableBuilder(
    column: $table.confirmedTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isTitleConfirmed => $composableBuilder(
    column: $table.isTitleConfirmed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCoverUserSelected => $composableBuilder(
    column: $table.isCoverUserSelected,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavourite => $composableBuilder(
    column: $table.isFavourite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get manualRating => $composableBuilder(
    column: $table.manualRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isImportant => $composableBuilder(
    column: $table.isImportant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSensitive => $composableBuilder(
    column: $table.isSensitive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get viewCount => $composableBuilder(
    column: $table.viewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastViewedAt => $composableBuilder(
    column: $table.lastViewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clusteringVersion => $composableBuilder(
    column: $table.clusteringVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDemo => $composableBuilder(
    column: $table.isDemo,
    builder: (column) => ColumnFilters(column),
  );

  $$PlacesTableFilterComposer get placeId {
    final $$PlacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.placeId,
      referencedTable: $db.places,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlacesTableFilterComposer(
            $db: $db,
            $table: $db.places,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaItemsTableFilterComposer get coverMediaId {
    final $$MediaItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coverMediaId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableFilterComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> eventMediaRefs(
    Expression<bool> Function($$EventMediaTableFilterComposer f) f,
  ) {
    final $$EventMediaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventMedia,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventMediaTableFilterComposer(
            $db: $db,
            $table: $db.eventMedia,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventPersonsRefs(
    Expression<bool> Function($$EventPersonsTableFilterComposer f) f,
  ) {
    final $$EventPersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventPersons,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventPersonsTableFilterComposer(
            $db: $db,
            $table: $db.eventPersons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> notesRefs(
    Expression<bool> Function($$NotesTableFilterComposer f) f,
  ) {
    final $$NotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotesTableFilterComposer(
            $db: $db,
            $table: $db.notes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> voiceNotesRefs(
    Expression<bool> Function($$VoiceNotesTableFilterComposer f) f,
  ) {
    final $$VoiceNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.voiceNotes,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VoiceNotesTableFilterComposer(
            $db: $db,
            $table: $db.voiceNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> significanceScoresRefs(
    Expression<bool> Function($$SignificanceScoresTableFilterComposer f) f,
  ) {
    final $$SignificanceScoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.significanceScores,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SignificanceScoresTableFilterComposer(
            $db: $db,
            $table: $db.significanceScores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> rediscoveryScoresRefs(
    Expression<bool> Function($$RediscoveryScoresTableFilterComposer f) f,
  ) {
    final $$RediscoveryScoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rediscoveryScores,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RediscoveryScoresTableFilterComposer(
            $db: $db,
            $table: $db.rediscoveryScores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> contextScoresRefs(
    Expression<bool> Function($$ContextScoresTableFilterComposer f) f,
  ) {
    final $$ContextScoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contextScores,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextScoresTableFilterComposer(
            $db: $db,
            $table: $db.contextScores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> preservationRecommendationsRefs(
    Expression<bool> Function(
      $$PreservationRecommendationsTableFilterComposer f,
    )
    f,
  ) {
    final $$PreservationRecommendationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.preservationRecommendations,
          getReferencedColumn: (t) => t.eventId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PreservationRecommendationsTableFilterComposer(
                $db: $db,
                $table: $db.preservationRecommendations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> remindersRefs(
    Expression<bool> Function($$RemindersTableFilterComposer f) f,
  ) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userFeedbackRefs(
    Expression<bool> Function($$UserFeedbackTableFilterComposer f) f,
  ) {
    final $$UserFeedbackTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userFeedback,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserFeedbackTableFilterComposer(
            $db: $db,
            $table: $db.userFeedback,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventInteractionsRefs(
    Expression<bool> Function($$EventInteractionsTableFilterComposer f) f,
  ) {
    final $$EventInteractionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventInteractions,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventInteractionsTableFilterComposer(
            $db: $db,
            $table: $db.eventInteractions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> processingJobsRefs(
    Expression<bool> Function($$ProcessingJobsTableFilterComposer f) f,
  ) {
    final $$ProcessingJobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.processingJobs,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProcessingJobsTableFilterComposer(
            $db: $db,
            $table: $db.processingJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get generatedTitle => $composableBuilder(
    column: $table.generatedTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get confirmedTitle => $composableBuilder(
    column: $table.confirmedTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isTitleConfirmed => $composableBuilder(
    column: $table.isTitleConfirmed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCoverUserSelected => $composableBuilder(
    column: $table.isCoverUserSelected,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavourite => $composableBuilder(
    column: $table.isFavourite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get manualRating => $composableBuilder(
    column: $table.manualRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isImportant => $composableBuilder(
    column: $table.isImportant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSensitive => $composableBuilder(
    column: $table.isSensitive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get viewCount => $composableBuilder(
    column: $table.viewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastViewedAt => $composableBuilder(
    column: $table.lastViewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clusteringVersion => $composableBuilder(
    column: $table.clusteringVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDemo => $composableBuilder(
    column: $table.isDemo,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlacesTableOrderingComposer get placeId {
    final $$PlacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.placeId,
      referencedTable: $db.places,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlacesTableOrderingComposer(
            $db: $db,
            $table: $db.places,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaItemsTableOrderingComposer get coverMediaId {
    final $$MediaItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coverMediaId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableOrderingComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get generatedTitle => $composableBuilder(
    column: $table.generatedTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get confirmedTitle => $composableBuilder(
    column: $table.confirmedTitle,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isTitleConfirmed => $composableBuilder(
    column: $table.isTitleConfirmed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endAt =>
      $composableBuilder(column: $table.endAt, builder: (column) => column);

  GeneratedColumn<bool> get isCoverUserSelected => $composableBuilder(
    column: $table.isCoverUserSelected,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavourite => $composableBuilder(
    column: $table.isFavourite,
    builder: (column) => column,
  );

  GeneratedColumn<int> get manualRating => $composableBuilder(
    column: $table.manualRating,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isImportant => $composableBuilder(
    column: $table.isImportant,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSensitive => $composableBuilder(
    column: $table.isSensitive,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isHidden =>
      $composableBuilder(column: $table.isHidden, builder: (column) => column);

  GeneratedColumn<int> get viewCount =>
      $composableBuilder(column: $table.viewCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastViewedAt => $composableBuilder(
    column: $table.lastViewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get clusteringVersion => $composableBuilder(
    column: $table.clusteringVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDemo =>
      $composableBuilder(column: $table.isDemo, builder: (column) => column);

  $$PlacesTableAnnotationComposer get placeId {
    final $$PlacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.placeId,
      referencedTable: $db.places,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlacesTableAnnotationComposer(
            $db: $db,
            $table: $db.places,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaItemsTableAnnotationComposer get coverMediaId {
    final $$MediaItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coverMediaId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> eventMediaRefs<T extends Object>(
    Expression<T> Function($$EventMediaTableAnnotationComposer a) f,
  ) {
    final $$EventMediaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventMedia,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventMediaTableAnnotationComposer(
            $db: $db,
            $table: $db.eventMedia,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventPersonsRefs<T extends Object>(
    Expression<T> Function($$EventPersonsTableAnnotationComposer a) f,
  ) {
    final $$EventPersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventPersons,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventPersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.eventPersons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> notesRefs<T extends Object>(
    Expression<T> Function($$NotesTableAnnotationComposer a) f,
  ) {
    final $$NotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotesTableAnnotationComposer(
            $db: $db,
            $table: $db.notes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> voiceNotesRefs<T extends Object>(
    Expression<T> Function($$VoiceNotesTableAnnotationComposer a) f,
  ) {
    final $$VoiceNotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.voiceNotes,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VoiceNotesTableAnnotationComposer(
            $db: $db,
            $table: $db.voiceNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> significanceScoresRefs<T extends Object>(
    Expression<T> Function($$SignificanceScoresTableAnnotationComposer a) f,
  ) {
    final $$SignificanceScoresTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.significanceScores,
          getReferencedColumn: (t) => t.eventId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SignificanceScoresTableAnnotationComposer(
                $db: $db,
                $table: $db.significanceScores,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> rediscoveryScoresRefs<T extends Object>(
    Expression<T> Function($$RediscoveryScoresTableAnnotationComposer a) f,
  ) {
    final $$RediscoveryScoresTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.rediscoveryScores,
          getReferencedColumn: (t) => t.eventId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RediscoveryScoresTableAnnotationComposer(
                $db: $db,
                $table: $db.rediscoveryScores,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> contextScoresRefs<T extends Object>(
    Expression<T> Function($$ContextScoresTableAnnotationComposer a) f,
  ) {
    final $$ContextScoresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contextScores,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContextScoresTableAnnotationComposer(
            $db: $db,
            $table: $db.contextScores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> preservationRecommendationsRefs<T extends Object>(
    Expression<T> Function(
      $$PreservationRecommendationsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$PreservationRecommendationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.preservationRecommendations,
          getReferencedColumn: (t) => t.eventId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PreservationRecommendationsTableAnnotationComposer(
                $db: $db,
                $table: $db.preservationRecommendations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> remindersRefs<T extends Object>(
    Expression<T> Function($$RemindersTableAnnotationComposer a) f,
  ) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> userFeedbackRefs<T extends Object>(
    Expression<T> Function($$UserFeedbackTableAnnotationComposer a) f,
  ) {
    final $$UserFeedbackTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userFeedback,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserFeedbackTableAnnotationComposer(
            $db: $db,
            $table: $db.userFeedback,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventInteractionsRefs<T extends Object>(
    Expression<T> Function($$EventInteractionsTableAnnotationComposer a) f,
  ) {
    final $$EventInteractionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.eventInteractions,
          getReferencedColumn: (t) => t.eventId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EventInteractionsTableAnnotationComposer(
                $db: $db,
                $table: $db.eventInteractions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> processingJobsRefs<T extends Object>(
    Expression<T> Function($$ProcessingJobsTableAnnotationComposer a) f,
  ) {
    final $$ProcessingJobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.processingJobs,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProcessingJobsTableAnnotationComposer(
            $db: $db,
            $table: $db.processingJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventsTable,
          MemoryEventRow,
          $$EventsTableFilterComposer,
          $$EventsTableOrderingComposer,
          $$EventsTableAnnotationComposer,
          $$EventsTableCreateCompanionBuilder,
          $$EventsTableUpdateCompanionBuilder,
          (MemoryEventRow, $$EventsTableReferences),
          MemoryEventRow,
          PrefetchHooks Function({
            bool placeId,
            bool coverMediaId,
            bool eventMediaRefs,
            bool eventPersonsRefs,
            bool notesRefs,
            bool voiceNotesRefs,
            bool significanceScoresRefs,
            bool rediscoveryScoresRefs,
            bool contextScoresRefs,
            bool preservationRecommendationsRefs,
            bool remindersRefs,
            bool userFeedbackRefs,
            bool eventInteractionsRefs,
            bool processingJobsRefs,
          })
        > {
  $$EventsTableTableManager(_$AppDatabase db, $EventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> generatedTitle = const Value.absent(),
                Value<String?> confirmedTitle = const Value.absent(),
                Value<bool> isTitleConfirmed = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> startAt = const Value.absent(),
                Value<DateTime> endAt = const Value.absent(),
                Value<String?> placeId = const Value.absent(),
                Value<String?> coverMediaId = const Value.absent(),
                Value<bool> isCoverUserSelected = const Value.absent(),
                Value<bool> isFavourite = const Value.absent(),
                Value<int?> manualRating = const Value.absent(),
                Value<bool> isImportant = const Value.absent(),
                Value<bool> isSensitive = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
                Value<int> viewCount = const Value.absent(),
                Value<DateTime?> lastViewedAt = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> clusteringVersion = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<bool> isDemo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                generatedTitle: generatedTitle,
                confirmedTitle: confirmedTitle,
                isTitleConfirmed: isTitleConfirmed,
                description: description,
                startAt: startAt,
                endAt: endAt,
                placeId: placeId,
                coverMediaId: coverMediaId,
                isCoverUserSelected: isCoverUserSelected,
                isFavourite: isFavourite,
                manualRating: manualRating,
                isImportant: isImportant,
                isSensitive: isSensitive,
                isHidden: isHidden,
                viewCount: viewCount,
                lastViewedAt: lastViewedAt,
                source: source,
                clusteringVersion: clusteringVersion,
                generatedAt: generatedAt,
                isDemo: isDemo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String generatedTitle,
                Value<String?> confirmedTitle = const Value.absent(),
                Value<bool> isTitleConfirmed = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required DateTime startAt,
                required DateTime endAt,
                Value<String?> placeId = const Value.absent(),
                Value<String?> coverMediaId = const Value.absent(),
                Value<bool> isCoverUserSelected = const Value.absent(),
                Value<bool> isFavourite = const Value.absent(),
                Value<int?> manualRating = const Value.absent(),
                Value<bool> isImportant = const Value.absent(),
                Value<bool> isSensitive = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
                Value<int> viewCount = const Value.absent(),
                Value<DateTime?> lastViewedAt = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> clusteringVersion = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<bool> isDemo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                generatedTitle: generatedTitle,
                confirmedTitle: confirmedTitle,
                isTitleConfirmed: isTitleConfirmed,
                description: description,
                startAt: startAt,
                endAt: endAt,
                placeId: placeId,
                coverMediaId: coverMediaId,
                isCoverUserSelected: isCoverUserSelected,
                isFavourite: isFavourite,
                manualRating: manualRating,
                isImportant: isImportant,
                isSensitive: isSensitive,
                isHidden: isHidden,
                viewCount: viewCount,
                lastViewedAt: lastViewedAt,
                source: source,
                clusteringVersion: clusteringVersion,
                generatedAt: generatedAt,
                isDemo: isDemo,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$EventsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                placeId = false,
                coverMediaId = false,
                eventMediaRefs = false,
                eventPersonsRefs = false,
                notesRefs = false,
                voiceNotesRefs = false,
                significanceScoresRefs = false,
                rediscoveryScoresRefs = false,
                contextScoresRefs = false,
                preservationRecommendationsRefs = false,
                remindersRefs = false,
                userFeedbackRefs = false,
                eventInteractionsRefs = false,
                processingJobsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventMediaRefs) db.eventMedia,
                    if (eventPersonsRefs) db.eventPersons,
                    if (notesRefs) db.notes,
                    if (voiceNotesRefs) db.voiceNotes,
                    if (significanceScoresRefs) db.significanceScores,
                    if (rediscoveryScoresRefs) db.rediscoveryScores,
                    if (contextScoresRefs) db.contextScores,
                    if (preservationRecommendationsRefs)
                      db.preservationRecommendations,
                    if (remindersRefs) db.reminders,
                    if (userFeedbackRefs) db.userFeedback,
                    if (eventInteractionsRefs) db.eventInteractions,
                    if (processingJobsRefs) db.processingJobs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (placeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.placeId,
                                    referencedTable: $$EventsTableReferences
                                        ._placeIdTable(db),
                                    referencedColumn: $$EventsTableReferences
                                        ._placeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (coverMediaId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.coverMediaId,
                                    referencedTable: $$EventsTableReferences
                                        ._coverMediaIdTable(db),
                                    referencedColumn: $$EventsTableReferences
                                        ._coverMediaIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventMediaRefs)
                        await $_getPrefetchedData<
                          MemoryEventRow,
                          $EventsTable,
                          EventMediaRow
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._eventMediaRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventMediaRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventPersonsRefs)
                        await $_getPrefetchedData<
                          MemoryEventRow,
                          $EventsTable,
                          EventPersonRow
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._eventPersonsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventPersonsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (notesRefs)
                        await $_getPrefetchedData<
                          MemoryEventRow,
                          $EventsTable,
                          NoteRow
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._notesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(db, table, p0).notesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (voiceNotesRefs)
                        await $_getPrefetchedData<
                          MemoryEventRow,
                          $EventsTable,
                          VoiceNoteRow
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._voiceNotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).voiceNotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (significanceScoresRefs)
                        await $_getPrefetchedData<
                          MemoryEventRow,
                          $EventsTable,
                          SignificanceScoreRow
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._significanceScoresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).significanceScoresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (rediscoveryScoresRefs)
                        await $_getPrefetchedData<
                          MemoryEventRow,
                          $EventsTable,
                          RediscoveryScoreRow
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._rediscoveryScoresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).rediscoveryScoresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (contextScoresRefs)
                        await $_getPrefetchedData<
                          MemoryEventRow,
                          $EventsTable,
                          ContextScoreRow
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._contextScoresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).contextScoresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (preservationRecommendationsRefs)
                        await $_getPrefetchedData<
                          MemoryEventRow,
                          $EventsTable,
                          PreservationRecommendationRow
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._preservationRecommendationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).preservationRecommendationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (remindersRefs)
                        await $_getPrefetchedData<
                          MemoryEventRow,
                          $EventsTable,
                          ReminderRow
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._remindersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).remindersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (userFeedbackRefs)
                        await $_getPrefetchedData<
                          MemoryEventRow,
                          $EventsTable,
                          UserFeedbackRow
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._userFeedbackRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).userFeedbackRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventInteractionsRefs)
                        await $_getPrefetchedData<
                          MemoryEventRow,
                          $EventsTable,
                          EventInteractionRow
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._eventInteractionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventInteractionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (processingJobsRefs)
                        await $_getPrefetchedData<
                          MemoryEventRow,
                          $EventsTable,
                          ProcessingJobRow
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._processingJobsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).processingJobsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventsTable,
      MemoryEventRow,
      $$EventsTableFilterComposer,
      $$EventsTableOrderingComposer,
      $$EventsTableAnnotationComposer,
      $$EventsTableCreateCompanionBuilder,
      $$EventsTableUpdateCompanionBuilder,
      (MemoryEventRow, $$EventsTableReferences),
      MemoryEventRow,
      PrefetchHooks Function({
        bool placeId,
        bool coverMediaId,
        bool eventMediaRefs,
        bool eventPersonsRefs,
        bool notesRefs,
        bool voiceNotesRefs,
        bool significanceScoresRefs,
        bool rediscoveryScoresRefs,
        bool contextScoresRefs,
        bool preservationRecommendationsRefs,
        bool remindersRefs,
        bool userFeedbackRefs,
        bool eventInteractionsRefs,
        bool processingJobsRefs,
      })
    >;
typedef $$EventMediaTableCreateCompanionBuilder =
    EventMediaCompanion Function({
      required String eventId,
      required String mediaId,
      Value<int> position,
      Value<double?> clusteringConfidence,
      Value<bool> isUserConfirmed,
      Value<DateTime> addedAt,
      Value<int> rowid,
    });
typedef $$EventMediaTableUpdateCompanionBuilder =
    EventMediaCompanion Function({
      Value<String> eventId,
      Value<String> mediaId,
      Value<int> position,
      Value<double?> clusteringConfidence,
      Value<bool> isUserConfirmed,
      Value<DateTime> addedAt,
      Value<int> rowid,
    });

final class $$EventMediaTableReferences
    extends BaseReferences<_$AppDatabase, $EventMediaTable, EventMediaRow> {
  $$EventMediaTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.eventMedia.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MediaItemsTable _mediaIdTable(_$AppDatabase db) =>
      db.mediaItems.createAlias(
        $_aliasNameGenerator(db.eventMedia.mediaId, db.mediaItems.id),
      );

  $$MediaItemsTableProcessedTableManager get mediaId {
    final $_column = $_itemColumn<String>('media_id')!;

    final manager = $$MediaItemsTableTableManager(
      $_db,
      $_db.mediaItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mediaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventMediaTableFilterComposer
    extends Composer<_$AppDatabase, $EventMediaTable> {
  $$EventMediaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get clusteringConfidence => $composableBuilder(
    column: $table.clusteringConfidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUserConfirmed => $composableBuilder(
    column: $table.isUserConfirmed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaItemsTableFilterComposer get mediaId {
    final $$MediaItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableFilterComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventMediaTableOrderingComposer
    extends Composer<_$AppDatabase, $EventMediaTable> {
  $$EventMediaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get clusteringConfidence => $composableBuilder(
    column: $table.clusteringConfidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUserConfirmed => $composableBuilder(
    column: $table.isUserConfirmed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaItemsTableOrderingComposer get mediaId {
    final $$MediaItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableOrderingComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventMediaTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventMediaTable> {
  $$EventMediaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<double> get clusteringConfidence => $composableBuilder(
    column: $table.clusteringConfidence,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isUserConfirmed => $composableBuilder(
    column: $table.isUserConfirmed,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaItemsTableAnnotationComposer get mediaId {
    final $$MediaItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventMediaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventMediaTable,
          EventMediaRow,
          $$EventMediaTableFilterComposer,
          $$EventMediaTableOrderingComposer,
          $$EventMediaTableAnnotationComposer,
          $$EventMediaTableCreateCompanionBuilder,
          $$EventMediaTableUpdateCompanionBuilder,
          (EventMediaRow, $$EventMediaTableReferences),
          EventMediaRow,
          PrefetchHooks Function({bool eventId, bool mediaId})
        > {
  $$EventMediaTableTableManager(_$AppDatabase db, $EventMediaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventMediaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventMediaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventMediaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> eventId = const Value.absent(),
                Value<String> mediaId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<double?> clusteringConfidence = const Value.absent(),
                Value<bool> isUserConfirmed = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventMediaCompanion(
                eventId: eventId,
                mediaId: mediaId,
                position: position,
                clusteringConfidence: clusteringConfidence,
                isUserConfirmed: isUserConfirmed,
                addedAt: addedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String eventId,
                required String mediaId,
                Value<int> position = const Value.absent(),
                Value<double?> clusteringConfidence = const Value.absent(),
                Value<bool> isUserConfirmed = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventMediaCompanion.insert(
                eventId: eventId,
                mediaId: mediaId,
                position: position,
                clusteringConfidence: clusteringConfidence,
                isUserConfirmed: isUserConfirmed,
                addedAt: addedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventMediaTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false, mediaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$EventMediaTableReferences
                                    ._eventIdTable(db),
                                referencedColumn: $$EventMediaTableReferences
                                    ._eventIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (mediaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mediaId,
                                referencedTable: $$EventMediaTableReferences
                                    ._mediaIdTable(db),
                                referencedColumn: $$EventMediaTableReferences
                                    ._mediaIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EventMediaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventMediaTable,
      EventMediaRow,
      $$EventMediaTableFilterComposer,
      $$EventMediaTableOrderingComposer,
      $$EventMediaTableAnnotationComposer,
      $$EventMediaTableCreateCompanionBuilder,
      $$EventMediaTableUpdateCompanionBuilder,
      (EventMediaRow, $$EventMediaTableReferences),
      EventMediaRow,
      PrefetchHooks Function({bool eventId, bool mediaId})
    >;
typedef $$PersonsTableCreateCompanionBuilder =
    PersonsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String displayName,
      Value<bool> isConfirmed,
      Value<bool> isDemo,
      Value<int> rowid,
    });
typedef $$PersonsTableUpdateCompanionBuilder =
    PersonsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> displayName,
      Value<bool> isConfirmed,
      Value<bool> isDemo,
      Value<int> rowid,
    });

final class $$PersonsTableReferences
    extends BaseReferences<_$AppDatabase, $PersonsTable, PersonRow> {
  $$PersonsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EventPersonsTable, List<EventPersonRow>>
  _eventPersonsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventPersons,
    aliasName: $_aliasNameGenerator(db.persons.id, db.eventPersons.personId),
  );

  $$EventPersonsTableProcessedTableManager get eventPersonsRefs {
    final manager = $$EventPersonsTableTableManager(
      $_db,
      $_db.eventPersons,
    ).filter((f) => f.personId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventPersonsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MediaPersonsTable, List<MediaPersonRow>>
  _mediaPersonsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mediaPersons,
    aliasName: $_aliasNameGenerator(db.persons.id, db.mediaPersons.personId),
  );

  $$MediaPersonsTableProcessedTableManager get mediaPersonsRefs {
    final manager = $$MediaPersonsTableTableManager(
      $_db,
      $_db.mediaPersons,
    ).filter((f) => f.personId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mediaPersonsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PersonsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isConfirmed => $composableBuilder(
    column: $table.isConfirmed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDemo => $composableBuilder(
    column: $table.isDemo,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> eventPersonsRefs(
    Expression<bool> Function($$EventPersonsTableFilterComposer f) f,
  ) {
    final $$EventPersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventPersons,
      getReferencedColumn: (t) => t.personId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventPersonsTableFilterComposer(
            $db: $db,
            $table: $db.eventPersons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mediaPersonsRefs(
    Expression<bool> Function($$MediaPersonsTableFilterComposer f) f,
  ) {
    final $$MediaPersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mediaPersons,
      getReferencedColumn: (t) => t.personId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaPersonsTableFilterComposer(
            $db: $db,
            $table: $db.mediaPersons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PersonsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isConfirmed => $composableBuilder(
    column: $table.isConfirmed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDemo => $composableBuilder(
    column: $table.isDemo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PersonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isConfirmed => $composableBuilder(
    column: $table.isConfirmed,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDemo =>
      $composableBuilder(column: $table.isDemo, builder: (column) => column);

  Expression<T> eventPersonsRefs<T extends Object>(
    Expression<T> Function($$EventPersonsTableAnnotationComposer a) f,
  ) {
    final $$EventPersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventPersons,
      getReferencedColumn: (t) => t.personId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventPersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.eventPersons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mediaPersonsRefs<T extends Object>(
    Expression<T> Function($$MediaPersonsTableAnnotationComposer a) f,
  ) {
    final $$MediaPersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mediaPersons,
      getReferencedColumn: (t) => t.personId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaPersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaPersons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PersonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonsTable,
          PersonRow,
          $$PersonsTableFilterComposer,
          $$PersonsTableOrderingComposer,
          $$PersonsTableAnnotationComposer,
          $$PersonsTableCreateCompanionBuilder,
          $$PersonsTableUpdateCompanionBuilder,
          (PersonRow, $$PersonsTableReferences),
          PersonRow,
          PrefetchHooks Function({bool eventPersonsRefs, bool mediaPersonsRefs})
        > {
  $$PersonsTableTableManager(_$AppDatabase db, $PersonsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<bool> isConfirmed = const Value.absent(),
                Value<bool> isDemo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersonsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                displayName: displayName,
                isConfirmed: isConfirmed,
                isDemo: isDemo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String displayName,
                Value<bool> isConfirmed = const Value.absent(),
                Value<bool> isDemo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersonsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                displayName: displayName,
                isConfirmed: isConfirmed,
                isDemo: isDemo,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PersonsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({eventPersonsRefs = false, mediaPersonsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventPersonsRefs) db.eventPersons,
                    if (mediaPersonsRefs) db.mediaPersons,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventPersonsRefs)
                        await $_getPrefetchedData<
                          PersonRow,
                          $PersonsTable,
                          EventPersonRow
                        >(
                          currentTable: table,
                          referencedTable: $$PersonsTableReferences
                              ._eventPersonsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PersonsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventPersonsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.personId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mediaPersonsRefs)
                        await $_getPrefetchedData<
                          PersonRow,
                          $PersonsTable,
                          MediaPersonRow
                        >(
                          currentTable: table,
                          referencedTable: $$PersonsTableReferences
                              ._mediaPersonsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PersonsTableReferences(
                                db,
                                table,
                                p0,
                              ).mediaPersonsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.personId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PersonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonsTable,
      PersonRow,
      $$PersonsTableFilterComposer,
      $$PersonsTableOrderingComposer,
      $$PersonsTableAnnotationComposer,
      $$PersonsTableCreateCompanionBuilder,
      $$PersonsTableUpdateCompanionBuilder,
      (PersonRow, $$PersonsTableReferences),
      PersonRow,
      PrefetchHooks Function({bool eventPersonsRefs, bool mediaPersonsRefs})
    >;
typedef $$EventPersonsTableCreateCompanionBuilder =
    EventPersonsCompanion Function({
      required String eventId,
      required String personId,
      Value<String> role,
      Value<bool> isUserConfirmed,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$EventPersonsTableUpdateCompanionBuilder =
    EventPersonsCompanion Function({
      Value<String> eventId,
      Value<String> personId,
      Value<String> role,
      Value<bool> isUserConfirmed,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$EventPersonsTableReferences
    extends BaseReferences<_$AppDatabase, $EventPersonsTable, EventPersonRow> {
  $$EventPersonsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.eventPersons.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PersonsTable _personIdTable(_$AppDatabase db) =>
      db.persons.createAlias(
        $_aliasNameGenerator(db.eventPersons.personId, db.persons.id),
      );

  $$PersonsTableProcessedTableManager get personId {
    final $_column = $_itemColumn<String>('person_id')!;

    final manager = $$PersonsTableTableManager(
      $_db,
      $_db.persons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventPersonsTableFilterComposer
    extends Composer<_$AppDatabase, $EventPersonsTable> {
  $$EventPersonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUserConfirmed => $composableBuilder(
    column: $table.isUserConfirmed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableFilterComposer get personId {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableFilterComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventPersonsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventPersonsTable> {
  $$EventPersonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUserConfirmed => $composableBuilder(
    column: $table.isUserConfirmed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableOrderingComposer get personId {
    final $$PersonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableOrderingComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventPersonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventPersonsTable> {
  $$EventPersonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get isUserConfirmed => $composableBuilder(
    column: $table.isUserConfirmed,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableAnnotationComposer get personId {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventPersonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventPersonsTable,
          EventPersonRow,
          $$EventPersonsTableFilterComposer,
          $$EventPersonsTableOrderingComposer,
          $$EventPersonsTableAnnotationComposer,
          $$EventPersonsTableCreateCompanionBuilder,
          $$EventPersonsTableUpdateCompanionBuilder,
          (EventPersonRow, $$EventPersonsTableReferences),
          EventPersonRow,
          PrefetchHooks Function({bool eventId, bool personId})
        > {
  $$EventPersonsTableTableManager(_$AppDatabase db, $EventPersonsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventPersonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventPersonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventPersonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> eventId = const Value.absent(),
                Value<String> personId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<bool> isUserConfirmed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventPersonsCompanion(
                eventId: eventId,
                personId: personId,
                role: role,
                isUserConfirmed: isUserConfirmed,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String eventId,
                required String personId,
                Value<String> role = const Value.absent(),
                Value<bool> isUserConfirmed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventPersonsCompanion.insert(
                eventId: eventId,
                personId: personId,
                role: role,
                isUserConfirmed: isUserConfirmed,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventPersonsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false, personId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$EventPersonsTableReferences
                                    ._eventIdTable(db),
                                referencedColumn: $$EventPersonsTableReferences
                                    ._eventIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (personId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.personId,
                                referencedTable: $$EventPersonsTableReferences
                                    ._personIdTable(db),
                                referencedColumn: $$EventPersonsTableReferences
                                    ._personIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EventPersonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventPersonsTable,
      EventPersonRow,
      $$EventPersonsTableFilterComposer,
      $$EventPersonsTableOrderingComposer,
      $$EventPersonsTableAnnotationComposer,
      $$EventPersonsTableCreateCompanionBuilder,
      $$EventPersonsTableUpdateCompanionBuilder,
      (EventPersonRow, $$EventPersonsTableReferences),
      EventPersonRow,
      PrefetchHooks Function({bool eventId, bool personId})
    >;
typedef $$MediaPersonsTableCreateCompanionBuilder =
    MediaPersonsCompanion Function({
      required String mediaId,
      required String personId,
      Value<String?> faceBoundsJson,
      Value<bool> isUserConfirmed,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$MediaPersonsTableUpdateCompanionBuilder =
    MediaPersonsCompanion Function({
      Value<String> mediaId,
      Value<String> personId,
      Value<String?> faceBoundsJson,
      Value<bool> isUserConfirmed,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$MediaPersonsTableReferences
    extends BaseReferences<_$AppDatabase, $MediaPersonsTable, MediaPersonRow> {
  $$MediaPersonsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MediaItemsTable _mediaIdTable(_$AppDatabase db) =>
      db.mediaItems.createAlias(
        $_aliasNameGenerator(db.mediaPersons.mediaId, db.mediaItems.id),
      );

  $$MediaItemsTableProcessedTableManager get mediaId {
    final $_column = $_itemColumn<String>('media_id')!;

    final manager = $$MediaItemsTableTableManager(
      $_db,
      $_db.mediaItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mediaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PersonsTable _personIdTable(_$AppDatabase db) =>
      db.persons.createAlias(
        $_aliasNameGenerator(db.mediaPersons.personId, db.persons.id),
      );

  $$PersonsTableProcessedTableManager get personId {
    final $_column = $_itemColumn<String>('person_id')!;

    final manager = $$PersonsTableTableManager(
      $_db,
      $_db.persons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MediaPersonsTableFilterComposer
    extends Composer<_$AppDatabase, $MediaPersonsTable> {
  $$MediaPersonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get faceBoundsJson => $composableBuilder(
    column: $table.faceBoundsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUserConfirmed => $composableBuilder(
    column: $table.isUserConfirmed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MediaItemsTableFilterComposer get mediaId {
    final $$MediaItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableFilterComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableFilterComposer get personId {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableFilterComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MediaPersonsTableOrderingComposer
    extends Composer<_$AppDatabase, $MediaPersonsTable> {
  $$MediaPersonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get faceBoundsJson => $composableBuilder(
    column: $table.faceBoundsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUserConfirmed => $composableBuilder(
    column: $table.isUserConfirmed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MediaItemsTableOrderingComposer get mediaId {
    final $$MediaItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableOrderingComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableOrderingComposer get personId {
    final $$PersonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableOrderingComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MediaPersonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MediaPersonsTable> {
  $$MediaPersonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get faceBoundsJson => $composableBuilder(
    column: $table.faceBoundsJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isUserConfirmed => $composableBuilder(
    column: $table.isUserConfirmed,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MediaItemsTableAnnotationComposer get mediaId {
    final $$MediaItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableAnnotationComposer get personId {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MediaPersonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MediaPersonsTable,
          MediaPersonRow,
          $$MediaPersonsTableFilterComposer,
          $$MediaPersonsTableOrderingComposer,
          $$MediaPersonsTableAnnotationComposer,
          $$MediaPersonsTableCreateCompanionBuilder,
          $$MediaPersonsTableUpdateCompanionBuilder,
          (MediaPersonRow, $$MediaPersonsTableReferences),
          MediaPersonRow,
          PrefetchHooks Function({bool mediaId, bool personId})
        > {
  $$MediaPersonsTableTableManager(_$AppDatabase db, $MediaPersonsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaPersonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaPersonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaPersonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> mediaId = const Value.absent(),
                Value<String> personId = const Value.absent(),
                Value<String?> faceBoundsJson = const Value.absent(),
                Value<bool> isUserConfirmed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MediaPersonsCompanion(
                mediaId: mediaId,
                personId: personId,
                faceBoundsJson: faceBoundsJson,
                isUserConfirmed: isUserConfirmed,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String mediaId,
                required String personId,
                Value<String?> faceBoundsJson = const Value.absent(),
                Value<bool> isUserConfirmed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MediaPersonsCompanion.insert(
                mediaId: mediaId,
                personId: personId,
                faceBoundsJson: faceBoundsJson,
                isUserConfirmed: isUserConfirmed,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MediaPersonsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mediaId = false, personId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mediaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mediaId,
                                referencedTable: $$MediaPersonsTableReferences
                                    ._mediaIdTable(db),
                                referencedColumn: $$MediaPersonsTableReferences
                                    ._mediaIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (personId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.personId,
                                referencedTable: $$MediaPersonsTableReferences
                                    ._personIdTable(db),
                                referencedColumn: $$MediaPersonsTableReferences
                                    ._personIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MediaPersonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MediaPersonsTable,
      MediaPersonRow,
      $$MediaPersonsTableFilterComposer,
      $$MediaPersonsTableOrderingComposer,
      $$MediaPersonsTableAnnotationComposer,
      $$MediaPersonsTableCreateCompanionBuilder,
      $$MediaPersonsTableUpdateCompanionBuilder,
      (MediaPersonRow, $$MediaPersonsTableReferences),
      MediaPersonRow,
      PrefetchHooks Function({bool mediaId, bool personId})
    >;
typedef $$NotesTableCreateCompanionBuilder =
    NotesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String eventId,
      required String body,
      Value<String> noteType,
      Value<bool> isGenerated,
      Value<int> rowid,
    });
typedef $$NotesTableUpdateCompanionBuilder =
    NotesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> eventId,
      Value<String> body,
      Value<String> noteType,
      Value<bool> isGenerated,
      Value<int> rowid,
    });

final class $$NotesTableReferences
    extends BaseReferences<_$AppDatabase, $NotesTable, NoteRow> {
  $$NotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.notes.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noteType => $composableBuilder(
    column: $table.noteType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isGenerated => $composableBuilder(
    column: $table.isGenerated,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noteType => $composableBuilder(
    column: $table.noteType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isGenerated => $composableBuilder(
    column: $table.isGenerated,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get noteType =>
      $composableBuilder(column: $table.noteType, builder: (column) => column);

  GeneratedColumn<bool> get isGenerated => $composableBuilder(
    column: $table.isGenerated,
    builder: (column) => column,
  );

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotesTable,
          NoteRow,
          $$NotesTableFilterComposer,
          $$NotesTableOrderingComposer,
          $$NotesTableAnnotationComposer,
          $$NotesTableCreateCompanionBuilder,
          $$NotesTableUpdateCompanionBuilder,
          (NoteRow, $$NotesTableReferences),
          NoteRow,
          PrefetchHooks Function({bool eventId})
        > {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String> noteType = const Value.absent(),
                Value<bool> isGenerated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                eventId: eventId,
                body: body,
                noteType: noteType,
                isGenerated: isGenerated,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String eventId,
                required String body,
                Value<String> noteType = const Value.absent(),
                Value<bool> isGenerated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                eventId: eventId,
                body: body,
                noteType: noteType,
                isGenerated: isGenerated,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$NotesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$NotesTableReferences
                                    ._eventIdTable(db),
                                referencedColumn: $$NotesTableReferences
                                    ._eventIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotesTable,
      NoteRow,
      $$NotesTableFilterComposer,
      $$NotesTableOrderingComposer,
      $$NotesTableAnnotationComposer,
      $$NotesTableCreateCompanionBuilder,
      $$NotesTableUpdateCompanionBuilder,
      (NoteRow, $$NotesTableReferences),
      NoteRow,
      PrefetchHooks Function({bool eventId})
    >;
typedef $$VoiceNotesTableCreateCompanionBuilder =
    VoiceNotesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String eventId,
      required String filePath,
      required int durationMs,
      Value<String?> transcript,
      Value<int> rowid,
    });
typedef $$VoiceNotesTableUpdateCompanionBuilder =
    VoiceNotesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> eventId,
      Value<String> filePath,
      Value<int> durationMs,
      Value<String?> transcript,
      Value<int> rowid,
    });

final class $$VoiceNotesTableReferences
    extends BaseReferences<_$AppDatabase, $VoiceNotesTable, VoiceNoteRow> {
  $$VoiceNotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.voiceNotes.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VoiceNotesTableFilterComposer
    extends Composer<_$AppDatabase, $VoiceNotesTable> {
  $$VoiceNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transcript => $composableBuilder(
    column: $table.transcript,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VoiceNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $VoiceNotesTable> {
  $$VoiceNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transcript => $composableBuilder(
    column: $table.transcript,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VoiceNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VoiceNotesTable> {
  $$VoiceNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transcript => $composableBuilder(
    column: $table.transcript,
    builder: (column) => column,
  );

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VoiceNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VoiceNotesTable,
          VoiceNoteRow,
          $$VoiceNotesTableFilterComposer,
          $$VoiceNotesTableOrderingComposer,
          $$VoiceNotesTableAnnotationComposer,
          $$VoiceNotesTableCreateCompanionBuilder,
          $$VoiceNotesTableUpdateCompanionBuilder,
          (VoiceNoteRow, $$VoiceNotesTableReferences),
          VoiceNoteRow,
          PrefetchHooks Function({bool eventId})
        > {
  $$VoiceNotesTableTableManager(_$AppDatabase db, $VoiceNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VoiceNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VoiceNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VoiceNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
                Value<String?> transcript = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VoiceNotesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                eventId: eventId,
                filePath: filePath,
                durationMs: durationMs,
                transcript: transcript,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String eventId,
                required String filePath,
                required int durationMs,
                Value<String?> transcript = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VoiceNotesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                eventId: eventId,
                filePath: filePath,
                durationMs: durationMs,
                transcript: transcript,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VoiceNotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$VoiceNotesTableReferences
                                    ._eventIdTable(db),
                                referencedColumn: $$VoiceNotesTableReferences
                                    ._eventIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VoiceNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VoiceNotesTable,
      VoiceNoteRow,
      $$VoiceNotesTableFilterComposer,
      $$VoiceNotesTableOrderingComposer,
      $$VoiceNotesTableAnnotationComposer,
      $$VoiceNotesTableCreateCompanionBuilder,
      $$VoiceNotesTableUpdateCompanionBuilder,
      (VoiceNoteRow, $$VoiceNotesTableReferences),
      VoiceNoteRow,
      PrefetchHooks Function({bool eventId})
    >;
typedef $$GraphNodesTableCreateCompanionBuilder =
    GraphNodesCompanion Function({
      required String id,
      required String nodeType,
      required String entityId,
      required String label,
      Value<String> metadataJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$GraphNodesTableUpdateCompanionBuilder =
    GraphNodesCompanion Function({
      Value<String> id,
      Value<String> nodeType,
      Value<String> entityId,
      Value<String> label,
      Value<String> metadataJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$GraphNodesTableFilterComposer
    extends Composer<_$AppDatabase, $GraphNodesTable> {
  $$GraphNodesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nodeType => $composableBuilder(
    column: $table.nodeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GraphNodesTableOrderingComposer
    extends Composer<_$AppDatabase, $GraphNodesTable> {
  $$GraphNodesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nodeType => $composableBuilder(
    column: $table.nodeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GraphNodesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GraphNodesTable> {
  $$GraphNodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nodeType =>
      $composableBuilder(column: $table.nodeType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$GraphNodesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GraphNodesTable,
          GraphNodeRow,
          $$GraphNodesTableFilterComposer,
          $$GraphNodesTableOrderingComposer,
          $$GraphNodesTableAnnotationComposer,
          $$GraphNodesTableCreateCompanionBuilder,
          $$GraphNodesTableUpdateCompanionBuilder,
          (
            GraphNodeRow,
            BaseReferences<_$AppDatabase, $GraphNodesTable, GraphNodeRow>,
          ),
          GraphNodeRow,
          PrefetchHooks Function()
        > {
  $$GraphNodesTableTableManager(_$AppDatabase db, $GraphNodesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GraphNodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GraphNodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GraphNodesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nodeType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GraphNodesCompanion(
                id: id,
                nodeType: nodeType,
                entityId: entityId,
                label: label,
                metadataJson: metadataJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nodeType,
                required String entityId,
                required String label,
                Value<String> metadataJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GraphNodesCompanion.insert(
                id: id,
                nodeType: nodeType,
                entityId: entityId,
                label: label,
                metadataJson: metadataJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GraphNodesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GraphNodesTable,
      GraphNodeRow,
      $$GraphNodesTableFilterComposer,
      $$GraphNodesTableOrderingComposer,
      $$GraphNodesTableAnnotationComposer,
      $$GraphNodesTableCreateCompanionBuilder,
      $$GraphNodesTableUpdateCompanionBuilder,
      (
        GraphNodeRow,
        BaseReferences<_$AppDatabase, $GraphNodesTable, GraphNodeRow>,
      ),
      GraphNodeRow,
      PrefetchHooks Function()
    >;
typedef $$GraphEdgesTableCreateCompanionBuilder =
    GraphEdgesCompanion Function({
      required String id,
      required String sourceNodeId,
      required String targetNodeId,
      required String relationType,
      Value<double> weight,
      Value<String> metadataJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$GraphEdgesTableUpdateCompanionBuilder =
    GraphEdgesCompanion Function({
      Value<String> id,
      Value<String> sourceNodeId,
      Value<String> targetNodeId,
      Value<String> relationType,
      Value<double> weight,
      Value<String> metadataJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$GraphEdgesTableReferences
    extends BaseReferences<_$AppDatabase, $GraphEdgesTable, GraphEdgeRow> {
  $$GraphEdgesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GraphNodesTable _sourceNodeIdTable(_$AppDatabase db) =>
      db.graphNodes.createAlias(
        $_aliasNameGenerator(db.graphEdges.sourceNodeId, db.graphNodes.id),
      );

  $$GraphNodesTableProcessedTableManager get sourceNodeId {
    final $_column = $_itemColumn<String>('source_node_id')!;

    final manager = $$GraphNodesTableTableManager(
      $_db,
      $_db.graphNodes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceNodeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GraphNodesTable _targetNodeIdTable(_$AppDatabase db) =>
      db.graphNodes.createAlias(
        $_aliasNameGenerator(db.graphEdges.targetNodeId, db.graphNodes.id),
      );

  $$GraphNodesTableProcessedTableManager get targetNodeId {
    final $_column = $_itemColumn<String>('target_node_id')!;

    final manager = $$GraphNodesTableTableManager(
      $_db,
      $_db.graphNodes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_targetNodeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GraphEdgesTableFilterComposer
    extends Composer<_$AppDatabase, $GraphEdgesTable> {
  $$GraphEdgesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relationType => $composableBuilder(
    column: $table.relationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GraphNodesTableFilterComposer get sourceNodeId {
    final $$GraphNodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceNodeId,
      referencedTable: $db.graphNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GraphNodesTableFilterComposer(
            $db: $db,
            $table: $db.graphNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GraphNodesTableFilterComposer get targetNodeId {
    final $$GraphNodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetNodeId,
      referencedTable: $db.graphNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GraphNodesTableFilterComposer(
            $db: $db,
            $table: $db.graphNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GraphEdgesTableOrderingComposer
    extends Composer<_$AppDatabase, $GraphEdgesTable> {
  $$GraphEdgesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relationType => $composableBuilder(
    column: $table.relationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GraphNodesTableOrderingComposer get sourceNodeId {
    final $$GraphNodesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceNodeId,
      referencedTable: $db.graphNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GraphNodesTableOrderingComposer(
            $db: $db,
            $table: $db.graphNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GraphNodesTableOrderingComposer get targetNodeId {
    final $$GraphNodesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetNodeId,
      referencedTable: $db.graphNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GraphNodesTableOrderingComposer(
            $db: $db,
            $table: $db.graphNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GraphEdgesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GraphEdgesTable> {
  $$GraphEdgesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get relationType => $composableBuilder(
    column: $table.relationType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GraphNodesTableAnnotationComposer get sourceNodeId {
    final $$GraphNodesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceNodeId,
      referencedTable: $db.graphNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GraphNodesTableAnnotationComposer(
            $db: $db,
            $table: $db.graphNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GraphNodesTableAnnotationComposer get targetNodeId {
    final $$GraphNodesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetNodeId,
      referencedTable: $db.graphNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GraphNodesTableAnnotationComposer(
            $db: $db,
            $table: $db.graphNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GraphEdgesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GraphEdgesTable,
          GraphEdgeRow,
          $$GraphEdgesTableFilterComposer,
          $$GraphEdgesTableOrderingComposer,
          $$GraphEdgesTableAnnotationComposer,
          $$GraphEdgesTableCreateCompanionBuilder,
          $$GraphEdgesTableUpdateCompanionBuilder,
          (GraphEdgeRow, $$GraphEdgesTableReferences),
          GraphEdgeRow,
          PrefetchHooks Function({bool sourceNodeId, bool targetNodeId})
        > {
  $$GraphEdgesTableTableManager(_$AppDatabase db, $GraphEdgesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GraphEdgesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GraphEdgesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GraphEdgesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sourceNodeId = const Value.absent(),
                Value<String> targetNodeId = const Value.absent(),
                Value<String> relationType = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GraphEdgesCompanion(
                id: id,
                sourceNodeId: sourceNodeId,
                targetNodeId: targetNodeId,
                relationType: relationType,
                weight: weight,
                metadataJson: metadataJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sourceNodeId,
                required String targetNodeId,
                required String relationType,
                Value<double> weight = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GraphEdgesCompanion.insert(
                id: id,
                sourceNodeId: sourceNodeId,
                targetNodeId: targetNodeId,
                relationType: relationType,
                weight: weight,
                metadataJson: metadataJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GraphEdgesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({sourceNodeId = false, targetNodeId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sourceNodeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sourceNodeId,
                                    referencedTable: $$GraphEdgesTableReferences
                                        ._sourceNodeIdTable(db),
                                    referencedColumn:
                                        $$GraphEdgesTableReferences
                                            ._sourceNodeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (targetNodeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.targetNodeId,
                                    referencedTable: $$GraphEdgesTableReferences
                                        ._targetNodeIdTable(db),
                                    referencedColumn:
                                        $$GraphEdgesTableReferences
                                            ._targetNodeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$GraphEdgesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GraphEdgesTable,
      GraphEdgeRow,
      $$GraphEdgesTableFilterComposer,
      $$GraphEdgesTableOrderingComposer,
      $$GraphEdgesTableAnnotationComposer,
      $$GraphEdgesTableCreateCompanionBuilder,
      $$GraphEdgesTableUpdateCompanionBuilder,
      (GraphEdgeRow, $$GraphEdgesTableReferences),
      GraphEdgeRow,
      PrefetchHooks Function({bool sourceNodeId, bool targetNodeId})
    >;
typedef $$SignificanceScoresTableCreateCompanionBuilder =
    SignificanceScoresCompanion Function({
      required String id,
      required String eventId,
      required double score,
      required String factorsJson,
      required String algorithmVersion,
      Value<bool> isIllustrative,
      Value<DateTime> evaluatedAt,
      Value<int> rowid,
    });
typedef $$SignificanceScoresTableUpdateCompanionBuilder =
    SignificanceScoresCompanion Function({
      Value<String> id,
      Value<String> eventId,
      Value<double> score,
      Value<String> factorsJson,
      Value<String> algorithmVersion,
      Value<bool> isIllustrative,
      Value<DateTime> evaluatedAt,
      Value<int> rowid,
    });

final class $$SignificanceScoresTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SignificanceScoresTable,
          SignificanceScoreRow
        > {
  $$SignificanceScoresTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.significanceScores.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SignificanceScoresTableFilterComposer
    extends Composer<_$AppDatabase, $SignificanceScoresTable> {
  $$SignificanceScoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get factorsJson => $composableBuilder(
    column: $table.factorsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isIllustrative => $composableBuilder(
    column: $table.isIllustrative,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get evaluatedAt => $composableBuilder(
    column: $table.evaluatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SignificanceScoresTableOrderingComposer
    extends Composer<_$AppDatabase, $SignificanceScoresTable> {
  $$SignificanceScoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get factorsJson => $composableBuilder(
    column: $table.factorsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isIllustrative => $composableBuilder(
    column: $table.isIllustrative,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get evaluatedAt => $composableBuilder(
    column: $table.evaluatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SignificanceScoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $SignificanceScoresTable> {
  $$SignificanceScoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get factorsJson => $composableBuilder(
    column: $table.factorsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isIllustrative => $composableBuilder(
    column: $table.isIllustrative,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get evaluatedAt => $composableBuilder(
    column: $table.evaluatedAt,
    builder: (column) => column,
  );

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SignificanceScoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SignificanceScoresTable,
          SignificanceScoreRow,
          $$SignificanceScoresTableFilterComposer,
          $$SignificanceScoresTableOrderingComposer,
          $$SignificanceScoresTableAnnotationComposer,
          $$SignificanceScoresTableCreateCompanionBuilder,
          $$SignificanceScoresTableUpdateCompanionBuilder,
          (SignificanceScoreRow, $$SignificanceScoresTableReferences),
          SignificanceScoreRow,
          PrefetchHooks Function({bool eventId})
        > {
  $$SignificanceScoresTableTableManager(
    _$AppDatabase db,
    $SignificanceScoresTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SignificanceScoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SignificanceScoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SignificanceScoresTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<double> score = const Value.absent(),
                Value<String> factorsJson = const Value.absent(),
                Value<String> algorithmVersion = const Value.absent(),
                Value<bool> isIllustrative = const Value.absent(),
                Value<DateTime> evaluatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SignificanceScoresCompanion(
                id: id,
                eventId: eventId,
                score: score,
                factorsJson: factorsJson,
                algorithmVersion: algorithmVersion,
                isIllustrative: isIllustrative,
                evaluatedAt: evaluatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String eventId,
                required double score,
                required String factorsJson,
                required String algorithmVersion,
                Value<bool> isIllustrative = const Value.absent(),
                Value<DateTime> evaluatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SignificanceScoresCompanion.insert(
                id: id,
                eventId: eventId,
                score: score,
                factorsJson: factorsJson,
                algorithmVersion: algorithmVersion,
                isIllustrative: isIllustrative,
                evaluatedAt: evaluatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SignificanceScoresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable:
                                    $$SignificanceScoresTableReferences
                                        ._eventIdTable(db),
                                referencedColumn:
                                    $$SignificanceScoresTableReferences
                                        ._eventIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SignificanceScoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SignificanceScoresTable,
      SignificanceScoreRow,
      $$SignificanceScoresTableFilterComposer,
      $$SignificanceScoresTableOrderingComposer,
      $$SignificanceScoresTableAnnotationComposer,
      $$SignificanceScoresTableCreateCompanionBuilder,
      $$SignificanceScoresTableUpdateCompanionBuilder,
      (SignificanceScoreRow, $$SignificanceScoresTableReferences),
      SignificanceScoreRow,
      PrefetchHooks Function({bool eventId})
    >;
typedef $$RediscoveryScoresTableCreateCompanionBuilder =
    RediscoveryScoresCompanion Function({
      required String id,
      required String eventId,
      required double score,
      required String factorsJson,
      required String algorithmVersion,
      Value<bool> isIllustrative,
      Value<DateTime> evaluatedAt,
      Value<int> rowid,
    });
typedef $$RediscoveryScoresTableUpdateCompanionBuilder =
    RediscoveryScoresCompanion Function({
      Value<String> id,
      Value<String> eventId,
      Value<double> score,
      Value<String> factorsJson,
      Value<String> algorithmVersion,
      Value<bool> isIllustrative,
      Value<DateTime> evaluatedAt,
      Value<int> rowid,
    });

final class $$RediscoveryScoresTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RediscoveryScoresTable,
          RediscoveryScoreRow
        > {
  $$RediscoveryScoresTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.rediscoveryScores.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RediscoveryScoresTableFilterComposer
    extends Composer<_$AppDatabase, $RediscoveryScoresTable> {
  $$RediscoveryScoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get factorsJson => $composableBuilder(
    column: $table.factorsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isIllustrative => $composableBuilder(
    column: $table.isIllustrative,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get evaluatedAt => $composableBuilder(
    column: $table.evaluatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RediscoveryScoresTableOrderingComposer
    extends Composer<_$AppDatabase, $RediscoveryScoresTable> {
  $$RediscoveryScoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get factorsJson => $composableBuilder(
    column: $table.factorsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isIllustrative => $composableBuilder(
    column: $table.isIllustrative,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get evaluatedAt => $composableBuilder(
    column: $table.evaluatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RediscoveryScoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $RediscoveryScoresTable> {
  $$RediscoveryScoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get factorsJson => $composableBuilder(
    column: $table.factorsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isIllustrative => $composableBuilder(
    column: $table.isIllustrative,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get evaluatedAt => $composableBuilder(
    column: $table.evaluatedAt,
    builder: (column) => column,
  );

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RediscoveryScoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RediscoveryScoresTable,
          RediscoveryScoreRow,
          $$RediscoveryScoresTableFilterComposer,
          $$RediscoveryScoresTableOrderingComposer,
          $$RediscoveryScoresTableAnnotationComposer,
          $$RediscoveryScoresTableCreateCompanionBuilder,
          $$RediscoveryScoresTableUpdateCompanionBuilder,
          (RediscoveryScoreRow, $$RediscoveryScoresTableReferences),
          RediscoveryScoreRow,
          PrefetchHooks Function({bool eventId})
        > {
  $$RediscoveryScoresTableTableManager(
    _$AppDatabase db,
    $RediscoveryScoresTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RediscoveryScoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RediscoveryScoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RediscoveryScoresTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<double> score = const Value.absent(),
                Value<String> factorsJson = const Value.absent(),
                Value<String> algorithmVersion = const Value.absent(),
                Value<bool> isIllustrative = const Value.absent(),
                Value<DateTime> evaluatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RediscoveryScoresCompanion(
                id: id,
                eventId: eventId,
                score: score,
                factorsJson: factorsJson,
                algorithmVersion: algorithmVersion,
                isIllustrative: isIllustrative,
                evaluatedAt: evaluatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String eventId,
                required double score,
                required String factorsJson,
                required String algorithmVersion,
                Value<bool> isIllustrative = const Value.absent(),
                Value<DateTime> evaluatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RediscoveryScoresCompanion.insert(
                id: id,
                eventId: eventId,
                score: score,
                factorsJson: factorsJson,
                algorithmVersion: algorithmVersion,
                isIllustrative: isIllustrative,
                evaluatedAt: evaluatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RediscoveryScoresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable:
                                    $$RediscoveryScoresTableReferences
                                        ._eventIdTable(db),
                                referencedColumn:
                                    $$RediscoveryScoresTableReferences
                                        ._eventIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RediscoveryScoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RediscoveryScoresTable,
      RediscoveryScoreRow,
      $$RediscoveryScoresTableFilterComposer,
      $$RediscoveryScoresTableOrderingComposer,
      $$RediscoveryScoresTableAnnotationComposer,
      $$RediscoveryScoresTableCreateCompanionBuilder,
      $$RediscoveryScoresTableUpdateCompanionBuilder,
      (RediscoveryScoreRow, $$RediscoveryScoresTableReferences),
      RediscoveryScoreRow,
      PrefetchHooks Function({bool eventId})
    >;
typedef $$ContextScoresTableCreateCompanionBuilder =
    ContextScoresCompanion Function({
      required String id,
      required String eventId,
      required double score,
      required String factorsJson,
      required String algorithmVersion,
      Value<bool> isIllustrative,
      Value<DateTime> evaluatedAt,
      Value<int> rowid,
    });
typedef $$ContextScoresTableUpdateCompanionBuilder =
    ContextScoresCompanion Function({
      Value<String> id,
      Value<String> eventId,
      Value<double> score,
      Value<String> factorsJson,
      Value<String> algorithmVersion,
      Value<bool> isIllustrative,
      Value<DateTime> evaluatedAt,
      Value<int> rowid,
    });

final class $$ContextScoresTableReferences
    extends
        BaseReferences<_$AppDatabase, $ContextScoresTable, ContextScoreRow> {
  $$ContextScoresTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.contextScores.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ContextScoresTableFilterComposer
    extends Composer<_$AppDatabase, $ContextScoresTable> {
  $$ContextScoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get factorsJson => $composableBuilder(
    column: $table.factorsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isIllustrative => $composableBuilder(
    column: $table.isIllustrative,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get evaluatedAt => $composableBuilder(
    column: $table.evaluatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContextScoresTableOrderingComposer
    extends Composer<_$AppDatabase, $ContextScoresTable> {
  $$ContextScoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get factorsJson => $composableBuilder(
    column: $table.factorsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isIllustrative => $composableBuilder(
    column: $table.isIllustrative,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get evaluatedAt => $composableBuilder(
    column: $table.evaluatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContextScoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContextScoresTable> {
  $$ContextScoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get factorsJson => $composableBuilder(
    column: $table.factorsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isIllustrative => $composableBuilder(
    column: $table.isIllustrative,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get evaluatedAt => $composableBuilder(
    column: $table.evaluatedAt,
    builder: (column) => column,
  );

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContextScoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContextScoresTable,
          ContextScoreRow,
          $$ContextScoresTableFilterComposer,
          $$ContextScoresTableOrderingComposer,
          $$ContextScoresTableAnnotationComposer,
          $$ContextScoresTableCreateCompanionBuilder,
          $$ContextScoresTableUpdateCompanionBuilder,
          (ContextScoreRow, $$ContextScoresTableReferences),
          ContextScoreRow,
          PrefetchHooks Function({bool eventId})
        > {
  $$ContextScoresTableTableManager(_$AppDatabase db, $ContextScoresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContextScoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContextScoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContextScoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<double> score = const Value.absent(),
                Value<String> factorsJson = const Value.absent(),
                Value<String> algorithmVersion = const Value.absent(),
                Value<bool> isIllustrative = const Value.absent(),
                Value<DateTime> evaluatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContextScoresCompanion(
                id: id,
                eventId: eventId,
                score: score,
                factorsJson: factorsJson,
                algorithmVersion: algorithmVersion,
                isIllustrative: isIllustrative,
                evaluatedAt: evaluatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String eventId,
                required double score,
                required String factorsJson,
                required String algorithmVersion,
                Value<bool> isIllustrative = const Value.absent(),
                Value<DateTime> evaluatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContextScoresCompanion.insert(
                id: id,
                eventId: eventId,
                score: score,
                factorsJson: factorsJson,
                algorithmVersion: algorithmVersion,
                isIllustrative: isIllustrative,
                evaluatedAt: evaluatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContextScoresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$ContextScoresTableReferences
                                    ._eventIdTable(db),
                                referencedColumn: $$ContextScoresTableReferences
                                    ._eventIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ContextScoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContextScoresTable,
      ContextScoreRow,
      $$ContextScoresTableFilterComposer,
      $$ContextScoresTableOrderingComposer,
      $$ContextScoresTableAnnotationComposer,
      $$ContextScoresTableCreateCompanionBuilder,
      $$ContextScoresTableUpdateCompanionBuilder,
      (ContextScoreRow, $$ContextScoresTableReferences),
      ContextScoreRow,
      PrefetchHooks Function({bool eventId})
    >;
typedef $$PreservationRecommendationsTableCreateCompanionBuilder =
    PreservationRecommendationsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String eventId,
      required String recommendationType,
      required String explanation,
      required String proposedAction,
      Value<String> actionPayloadJson,
      required double preservationNeed,
      Value<double> sensitivityAtCreation,
      Value<bool> isSafeForNotification,
      Value<String> status,
      Value<DateTime?> actedAt,
      Value<DateTime?> dismissedAt,
      Value<int> rowid,
    });
typedef $$PreservationRecommendationsTableUpdateCompanionBuilder =
    PreservationRecommendationsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> eventId,
      Value<String> recommendationType,
      Value<String> explanation,
      Value<String> proposedAction,
      Value<String> actionPayloadJson,
      Value<double> preservationNeed,
      Value<double> sensitivityAtCreation,
      Value<bool> isSafeForNotification,
      Value<String> status,
      Value<DateTime?> actedAt,
      Value<DateTime?> dismissedAt,
      Value<int> rowid,
    });

final class $$PreservationRecommendationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PreservationRecommendationsTable,
          PreservationRecommendationRow
        > {
  $$PreservationRecommendationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.preservationRecommendations.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RemindersTable, List<ReminderRow>>
  _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminders,
    aliasName: $_aliasNameGenerator(
      db.preservationRecommendations.id,
      db.reminders.recommendationId,
    ),
  );

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager($_db, $_db.reminders).filter(
      (f) => f.recommendationId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UserFeedbackTable, List<UserFeedbackRow>>
  _userFeedbackRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userFeedback,
    aliasName: $_aliasNameGenerator(
      db.preservationRecommendations.id,
      db.userFeedback.recommendationId,
    ),
  );

  $$UserFeedbackTableProcessedTableManager get userFeedbackRefs {
    final manager = $$UserFeedbackTableTableManager($_db, $_db.userFeedback)
        .filter(
          (f) => f.recommendationId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_userFeedbackRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PreservationRecommendationsTableFilterComposer
    extends Composer<_$AppDatabase, $PreservationRecommendationsTable> {
  $$PreservationRecommendationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recommendationType => $composableBuilder(
    column: $table.recommendationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proposedAction => $composableBuilder(
    column: $table.proposedAction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actionPayloadJson => $composableBuilder(
    column: $table.actionPayloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get preservationNeed => $composableBuilder(
    column: $table.preservationNeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sensitivityAtCreation => $composableBuilder(
    column: $table.sensitivityAtCreation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSafeForNotification => $composableBuilder(
    column: $table.isSafeForNotification,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get actedAt => $composableBuilder(
    column: $table.actedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dismissedAt => $composableBuilder(
    column: $table.dismissedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> remindersRefs(
    Expression<bool> Function($$RemindersTableFilterComposer f) f,
  ) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.recommendationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userFeedbackRefs(
    Expression<bool> Function($$UserFeedbackTableFilterComposer f) f,
  ) {
    final $$UserFeedbackTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userFeedback,
      getReferencedColumn: (t) => t.recommendationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserFeedbackTableFilterComposer(
            $db: $db,
            $table: $db.userFeedback,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PreservationRecommendationsTableOrderingComposer
    extends Composer<_$AppDatabase, $PreservationRecommendationsTable> {
  $$PreservationRecommendationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recommendationType => $composableBuilder(
    column: $table.recommendationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proposedAction => $composableBuilder(
    column: $table.proposedAction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actionPayloadJson => $composableBuilder(
    column: $table.actionPayloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get preservationNeed => $composableBuilder(
    column: $table.preservationNeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sensitivityAtCreation => $composableBuilder(
    column: $table.sensitivityAtCreation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSafeForNotification => $composableBuilder(
    column: $table.isSafeForNotification,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get actedAt => $composableBuilder(
    column: $table.actedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dismissedAt => $composableBuilder(
    column: $table.dismissedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PreservationRecommendationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PreservationRecommendationsTable> {
  $$PreservationRecommendationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get recommendationType => $composableBuilder(
    column: $table.recommendationType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get proposedAction => $composableBuilder(
    column: $table.proposedAction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actionPayloadJson => $composableBuilder(
    column: $table.actionPayloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get preservationNeed => $composableBuilder(
    column: $table.preservationNeed,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sensitivityAtCreation => $composableBuilder(
    column: $table.sensitivityAtCreation,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSafeForNotification => $composableBuilder(
    column: $table.isSafeForNotification,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get actedAt =>
      $composableBuilder(column: $table.actedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get dismissedAt => $composableBuilder(
    column: $table.dismissedAt,
    builder: (column) => column,
  );

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> remindersRefs<T extends Object>(
    Expression<T> Function($$RemindersTableAnnotationComposer a) f,
  ) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.recommendationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> userFeedbackRefs<T extends Object>(
    Expression<T> Function($$UserFeedbackTableAnnotationComposer a) f,
  ) {
    final $$UserFeedbackTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userFeedback,
      getReferencedColumn: (t) => t.recommendationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserFeedbackTableAnnotationComposer(
            $db: $db,
            $table: $db.userFeedback,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PreservationRecommendationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PreservationRecommendationsTable,
          PreservationRecommendationRow,
          $$PreservationRecommendationsTableFilterComposer,
          $$PreservationRecommendationsTableOrderingComposer,
          $$PreservationRecommendationsTableAnnotationComposer,
          $$PreservationRecommendationsTableCreateCompanionBuilder,
          $$PreservationRecommendationsTableUpdateCompanionBuilder,
          (
            PreservationRecommendationRow,
            $$PreservationRecommendationsTableReferences,
          ),
          PreservationRecommendationRow,
          PrefetchHooks Function({
            bool eventId,
            bool remindersRefs,
            bool userFeedbackRefs,
          })
        > {
  $$PreservationRecommendationsTableTableManager(
    _$AppDatabase db,
    $PreservationRecommendationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PreservationRecommendationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PreservationRecommendationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PreservationRecommendationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<String> recommendationType = const Value.absent(),
                Value<String> explanation = const Value.absent(),
                Value<String> proposedAction = const Value.absent(),
                Value<String> actionPayloadJson = const Value.absent(),
                Value<double> preservationNeed = const Value.absent(),
                Value<double> sensitivityAtCreation = const Value.absent(),
                Value<bool> isSafeForNotification = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> actedAt = const Value.absent(),
                Value<DateTime?> dismissedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PreservationRecommendationsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                eventId: eventId,
                recommendationType: recommendationType,
                explanation: explanation,
                proposedAction: proposedAction,
                actionPayloadJson: actionPayloadJson,
                preservationNeed: preservationNeed,
                sensitivityAtCreation: sensitivityAtCreation,
                isSafeForNotification: isSafeForNotification,
                status: status,
                actedAt: actedAt,
                dismissedAt: dismissedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String eventId,
                required String recommendationType,
                required String explanation,
                required String proposedAction,
                Value<String> actionPayloadJson = const Value.absent(),
                required double preservationNeed,
                Value<double> sensitivityAtCreation = const Value.absent(),
                Value<bool> isSafeForNotification = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> actedAt = const Value.absent(),
                Value<DateTime?> dismissedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PreservationRecommendationsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                eventId: eventId,
                recommendationType: recommendationType,
                explanation: explanation,
                proposedAction: proposedAction,
                actionPayloadJson: actionPayloadJson,
                preservationNeed: preservationNeed,
                sensitivityAtCreation: sensitivityAtCreation,
                isSafeForNotification: isSafeForNotification,
                status: status,
                actedAt: actedAt,
                dismissedAt: dismissedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PreservationRecommendationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                eventId = false,
                remindersRefs = false,
                userFeedbackRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (remindersRefs) db.reminders,
                    if (userFeedbackRefs) db.userFeedback,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (eventId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.eventId,
                                    referencedTable:
                                        $$PreservationRecommendationsTableReferences
                                            ._eventIdTable(db),
                                    referencedColumn:
                                        $$PreservationRecommendationsTableReferences
                                            ._eventIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (remindersRefs)
                        await $_getPrefetchedData<
                          PreservationRecommendationRow,
                          $PreservationRecommendationsTable,
                          ReminderRow
                        >(
                          currentTable: table,
                          referencedTable:
                              $$PreservationRecommendationsTableReferences
                                  ._remindersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PreservationRecommendationsTableReferences(
                                db,
                                table,
                                p0,
                              ).remindersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recommendationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (userFeedbackRefs)
                        await $_getPrefetchedData<
                          PreservationRecommendationRow,
                          $PreservationRecommendationsTable,
                          UserFeedbackRow
                        >(
                          currentTable: table,
                          referencedTable:
                              $$PreservationRecommendationsTableReferences
                                  ._userFeedbackRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PreservationRecommendationsTableReferences(
                                db,
                                table,
                                p0,
                              ).userFeedbackRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recommendationId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PreservationRecommendationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PreservationRecommendationsTable,
      PreservationRecommendationRow,
      $$PreservationRecommendationsTableFilterComposer,
      $$PreservationRecommendationsTableOrderingComposer,
      $$PreservationRecommendationsTableAnnotationComposer,
      $$PreservationRecommendationsTableCreateCompanionBuilder,
      $$PreservationRecommendationsTableUpdateCompanionBuilder,
      (
        PreservationRecommendationRow,
        $$PreservationRecommendationsTableReferences,
      ),
      PreservationRecommendationRow,
      PrefetchHooks Function({
        bool eventId,
        bool remindersRefs,
        bool userFeedbackRefs,
      })
    >;
typedef $$RemindersTableCreateCompanionBuilder =
    RemindersCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String eventId,
      Value<String?> recommendationId,
      required String reminderType,
      required DateTime scheduledAt,
      required String neutralText,
      Value<int?> notificationId,
      Value<String> status,
      Value<DateTime?> deliveredAt,
      Value<DateTime?> openedAt,
      Value<int> rowid,
    });
typedef $$RemindersTableUpdateCompanionBuilder =
    RemindersCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> eventId,
      Value<String?> recommendationId,
      Value<String> reminderType,
      Value<DateTime> scheduledAt,
      Value<String> neutralText,
      Value<int?> notificationId,
      Value<String> status,
      Value<DateTime?> deliveredAt,
      Value<DateTime?> openedAt,
      Value<int> rowid,
    });

final class $$RemindersTableReferences
    extends BaseReferences<_$AppDatabase, $RemindersTable, ReminderRow> {
  $$RemindersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.reminders.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PreservationRecommendationsTable _recommendationIdTable(
    _$AppDatabase db,
  ) => db.preservationRecommendations.createAlias(
    $_aliasNameGenerator(
      db.reminders.recommendationId,
      db.preservationRecommendations.id,
    ),
  );

  $$PreservationRecommendationsTableProcessedTableManager?
  get recommendationId {
    final $_column = $_itemColumn<String>('recommendation_id');
    if ($_column == null) return null;
    final manager = $$PreservationRecommendationsTableTableManager(
      $_db,
      $_db.preservationRecommendations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recommendationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderType => $composableBuilder(
    column: $table.reminderType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get neutralText => $composableBuilder(
    column: $table.neutralText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deliveredAt => $composableBuilder(
    column: $table.deliveredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PreservationRecommendationsTableFilterComposer get recommendationId {
    final $$PreservationRecommendationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.recommendationId,
          referencedTable: $db.preservationRecommendations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PreservationRecommendationsTableFilterComposer(
                $db: $db,
                $table: $db.preservationRecommendations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderType => $composableBuilder(
    column: $table.reminderType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get neutralText => $composableBuilder(
    column: $table.neutralText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deliveredAt => $composableBuilder(
    column: $table.deliveredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PreservationRecommendationsTableOrderingComposer get recommendationId {
    final $$PreservationRecommendationsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.recommendationId,
          referencedTable: $db.preservationRecommendations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PreservationRecommendationsTableOrderingComposer(
                $db: $db,
                $table: $db.preservationRecommendations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reminderType => $composableBuilder(
    column: $table.reminderType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get neutralText => $composableBuilder(
    column: $table.neutralText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get deliveredAt => $composableBuilder(
    column: $table.deliveredAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => column);

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PreservationRecommendationsTableAnnotationComposer get recommendationId {
    final $$PreservationRecommendationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.recommendationId,
          referencedTable: $db.preservationRecommendations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PreservationRecommendationsTableAnnotationComposer(
                $db: $db,
                $table: $db.preservationRecommendations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          ReminderRow,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (ReminderRow, $$RemindersTableReferences),
          ReminderRow,
          PrefetchHooks Function({bool eventId, bool recommendationId})
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<String?> recommendationId = const Value.absent(),
                Value<String> reminderType = const Value.absent(),
                Value<DateTime> scheduledAt = const Value.absent(),
                Value<String> neutralText = const Value.absent(),
                Value<int?> notificationId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> deliveredAt = const Value.absent(),
                Value<DateTime?> openedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                eventId: eventId,
                recommendationId: recommendationId,
                reminderType: reminderType,
                scheduledAt: scheduledAt,
                neutralText: neutralText,
                notificationId: notificationId,
                status: status,
                deliveredAt: deliveredAt,
                openedAt: openedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String eventId,
                Value<String?> recommendationId = const Value.absent(),
                required String reminderType,
                required DateTime scheduledAt,
                required String neutralText,
                Value<int?> notificationId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> deliveredAt = const Value.absent(),
                Value<DateTime?> openedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                eventId: eventId,
                recommendationId: recommendationId,
                reminderType: reminderType,
                scheduledAt: scheduledAt,
                neutralText: neutralText,
                notificationId: notificationId,
                status: status,
                deliveredAt: deliveredAt,
                openedAt: openedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RemindersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false, recommendationId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$RemindersTableReferences
                                    ._eventIdTable(db),
                                referencedColumn: $$RemindersTableReferences
                                    ._eventIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (recommendationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recommendationId,
                                referencedTable: $$RemindersTableReferences
                                    ._recommendationIdTable(db),
                                referencedColumn: $$RemindersTableReferences
                                    ._recommendationIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      ReminderRow,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (ReminderRow, $$RemindersTableReferences),
      ReminderRow,
      PrefetchHooks Function({bool eventId, bool recommendationId})
    >;
typedef $$UserFeedbackTableCreateCompanionBuilder =
    UserFeedbackCompanion Function({
      required String id,
      required String eventId,
      Value<String?> recommendationId,
      required String feedbackType,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$UserFeedbackTableUpdateCompanionBuilder =
    UserFeedbackCompanion Function({
      Value<String> id,
      Value<String> eventId,
      Value<String?> recommendationId,
      Value<String> feedbackType,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$UserFeedbackTableReferences
    extends BaseReferences<_$AppDatabase, $UserFeedbackTable, UserFeedbackRow> {
  $$UserFeedbackTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.userFeedback.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PreservationRecommendationsTable _recommendationIdTable(
    _$AppDatabase db,
  ) => db.preservationRecommendations.createAlias(
    $_aliasNameGenerator(
      db.userFeedback.recommendationId,
      db.preservationRecommendations.id,
    ),
  );

  $$PreservationRecommendationsTableProcessedTableManager?
  get recommendationId {
    final $_column = $_itemColumn<String>('recommendation_id');
    if ($_column == null) return null;
    final manager = $$PreservationRecommendationsTableTableManager(
      $_db,
      $_db.preservationRecommendations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recommendationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserFeedbackTableFilterComposer
    extends Composer<_$AppDatabase, $UserFeedbackTable> {
  $$UserFeedbackTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feedbackType => $composableBuilder(
    column: $table.feedbackType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PreservationRecommendationsTableFilterComposer get recommendationId {
    final $$PreservationRecommendationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.recommendationId,
          referencedTable: $db.preservationRecommendations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PreservationRecommendationsTableFilterComposer(
                $db: $db,
                $table: $db.preservationRecommendations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$UserFeedbackTableOrderingComposer
    extends Composer<_$AppDatabase, $UserFeedbackTable> {
  $$UserFeedbackTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedbackType => $composableBuilder(
    column: $table.feedbackType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PreservationRecommendationsTableOrderingComposer get recommendationId {
    final $$PreservationRecommendationsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.recommendationId,
          referencedTable: $db.preservationRecommendations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PreservationRecommendationsTableOrderingComposer(
                $db: $db,
                $table: $db.preservationRecommendations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$UserFeedbackTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserFeedbackTable> {
  $$UserFeedbackTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get feedbackType => $composableBuilder(
    column: $table.feedbackType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PreservationRecommendationsTableAnnotationComposer get recommendationId {
    final $$PreservationRecommendationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.recommendationId,
          referencedTable: $db.preservationRecommendations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PreservationRecommendationsTableAnnotationComposer(
                $db: $db,
                $table: $db.preservationRecommendations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$UserFeedbackTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserFeedbackTable,
          UserFeedbackRow,
          $$UserFeedbackTableFilterComposer,
          $$UserFeedbackTableOrderingComposer,
          $$UserFeedbackTableAnnotationComposer,
          $$UserFeedbackTableCreateCompanionBuilder,
          $$UserFeedbackTableUpdateCompanionBuilder,
          (UserFeedbackRow, $$UserFeedbackTableReferences),
          UserFeedbackRow,
          PrefetchHooks Function({bool eventId, bool recommendationId})
        > {
  $$UserFeedbackTableTableManager(_$AppDatabase db, $UserFeedbackTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserFeedbackTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserFeedbackTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserFeedbackTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<String?> recommendationId = const Value.absent(),
                Value<String> feedbackType = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserFeedbackCompanion(
                id: id,
                eventId: eventId,
                recommendationId: recommendationId,
                feedbackType: feedbackType,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String eventId,
                Value<String?> recommendationId = const Value.absent(),
                required String feedbackType,
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserFeedbackCompanion.insert(
                id: id,
                eventId: eventId,
                recommendationId: recommendationId,
                feedbackType: feedbackType,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserFeedbackTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false, recommendationId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$UserFeedbackTableReferences
                                    ._eventIdTable(db),
                                referencedColumn: $$UserFeedbackTableReferences
                                    ._eventIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (recommendationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recommendationId,
                                referencedTable: $$UserFeedbackTableReferences
                                    ._recommendationIdTable(db),
                                referencedColumn: $$UserFeedbackTableReferences
                                    ._recommendationIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserFeedbackTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserFeedbackTable,
      UserFeedbackRow,
      $$UserFeedbackTableFilterComposer,
      $$UserFeedbackTableOrderingComposer,
      $$UserFeedbackTableAnnotationComposer,
      $$UserFeedbackTableCreateCompanionBuilder,
      $$UserFeedbackTableUpdateCompanionBuilder,
      (UserFeedbackRow, $$UserFeedbackTableReferences),
      UserFeedbackRow,
      PrefetchHooks Function({bool eventId, bool recommendationId})
    >;
typedef $$PrivacySettingsTableCreateCompanionBuilder =
    PrivacySettingsCompanion Function({
      required String id,
      Value<String> galleryAccessMode,
      Value<bool> biometricLockEnabled,
      Value<bool> hideSensitivePreviews,
      Value<bool> neutralNotificationsOnly,
      Value<bool> analyticsEnabled,
      Value<bool> cloudBackupEnabled,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$PrivacySettingsTableUpdateCompanionBuilder =
    PrivacySettingsCompanion Function({
      Value<String> id,
      Value<String> galleryAccessMode,
      Value<bool> biometricLockEnabled,
      Value<bool> hideSensitivePreviews,
      Value<bool> neutralNotificationsOnly,
      Value<bool> analyticsEnabled,
      Value<bool> cloudBackupEnabled,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$PrivacySettingsTableFilterComposer
    extends Composer<_$AppDatabase, $PrivacySettingsTable> {
  $$PrivacySettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get galleryAccessMode => $composableBuilder(
    column: $table.galleryAccessMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get biometricLockEnabled => $composableBuilder(
    column: $table.biometricLockEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hideSensitivePreviews => $composableBuilder(
    column: $table.hideSensitivePreviews,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get neutralNotificationsOnly => $composableBuilder(
    column: $table.neutralNotificationsOnly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get analyticsEnabled => $composableBuilder(
    column: $table.analyticsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get cloudBackupEnabled => $composableBuilder(
    column: $table.cloudBackupEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PrivacySettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $PrivacySettingsTable> {
  $$PrivacySettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get galleryAccessMode => $composableBuilder(
    column: $table.galleryAccessMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get biometricLockEnabled => $composableBuilder(
    column: $table.biometricLockEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hideSensitivePreviews => $composableBuilder(
    column: $table.hideSensitivePreviews,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get neutralNotificationsOnly => $composableBuilder(
    column: $table.neutralNotificationsOnly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get analyticsEnabled => $composableBuilder(
    column: $table.analyticsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get cloudBackupEnabled => $composableBuilder(
    column: $table.cloudBackupEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrivacySettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrivacySettingsTable> {
  $$PrivacySettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get galleryAccessMode => $composableBuilder(
    column: $table.galleryAccessMode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get biometricLockEnabled => $composableBuilder(
    column: $table.biometricLockEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hideSensitivePreviews => $composableBuilder(
    column: $table.hideSensitivePreviews,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get neutralNotificationsOnly => $composableBuilder(
    column: $table.neutralNotificationsOnly,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get analyticsEnabled => $composableBuilder(
    column: $table.analyticsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get cloudBackupEnabled => $composableBuilder(
    column: $table.cloudBackupEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PrivacySettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrivacySettingsTable,
          PrivacySettingsRow,
          $$PrivacySettingsTableFilterComposer,
          $$PrivacySettingsTableOrderingComposer,
          $$PrivacySettingsTableAnnotationComposer,
          $$PrivacySettingsTableCreateCompanionBuilder,
          $$PrivacySettingsTableUpdateCompanionBuilder,
          (
            PrivacySettingsRow,
            BaseReferences<
              _$AppDatabase,
              $PrivacySettingsTable,
              PrivacySettingsRow
            >,
          ),
          PrivacySettingsRow,
          PrefetchHooks Function()
        > {
  $$PrivacySettingsTableTableManager(
    _$AppDatabase db,
    $PrivacySettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrivacySettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrivacySettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrivacySettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> galleryAccessMode = const Value.absent(),
                Value<bool> biometricLockEnabled = const Value.absent(),
                Value<bool> hideSensitivePreviews = const Value.absent(),
                Value<bool> neutralNotificationsOnly = const Value.absent(),
                Value<bool> analyticsEnabled = const Value.absent(),
                Value<bool> cloudBackupEnabled = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrivacySettingsCompanion(
                id: id,
                galleryAccessMode: galleryAccessMode,
                biometricLockEnabled: biometricLockEnabled,
                hideSensitivePreviews: hideSensitivePreviews,
                neutralNotificationsOnly: neutralNotificationsOnly,
                analyticsEnabled: analyticsEnabled,
                cloudBackupEnabled: cloudBackupEnabled,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> galleryAccessMode = const Value.absent(),
                Value<bool> biometricLockEnabled = const Value.absent(),
                Value<bool> hideSensitivePreviews = const Value.absent(),
                Value<bool> neutralNotificationsOnly = const Value.absent(),
                Value<bool> analyticsEnabled = const Value.absent(),
                Value<bool> cloudBackupEnabled = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrivacySettingsCompanion.insert(
                id: id,
                galleryAccessMode: galleryAccessMode,
                biometricLockEnabled: biometricLockEnabled,
                hideSensitivePreviews: hideSensitivePreviews,
                neutralNotificationsOnly: neutralNotificationsOnly,
                analyticsEnabled: analyticsEnabled,
                cloudBackupEnabled: cloudBackupEnabled,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PrivacySettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrivacySettingsTable,
      PrivacySettingsRow,
      $$PrivacySettingsTableFilterComposer,
      $$PrivacySettingsTableOrderingComposer,
      $$PrivacySettingsTableAnnotationComposer,
      $$PrivacySettingsTableCreateCompanionBuilder,
      $$PrivacySettingsTableUpdateCompanionBuilder,
      (
        PrivacySettingsRow,
        BaseReferences<
          _$AppDatabase,
          $PrivacySettingsTable,
          PrivacySettingsRow
        >,
      ),
      PrivacySettingsRow,
      PrefetchHooks Function()
    >;
typedef $$EventInteractionsTableCreateCompanionBuilder =
    EventInteractionsCompanion Function({
      required String id,
      required String eventId,
      required String interactionType,
      Value<String> source,
      required DateTime occurredAt,
      Value<String> metadataJson,
      Value<int> rowid,
    });
typedef $$EventInteractionsTableUpdateCompanionBuilder =
    EventInteractionsCompanion Function({
      Value<String> id,
      Value<String> eventId,
      Value<String> interactionType,
      Value<String> source,
      Value<DateTime> occurredAt,
      Value<String> metadataJson,
      Value<int> rowid,
    });

final class $$EventInteractionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $EventInteractionsTable,
          EventInteractionRow
        > {
  $$EventInteractionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.eventInteractions.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventInteractionsTableFilterComposer
    extends Composer<_$AppDatabase, $EventInteractionsTable> {
  $$EventInteractionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get interactionType => $composableBuilder(
    column: $table.interactionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventInteractionsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventInteractionsTable> {
  $$EventInteractionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get interactionType => $composableBuilder(
    column: $table.interactionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventInteractionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventInteractionsTable> {
  $$EventInteractionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get interactionType => $composableBuilder(
    column: $table.interactionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventInteractionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventInteractionsTable,
          EventInteractionRow,
          $$EventInteractionsTableFilterComposer,
          $$EventInteractionsTableOrderingComposer,
          $$EventInteractionsTableAnnotationComposer,
          $$EventInteractionsTableCreateCompanionBuilder,
          $$EventInteractionsTableUpdateCompanionBuilder,
          (EventInteractionRow, $$EventInteractionsTableReferences),
          EventInteractionRow,
          PrefetchHooks Function({bool eventId})
        > {
  $$EventInteractionsTableTableManager(
    _$AppDatabase db,
    $EventInteractionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventInteractionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventInteractionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventInteractionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<String> interactionType = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventInteractionsCompanion(
                id: id,
                eventId: eventId,
                interactionType: interactionType,
                source: source,
                occurredAt: occurredAt,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String eventId,
                required String interactionType,
                Value<String> source = const Value.absent(),
                required DateTime occurredAt,
                Value<String> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventInteractionsCompanion.insert(
                id: id,
                eventId: eventId,
                interactionType: interactionType,
                source: source,
                occurredAt: occurredAt,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventInteractionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable:
                                    $$EventInteractionsTableReferences
                                        ._eventIdTable(db),
                                referencedColumn:
                                    $$EventInteractionsTableReferences
                                        ._eventIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EventInteractionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventInteractionsTable,
      EventInteractionRow,
      $$EventInteractionsTableFilterComposer,
      $$EventInteractionsTableOrderingComposer,
      $$EventInteractionsTableAnnotationComposer,
      $$EventInteractionsTableCreateCompanionBuilder,
      $$EventInteractionsTableUpdateCompanionBuilder,
      (EventInteractionRow, $$EventInteractionsTableReferences),
      EventInteractionRow,
      PrefetchHooks Function({bool eventId})
    >;
typedef $$ProcessingJobsTableCreateCompanionBuilder =
    ProcessingJobsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      Value<String?> mediaId,
      Value<String?> eventId,
      required String jobType,
      Value<String> status,
      Value<int> attempts,
      Value<double> progress,
      Value<DateTime?> nextAttemptAt,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<String?> errorCode,
      Value<String> payloadJson,
      Value<int> rowid,
    });
typedef $$ProcessingJobsTableUpdateCompanionBuilder =
    ProcessingJobsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String?> mediaId,
      Value<String?> eventId,
      Value<String> jobType,
      Value<String> status,
      Value<int> attempts,
      Value<double> progress,
      Value<DateTime?> nextAttemptAt,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<String?> errorCode,
      Value<String> payloadJson,
      Value<int> rowid,
    });

final class $$ProcessingJobsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ProcessingJobsTable, ProcessingJobRow> {
  $$ProcessingJobsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MediaItemsTable _mediaIdTable(_$AppDatabase db) =>
      db.mediaItems.createAlias(
        $_aliasNameGenerator(db.processingJobs.mediaId, db.mediaItems.id),
      );

  $$MediaItemsTableProcessedTableManager? get mediaId {
    final $_column = $_itemColumn<String>('media_id');
    if ($_column == null) return null;
    final manager = $$MediaItemsTableTableManager(
      $_db,
      $_db.mediaItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mediaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.processingJobs.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager? get eventId {
    final $_column = $_itemColumn<String>('event_id');
    if ($_column == null) return null;
    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProcessingJobsTableFilterComposer
    extends Composer<_$AppDatabase, $ProcessingJobsTable> {
  $$ProcessingJobsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jobType => $composableBuilder(
    column: $table.jobType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  $$MediaItemsTableFilterComposer get mediaId {
    final $$MediaItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableFilterComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProcessingJobsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProcessingJobsTable> {
  $$ProcessingJobsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jobType => $composableBuilder(
    column: $table.jobType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  $$MediaItemsTableOrderingComposer get mediaId {
    final $$MediaItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableOrderingComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProcessingJobsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProcessingJobsTable> {
  $$ProcessingJobsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get jobType =>
      $composableBuilder(column: $table.jobType, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorCode =>
      $composableBuilder(column: $table.errorCode, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  $$MediaItemsTableAnnotationComposer get mediaId {
    final $$MediaItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProcessingJobsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProcessingJobsTable,
          ProcessingJobRow,
          $$ProcessingJobsTableFilterComposer,
          $$ProcessingJobsTableOrderingComposer,
          $$ProcessingJobsTableAnnotationComposer,
          $$ProcessingJobsTableCreateCompanionBuilder,
          $$ProcessingJobsTableUpdateCompanionBuilder,
          (ProcessingJobRow, $$ProcessingJobsTableReferences),
          ProcessingJobRow,
          PrefetchHooks Function({bool mediaId, bool eventId})
        > {
  $$ProcessingJobsTableTableManager(
    _$AppDatabase db,
    $ProcessingJobsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProcessingJobsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProcessingJobsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProcessingJobsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String?> mediaId = const Value.absent(),
                Value<String?> eventId = const Value.absent(),
                Value<String> jobType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<DateTime?> nextAttemptAt = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProcessingJobsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                mediaId: mediaId,
                eventId: eventId,
                jobType: jobType,
                status: status,
                attempts: attempts,
                progress: progress,
                nextAttemptAt: nextAttemptAt,
                startedAt: startedAt,
                completedAt: completedAt,
                errorCode: errorCode,
                payloadJson: payloadJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                Value<String?> mediaId = const Value.absent(),
                Value<String?> eventId = const Value.absent(),
                required String jobType,
                Value<String> status = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<DateTime?> nextAttemptAt = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProcessingJobsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                mediaId: mediaId,
                eventId: eventId,
                jobType: jobType,
                status: status,
                attempts: attempts,
                progress: progress,
                nextAttemptAt: nextAttemptAt,
                startedAt: startedAt,
                completedAt: completedAt,
                errorCode: errorCode,
                payloadJson: payloadJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProcessingJobsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mediaId = false, eventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mediaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mediaId,
                                referencedTable: $$ProcessingJobsTableReferences
                                    ._mediaIdTable(db),
                                referencedColumn:
                                    $$ProcessingJobsTableReferences
                                        ._mediaIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$ProcessingJobsTableReferences
                                    ._eventIdTable(db),
                                referencedColumn:
                                    $$ProcessingJobsTableReferences
                                        ._eventIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProcessingJobsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProcessingJobsTable,
      ProcessingJobRow,
      $$ProcessingJobsTableFilterComposer,
      $$ProcessingJobsTableOrderingComposer,
      $$ProcessingJobsTableAnnotationComposer,
      $$ProcessingJobsTableCreateCompanionBuilder,
      $$ProcessingJobsTableUpdateCompanionBuilder,
      (ProcessingJobRow, $$ProcessingJobsTableReferences),
      ProcessingJobRow,
      PrefetchHooks Function({bool mediaId, bool eventId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ScanHistoryTableTableManager get scanHistory =>
      $$ScanHistoryTableTableManager(_db, _db.scanHistory);
  $$MediaItemsTableTableManager get mediaItems =>
      $$MediaItemsTableTableManager(_db, _db.mediaItems);
  $$PlacesTableTableManager get places =>
      $$PlacesTableTableManager(_db, _db.places);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$EventMediaTableTableManager get eventMedia =>
      $$EventMediaTableTableManager(_db, _db.eventMedia);
  $$PersonsTableTableManager get persons =>
      $$PersonsTableTableManager(_db, _db.persons);
  $$EventPersonsTableTableManager get eventPersons =>
      $$EventPersonsTableTableManager(_db, _db.eventPersons);
  $$MediaPersonsTableTableManager get mediaPersons =>
      $$MediaPersonsTableTableManager(_db, _db.mediaPersons);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$VoiceNotesTableTableManager get voiceNotes =>
      $$VoiceNotesTableTableManager(_db, _db.voiceNotes);
  $$GraphNodesTableTableManager get graphNodes =>
      $$GraphNodesTableTableManager(_db, _db.graphNodes);
  $$GraphEdgesTableTableManager get graphEdges =>
      $$GraphEdgesTableTableManager(_db, _db.graphEdges);
  $$SignificanceScoresTableTableManager get significanceScores =>
      $$SignificanceScoresTableTableManager(_db, _db.significanceScores);
  $$RediscoveryScoresTableTableManager get rediscoveryScores =>
      $$RediscoveryScoresTableTableManager(_db, _db.rediscoveryScores);
  $$ContextScoresTableTableManager get contextScores =>
      $$ContextScoresTableTableManager(_db, _db.contextScores);
  $$PreservationRecommendationsTableTableManager
  get preservationRecommendations =>
      $$PreservationRecommendationsTableTableManager(
        _db,
        _db.preservationRecommendations,
      );
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$UserFeedbackTableTableManager get userFeedback =>
      $$UserFeedbackTableTableManager(_db, _db.userFeedback);
  $$PrivacySettingsTableTableManager get privacySettings =>
      $$PrivacySettingsTableTableManager(_db, _db.privacySettings);
  $$EventInteractionsTableTableManager get eventInteractions =>
      $$EventInteractionsTableTableManager(_db, _db.eventInteractions);
  $$ProcessingJobsTableTableManager get processingJobs =>
      $$ProcessingJobsTableTableManager(_db, _db.processingJobs);
}
