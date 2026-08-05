// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DatabaseMetadataTable extends DatabaseMetadata
    with TableInfo<$DatabaseMetadataTable, DatabaseMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DatabaseMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'database_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<DatabaseMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  DatabaseMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DatabaseMetadataData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DatabaseMetadataTable createAlias(String alias) {
    return $DatabaseMetadataTable(attachedDatabase, alias);
  }
}

class DatabaseMetadataData extends DataClass
    implements Insertable<DatabaseMetadataData> {
  final String key;
  final String value;
  final int createdAt;
  final int updatedAt;
  const DatabaseMetadataData({
    required this.key,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  DatabaseMetadataCompanion toCompanion(bool nullToAbsent) {
    return DatabaseMetadataCompanion(
      key: Value(key),
      value: Value(value),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DatabaseMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DatabaseMetadataData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  DatabaseMetadataData copyWith({
    String? key,
    String? value,
    int? createdAt,
    int? updatedAt,
  }) => DatabaseMetadataData(
    key: key ?? this.key,
    value: value ?? this.value,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DatabaseMetadataData copyWithCompanion(DatabaseMetadataCompanion data) {
    return DatabaseMetadataData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DatabaseMetadataData(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DatabaseMetadataData &&
          other.key == this.key &&
          other.value == this.value &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DatabaseMetadataCompanion extends UpdateCompanion<DatabaseMetadataData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const DatabaseMetadataCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DatabaseMetadataCompanion.insert({
    required String key,
    required String value,
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<DatabaseMetadataData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DatabaseMetadataCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return DatabaseMetadataCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DatabaseMetadataCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserSettingsTable extends UserSettings
    with TableInfo<$UserSettingsTable, UserSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
    'locale',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekStartMeta = const VerificationMeta(
    'weekStart',
  );
  @override
  late final GeneratedColumn<int> weekStart = GeneratedColumn<int>(
    'week_start',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hourDisplayModeMeta = const VerificationMeta(
    'hourDisplayMode',
  );
  @override
  late final GeneratedColumn<String> hourDisplayMode = GeneratedColumn<String>(
    'hour_display_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _holidayRegionMeta = const VerificationMeta(
    'holidayRegion',
  );
  @override
  late final GeneratedColumn<String> holidayRegion = GeneratedColumn<String>(
    'holiday_region',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    locale,
    timezone,
    currency,
    weekStart,
    hourDisplayMode,
    themeMode,
    holidayRegion,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('locale')) {
      context.handle(
        _localeMeta,
        locale.isAcceptableOrUnknown(data['locale']!, _localeMeta),
      );
    } else if (isInserting) {
      context.missing(_localeMeta);
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    } else if (isInserting) {
      context.missing(_timezoneMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('week_start')) {
      context.handle(
        _weekStartMeta,
        weekStart.isAcceptableOrUnknown(data['week_start']!, _weekStartMeta),
      );
    } else if (isInserting) {
      context.missing(_weekStartMeta);
    }
    if (data.containsKey('hour_display_mode')) {
      context.handle(
        _hourDisplayModeMeta,
        hourDisplayMode.isAcceptableOrUnknown(
          data['hour_display_mode']!,
          _hourDisplayModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hourDisplayModeMeta);
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    } else if (isInserting) {
      context.missing(_themeModeMeta);
    }
    if (data.containsKey('holiday_region')) {
      context.handle(
        _holidayRegionMeta,
        holidayRegion.isAcceptableOrUnknown(
          data['holiday_region']!,
          _holidayRegionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_holidayRegionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      locale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale'],
      )!,
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      weekStart: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_start'],
      )!,
      hourDisplayMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hour_display_mode'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      holidayRegion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}holiday_region'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserSettingsTable createAlias(String alias) {
    return $UserSettingsTable(attachedDatabase, alias);
  }
}

class UserSetting extends DataClass implements Insertable<UserSetting> {
  final String id;
  final String locale;
  final String timezone;
  final String currency;
  final int weekStart;
  final String hourDisplayMode;
  final String themeMode;
  final String holidayRegion;
  final int createdAt;
  final int updatedAt;
  const UserSetting({
    required this.id,
    required this.locale,
    required this.timezone,
    required this.currency,
    required this.weekStart,
    required this.hourDisplayMode,
    required this.themeMode,
    required this.holidayRegion,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['locale'] = Variable<String>(locale);
    map['timezone'] = Variable<String>(timezone);
    map['currency'] = Variable<String>(currency);
    map['week_start'] = Variable<int>(weekStart);
    map['hour_display_mode'] = Variable<String>(hourDisplayMode);
    map['theme_mode'] = Variable<String>(themeMode);
    map['holiday_region'] = Variable<String>(holidayRegion);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  UserSettingsCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsCompanion(
      id: Value(id),
      locale: Value(locale),
      timezone: Value(timezone),
      currency: Value(currency),
      weekStart: Value(weekStart),
      hourDisplayMode: Value(hourDisplayMode),
      themeMode: Value(themeMode),
      holidayRegion: Value(holidayRegion),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSetting(
      id: serializer.fromJson<String>(json['id']),
      locale: serializer.fromJson<String>(json['locale']),
      timezone: serializer.fromJson<String>(json['timezone']),
      currency: serializer.fromJson<String>(json['currency']),
      weekStart: serializer.fromJson<int>(json['weekStart']),
      hourDisplayMode: serializer.fromJson<String>(json['hourDisplayMode']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      holidayRegion: serializer.fromJson<String>(json['holidayRegion']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'locale': serializer.toJson<String>(locale),
      'timezone': serializer.toJson<String>(timezone),
      'currency': serializer.toJson<String>(currency),
      'weekStart': serializer.toJson<int>(weekStart),
      'hourDisplayMode': serializer.toJson<String>(hourDisplayMode),
      'themeMode': serializer.toJson<String>(themeMode),
      'holidayRegion': serializer.toJson<String>(holidayRegion),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  UserSetting copyWith({
    String? id,
    String? locale,
    String? timezone,
    String? currency,
    int? weekStart,
    String? hourDisplayMode,
    String? themeMode,
    String? holidayRegion,
    int? createdAt,
    int? updatedAt,
  }) => UserSetting(
    id: id ?? this.id,
    locale: locale ?? this.locale,
    timezone: timezone ?? this.timezone,
    currency: currency ?? this.currency,
    weekStart: weekStart ?? this.weekStart,
    hourDisplayMode: hourDisplayMode ?? this.hourDisplayMode,
    themeMode: themeMode ?? this.themeMode,
    holidayRegion: holidayRegion ?? this.holidayRegion,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserSetting copyWithCompanion(UserSettingsCompanion data) {
    return UserSetting(
      id: data.id.present ? data.id.value : this.id,
      locale: data.locale.present ? data.locale.value : this.locale,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      currency: data.currency.present ? data.currency.value : this.currency,
      weekStart: data.weekStart.present ? data.weekStart.value : this.weekStart,
      hourDisplayMode: data.hourDisplayMode.present
          ? data.hourDisplayMode.value
          : this.hourDisplayMode,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      holidayRegion: data.holidayRegion.present
          ? data.holidayRegion.value
          : this.holidayRegion,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSetting(')
          ..write('id: $id, ')
          ..write('locale: $locale, ')
          ..write('timezone: $timezone, ')
          ..write('currency: $currency, ')
          ..write('weekStart: $weekStart, ')
          ..write('hourDisplayMode: $hourDisplayMode, ')
          ..write('themeMode: $themeMode, ')
          ..write('holidayRegion: $holidayRegion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    locale,
    timezone,
    currency,
    weekStart,
    hourDisplayMode,
    themeMode,
    holidayRegion,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSetting &&
          other.id == this.id &&
          other.locale == this.locale &&
          other.timezone == this.timezone &&
          other.currency == this.currency &&
          other.weekStart == this.weekStart &&
          other.hourDisplayMode == this.hourDisplayMode &&
          other.themeMode == this.themeMode &&
          other.holidayRegion == this.holidayRegion &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserSettingsCompanion extends UpdateCompanion<UserSetting> {
  final Value<String> id;
  final Value<String> locale;
  final Value<String> timezone;
  final Value<String> currency;
  final Value<int> weekStart;
  final Value<String> hourDisplayMode;
  final Value<String> themeMode;
  final Value<String> holidayRegion;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const UserSettingsCompanion({
    this.id = const Value.absent(),
    this.locale = const Value.absent(),
    this.timezone = const Value.absent(),
    this.currency = const Value.absent(),
    this.weekStart = const Value.absent(),
    this.hourDisplayMode = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.holidayRegion = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserSettingsCompanion.insert({
    required String id,
    required String locale,
    required String timezone,
    required String currency,
    required int weekStart,
    required String hourDisplayMode,
    required String themeMode,
    required String holidayRegion,
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       locale = Value(locale),
       timezone = Value(timezone),
       currency = Value(currency),
       weekStart = Value(weekStart),
       hourDisplayMode = Value(hourDisplayMode),
       themeMode = Value(themeMode),
       holidayRegion = Value(holidayRegion),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserSetting> custom({
    Expression<String>? id,
    Expression<String>? locale,
    Expression<String>? timezone,
    Expression<String>? currency,
    Expression<int>? weekStart,
    Expression<String>? hourDisplayMode,
    Expression<String>? themeMode,
    Expression<String>? holidayRegion,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (locale != null) 'locale': locale,
      if (timezone != null) 'timezone': timezone,
      if (currency != null) 'currency': currency,
      if (weekStart != null) 'week_start': weekStart,
      if (hourDisplayMode != null) 'hour_display_mode': hourDisplayMode,
      if (themeMode != null) 'theme_mode': themeMode,
      if (holidayRegion != null) 'holiday_region': holidayRegion,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserSettingsCompanion copyWith({
    Value<String>? id,
    Value<String>? locale,
    Value<String>? timezone,
    Value<String>? currency,
    Value<int>? weekStart,
    Value<String>? hourDisplayMode,
    Value<String>? themeMode,
    Value<String>? holidayRegion,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserSettingsCompanion(
      id: id ?? this.id,
      locale: locale ?? this.locale,
      timezone: timezone ?? this.timezone,
      currency: currency ?? this.currency,
      weekStart: weekStart ?? this.weekStart,
      hourDisplayMode: hourDisplayMode ?? this.hourDisplayMode,
      themeMode: themeMode ?? this.themeMode,
      holidayRegion: holidayRegion ?? this.holidayRegion,
      createdAt: createdAt ?? this.createdAt,
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
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (weekStart.present) {
      map['week_start'] = Variable<int>(weekStart.value);
    }
    if (hourDisplayMode.present) {
      map['hour_display_mode'] = Variable<String>(hourDisplayMode.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (holidayRegion.present) {
      map['holiday_region'] = Variable<String>(holidayRegion.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsCompanion(')
          ..write('id: $id, ')
          ..write('locale: $locale, ')
          ..write('timezone: $timezone, ')
          ..write('currency: $currency, ')
          ..write('weekStart: $weekStart, ')
          ..write('hourDisplayMode: $hourDisplayMode, ')
          ..write('themeMode: $themeMode, ')
          ..write('holidayRegion: $holidayRegion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DatabaseMetadataTable databaseMetadata = $DatabaseMetadataTable(
    this,
  );
  late final $UserSettingsTable userSettings = $UserSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    databaseMetadata,
    userSettings,
  ];
}

typedef $$DatabaseMetadataTableCreateCompanionBuilder =
    DatabaseMetadataCompanion Function({
      required String key,
      required String value,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$DatabaseMetadataTableUpdateCompanionBuilder =
    DatabaseMetadataCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$DatabaseMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $DatabaseMetadataTable> {
  $$DatabaseMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DatabaseMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $DatabaseMetadataTable> {
  $$DatabaseMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DatabaseMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $DatabaseMetadataTable> {
  $$DatabaseMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DatabaseMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DatabaseMetadataTable,
          DatabaseMetadataData,
          $$DatabaseMetadataTableFilterComposer,
          $$DatabaseMetadataTableOrderingComposer,
          $$DatabaseMetadataTableAnnotationComposer,
          $$DatabaseMetadataTableCreateCompanionBuilder,
          $$DatabaseMetadataTableUpdateCompanionBuilder,
          (
            DatabaseMetadataData,
            BaseReferences<
              _$AppDatabase,
              $DatabaseMetadataTable,
              DatabaseMetadataData
            >,
          ),
          DatabaseMetadataData,
          PrefetchHooks Function()
        > {
  $$DatabaseMetadataTableTableManager(
    _$AppDatabase db,
    $DatabaseMetadataTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DatabaseMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DatabaseMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DatabaseMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DatabaseMetadataCompanion(
                key: key,
                value: value,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DatabaseMetadataCompanion.insert(
                key: key,
                value: value,
                createdAt: createdAt,
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

typedef $$DatabaseMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DatabaseMetadataTable,
      DatabaseMetadataData,
      $$DatabaseMetadataTableFilterComposer,
      $$DatabaseMetadataTableOrderingComposer,
      $$DatabaseMetadataTableAnnotationComposer,
      $$DatabaseMetadataTableCreateCompanionBuilder,
      $$DatabaseMetadataTableUpdateCompanionBuilder,
      (
        DatabaseMetadataData,
        BaseReferences<
          _$AppDatabase,
          $DatabaseMetadataTable,
          DatabaseMetadataData
        >,
      ),
      DatabaseMetadataData,
      PrefetchHooks Function()
    >;
typedef $$UserSettingsTableCreateCompanionBuilder =
    UserSettingsCompanion Function({
      required String id,
      required String locale,
      required String timezone,
      required String currency,
      required int weekStart,
      required String hourDisplayMode,
      required String themeMode,
      required String holidayRegion,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$UserSettingsTableUpdateCompanionBuilder =
    UserSettingsCompanion Function({
      Value<String> id,
      Value<String> locale,
      Value<String> timezone,
      Value<String> currency,
      Value<int> weekStart,
      Value<String> hourDisplayMode,
      Value<String> themeMode,
      Value<String> holidayRegion,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$UserSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableFilterComposer({
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

  ColumnFilters<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hourDisplayMode => $composableBuilder(
    column: $table.hourDisplayMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get holidayRegion => $composableBuilder(
    column: $table.holidayRegion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableOrderingComposer({
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

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hourDisplayMode => $composableBuilder(
    column: $table.hourDisplayMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get holidayRegion => $composableBuilder(
    column: $table.holidayRegion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get weekStart =>
      $composableBuilder(column: $table.weekStart, builder: (column) => column);

  GeneratedColumn<String> get hourDisplayMode => $composableBuilder(
    column: $table.hourDisplayMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get holidayRegion => $composableBuilder(
    column: $table.holidayRegion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserSettingsTable,
          UserSetting,
          $$UserSettingsTableFilterComposer,
          $$UserSettingsTableOrderingComposer,
          $$UserSettingsTableAnnotationComposer,
          $$UserSettingsTableCreateCompanionBuilder,
          $$UserSettingsTableUpdateCompanionBuilder,
          (
            UserSetting,
            BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>,
          ),
          UserSetting,
          PrefetchHooks Function()
        > {
  $$UserSettingsTableTableManager(_$AppDatabase db, $UserSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> weekStart = const Value.absent(),
                Value<String> hourDisplayMode = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> holidayRegion = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserSettingsCompanion(
                id: id,
                locale: locale,
                timezone: timezone,
                currency: currency,
                weekStart: weekStart,
                hourDisplayMode: hourDisplayMode,
                themeMode: themeMode,
                holidayRegion: holidayRegion,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String locale,
                required String timezone,
                required String currency,
                required int weekStart,
                required String hourDisplayMode,
                required String themeMode,
                required String holidayRegion,
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserSettingsCompanion.insert(
                id: id,
                locale: locale,
                timezone: timezone,
                currency: currency,
                weekStart: weekStart,
                hourDisplayMode: hourDisplayMode,
                themeMode: themeMode,
                holidayRegion: holidayRegion,
                createdAt: createdAt,
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

typedef $$UserSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserSettingsTable,
      UserSetting,
      $$UserSettingsTableFilterComposer,
      $$UserSettingsTableOrderingComposer,
      $$UserSettingsTableAnnotationComposer,
      $$UserSettingsTableCreateCompanionBuilder,
      $$UserSettingsTableUpdateCompanionBuilder,
      (
        UserSetting,
        BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>,
      ),
      UserSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DatabaseMetadataTableTableManager get databaseMetadata =>
      $$DatabaseMetadataTableTableManager(_db, _db.databaseMetadata);
  $$UserSettingsTableTableManager get userSettings =>
      $$UserSettingsTableTableManager(_db, _db.userSettings);
}
