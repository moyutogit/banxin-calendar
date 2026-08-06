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

class $ShiftTemplatesTable extends ShiftTemplates
    with TableInfo<$ShiftTemplatesTable, ShiftTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShiftTemplatesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _shortNameMeta = const VerificationMeta(
    'shortName',
  );
  @override
  late final GeneratedColumn<String> shortName = GeneratedColumn<String>(
    'short_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startMinuteMeta = const VerificationMeta(
    'startMinute',
  );
  @override
  late final GeneratedColumn<int> startMinute = GeneratedColumn<int>(
    'start_minute',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endMinuteMeta = const VerificationMeta(
    'endMinute',
  );
  @override
  late final GeneratedColumn<int> endMinute = GeneratedColumn<int>(
    'end_minute',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _crossDayMeta = const VerificationMeta(
    'crossDay',
  );
  @override
  late final GeneratedColumn<int> crossDay = GeneratedColumn<int>(
    'cross_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unpaidBreakMinutesMeta =
      const VerificationMeta('unpaidBreakMinutes');
  @override
  late final GeneratedColumn<int> unpaidBreakMinutes = GeneratedColumn<int>(
    'unpaid_break_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedPaidMinutesMeta =
      const VerificationMeta('plannedPaidMinutes');
  @override
  late final GeneratedColumn<int> plannedPaidMinutes = GeneratedColumn<int>(
    'planned_paid_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorArgbMeta = const VerificationMeta(
    'colorArgb',
  );
  @override
  late final GeneratedColumn<int> colorArgb = GeneratedColumn<int>(
    'color_argb',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isWorkdayMeta = const VerificationMeta(
    'isWorkday',
  );
  @override
  late final GeneratedColumn<int> isWorkday = GeneratedColumn<int>(
    'is_workday',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<int> enabled = GeneratedColumn<int>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    shortName,
    startMinute,
    endMinute,
    crossDay,
    unpaidBreakMinutes,
    plannedPaidMinutes,
    colorArgb,
    isWorkday,
    enabled,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shift_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShiftTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('short_name')) {
      context.handle(
        _shortNameMeta,
        shortName.isAcceptableOrUnknown(data['short_name']!, _shortNameMeta),
      );
    } else if (isInserting) {
      context.missing(_shortNameMeta);
    }
    if (data.containsKey('start_minute')) {
      context.handle(
        _startMinuteMeta,
        startMinute.isAcceptableOrUnknown(
          data['start_minute']!,
          _startMinuteMeta,
        ),
      );
    }
    if (data.containsKey('end_minute')) {
      context.handle(
        _endMinuteMeta,
        endMinute.isAcceptableOrUnknown(data['end_minute']!, _endMinuteMeta),
      );
    }
    if (data.containsKey('cross_day')) {
      context.handle(
        _crossDayMeta,
        crossDay.isAcceptableOrUnknown(data['cross_day']!, _crossDayMeta),
      );
    } else if (isInserting) {
      context.missing(_crossDayMeta);
    }
    if (data.containsKey('unpaid_break_minutes')) {
      context.handle(
        _unpaidBreakMinutesMeta,
        unpaidBreakMinutes.isAcceptableOrUnknown(
          data['unpaid_break_minutes']!,
          _unpaidBreakMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unpaidBreakMinutesMeta);
    }
    if (data.containsKey('planned_paid_minutes')) {
      context.handle(
        _plannedPaidMinutesMeta,
        plannedPaidMinutes.isAcceptableOrUnknown(
          data['planned_paid_minutes']!,
          _plannedPaidMinutesMeta,
        ),
      );
    }
    if (data.containsKey('color_argb')) {
      context.handle(
        _colorArgbMeta,
        colorArgb.isAcceptableOrUnknown(data['color_argb']!, _colorArgbMeta),
      );
    } else if (isInserting) {
      context.missing(_colorArgbMeta);
    }
    if (data.containsKey('is_workday')) {
      context.handle(
        _isWorkdayMeta,
        isWorkday.isAcceptableOrUnknown(data['is_workday']!, _isWorkdayMeta),
      );
    } else if (isInserting) {
      context.missing(_isWorkdayMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    } else if (isInserting) {
      context.missing(_enabledMeta);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShiftTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShiftTemplate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      shortName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_name'],
      )!,
      startMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_minute'],
      ),
      endMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_minute'],
      ),
      crossDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cross_day'],
      )!,
      unpaidBreakMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unpaid_break_minutes'],
      )!,
      plannedPaidMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_paid_minutes'],
      ),
      colorArgb: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_argb'],
      )!,
      isWorkday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_workday'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ShiftTemplatesTable createAlias(String alias) {
    return $ShiftTemplatesTable(attachedDatabase, alias);
  }
}

class ShiftTemplate extends DataClass implements Insertable<ShiftTemplate> {
  final String id;
  final String name;
  final String shortName;
  final int? startMinute;
  final int? endMinute;
  final int crossDay;
  final int unpaidBreakMinutes;
  final int? plannedPaidMinutes;
  final int colorArgb;
  final int isWorkday;
  final int enabled;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  const ShiftTemplate({
    required this.id,
    required this.name,
    required this.shortName,
    this.startMinute,
    this.endMinute,
    required this.crossDay,
    required this.unpaidBreakMinutes,
    this.plannedPaidMinutes,
    required this.colorArgb,
    required this.isWorkday,
    required this.enabled,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['short_name'] = Variable<String>(shortName);
    if (!nullToAbsent || startMinute != null) {
      map['start_minute'] = Variable<int>(startMinute);
    }
    if (!nullToAbsent || endMinute != null) {
      map['end_minute'] = Variable<int>(endMinute);
    }
    map['cross_day'] = Variable<int>(crossDay);
    map['unpaid_break_minutes'] = Variable<int>(unpaidBreakMinutes);
    if (!nullToAbsent || plannedPaidMinutes != null) {
      map['planned_paid_minutes'] = Variable<int>(plannedPaidMinutes);
    }
    map['color_argb'] = Variable<int>(colorArgb);
    map['is_workday'] = Variable<int>(isWorkday);
    map['enabled'] = Variable<int>(enabled);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  ShiftTemplatesCompanion toCompanion(bool nullToAbsent) {
    return ShiftTemplatesCompanion(
      id: Value(id),
      name: Value(name),
      shortName: Value(shortName),
      startMinute: startMinute == null && nullToAbsent
          ? const Value.absent()
          : Value(startMinute),
      endMinute: endMinute == null && nullToAbsent
          ? const Value.absent()
          : Value(endMinute),
      crossDay: Value(crossDay),
      unpaidBreakMinutes: Value(unpaidBreakMinutes),
      plannedPaidMinutes: plannedPaidMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedPaidMinutes),
      colorArgb: Value(colorArgb),
      isWorkday: Value(isWorkday),
      enabled: Value(enabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ShiftTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShiftTemplate(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      shortName: serializer.fromJson<String>(json['shortName']),
      startMinute: serializer.fromJson<int?>(json['startMinute']),
      endMinute: serializer.fromJson<int?>(json['endMinute']),
      crossDay: serializer.fromJson<int>(json['crossDay']),
      unpaidBreakMinutes: serializer.fromJson<int>(json['unpaidBreakMinutes']),
      plannedPaidMinutes: serializer.fromJson<int?>(json['plannedPaidMinutes']),
      colorArgb: serializer.fromJson<int>(json['colorArgb']),
      isWorkday: serializer.fromJson<int>(json['isWorkday']),
      enabled: serializer.fromJson<int>(json['enabled']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'shortName': serializer.toJson<String>(shortName),
      'startMinute': serializer.toJson<int?>(startMinute),
      'endMinute': serializer.toJson<int?>(endMinute),
      'crossDay': serializer.toJson<int>(crossDay),
      'unpaidBreakMinutes': serializer.toJson<int>(unpaidBreakMinutes),
      'plannedPaidMinutes': serializer.toJson<int?>(plannedPaidMinutes),
      'colorArgb': serializer.toJson<int>(colorArgb),
      'isWorkday': serializer.toJson<int>(isWorkday),
      'enabled': serializer.toJson<int>(enabled),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  ShiftTemplate copyWith({
    String? id,
    String? name,
    String? shortName,
    Value<int?> startMinute = const Value.absent(),
    Value<int?> endMinute = const Value.absent(),
    int? crossDay,
    int? unpaidBreakMinutes,
    Value<int?> plannedPaidMinutes = const Value.absent(),
    int? colorArgb,
    int? isWorkday,
    int? enabled,
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => ShiftTemplate(
    id: id ?? this.id,
    name: name ?? this.name,
    shortName: shortName ?? this.shortName,
    startMinute: startMinute.present ? startMinute.value : this.startMinute,
    endMinute: endMinute.present ? endMinute.value : this.endMinute,
    crossDay: crossDay ?? this.crossDay,
    unpaidBreakMinutes: unpaidBreakMinutes ?? this.unpaidBreakMinutes,
    plannedPaidMinutes: plannedPaidMinutes.present
        ? plannedPaidMinutes.value
        : this.plannedPaidMinutes,
    colorArgb: colorArgb ?? this.colorArgb,
    isWorkday: isWorkday ?? this.isWorkday,
    enabled: enabled ?? this.enabled,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  ShiftTemplate copyWithCompanion(ShiftTemplatesCompanion data) {
    return ShiftTemplate(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      shortName: data.shortName.present ? data.shortName.value : this.shortName,
      startMinute: data.startMinute.present
          ? data.startMinute.value
          : this.startMinute,
      endMinute: data.endMinute.present ? data.endMinute.value : this.endMinute,
      crossDay: data.crossDay.present ? data.crossDay.value : this.crossDay,
      unpaidBreakMinutes: data.unpaidBreakMinutes.present
          ? data.unpaidBreakMinutes.value
          : this.unpaidBreakMinutes,
      plannedPaidMinutes: data.plannedPaidMinutes.present
          ? data.plannedPaidMinutes.value
          : this.plannedPaidMinutes,
      colorArgb: data.colorArgb.present ? data.colorArgb.value : this.colorArgb,
      isWorkday: data.isWorkday.present ? data.isWorkday.value : this.isWorkday,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShiftTemplate(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shortName: $shortName, ')
          ..write('startMinute: $startMinute, ')
          ..write('endMinute: $endMinute, ')
          ..write('crossDay: $crossDay, ')
          ..write('unpaidBreakMinutes: $unpaidBreakMinutes, ')
          ..write('plannedPaidMinutes: $plannedPaidMinutes, ')
          ..write('colorArgb: $colorArgb, ')
          ..write('isWorkday: $isWorkday, ')
          ..write('enabled: $enabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    shortName,
    startMinute,
    endMinute,
    crossDay,
    unpaidBreakMinutes,
    plannedPaidMinutes,
    colorArgb,
    isWorkday,
    enabled,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShiftTemplate &&
          other.id == this.id &&
          other.name == this.name &&
          other.shortName == this.shortName &&
          other.startMinute == this.startMinute &&
          other.endMinute == this.endMinute &&
          other.crossDay == this.crossDay &&
          other.unpaidBreakMinutes == this.unpaidBreakMinutes &&
          other.plannedPaidMinutes == this.plannedPaidMinutes &&
          other.colorArgb == this.colorArgb &&
          other.isWorkday == this.isWorkday &&
          other.enabled == this.enabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class ShiftTemplatesCompanion extends UpdateCompanion<ShiftTemplate> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> shortName;
  final Value<int?> startMinute;
  final Value<int?> endMinute;
  final Value<int> crossDay;
  final Value<int> unpaidBreakMinutes;
  final Value<int?> plannedPaidMinutes;
  final Value<int> colorArgb;
  final Value<int> isWorkday;
  final Value<int> enabled;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const ShiftTemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.shortName = const Value.absent(),
    this.startMinute = const Value.absent(),
    this.endMinute = const Value.absent(),
    this.crossDay = const Value.absent(),
    this.unpaidBreakMinutes = const Value.absent(),
    this.plannedPaidMinutes = const Value.absent(),
    this.colorArgb = const Value.absent(),
    this.isWorkday = const Value.absent(),
    this.enabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShiftTemplatesCompanion.insert({
    required String id,
    required String name,
    required String shortName,
    this.startMinute = const Value.absent(),
    this.endMinute = const Value.absent(),
    required int crossDay,
    required int unpaidBreakMinutes,
    this.plannedPaidMinutes = const Value.absent(),
    required int colorArgb,
    required int isWorkday,
    required int enabled,
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       shortName = Value(shortName),
       crossDay = Value(crossDay),
       unpaidBreakMinutes = Value(unpaidBreakMinutes),
       colorArgb = Value(colorArgb),
       isWorkday = Value(isWorkday),
       enabled = Value(enabled),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ShiftTemplate> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? shortName,
    Expression<int>? startMinute,
    Expression<int>? endMinute,
    Expression<int>? crossDay,
    Expression<int>? unpaidBreakMinutes,
    Expression<int>? plannedPaidMinutes,
    Expression<int>? colorArgb,
    Expression<int>? isWorkday,
    Expression<int>? enabled,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (shortName != null) 'short_name': shortName,
      if (startMinute != null) 'start_minute': startMinute,
      if (endMinute != null) 'end_minute': endMinute,
      if (crossDay != null) 'cross_day': crossDay,
      if (unpaidBreakMinutes != null)
        'unpaid_break_minutes': unpaidBreakMinutes,
      if (plannedPaidMinutes != null)
        'planned_paid_minutes': plannedPaidMinutes,
      if (colorArgb != null) 'color_argb': colorArgb,
      if (isWorkday != null) 'is_workday': isWorkday,
      if (enabled != null) 'enabled': enabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShiftTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? shortName,
    Value<int?>? startMinute,
    Value<int?>? endMinute,
    Value<int>? crossDay,
    Value<int>? unpaidBreakMinutes,
    Value<int?>? plannedPaidMinutes,
    Value<int>? colorArgb,
    Value<int>? isWorkday,
    Value<int>? enabled,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ShiftTemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      crossDay: crossDay ?? this.crossDay,
      unpaidBreakMinutes: unpaidBreakMinutes ?? this.unpaidBreakMinutes,
      plannedPaidMinutes: plannedPaidMinutes ?? this.plannedPaidMinutes,
      colorArgb: colorArgb ?? this.colorArgb,
      isWorkday: isWorkday ?? this.isWorkday,
      enabled: enabled ?? this.enabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (shortName.present) {
      map['short_name'] = Variable<String>(shortName.value);
    }
    if (startMinute.present) {
      map['start_minute'] = Variable<int>(startMinute.value);
    }
    if (endMinute.present) {
      map['end_minute'] = Variable<int>(endMinute.value);
    }
    if (crossDay.present) {
      map['cross_day'] = Variable<int>(crossDay.value);
    }
    if (unpaidBreakMinutes.present) {
      map['unpaid_break_minutes'] = Variable<int>(unpaidBreakMinutes.value);
    }
    if (plannedPaidMinutes.present) {
      map['planned_paid_minutes'] = Variable<int>(plannedPaidMinutes.value);
    }
    if (colorArgb.present) {
      map['color_argb'] = Variable<int>(colorArgb.value);
    }
    if (isWorkday.present) {
      map['is_workday'] = Variable<int>(isWorkday.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<int>(enabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShiftTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shortName: $shortName, ')
          ..write('startMinute: $startMinute, ')
          ..write('endMinute: $endMinute, ')
          ..write('crossDay: $crossDay, ')
          ..write('unpaidBreakMinutes: $unpaidBreakMinutes, ')
          ..write('plannedPaidMinutes: $plannedPaidMinutes, ')
          ..write('colorArgb: $colorArgb, ')
          ..write('isWorkday: $isWorkday, ')
          ..write('enabled: $enabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScheduleRulesTable extends ScheduleRules
    with TableInfo<$ScheduleRulesTable, ScheduleRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleRulesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _ruleTypeMeta = const VerificationMeta(
    'ruleType',
  );
  @override
  late final GeneratedColumn<String> ruleType = GeneratedColumn<String>(
    'rule_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _anchorDateMeta = const VerificationMeta(
    'anchorDate',
  );
  @override
  late final GeneratedColumn<String> anchorDate = GeneratedColumn<String>(
    'anchor_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cycleLengthDaysMeta = const VerificationMeta(
    'cycleLengthDays',
  );
  @override
  late final GeneratedColumn<int> cycleLengthDays = GeneratedColumn<int>(
    'cycle_length_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cyclePayloadJsonMeta = const VerificationMeta(
    'cyclePayloadJson',
  );
  @override
  late final GeneratedColumn<String> cyclePayloadJson = GeneratedColumn<String>(
    'cycle_payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _effectiveStartMeta = const VerificationMeta(
    'effectiveStart',
  );
  @override
  late final GeneratedColumn<String> effectiveStart = GeneratedColumn<String>(
    'effective_start',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _effectiveEndMeta = const VerificationMeta(
    'effectiveEnd',
  );
  @override
  late final GeneratedColumn<String> effectiveEnd = GeneratedColumn<String>(
    'effective_end',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<int> enabled = GeneratedColumn<int>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    ruleType,
    anchorDate,
    cycleLengthDays,
    cyclePayloadJson,
    effectiveStart,
    effectiveEnd,
    priority,
    enabled,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedule_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduleRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('rule_type')) {
      context.handle(
        _ruleTypeMeta,
        ruleType.isAcceptableOrUnknown(data['rule_type']!, _ruleTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleTypeMeta);
    }
    if (data.containsKey('anchor_date')) {
      context.handle(
        _anchorDateMeta,
        anchorDate.isAcceptableOrUnknown(data['anchor_date']!, _anchorDateMeta),
      );
    } else if (isInserting) {
      context.missing(_anchorDateMeta);
    }
    if (data.containsKey('cycle_length_days')) {
      context.handle(
        _cycleLengthDaysMeta,
        cycleLengthDays.isAcceptableOrUnknown(
          data['cycle_length_days']!,
          _cycleLengthDaysMeta,
        ),
      );
    }
    if (data.containsKey('cycle_payload_json')) {
      context.handle(
        _cyclePayloadJsonMeta,
        cyclePayloadJson.isAcceptableOrUnknown(
          data['cycle_payload_json']!,
          _cyclePayloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cyclePayloadJsonMeta);
    }
    if (data.containsKey('effective_start')) {
      context.handle(
        _effectiveStartMeta,
        effectiveStart.isAcceptableOrUnknown(
          data['effective_start']!,
          _effectiveStartMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_effectiveStartMeta);
    }
    if (data.containsKey('effective_end')) {
      context.handle(
        _effectiveEndMeta,
        effectiveEnd.isAcceptableOrUnknown(
          data['effective_end']!,
          _effectiveEndMeta,
        ),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    } else if (isInserting) {
      context.missing(_enabledMeta);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduleRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      ruleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_type'],
      )!,
      anchorDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}anchor_date'],
      )!,
      cycleLengthDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cycle_length_days'],
      ),
      cyclePayloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cycle_payload_json'],
      )!,
      effectiveStart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effective_start'],
      )!,
      effectiveEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effective_end'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ScheduleRulesTable createAlias(String alias) {
    return $ScheduleRulesTable(attachedDatabase, alias);
  }
}

class ScheduleRule extends DataClass implements Insertable<ScheduleRule> {
  final String id;
  final String name;
  final String ruleType;
  final String anchorDate;
  final int? cycleLengthDays;
  final String cyclePayloadJson;
  final String effectiveStart;
  final String? effectiveEnd;
  final int priority;
  final int enabled;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  const ScheduleRule({
    required this.id,
    required this.name,
    required this.ruleType,
    required this.anchorDate,
    this.cycleLengthDays,
    required this.cyclePayloadJson,
    required this.effectiveStart,
    this.effectiveEnd,
    required this.priority,
    required this.enabled,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['rule_type'] = Variable<String>(ruleType);
    map['anchor_date'] = Variable<String>(anchorDate);
    if (!nullToAbsent || cycleLengthDays != null) {
      map['cycle_length_days'] = Variable<int>(cycleLengthDays);
    }
    map['cycle_payload_json'] = Variable<String>(cyclePayloadJson);
    map['effective_start'] = Variable<String>(effectiveStart);
    if (!nullToAbsent || effectiveEnd != null) {
      map['effective_end'] = Variable<String>(effectiveEnd);
    }
    map['priority'] = Variable<int>(priority);
    map['enabled'] = Variable<int>(enabled);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  ScheduleRulesCompanion toCompanion(bool nullToAbsent) {
    return ScheduleRulesCompanion(
      id: Value(id),
      name: Value(name),
      ruleType: Value(ruleType),
      anchorDate: Value(anchorDate),
      cycleLengthDays: cycleLengthDays == null && nullToAbsent
          ? const Value.absent()
          : Value(cycleLengthDays),
      cyclePayloadJson: Value(cyclePayloadJson),
      effectiveStart: Value(effectiveStart),
      effectiveEnd: effectiveEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(effectiveEnd),
      priority: Value(priority),
      enabled: Value(enabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ScheduleRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleRule(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      ruleType: serializer.fromJson<String>(json['ruleType']),
      anchorDate: serializer.fromJson<String>(json['anchorDate']),
      cycleLengthDays: serializer.fromJson<int?>(json['cycleLengthDays']),
      cyclePayloadJson: serializer.fromJson<String>(json['cyclePayloadJson']),
      effectiveStart: serializer.fromJson<String>(json['effectiveStart']),
      effectiveEnd: serializer.fromJson<String?>(json['effectiveEnd']),
      priority: serializer.fromJson<int>(json['priority']),
      enabled: serializer.fromJson<int>(json['enabled']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'ruleType': serializer.toJson<String>(ruleType),
      'anchorDate': serializer.toJson<String>(anchorDate),
      'cycleLengthDays': serializer.toJson<int?>(cycleLengthDays),
      'cyclePayloadJson': serializer.toJson<String>(cyclePayloadJson),
      'effectiveStart': serializer.toJson<String>(effectiveStart),
      'effectiveEnd': serializer.toJson<String?>(effectiveEnd),
      'priority': serializer.toJson<int>(priority),
      'enabled': serializer.toJson<int>(enabled),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  ScheduleRule copyWith({
    String? id,
    String? name,
    String? ruleType,
    String? anchorDate,
    Value<int?> cycleLengthDays = const Value.absent(),
    String? cyclePayloadJson,
    String? effectiveStart,
    Value<String?> effectiveEnd = const Value.absent(),
    int? priority,
    int? enabled,
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => ScheduleRule(
    id: id ?? this.id,
    name: name ?? this.name,
    ruleType: ruleType ?? this.ruleType,
    anchorDate: anchorDate ?? this.anchorDate,
    cycleLengthDays: cycleLengthDays.present
        ? cycleLengthDays.value
        : this.cycleLengthDays,
    cyclePayloadJson: cyclePayloadJson ?? this.cyclePayloadJson,
    effectiveStart: effectiveStart ?? this.effectiveStart,
    effectiveEnd: effectiveEnd.present ? effectiveEnd.value : this.effectiveEnd,
    priority: priority ?? this.priority,
    enabled: enabled ?? this.enabled,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  ScheduleRule copyWithCompanion(ScheduleRulesCompanion data) {
    return ScheduleRule(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      ruleType: data.ruleType.present ? data.ruleType.value : this.ruleType,
      anchorDate: data.anchorDate.present
          ? data.anchorDate.value
          : this.anchorDate,
      cycleLengthDays: data.cycleLengthDays.present
          ? data.cycleLengthDays.value
          : this.cycleLengthDays,
      cyclePayloadJson: data.cyclePayloadJson.present
          ? data.cyclePayloadJson.value
          : this.cyclePayloadJson,
      effectiveStart: data.effectiveStart.present
          ? data.effectiveStart.value
          : this.effectiveStart,
      effectiveEnd: data.effectiveEnd.present
          ? data.effectiveEnd.value
          : this.effectiveEnd,
      priority: data.priority.present ? data.priority.value : this.priority,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleRule(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ruleType: $ruleType, ')
          ..write('anchorDate: $anchorDate, ')
          ..write('cycleLengthDays: $cycleLengthDays, ')
          ..write('cyclePayloadJson: $cyclePayloadJson, ')
          ..write('effectiveStart: $effectiveStart, ')
          ..write('effectiveEnd: $effectiveEnd, ')
          ..write('priority: $priority, ')
          ..write('enabled: $enabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    ruleType,
    anchorDate,
    cycleLengthDays,
    cyclePayloadJson,
    effectiveStart,
    effectiveEnd,
    priority,
    enabled,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleRule &&
          other.id == this.id &&
          other.name == this.name &&
          other.ruleType == this.ruleType &&
          other.anchorDate == this.anchorDate &&
          other.cycleLengthDays == this.cycleLengthDays &&
          other.cyclePayloadJson == this.cyclePayloadJson &&
          other.effectiveStart == this.effectiveStart &&
          other.effectiveEnd == this.effectiveEnd &&
          other.priority == this.priority &&
          other.enabled == this.enabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class ScheduleRulesCompanion extends UpdateCompanion<ScheduleRule> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> ruleType;
  final Value<String> anchorDate;
  final Value<int?> cycleLengthDays;
  final Value<String> cyclePayloadJson;
  final Value<String> effectiveStart;
  final Value<String?> effectiveEnd;
  final Value<int> priority;
  final Value<int> enabled;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const ScheduleRulesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.ruleType = const Value.absent(),
    this.anchorDate = const Value.absent(),
    this.cycleLengthDays = const Value.absent(),
    this.cyclePayloadJson = const Value.absent(),
    this.effectiveStart = const Value.absent(),
    this.effectiveEnd = const Value.absent(),
    this.priority = const Value.absent(),
    this.enabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScheduleRulesCompanion.insert({
    required String id,
    required String name,
    required String ruleType,
    required String anchorDate,
    this.cycleLengthDays = const Value.absent(),
    required String cyclePayloadJson,
    required String effectiveStart,
    this.effectiveEnd = const Value.absent(),
    required int priority,
    required int enabled,
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       ruleType = Value(ruleType),
       anchorDate = Value(anchorDate),
       cyclePayloadJson = Value(cyclePayloadJson),
       effectiveStart = Value(effectiveStart),
       priority = Value(priority),
       enabled = Value(enabled),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ScheduleRule> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? ruleType,
    Expression<String>? anchorDate,
    Expression<int>? cycleLengthDays,
    Expression<String>? cyclePayloadJson,
    Expression<String>? effectiveStart,
    Expression<String>? effectiveEnd,
    Expression<int>? priority,
    Expression<int>? enabled,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (ruleType != null) 'rule_type': ruleType,
      if (anchorDate != null) 'anchor_date': anchorDate,
      if (cycleLengthDays != null) 'cycle_length_days': cycleLengthDays,
      if (cyclePayloadJson != null) 'cycle_payload_json': cyclePayloadJson,
      if (effectiveStart != null) 'effective_start': effectiveStart,
      if (effectiveEnd != null) 'effective_end': effectiveEnd,
      if (priority != null) 'priority': priority,
      if (enabled != null) 'enabled': enabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScheduleRulesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? ruleType,
    Value<String>? anchorDate,
    Value<int?>? cycleLengthDays,
    Value<String>? cyclePayloadJson,
    Value<String>? effectiveStart,
    Value<String?>? effectiveEnd,
    Value<int>? priority,
    Value<int>? enabled,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ScheduleRulesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      ruleType: ruleType ?? this.ruleType,
      anchorDate: anchorDate ?? this.anchorDate,
      cycleLengthDays: cycleLengthDays ?? this.cycleLengthDays,
      cyclePayloadJson: cyclePayloadJson ?? this.cyclePayloadJson,
      effectiveStart: effectiveStart ?? this.effectiveStart,
      effectiveEnd: effectiveEnd ?? this.effectiveEnd,
      priority: priority ?? this.priority,
      enabled: enabled ?? this.enabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (ruleType.present) {
      map['rule_type'] = Variable<String>(ruleType.value);
    }
    if (anchorDate.present) {
      map['anchor_date'] = Variable<String>(anchorDate.value);
    }
    if (cycleLengthDays.present) {
      map['cycle_length_days'] = Variable<int>(cycleLengthDays.value);
    }
    if (cyclePayloadJson.present) {
      map['cycle_payload_json'] = Variable<String>(cyclePayloadJson.value);
    }
    if (effectiveStart.present) {
      map['effective_start'] = Variable<String>(effectiveStart.value);
    }
    if (effectiveEnd.present) {
      map['effective_end'] = Variable<String>(effectiveEnd.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<int>(enabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleRulesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ruleType: $ruleType, ')
          ..write('anchorDate: $anchorDate, ')
          ..write('cycleLengthDays: $cycleLengthDays, ')
          ..write('cyclePayloadJson: $cyclePayloadJson, ')
          ..write('effectiveStart: $effectiveStart, ')
          ..write('effectiveEnd: $effectiveEnd, ')
          ..write('priority: $priority, ')
          ..write('enabled: $enabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DayOverridesTable extends DayOverrides
    with TableInfo<$DayOverridesTable, DayOverride> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DayOverridesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workDateMeta = const VerificationMeta(
    'workDate',
  );
  @override
  late final GeneratedColumn<String> workDate = GeneratedColumn<String>(
    'work_date',
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shiftTemplateIdMeta = const VerificationMeta(
    'shiftTemplateId',
  );
  @override
  late final GeneratedColumn<String> shiftTemplateId = GeneratedColumn<String>(
    'shift_template_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES shift_templates (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _shiftSnapshotJsonMeta = const VerificationMeta(
    'shiftSnapshotJson',
  );
  @override
  late final GeneratedColumn<String> shiftSnapshotJson =
      GeneratedColumn<String>(
        'shift_snapshot_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _overrideTypeMeta = const VerificationMeta(
    'overrideType',
  );
  @override
  late final GeneratedColumn<String> overrideType = GeneratedColumn<String>(
    'override_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workDate,
    status,
    shiftTemplateId,
    shiftSnapshotJson,
    overrideType,
    reason,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'day_overrides';
  @override
  VerificationContext validateIntegrity(
    Insertable<DayOverride> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('work_date')) {
      context.handle(
        _workDateMeta,
        workDate.isAcceptableOrUnknown(data['work_date']!, _workDateMeta),
      );
    } else if (isInserting) {
      context.missing(_workDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('shift_template_id')) {
      context.handle(
        _shiftTemplateIdMeta,
        shiftTemplateId.isAcceptableOrUnknown(
          data['shift_template_id']!,
          _shiftTemplateIdMeta,
        ),
      );
    }
    if (data.containsKey('shift_snapshot_json')) {
      context.handle(
        _shiftSnapshotJsonMeta,
        shiftSnapshotJson.isAcceptableOrUnknown(
          data['shift_snapshot_json']!,
          _shiftSnapshotJsonMeta,
        ),
      );
    }
    if (data.containsKey('override_type')) {
      context.handle(
        _overrideTypeMeta,
        overrideType.isAcceptableOrUnknown(
          data['override_type']!,
          _overrideTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_overrideTypeMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DayOverride map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DayOverride(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      shiftTemplateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shift_template_id'],
      ),
      shiftSnapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shift_snapshot_json'],
      ),
      overrideType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}override_type'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $DayOverridesTable createAlias(String alias) {
    return $DayOverridesTable(attachedDatabase, alias);
  }
}

class DayOverride extends DataClass implements Insertable<DayOverride> {
  final String id;
  final String workDate;
  final String status;
  final String? shiftTemplateId;
  final String? shiftSnapshotJson;
  final String overrideType;
  final String? reason;
  final String? note;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  const DayOverride({
    required this.id,
    required this.workDate,
    required this.status,
    this.shiftTemplateId,
    this.shiftSnapshotJson,
    required this.overrideType,
    this.reason,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['work_date'] = Variable<String>(workDate);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || shiftTemplateId != null) {
      map['shift_template_id'] = Variable<String>(shiftTemplateId);
    }
    if (!nullToAbsent || shiftSnapshotJson != null) {
      map['shift_snapshot_json'] = Variable<String>(shiftSnapshotJson);
    }
    map['override_type'] = Variable<String>(overrideType);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  DayOverridesCompanion toCompanion(bool nullToAbsent) {
    return DayOverridesCompanion(
      id: Value(id),
      workDate: Value(workDate),
      status: Value(status),
      shiftTemplateId: shiftTemplateId == null && nullToAbsent
          ? const Value.absent()
          : Value(shiftTemplateId),
      shiftSnapshotJson: shiftSnapshotJson == null && nullToAbsent
          ? const Value.absent()
          : Value(shiftSnapshotJson),
      overrideType: Value(overrideType),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory DayOverride.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DayOverride(
      id: serializer.fromJson<String>(json['id']),
      workDate: serializer.fromJson<String>(json['workDate']),
      status: serializer.fromJson<String>(json['status']),
      shiftTemplateId: serializer.fromJson<String?>(json['shiftTemplateId']),
      shiftSnapshotJson: serializer.fromJson<String?>(
        json['shiftSnapshotJson'],
      ),
      overrideType: serializer.fromJson<String>(json['overrideType']),
      reason: serializer.fromJson<String?>(json['reason']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workDate': serializer.toJson<String>(workDate),
      'status': serializer.toJson<String>(status),
      'shiftTemplateId': serializer.toJson<String?>(shiftTemplateId),
      'shiftSnapshotJson': serializer.toJson<String?>(shiftSnapshotJson),
      'overrideType': serializer.toJson<String>(overrideType),
      'reason': serializer.toJson<String?>(reason),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  DayOverride copyWith({
    String? id,
    String? workDate,
    String? status,
    Value<String?> shiftTemplateId = const Value.absent(),
    Value<String?> shiftSnapshotJson = const Value.absent(),
    String? overrideType,
    Value<String?> reason = const Value.absent(),
    Value<String?> note = const Value.absent(),
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => DayOverride(
    id: id ?? this.id,
    workDate: workDate ?? this.workDate,
    status: status ?? this.status,
    shiftTemplateId: shiftTemplateId.present
        ? shiftTemplateId.value
        : this.shiftTemplateId,
    shiftSnapshotJson: shiftSnapshotJson.present
        ? shiftSnapshotJson.value
        : this.shiftSnapshotJson,
    overrideType: overrideType ?? this.overrideType,
    reason: reason.present ? reason.value : this.reason,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  DayOverride copyWithCompanion(DayOverridesCompanion data) {
    return DayOverride(
      id: data.id.present ? data.id.value : this.id,
      workDate: data.workDate.present ? data.workDate.value : this.workDate,
      status: data.status.present ? data.status.value : this.status,
      shiftTemplateId: data.shiftTemplateId.present
          ? data.shiftTemplateId.value
          : this.shiftTemplateId,
      shiftSnapshotJson: data.shiftSnapshotJson.present
          ? data.shiftSnapshotJson.value
          : this.shiftSnapshotJson,
      overrideType: data.overrideType.present
          ? data.overrideType.value
          : this.overrideType,
      reason: data.reason.present ? data.reason.value : this.reason,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DayOverride(')
          ..write('id: $id, ')
          ..write('workDate: $workDate, ')
          ..write('status: $status, ')
          ..write('shiftTemplateId: $shiftTemplateId, ')
          ..write('shiftSnapshotJson: $shiftSnapshotJson, ')
          ..write('overrideType: $overrideType, ')
          ..write('reason: $reason, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workDate,
    status,
    shiftTemplateId,
    shiftSnapshotJson,
    overrideType,
    reason,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DayOverride &&
          other.id == this.id &&
          other.workDate == this.workDate &&
          other.status == this.status &&
          other.shiftTemplateId == this.shiftTemplateId &&
          other.shiftSnapshotJson == this.shiftSnapshotJson &&
          other.overrideType == this.overrideType &&
          other.reason == this.reason &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class DayOverridesCompanion extends UpdateCompanion<DayOverride> {
  final Value<String> id;
  final Value<String> workDate;
  final Value<String> status;
  final Value<String?> shiftTemplateId;
  final Value<String?> shiftSnapshotJson;
  final Value<String> overrideType;
  final Value<String?> reason;
  final Value<String?> note;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const DayOverridesCompanion({
    this.id = const Value.absent(),
    this.workDate = const Value.absent(),
    this.status = const Value.absent(),
    this.shiftTemplateId = const Value.absent(),
    this.shiftSnapshotJson = const Value.absent(),
    this.overrideType = const Value.absent(),
    this.reason = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DayOverridesCompanion.insert({
    required String id,
    required String workDate,
    required String status,
    this.shiftTemplateId = const Value.absent(),
    this.shiftSnapshotJson = const Value.absent(),
    required String overrideType,
    this.reason = const Value.absent(),
    this.note = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workDate = Value(workDate),
       status = Value(status),
       overrideType = Value(overrideType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<DayOverride> custom({
    Expression<String>? id,
    Expression<String>? workDate,
    Expression<String>? status,
    Expression<String>? shiftTemplateId,
    Expression<String>? shiftSnapshotJson,
    Expression<String>? overrideType,
    Expression<String>? reason,
    Expression<String>? note,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workDate != null) 'work_date': workDate,
      if (status != null) 'status': status,
      if (shiftTemplateId != null) 'shift_template_id': shiftTemplateId,
      if (shiftSnapshotJson != null) 'shift_snapshot_json': shiftSnapshotJson,
      if (overrideType != null) 'override_type': overrideType,
      if (reason != null) 'reason': reason,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DayOverridesCompanion copyWith({
    Value<String>? id,
    Value<String>? workDate,
    Value<String>? status,
    Value<String?>? shiftTemplateId,
    Value<String?>? shiftSnapshotJson,
    Value<String>? overrideType,
    Value<String?>? reason,
    Value<String?>? note,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return DayOverridesCompanion(
      id: id ?? this.id,
      workDate: workDate ?? this.workDate,
      status: status ?? this.status,
      shiftTemplateId: shiftTemplateId ?? this.shiftTemplateId,
      shiftSnapshotJson: shiftSnapshotJson ?? this.shiftSnapshotJson,
      overrideType: overrideType ?? this.overrideType,
      reason: reason ?? this.reason,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workDate.present) {
      map['work_date'] = Variable<String>(workDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (shiftTemplateId.present) {
      map['shift_template_id'] = Variable<String>(shiftTemplateId.value);
    }
    if (shiftSnapshotJson.present) {
      map['shift_snapshot_json'] = Variable<String>(shiftSnapshotJson.value);
    }
    if (overrideType.present) {
      map['override_type'] = Variable<String>(overrideType.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DayOverridesCompanion(')
          ..write('id: $id, ')
          ..write('workDate: $workDate, ')
          ..write('status: $status, ')
          ..write('shiftTemplateId: $shiftTemplateId, ')
          ..write('shiftSnapshotJson: $shiftSnapshotJson, ')
          ..write('overrideType: $overrideType, ')
          ..write('reason: $reason, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HolidayRecordsTable extends HolidayRecords
    with TableInfo<$HolidayRecordsTable, HolidayRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HolidayRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _workDateMeta = const VerificationMeta(
    'workDate',
  );
  @override
  late final GeneratedColumn<String> workDate = GeneratedColumn<String>(
    'work_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
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
  static const VerificationMeta _dayTypeMeta = const VerificationMeta(
    'dayType',
  );
  @override
  late final GeneratedColumn<String> dayType = GeneratedColumn<String>(
    'day_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataVersionMeta = const VerificationMeta(
    'dataVersion',
  );
  @override
  late final GeneratedColumn<String> dataVersion = GeneratedColumn<String>(
    'data_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<int> publishedAt = GeneratedColumn<int>(
    'published_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    workDate,
    region,
    name,
    dayType,
    dataVersion,
    publishedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'holiday_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<HolidayRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('work_date')) {
      context.handle(
        _workDateMeta,
        workDate.isAcceptableOrUnknown(data['work_date']!, _workDateMeta),
      );
    } else if (isInserting) {
      context.missing(_workDateMeta);
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    } else if (isInserting) {
      context.missing(_regionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('day_type')) {
      context.handle(
        _dayTypeMeta,
        dayType.isAcceptableOrUnknown(data['day_type']!, _dayTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_dayTypeMeta);
    }
    if (data.containsKey('data_version')) {
      context.handle(
        _dataVersionMeta,
        dataVersion.isAcceptableOrUnknown(
          data['data_version']!,
          _dataVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dataVersionMeta);
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
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
  Set<GeneratedColumn> get $primaryKey => {workDate, region};
  @override
  HolidayRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HolidayRecord(
      workDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_date'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      dayType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day_type'],
      )!,
      dataVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data_version'],
      )!,
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}published_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $HolidayRecordsTable createAlias(String alias) {
    return $HolidayRecordsTable(attachedDatabase, alias);
  }
}

class HolidayRecord extends DataClass implements Insertable<HolidayRecord> {
  final String workDate;
  final String region;
  final String name;
  final String dayType;
  final String dataVersion;
  final int? publishedAt;
  final int updatedAt;
  const HolidayRecord({
    required this.workDate,
    required this.region,
    required this.name,
    required this.dayType,
    required this.dataVersion,
    this.publishedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['work_date'] = Variable<String>(workDate);
    map['region'] = Variable<String>(region);
    map['name'] = Variable<String>(name);
    map['day_type'] = Variable<String>(dayType);
    map['data_version'] = Variable<String>(dataVersion);
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<int>(publishedAt);
    }
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  HolidayRecordsCompanion toCompanion(bool nullToAbsent) {
    return HolidayRecordsCompanion(
      workDate: Value(workDate),
      region: Value(region),
      name: Value(name),
      dayType: Value(dayType),
      dataVersion: Value(dataVersion),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory HolidayRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HolidayRecord(
      workDate: serializer.fromJson<String>(json['workDate']),
      region: serializer.fromJson<String>(json['region']),
      name: serializer.fromJson<String>(json['name']),
      dayType: serializer.fromJson<String>(json['dayType']),
      dataVersion: serializer.fromJson<String>(json['dataVersion']),
      publishedAt: serializer.fromJson<int?>(json['publishedAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workDate': serializer.toJson<String>(workDate),
      'region': serializer.toJson<String>(region),
      'name': serializer.toJson<String>(name),
      'dayType': serializer.toJson<String>(dayType),
      'dataVersion': serializer.toJson<String>(dataVersion),
      'publishedAt': serializer.toJson<int?>(publishedAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  HolidayRecord copyWith({
    String? workDate,
    String? region,
    String? name,
    String? dayType,
    String? dataVersion,
    Value<int?> publishedAt = const Value.absent(),
    int? updatedAt,
  }) => HolidayRecord(
    workDate: workDate ?? this.workDate,
    region: region ?? this.region,
    name: name ?? this.name,
    dayType: dayType ?? this.dayType,
    dataVersion: dataVersion ?? this.dataVersion,
    publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  HolidayRecord copyWithCompanion(HolidayRecordsCompanion data) {
    return HolidayRecord(
      workDate: data.workDate.present ? data.workDate.value : this.workDate,
      region: data.region.present ? data.region.value : this.region,
      name: data.name.present ? data.name.value : this.name,
      dayType: data.dayType.present ? data.dayType.value : this.dayType,
      dataVersion: data.dataVersion.present
          ? data.dataVersion.value
          : this.dataVersion,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HolidayRecord(')
          ..write('workDate: $workDate, ')
          ..write('region: $region, ')
          ..write('name: $name, ')
          ..write('dayType: $dayType, ')
          ..write('dataVersion: $dataVersion, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    workDate,
    region,
    name,
    dayType,
    dataVersion,
    publishedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HolidayRecord &&
          other.workDate == this.workDate &&
          other.region == this.region &&
          other.name == this.name &&
          other.dayType == this.dayType &&
          other.dataVersion == this.dataVersion &&
          other.publishedAt == this.publishedAt &&
          other.updatedAt == this.updatedAt);
}

class HolidayRecordsCompanion extends UpdateCompanion<HolidayRecord> {
  final Value<String> workDate;
  final Value<String> region;
  final Value<String> name;
  final Value<String> dayType;
  final Value<String> dataVersion;
  final Value<int?> publishedAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const HolidayRecordsCompanion({
    this.workDate = const Value.absent(),
    this.region = const Value.absent(),
    this.name = const Value.absent(),
    this.dayType = const Value.absent(),
    this.dataVersion = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HolidayRecordsCompanion.insert({
    required String workDate,
    required String region,
    required String name,
    required String dayType,
    required String dataVersion,
    this.publishedAt = const Value.absent(),
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : workDate = Value(workDate),
       region = Value(region),
       name = Value(name),
       dayType = Value(dayType),
       dataVersion = Value(dataVersion),
       updatedAt = Value(updatedAt);
  static Insertable<HolidayRecord> custom({
    Expression<String>? workDate,
    Expression<String>? region,
    Expression<String>? name,
    Expression<String>? dayType,
    Expression<String>? dataVersion,
    Expression<int>? publishedAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (workDate != null) 'work_date': workDate,
      if (region != null) 'region': region,
      if (name != null) 'name': name,
      if (dayType != null) 'day_type': dayType,
      if (dataVersion != null) 'data_version': dataVersion,
      if (publishedAt != null) 'published_at': publishedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HolidayRecordsCompanion copyWith({
    Value<String>? workDate,
    Value<String>? region,
    Value<String>? name,
    Value<String>? dayType,
    Value<String>? dataVersion,
    Value<int?>? publishedAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return HolidayRecordsCompanion(
      workDate: workDate ?? this.workDate,
      region: region ?? this.region,
      name: name ?? this.name,
      dayType: dayType ?? this.dayType,
      dataVersion: dataVersion ?? this.dataVersion,
      publishedAt: publishedAt ?? this.publishedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (workDate.present) {
      map['work_date'] = Variable<String>(workDate.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dayType.present) {
      map['day_type'] = Variable<String>(dayType.value);
    }
    if (dataVersion.present) {
      map['data_version'] = Variable<String>(dataVersion.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<int>(publishedAt.value);
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
    return (StringBuffer('HolidayRecordsCompanion(')
          ..write('workDate: $workDate, ')
          ..write('region: $region, ')
          ..write('name: $name, ')
          ..write('dayType: $dayType, ')
          ..write('dataVersion: $dataVersion, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CalendarDayCacheTable extends CalendarDayCache
    with TableInfo<$CalendarDayCacheTable, CalendarDayCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalendarDayCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _workDateMeta = const VerificationMeta(
    'workDate',
  );
  @override
  late final GeneratedColumn<String> workDate = GeneratedColumn<String>(
    'work_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resolvedStatusMeta = const VerificationMeta(
    'resolvedStatus',
  );
  @override
  late final GeneratedColumn<String> resolvedStatus = GeneratedColumn<String>(
    'resolved_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shiftSnapshotJsonMeta = const VerificationMeta(
    'shiftSnapshotJson',
  );
  @override
  late final GeneratedColumn<String> shiftSnapshotJson =
      GeneratedColumn<String>(
        'shift_snapshot_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plannedMinutesMeta = const VerificationMeta(
    'plannedMinutes',
  );
  @override
  late final GeneratedColumn<int> plannedMinutes = GeneratedColumn<int>(
    'planned_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resolverVersionMeta = const VerificationMeta(
    'resolverVersion',
  );
  @override
  late final GeneratedColumn<int> resolverVersion = GeneratedColumn<int>(
    'resolver_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inputVersionMeta = const VerificationMeta(
    'inputVersion',
  );
  @override
  late final GeneratedColumn<String> inputVersion = GeneratedColumn<String>(
    'input_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resolvedAtMeta = const VerificationMeta(
    'resolvedAt',
  );
  @override
  late final GeneratedColumn<int> resolvedAt = GeneratedColumn<int>(
    'resolved_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    workDate,
    resolvedStatus,
    shiftSnapshotJson,
    sourceType,
    sourceId,
    plannedMinutes,
    resolverVersion,
    inputVersion,
    resolvedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calendar_day_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<CalendarDayCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('work_date')) {
      context.handle(
        _workDateMeta,
        workDate.isAcceptableOrUnknown(data['work_date']!, _workDateMeta),
      );
    } else if (isInserting) {
      context.missing(_workDateMeta);
    }
    if (data.containsKey('resolved_status')) {
      context.handle(
        _resolvedStatusMeta,
        resolvedStatus.isAcceptableOrUnknown(
          data['resolved_status']!,
          _resolvedStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_resolvedStatusMeta);
    }
    if (data.containsKey('shift_snapshot_json')) {
      context.handle(
        _shiftSnapshotJsonMeta,
        shiftSnapshotJson.isAcceptableOrUnknown(
          data['shift_snapshot_json']!,
          _shiftSnapshotJsonMeta,
        ),
      );
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    }
    if (data.containsKey('planned_minutes')) {
      context.handle(
        _plannedMinutesMeta,
        plannedMinutes.isAcceptableOrUnknown(
          data['planned_minutes']!,
          _plannedMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedMinutesMeta);
    }
    if (data.containsKey('resolver_version')) {
      context.handle(
        _resolverVersionMeta,
        resolverVersion.isAcceptableOrUnknown(
          data['resolver_version']!,
          _resolverVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_resolverVersionMeta);
    }
    if (data.containsKey('input_version')) {
      context.handle(
        _inputVersionMeta,
        inputVersion.isAcceptableOrUnknown(
          data['input_version']!,
          _inputVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inputVersionMeta);
    }
    if (data.containsKey('resolved_at')) {
      context.handle(
        _resolvedAtMeta,
        resolvedAt.isAcceptableOrUnknown(data['resolved_at']!, _resolvedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_resolvedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {workDate};
  @override
  CalendarDayCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalendarDayCacheData(
      workDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_date'],
      )!,
      resolvedStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resolved_status'],
      )!,
      shiftSnapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shift_snapshot_json'],
      ),
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      ),
      plannedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_minutes'],
      )!,
      resolverVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}resolver_version'],
      )!,
      inputVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}input_version'],
      )!,
      resolvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}resolved_at'],
      )!,
    );
  }

  @override
  $CalendarDayCacheTable createAlias(String alias) {
    return $CalendarDayCacheTable(attachedDatabase, alias);
  }
}

class CalendarDayCacheData extends DataClass
    implements Insertable<CalendarDayCacheData> {
  final String workDate;
  final String resolvedStatus;
  final String? shiftSnapshotJson;
  final String sourceType;
  final String? sourceId;
  final int plannedMinutes;
  final int resolverVersion;
  final String inputVersion;
  final int resolvedAt;
  const CalendarDayCacheData({
    required this.workDate,
    required this.resolvedStatus,
    this.shiftSnapshotJson,
    required this.sourceType,
    this.sourceId,
    required this.plannedMinutes,
    required this.resolverVersion,
    required this.inputVersion,
    required this.resolvedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['work_date'] = Variable<String>(workDate);
    map['resolved_status'] = Variable<String>(resolvedStatus);
    if (!nullToAbsent || shiftSnapshotJson != null) {
      map['shift_snapshot_json'] = Variable<String>(shiftSnapshotJson);
    }
    map['source_type'] = Variable<String>(sourceType);
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<String>(sourceId);
    }
    map['planned_minutes'] = Variable<int>(plannedMinutes);
    map['resolver_version'] = Variable<int>(resolverVersion);
    map['input_version'] = Variable<String>(inputVersion);
    map['resolved_at'] = Variable<int>(resolvedAt);
    return map;
  }

  CalendarDayCacheCompanion toCompanion(bool nullToAbsent) {
    return CalendarDayCacheCompanion(
      workDate: Value(workDate),
      resolvedStatus: Value(resolvedStatus),
      shiftSnapshotJson: shiftSnapshotJson == null && nullToAbsent
          ? const Value.absent()
          : Value(shiftSnapshotJson),
      sourceType: Value(sourceType),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
      plannedMinutes: Value(plannedMinutes),
      resolverVersion: Value(resolverVersion),
      inputVersion: Value(inputVersion),
      resolvedAt: Value(resolvedAt),
    );
  }

  factory CalendarDayCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalendarDayCacheData(
      workDate: serializer.fromJson<String>(json['workDate']),
      resolvedStatus: serializer.fromJson<String>(json['resolvedStatus']),
      shiftSnapshotJson: serializer.fromJson<String?>(
        json['shiftSnapshotJson'],
      ),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      sourceId: serializer.fromJson<String?>(json['sourceId']),
      plannedMinutes: serializer.fromJson<int>(json['plannedMinutes']),
      resolverVersion: serializer.fromJson<int>(json['resolverVersion']),
      inputVersion: serializer.fromJson<String>(json['inputVersion']),
      resolvedAt: serializer.fromJson<int>(json['resolvedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workDate': serializer.toJson<String>(workDate),
      'resolvedStatus': serializer.toJson<String>(resolvedStatus),
      'shiftSnapshotJson': serializer.toJson<String?>(shiftSnapshotJson),
      'sourceType': serializer.toJson<String>(sourceType),
      'sourceId': serializer.toJson<String?>(sourceId),
      'plannedMinutes': serializer.toJson<int>(plannedMinutes),
      'resolverVersion': serializer.toJson<int>(resolverVersion),
      'inputVersion': serializer.toJson<String>(inputVersion),
      'resolvedAt': serializer.toJson<int>(resolvedAt),
    };
  }

  CalendarDayCacheData copyWith({
    String? workDate,
    String? resolvedStatus,
    Value<String?> shiftSnapshotJson = const Value.absent(),
    String? sourceType,
    Value<String?> sourceId = const Value.absent(),
    int? plannedMinutes,
    int? resolverVersion,
    String? inputVersion,
    int? resolvedAt,
  }) => CalendarDayCacheData(
    workDate: workDate ?? this.workDate,
    resolvedStatus: resolvedStatus ?? this.resolvedStatus,
    shiftSnapshotJson: shiftSnapshotJson.present
        ? shiftSnapshotJson.value
        : this.shiftSnapshotJson,
    sourceType: sourceType ?? this.sourceType,
    sourceId: sourceId.present ? sourceId.value : this.sourceId,
    plannedMinutes: plannedMinutes ?? this.plannedMinutes,
    resolverVersion: resolverVersion ?? this.resolverVersion,
    inputVersion: inputVersion ?? this.inputVersion,
    resolvedAt: resolvedAt ?? this.resolvedAt,
  );
  CalendarDayCacheData copyWithCompanion(CalendarDayCacheCompanion data) {
    return CalendarDayCacheData(
      workDate: data.workDate.present ? data.workDate.value : this.workDate,
      resolvedStatus: data.resolvedStatus.present
          ? data.resolvedStatus.value
          : this.resolvedStatus,
      shiftSnapshotJson: data.shiftSnapshotJson.present
          ? data.shiftSnapshotJson.value
          : this.shiftSnapshotJson,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      plannedMinutes: data.plannedMinutes.present
          ? data.plannedMinutes.value
          : this.plannedMinutes,
      resolverVersion: data.resolverVersion.present
          ? data.resolverVersion.value
          : this.resolverVersion,
      inputVersion: data.inputVersion.present
          ? data.inputVersion.value
          : this.inputVersion,
      resolvedAt: data.resolvedAt.present
          ? data.resolvedAt.value
          : this.resolvedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalendarDayCacheData(')
          ..write('workDate: $workDate, ')
          ..write('resolvedStatus: $resolvedStatus, ')
          ..write('shiftSnapshotJson: $shiftSnapshotJson, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('plannedMinutes: $plannedMinutes, ')
          ..write('resolverVersion: $resolverVersion, ')
          ..write('inputVersion: $inputVersion, ')
          ..write('resolvedAt: $resolvedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    workDate,
    resolvedStatus,
    shiftSnapshotJson,
    sourceType,
    sourceId,
    plannedMinutes,
    resolverVersion,
    inputVersion,
    resolvedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalendarDayCacheData &&
          other.workDate == this.workDate &&
          other.resolvedStatus == this.resolvedStatus &&
          other.shiftSnapshotJson == this.shiftSnapshotJson &&
          other.sourceType == this.sourceType &&
          other.sourceId == this.sourceId &&
          other.plannedMinutes == this.plannedMinutes &&
          other.resolverVersion == this.resolverVersion &&
          other.inputVersion == this.inputVersion &&
          other.resolvedAt == this.resolvedAt);
}

class CalendarDayCacheCompanion extends UpdateCompanion<CalendarDayCacheData> {
  final Value<String> workDate;
  final Value<String> resolvedStatus;
  final Value<String?> shiftSnapshotJson;
  final Value<String> sourceType;
  final Value<String?> sourceId;
  final Value<int> plannedMinutes;
  final Value<int> resolverVersion;
  final Value<String> inputVersion;
  final Value<int> resolvedAt;
  final Value<int> rowid;
  const CalendarDayCacheCompanion({
    this.workDate = const Value.absent(),
    this.resolvedStatus = const Value.absent(),
    this.shiftSnapshotJson = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.plannedMinutes = const Value.absent(),
    this.resolverVersion = const Value.absent(),
    this.inputVersion = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CalendarDayCacheCompanion.insert({
    required String workDate,
    required String resolvedStatus,
    this.shiftSnapshotJson = const Value.absent(),
    required String sourceType,
    this.sourceId = const Value.absent(),
    required int plannedMinutes,
    required int resolverVersion,
    required String inputVersion,
    required int resolvedAt,
    this.rowid = const Value.absent(),
  }) : workDate = Value(workDate),
       resolvedStatus = Value(resolvedStatus),
       sourceType = Value(sourceType),
       plannedMinutes = Value(plannedMinutes),
       resolverVersion = Value(resolverVersion),
       inputVersion = Value(inputVersion),
       resolvedAt = Value(resolvedAt);
  static Insertable<CalendarDayCacheData> custom({
    Expression<String>? workDate,
    Expression<String>? resolvedStatus,
    Expression<String>? shiftSnapshotJson,
    Expression<String>? sourceType,
    Expression<String>? sourceId,
    Expression<int>? plannedMinutes,
    Expression<int>? resolverVersion,
    Expression<String>? inputVersion,
    Expression<int>? resolvedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (workDate != null) 'work_date': workDate,
      if (resolvedStatus != null) 'resolved_status': resolvedStatus,
      if (shiftSnapshotJson != null) 'shift_snapshot_json': shiftSnapshotJson,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceId != null) 'source_id': sourceId,
      if (plannedMinutes != null) 'planned_minutes': plannedMinutes,
      if (resolverVersion != null) 'resolver_version': resolverVersion,
      if (inputVersion != null) 'input_version': inputVersion,
      if (resolvedAt != null) 'resolved_at': resolvedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CalendarDayCacheCompanion copyWith({
    Value<String>? workDate,
    Value<String>? resolvedStatus,
    Value<String?>? shiftSnapshotJson,
    Value<String>? sourceType,
    Value<String?>? sourceId,
    Value<int>? plannedMinutes,
    Value<int>? resolverVersion,
    Value<String>? inputVersion,
    Value<int>? resolvedAt,
    Value<int>? rowid,
  }) {
    return CalendarDayCacheCompanion(
      workDate: workDate ?? this.workDate,
      resolvedStatus: resolvedStatus ?? this.resolvedStatus,
      shiftSnapshotJson: shiftSnapshotJson ?? this.shiftSnapshotJson,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      plannedMinutes: plannedMinutes ?? this.plannedMinutes,
      resolverVersion: resolverVersion ?? this.resolverVersion,
      inputVersion: inputVersion ?? this.inputVersion,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (workDate.present) {
      map['work_date'] = Variable<String>(workDate.value);
    }
    if (resolvedStatus.present) {
      map['resolved_status'] = Variable<String>(resolvedStatus.value);
    }
    if (shiftSnapshotJson.present) {
      map['shift_snapshot_json'] = Variable<String>(shiftSnapshotJson.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (plannedMinutes.present) {
      map['planned_minutes'] = Variable<int>(plannedMinutes.value);
    }
    if (resolverVersion.present) {
      map['resolver_version'] = Variable<int>(resolverVersion.value);
    }
    if (inputVersion.present) {
      map['input_version'] = Variable<String>(inputVersion.value);
    }
    if (resolvedAt.present) {
      map['resolved_at'] = Variable<int>(resolvedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalendarDayCacheCompanion(')
          ..write('workDate: $workDate, ')
          ..write('resolvedStatus: $resolvedStatus, ')
          ..write('shiftSnapshotJson: $shiftSnapshotJson, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('plannedMinutes: $plannedMinutes, ')
          ..write('resolverVersion: $resolverVersion, ')
          ..write('inputVersion: $inputVersion, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChangeLogTable extends ChangeLog
    with TableInfo<$ChangeLogTable, ChangeLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChangeLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
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
  static const VerificationMeta _changeTypeMeta = const VerificationMeta(
    'changeType',
  );
  @override
  late final GeneratedColumn<String> changeType = GeneratedColumn<String>(
    'change_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _beforeSnapshotJsonMeta =
      const VerificationMeta('beforeSnapshotJson');
  @override
  late final GeneratedColumn<String> beforeSnapshotJson =
      GeneratedColumn<String>(
        'before_snapshot_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _afterSnapshotJsonMeta = const VerificationMeta(
    'afterSnapshotJson',
  );
  @override
  late final GeneratedColumn<String> afterSnapshotJson =
      GeneratedColumn<String>(
        'after_snapshot_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
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
    entityType,
    entityId,
    changeType,
    beforeSnapshotJson,
    afterSnapshotJson,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'change_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChangeLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('change_type')) {
      context.handle(
        _changeTypeMeta,
        changeType.isAcceptableOrUnknown(data['change_type']!, _changeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_changeTypeMeta);
    }
    if (data.containsKey('before_snapshot_json')) {
      context.handle(
        _beforeSnapshotJsonMeta,
        beforeSnapshotJson.isAcceptableOrUnknown(
          data['before_snapshot_json']!,
          _beforeSnapshotJsonMeta,
        ),
      );
    }
    if (data.containsKey('after_snapshot_json')) {
      context.handle(
        _afterSnapshotJsonMeta,
        afterSnapshotJson.isAcceptableOrUnknown(
          data['after_snapshot_json']!,
          _afterSnapshotJsonMeta,
        ),
      );
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
  ChangeLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChangeLogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      changeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}change_type'],
      )!,
      beforeSnapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}before_snapshot_json'],
      ),
      afterSnapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}after_snapshot_json'],
      ),
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
  $ChangeLogTable createAlias(String alias) {
    return $ChangeLogTable(attachedDatabase, alias);
  }
}

class ChangeLogData extends DataClass implements Insertable<ChangeLogData> {
  final String id;
  final String entityType;
  final String entityId;
  final String changeType;
  final String? beforeSnapshotJson;
  final String? afterSnapshotJson;
  final int createdAt;
  final int updatedAt;
  const ChangeLogData({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.changeType,
    this.beforeSnapshotJson,
    this.afterSnapshotJson,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['change_type'] = Variable<String>(changeType);
    if (!nullToAbsent || beforeSnapshotJson != null) {
      map['before_snapshot_json'] = Variable<String>(beforeSnapshotJson);
    }
    if (!nullToAbsent || afterSnapshotJson != null) {
      map['after_snapshot_json'] = Variable<String>(afterSnapshotJson);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  ChangeLogCompanion toCompanion(bool nullToAbsent) {
    return ChangeLogCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      changeType: Value(changeType),
      beforeSnapshotJson: beforeSnapshotJson == null && nullToAbsent
          ? const Value.absent()
          : Value(beforeSnapshotJson),
      afterSnapshotJson: afterSnapshotJson == null && nullToAbsent
          ? const Value.absent()
          : Value(afterSnapshotJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ChangeLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChangeLogData(
      id: serializer.fromJson<String>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      changeType: serializer.fromJson<String>(json['changeType']),
      beforeSnapshotJson: serializer.fromJson<String?>(
        json['beforeSnapshotJson'],
      ),
      afterSnapshotJson: serializer.fromJson<String?>(
        json['afterSnapshotJson'],
      ),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'changeType': serializer.toJson<String>(changeType),
      'beforeSnapshotJson': serializer.toJson<String?>(beforeSnapshotJson),
      'afterSnapshotJson': serializer.toJson<String?>(afterSnapshotJson),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  ChangeLogData copyWith({
    String? id,
    String? entityType,
    String? entityId,
    String? changeType,
    Value<String?> beforeSnapshotJson = const Value.absent(),
    Value<String?> afterSnapshotJson = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => ChangeLogData(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    changeType: changeType ?? this.changeType,
    beforeSnapshotJson: beforeSnapshotJson.present
        ? beforeSnapshotJson.value
        : this.beforeSnapshotJson,
    afterSnapshotJson: afterSnapshotJson.present
        ? afterSnapshotJson.value
        : this.afterSnapshotJson,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ChangeLogData copyWithCompanion(ChangeLogCompanion data) {
    return ChangeLogData(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      changeType: data.changeType.present
          ? data.changeType.value
          : this.changeType,
      beforeSnapshotJson: data.beforeSnapshotJson.present
          ? data.beforeSnapshotJson.value
          : this.beforeSnapshotJson,
      afterSnapshotJson: data.afterSnapshotJson.present
          ? data.afterSnapshotJson.value
          : this.afterSnapshotJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChangeLogData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('changeType: $changeType, ')
          ..write('beforeSnapshotJson: $beforeSnapshotJson, ')
          ..write('afterSnapshotJson: $afterSnapshotJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    entityId,
    changeType,
    beforeSnapshotJson,
    afterSnapshotJson,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChangeLogData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.changeType == this.changeType &&
          other.beforeSnapshotJson == this.beforeSnapshotJson &&
          other.afterSnapshotJson == this.afterSnapshotJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ChangeLogCompanion extends UpdateCompanion<ChangeLogData> {
  final Value<String> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> changeType;
  final Value<String?> beforeSnapshotJson;
  final Value<String?> afterSnapshotJson;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const ChangeLogCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.changeType = const Value.absent(),
    this.beforeSnapshotJson = const Value.absent(),
    this.afterSnapshotJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChangeLogCompanion.insert({
    required String id,
    required String entityType,
    required String entityId,
    required String changeType,
    this.beforeSnapshotJson = const Value.absent(),
    this.afterSnapshotJson = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entityType = Value(entityType),
       entityId = Value(entityId),
       changeType = Value(changeType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ChangeLogData> custom({
    Expression<String>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? changeType,
    Expression<String>? beforeSnapshotJson,
    Expression<String>? afterSnapshotJson,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (changeType != null) 'change_type': changeType,
      if (beforeSnapshotJson != null)
        'before_snapshot_json': beforeSnapshotJson,
      if (afterSnapshotJson != null) 'after_snapshot_json': afterSnapshotJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChangeLogCompanion copyWith({
    Value<String>? id,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? changeType,
    Value<String?>? beforeSnapshotJson,
    Value<String?>? afterSnapshotJson,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return ChangeLogCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      changeType: changeType ?? this.changeType,
      beforeSnapshotJson: beforeSnapshotJson ?? this.beforeSnapshotJson,
      afterSnapshotJson: afterSnapshotJson ?? this.afterSnapshotJson,
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
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (changeType.present) {
      map['change_type'] = Variable<String>(changeType.value);
    }
    if (beforeSnapshotJson.present) {
      map['before_snapshot_json'] = Variable<String>(beforeSnapshotJson.value);
    }
    if (afterSnapshotJson.present) {
      map['after_snapshot_json'] = Variable<String>(afterSnapshotJson.value);
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
    return (StringBuffer('ChangeLogCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('changeType: $changeType, ')
          ..write('beforeSnapshotJson: $beforeSnapshotJson, ')
          ..write('afterSnapshotJson: $afterSnapshotJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlarmTemplatesTable extends AlarmTemplates
    with TableInfo<$AlarmTemplatesTable, AlarmTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmTemplatesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fixedMinuteMeta = const VerificationMeta(
    'fixedMinute',
  );
  @override
  late final GeneratedColumn<int> fixedMinute = GeneratedColumn<int>(
    'fixed_minute',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _offsetMinutesMeta = const VerificationMeta(
    'offsetMinutes',
  );
  @override
  late final GeneratedColumn<int> offsetMinutes = GeneratedColumn<int>(
    'offset_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _soundIdMeta = const VerificationMeta(
    'soundId',
  );
  @override
  late final GeneratedColumn<String> soundId = GeneratedColumn<String>(
    'sound_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vibrateMeta = const VerificationMeta(
    'vibrate',
  );
  @override
  late final GeneratedColumn<int> vibrate = GeneratedColumn<int>(
    'vibrate',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _volumeRampMeta = const VerificationMeta(
    'volumeRamp',
  );
  @override
  late final GeneratedColumn<int> volumeRamp = GeneratedColumn<int>(
    'volume_ramp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(0),
  );
  static const VerificationMeta _snoozeMinutesMeta = const VerificationMeta(
    'snoozeMinutes',
  );
  @override
  late final GeneratedColumn<int> snoozeMinutes = GeneratedColumn<int>(
    'snooze_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxSnoozeCountMeta = const VerificationMeta(
    'maxSnoozeCount',
  );
  @override
  late final GeneratedColumn<int> maxSnoozeCount = GeneratedColumn<int>(
    'max_snooze_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<int> enabled = GeneratedColumn<int>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    mode,
    fixedMinute,
    offsetMinutes,
    soundId,
    vibrate,
    volumeRamp,
    snoozeMinutes,
    maxSnoozeCount,
    enabled,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarm_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<AlarmTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('fixed_minute')) {
      context.handle(
        _fixedMinuteMeta,
        fixedMinute.isAcceptableOrUnknown(
          data['fixed_minute']!,
          _fixedMinuteMeta,
        ),
      );
    }
    if (data.containsKey('offset_minutes')) {
      context.handle(
        _offsetMinutesMeta,
        offsetMinutes.isAcceptableOrUnknown(
          data['offset_minutes']!,
          _offsetMinutesMeta,
        ),
      );
    }
    if (data.containsKey('sound_id')) {
      context.handle(
        _soundIdMeta,
        soundId.isAcceptableOrUnknown(data['sound_id']!, _soundIdMeta),
      );
    }
    if (data.containsKey('vibrate')) {
      context.handle(
        _vibrateMeta,
        vibrate.isAcceptableOrUnknown(data['vibrate']!, _vibrateMeta),
      );
    } else if (isInserting) {
      context.missing(_vibrateMeta);
    }
    if (data.containsKey('volume_ramp')) {
      context.handle(
        _volumeRampMeta,
        volumeRamp.isAcceptableOrUnknown(data['volume_ramp']!, _volumeRampMeta),
      );
    }
    if (data.containsKey('snooze_minutes')) {
      context.handle(
        _snoozeMinutesMeta,
        snoozeMinutes.isAcceptableOrUnknown(
          data['snooze_minutes']!,
          _snoozeMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_snoozeMinutesMeta);
    }
    if (data.containsKey('max_snooze_count')) {
      context.handle(
        _maxSnoozeCountMeta,
        maxSnoozeCount.isAcceptableOrUnknown(
          data['max_snooze_count']!,
          _maxSnoozeCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxSnoozeCountMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    } else if (isInserting) {
      context.missing(_enabledMeta);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AlarmTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlarmTemplate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      fixedMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fixed_minute'],
      ),
      offsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}offset_minutes'],
      ),
      soundId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sound_id'],
      ),
      vibrate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vibrate'],
      )!,
      volumeRamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}volume_ramp'],
      )!,
      snoozeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}snooze_minutes'],
      )!,
      maxSnoozeCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_snooze_count'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $AlarmTemplatesTable createAlias(String alias) {
    return $AlarmTemplatesTable(attachedDatabase, alias);
  }
}

class AlarmTemplate extends DataClass implements Insertable<AlarmTemplate> {
  final String id;
  final String name;
  final String mode;
  final int? fixedMinute;
  final int? offsetMinutes;
  final String? soundId;
  final int vibrate;
  final int volumeRamp;
  final int snoozeMinutes;
  final int maxSnoozeCount;
  final int enabled;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  const AlarmTemplate({
    required this.id,
    required this.name,
    required this.mode,
    this.fixedMinute,
    this.offsetMinutes,
    this.soundId,
    required this.vibrate,
    required this.volumeRamp,
    required this.snoozeMinutes,
    required this.maxSnoozeCount,
    required this.enabled,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['mode'] = Variable<String>(mode);
    if (!nullToAbsent || fixedMinute != null) {
      map['fixed_minute'] = Variable<int>(fixedMinute);
    }
    if (!nullToAbsent || offsetMinutes != null) {
      map['offset_minutes'] = Variable<int>(offsetMinutes);
    }
    if (!nullToAbsent || soundId != null) {
      map['sound_id'] = Variable<String>(soundId);
    }
    map['vibrate'] = Variable<int>(vibrate);
    map['volume_ramp'] = Variable<int>(volumeRamp);
    map['snooze_minutes'] = Variable<int>(snoozeMinutes);
    map['max_snooze_count'] = Variable<int>(maxSnoozeCount);
    map['enabled'] = Variable<int>(enabled);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  AlarmTemplatesCompanion toCompanion(bool nullToAbsent) {
    return AlarmTemplatesCompanion(
      id: Value(id),
      name: Value(name),
      mode: Value(mode),
      fixedMinute: fixedMinute == null && nullToAbsent
          ? const Value.absent()
          : Value(fixedMinute),
      offsetMinutes: offsetMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(offsetMinutes),
      soundId: soundId == null && nullToAbsent
          ? const Value.absent()
          : Value(soundId),
      vibrate: Value(vibrate),
      volumeRamp: Value(volumeRamp),
      snoozeMinutes: Value(snoozeMinutes),
      maxSnoozeCount: Value(maxSnoozeCount),
      enabled: Value(enabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory AlarmTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlarmTemplate(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      mode: serializer.fromJson<String>(json['mode']),
      fixedMinute: serializer.fromJson<int?>(json['fixedMinute']),
      offsetMinutes: serializer.fromJson<int?>(json['offsetMinutes']),
      soundId: serializer.fromJson<String?>(json['soundId']),
      vibrate: serializer.fromJson<int>(json['vibrate']),
      volumeRamp: serializer.fromJson<int>(json['volumeRamp']),
      snoozeMinutes: serializer.fromJson<int>(json['snoozeMinutes']),
      maxSnoozeCount: serializer.fromJson<int>(json['maxSnoozeCount']),
      enabled: serializer.fromJson<int>(json['enabled']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'mode': serializer.toJson<String>(mode),
      'fixedMinute': serializer.toJson<int?>(fixedMinute),
      'offsetMinutes': serializer.toJson<int?>(offsetMinutes),
      'soundId': serializer.toJson<String?>(soundId),
      'vibrate': serializer.toJson<int>(vibrate),
      'volumeRamp': serializer.toJson<int>(volumeRamp),
      'snoozeMinutes': serializer.toJson<int>(snoozeMinutes),
      'maxSnoozeCount': serializer.toJson<int>(maxSnoozeCount),
      'enabled': serializer.toJson<int>(enabled),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  AlarmTemplate copyWith({
    String? id,
    String? name,
    String? mode,
    Value<int?> fixedMinute = const Value.absent(),
    Value<int?> offsetMinutes = const Value.absent(),
    Value<String?> soundId = const Value.absent(),
    int? vibrate,
    int? volumeRamp,
    int? snoozeMinutes,
    int? maxSnoozeCount,
    int? enabled,
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => AlarmTemplate(
    id: id ?? this.id,
    name: name ?? this.name,
    mode: mode ?? this.mode,
    fixedMinute: fixedMinute.present ? fixedMinute.value : this.fixedMinute,
    offsetMinutes: offsetMinutes.present
        ? offsetMinutes.value
        : this.offsetMinutes,
    soundId: soundId.present ? soundId.value : this.soundId,
    vibrate: vibrate ?? this.vibrate,
    volumeRamp: volumeRamp ?? this.volumeRamp,
    snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
    maxSnoozeCount: maxSnoozeCount ?? this.maxSnoozeCount,
    enabled: enabled ?? this.enabled,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  AlarmTemplate copyWithCompanion(AlarmTemplatesCompanion data) {
    return AlarmTemplate(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      mode: data.mode.present ? data.mode.value : this.mode,
      fixedMinute: data.fixedMinute.present
          ? data.fixedMinute.value
          : this.fixedMinute,
      offsetMinutes: data.offsetMinutes.present
          ? data.offsetMinutes.value
          : this.offsetMinutes,
      soundId: data.soundId.present ? data.soundId.value : this.soundId,
      vibrate: data.vibrate.present ? data.vibrate.value : this.vibrate,
      volumeRamp: data.volumeRamp.present
          ? data.volumeRamp.value
          : this.volumeRamp,
      snoozeMinutes: data.snoozeMinutes.present
          ? data.snoozeMinutes.value
          : this.snoozeMinutes,
      maxSnoozeCount: data.maxSnoozeCount.present
          ? data.maxSnoozeCount.value
          : this.maxSnoozeCount,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlarmTemplate(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mode: $mode, ')
          ..write('fixedMinute: $fixedMinute, ')
          ..write('offsetMinutes: $offsetMinutes, ')
          ..write('soundId: $soundId, ')
          ..write('vibrate: $vibrate, ')
          ..write('volumeRamp: $volumeRamp, ')
          ..write('snoozeMinutes: $snoozeMinutes, ')
          ..write('maxSnoozeCount: $maxSnoozeCount, ')
          ..write('enabled: $enabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    mode,
    fixedMinute,
    offsetMinutes,
    soundId,
    vibrate,
    volumeRamp,
    snoozeMinutes,
    maxSnoozeCount,
    enabled,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlarmTemplate &&
          other.id == this.id &&
          other.name == this.name &&
          other.mode == this.mode &&
          other.fixedMinute == this.fixedMinute &&
          other.offsetMinutes == this.offsetMinutes &&
          other.soundId == this.soundId &&
          other.vibrate == this.vibrate &&
          other.volumeRamp == this.volumeRamp &&
          other.snoozeMinutes == this.snoozeMinutes &&
          other.maxSnoozeCount == this.maxSnoozeCount &&
          other.enabled == this.enabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class AlarmTemplatesCompanion extends UpdateCompanion<AlarmTemplate> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> mode;
  final Value<int?> fixedMinute;
  final Value<int?> offsetMinutes;
  final Value<String?> soundId;
  final Value<int> vibrate;
  final Value<int> volumeRamp;
  final Value<int> snoozeMinutes;
  final Value<int> maxSnoozeCount;
  final Value<int> enabled;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const AlarmTemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.mode = const Value.absent(),
    this.fixedMinute = const Value.absent(),
    this.offsetMinutes = const Value.absent(),
    this.soundId = const Value.absent(),
    this.vibrate = const Value.absent(),
    this.volumeRamp = const Value.absent(),
    this.snoozeMinutes = const Value.absent(),
    this.maxSnoozeCount = const Value.absent(),
    this.enabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlarmTemplatesCompanion.insert({
    required String id,
    required String name,
    required String mode,
    this.fixedMinute = const Value.absent(),
    this.offsetMinutes = const Value.absent(),
    this.soundId = const Value.absent(),
    required int vibrate,
    this.volumeRamp = const Value.absent(),
    required int snoozeMinutes,
    required int maxSnoozeCount,
    required int enabled,
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       mode = Value(mode),
       vibrate = Value(vibrate),
       snoozeMinutes = Value(snoozeMinutes),
       maxSnoozeCount = Value(maxSnoozeCount),
       enabled = Value(enabled),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AlarmTemplate> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? mode,
    Expression<int>? fixedMinute,
    Expression<int>? offsetMinutes,
    Expression<String>? soundId,
    Expression<int>? vibrate,
    Expression<int>? volumeRamp,
    Expression<int>? snoozeMinutes,
    Expression<int>? maxSnoozeCount,
    Expression<int>? enabled,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (mode != null) 'mode': mode,
      if (fixedMinute != null) 'fixed_minute': fixedMinute,
      if (offsetMinutes != null) 'offset_minutes': offsetMinutes,
      if (soundId != null) 'sound_id': soundId,
      if (vibrate != null) 'vibrate': vibrate,
      if (volumeRamp != null) 'volume_ramp': volumeRamp,
      if (snoozeMinutes != null) 'snooze_minutes': snoozeMinutes,
      if (maxSnoozeCount != null) 'max_snooze_count': maxSnoozeCount,
      if (enabled != null) 'enabled': enabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlarmTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? mode,
    Value<int?>? fixedMinute,
    Value<int?>? offsetMinutes,
    Value<String?>? soundId,
    Value<int>? vibrate,
    Value<int>? volumeRamp,
    Value<int>? snoozeMinutes,
    Value<int>? maxSnoozeCount,
    Value<int>? enabled,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return AlarmTemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      mode: mode ?? this.mode,
      fixedMinute: fixedMinute ?? this.fixedMinute,
      offsetMinutes: offsetMinutes ?? this.offsetMinutes,
      soundId: soundId ?? this.soundId,
      vibrate: vibrate ?? this.vibrate,
      volumeRamp: volumeRamp ?? this.volumeRamp,
      snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
      maxSnoozeCount: maxSnoozeCount ?? this.maxSnoozeCount,
      enabled: enabled ?? this.enabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (fixedMinute.present) {
      map['fixed_minute'] = Variable<int>(fixedMinute.value);
    }
    if (offsetMinutes.present) {
      map['offset_minutes'] = Variable<int>(offsetMinutes.value);
    }
    if (soundId.present) {
      map['sound_id'] = Variable<String>(soundId.value);
    }
    if (vibrate.present) {
      map['vibrate'] = Variable<int>(vibrate.value);
    }
    if (volumeRamp.present) {
      map['volume_ramp'] = Variable<int>(volumeRamp.value);
    }
    if (snoozeMinutes.present) {
      map['snooze_minutes'] = Variable<int>(snoozeMinutes.value);
    }
    if (maxSnoozeCount.present) {
      map['max_snooze_count'] = Variable<int>(maxSnoozeCount.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<int>(enabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mode: $mode, ')
          ..write('fixedMinute: $fixedMinute, ')
          ..write('offsetMinutes: $offsetMinutes, ')
          ..write('soundId: $soundId, ')
          ..write('vibrate: $vibrate, ')
          ..write('volumeRamp: $volumeRamp, ')
          ..write('snoozeMinutes: $snoozeMinutes, ')
          ..write('maxSnoozeCount: $maxSnoozeCount, ')
          ..write('enabled: $enabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShiftAlarmTemplatesTable extends ShiftAlarmTemplates
    with TableInfo<$ShiftAlarmTemplatesTable, ShiftAlarmTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShiftAlarmTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shiftTemplateIdMeta = const VerificationMeta(
    'shiftTemplateId',
  );
  @override
  late final GeneratedColumn<String> shiftTemplateId = GeneratedColumn<String>(
    'shift_template_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES shift_templates (id)',
    ),
  );
  static const VerificationMeta _alarmTemplateIdMeta = const VerificationMeta(
    'alarmTemplateId',
  );
  @override
  late final GeneratedColumn<String> alarmTemplateId = GeneratedColumn<String>(
    'alarm_template_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES alarm_templates (id)',
    ),
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shiftTemplateId,
    alarmTemplateId,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shift_alarm_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShiftAlarmTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shift_template_id')) {
      context.handle(
        _shiftTemplateIdMeta,
        shiftTemplateId.isAcceptableOrUnknown(
          data['shift_template_id']!,
          _shiftTemplateIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_shiftTemplateIdMeta);
    }
    if (data.containsKey('alarm_template_id')) {
      context.handle(
        _alarmTemplateIdMeta,
        alarmTemplateId.isAcceptableOrUnknown(
          data['alarm_template_id']!,
          _alarmTemplateIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_alarmTemplateIdMeta);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShiftAlarmTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShiftAlarmTemplate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shiftTemplateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shift_template_id'],
      )!,
      alarmTemplateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alarm_template_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ShiftAlarmTemplatesTable createAlias(String alias) {
    return $ShiftAlarmTemplatesTable(attachedDatabase, alias);
  }
}

class ShiftAlarmTemplate extends DataClass
    implements Insertable<ShiftAlarmTemplate> {
  final String id;
  final String shiftTemplateId;
  final String alarmTemplateId;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  const ShiftAlarmTemplate({
    required this.id,
    required this.shiftTemplateId,
    required this.alarmTemplateId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shift_template_id'] = Variable<String>(shiftTemplateId);
    map['alarm_template_id'] = Variable<String>(alarmTemplateId);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  ShiftAlarmTemplatesCompanion toCompanion(bool nullToAbsent) {
    return ShiftAlarmTemplatesCompanion(
      id: Value(id),
      shiftTemplateId: Value(shiftTemplateId),
      alarmTemplateId: Value(alarmTemplateId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ShiftAlarmTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShiftAlarmTemplate(
      id: serializer.fromJson<String>(json['id']),
      shiftTemplateId: serializer.fromJson<String>(json['shiftTemplateId']),
      alarmTemplateId: serializer.fromJson<String>(json['alarmTemplateId']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shiftTemplateId': serializer.toJson<String>(shiftTemplateId),
      'alarmTemplateId': serializer.toJson<String>(alarmTemplateId),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  ShiftAlarmTemplate copyWith({
    String? id,
    String? shiftTemplateId,
    String? alarmTemplateId,
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => ShiftAlarmTemplate(
    id: id ?? this.id,
    shiftTemplateId: shiftTemplateId ?? this.shiftTemplateId,
    alarmTemplateId: alarmTemplateId ?? this.alarmTemplateId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  ShiftAlarmTemplate copyWithCompanion(ShiftAlarmTemplatesCompanion data) {
    return ShiftAlarmTemplate(
      id: data.id.present ? data.id.value : this.id,
      shiftTemplateId: data.shiftTemplateId.present
          ? data.shiftTemplateId.value
          : this.shiftTemplateId,
      alarmTemplateId: data.alarmTemplateId.present
          ? data.alarmTemplateId.value
          : this.alarmTemplateId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShiftAlarmTemplate(')
          ..write('id: $id, ')
          ..write('shiftTemplateId: $shiftTemplateId, ')
          ..write('alarmTemplateId: $alarmTemplateId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shiftTemplateId,
    alarmTemplateId,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShiftAlarmTemplate &&
          other.id == this.id &&
          other.shiftTemplateId == this.shiftTemplateId &&
          other.alarmTemplateId == this.alarmTemplateId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class ShiftAlarmTemplatesCompanion extends UpdateCompanion<ShiftAlarmTemplate> {
  final Value<String> id;
  final Value<String> shiftTemplateId;
  final Value<String> alarmTemplateId;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const ShiftAlarmTemplatesCompanion({
    this.id = const Value.absent(),
    this.shiftTemplateId = const Value.absent(),
    this.alarmTemplateId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShiftAlarmTemplatesCompanion.insert({
    required String id,
    required String shiftTemplateId,
    required String alarmTemplateId,
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shiftTemplateId = Value(shiftTemplateId),
       alarmTemplateId = Value(alarmTemplateId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ShiftAlarmTemplate> custom({
    Expression<String>? id,
    Expression<String>? shiftTemplateId,
    Expression<String>? alarmTemplateId,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shiftTemplateId != null) 'shift_template_id': shiftTemplateId,
      if (alarmTemplateId != null) 'alarm_template_id': alarmTemplateId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShiftAlarmTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? shiftTemplateId,
    Value<String>? alarmTemplateId,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ShiftAlarmTemplatesCompanion(
      id: id ?? this.id,
      shiftTemplateId: shiftTemplateId ?? this.shiftTemplateId,
      alarmTemplateId: alarmTemplateId ?? this.alarmTemplateId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shiftTemplateId.present) {
      map['shift_template_id'] = Variable<String>(shiftTemplateId.value);
    }
    if (alarmTemplateId.present) {
      map['alarm_template_id'] = Variable<String>(alarmTemplateId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShiftAlarmTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('shiftTemplateId: $shiftTemplateId, ')
          ..write('alarmTemplateId: $alarmTemplateId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlarmInstancesTable extends AlarmInstances
    with TableInfo<$AlarmInstancesTable, AlarmInstance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmInstancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES alarm_templates (id)',
    ),
  );
  static const VerificationMeta _scheduleDateMeta = const VerificationMeta(
    'scheduleDate',
  );
  @override
  late final GeneratedColumn<String> scheduleDate = GeneratedColumn<String>(
    'schedule_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _triggerAtMeta = const VerificationMeta(
    'triggerAt',
  );
  @override
  late final GeneratedColumn<int> triggerAt = GeneratedColumn<int>(
    'trigger_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shiftIdMeta = const VerificationMeta(
    'shiftId',
  );
  @override
  late final GeneratedColumn<String> shiftId = GeneratedColumn<String>(
    'shift_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lockedMeta = const VerificationMeta('locked');
  @override
  late final GeneratedColumn<int> locked = GeneratedColumn<int>(
    'locked',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _platformAlarmIdMeta = const VerificationMeta(
    'platformAlarmId',
  );
  @override
  late final GeneratedColumn<String> platformAlarmId = GeneratedColumn<String>(
    'platform_alarm_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
  static const VerificationMeta _payloadHashMeta = const VerificationMeta(
    'payloadHash',
  );
  @override
  late final GeneratedColumn<String> payloadHash = GeneratedColumn<String>(
    'payload_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(0),
  );
  static const VerificationMeta _nextRetryAtMeta = const VerificationMeta(
    'nextRetryAt',
  );
  @override
  late final GeneratedColumn<int> nextRetryAt = GeneratedColumn<int>(
    'next_retry_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    templateId,
    scheduleDate,
    triggerAt,
    shiftId,
    locked,
    platformAlarmId,
    status,
    payloadHash,
    errorCode,
    retryCount,
    nextRetryAt,
    lastSyncedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarm_instances';
  @override
  VerificationContext validateIntegrity(
    Insertable<AlarmInstance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('schedule_date')) {
      context.handle(
        _scheduleDateMeta,
        scheduleDate.isAcceptableOrUnknown(
          data['schedule_date']!,
          _scheduleDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduleDateMeta);
    }
    if (data.containsKey('trigger_at')) {
      context.handle(
        _triggerAtMeta,
        triggerAt.isAcceptableOrUnknown(data['trigger_at']!, _triggerAtMeta),
      );
    } else if (isInserting) {
      context.missing(_triggerAtMeta);
    }
    if (data.containsKey('shift_id')) {
      context.handle(
        _shiftIdMeta,
        shiftId.isAcceptableOrUnknown(data['shift_id']!, _shiftIdMeta),
      );
    }
    if (data.containsKey('locked')) {
      context.handle(
        _lockedMeta,
        locked.isAcceptableOrUnknown(data['locked']!, _lockedMeta),
      );
    } else if (isInserting) {
      context.missing(_lockedMeta);
    }
    if (data.containsKey('platform_alarm_id')) {
      context.handle(
        _platformAlarmIdMeta,
        platformAlarmId.isAcceptableOrUnknown(
          data['platform_alarm_id']!,
          _platformAlarmIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_platformAlarmIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('payload_hash')) {
      context.handle(
        _payloadHashMeta,
        payloadHash.isAcceptableOrUnknown(
          data['payload_hash']!,
          _payloadHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadHashMeta);
    }
    if (data.containsKey('error_code')) {
      context.handle(
        _errorCodeMeta,
        errorCode.isAcceptableOrUnknown(data['error_code']!, _errorCodeMeta),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('next_retry_at')) {
      context.handle(
        _nextRetryAtMeta,
        nextRetryAt.isAcceptableOrUnknown(
          data['next_retry_at']!,
          _nextRetryAtMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
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
  AlarmInstance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlarmInstance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      )!,
      scheduleDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schedule_date'],
      )!,
      triggerAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trigger_at'],
      )!,
      shiftId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shift_id'],
      ),
      locked: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}locked'],
      )!,
      platformAlarmId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform_alarm_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      payloadHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_hash'],
      )!,
      errorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_code'],
      ),
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      nextRetryAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_retry_at'],
      ),
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_synced_at'],
      ),
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
  $AlarmInstancesTable createAlias(String alias) {
    return $AlarmInstancesTable(attachedDatabase, alias);
  }
}

class AlarmInstance extends DataClass implements Insertable<AlarmInstance> {
  final String id;
  final String templateId;
  final String scheduleDate;
  final int triggerAt;
  final String? shiftId;
  final int locked;
  final String platformAlarmId;
  final String status;
  final String payloadHash;
  final String? errorCode;
  final int retryCount;
  final int? nextRetryAt;
  final int? lastSyncedAt;
  final int createdAt;
  final int updatedAt;
  const AlarmInstance({
    required this.id,
    required this.templateId,
    required this.scheduleDate,
    required this.triggerAt,
    this.shiftId,
    required this.locked,
    required this.platformAlarmId,
    required this.status,
    required this.payloadHash,
    this.errorCode,
    required this.retryCount,
    this.nextRetryAt,
    this.lastSyncedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['template_id'] = Variable<String>(templateId);
    map['schedule_date'] = Variable<String>(scheduleDate);
    map['trigger_at'] = Variable<int>(triggerAt);
    if (!nullToAbsent || shiftId != null) {
      map['shift_id'] = Variable<String>(shiftId);
    }
    map['locked'] = Variable<int>(locked);
    map['platform_alarm_id'] = Variable<String>(platformAlarmId);
    map['status'] = Variable<String>(status);
    map['payload_hash'] = Variable<String>(payloadHash);
    if (!nullToAbsent || errorCode != null) {
      map['error_code'] = Variable<String>(errorCode);
    }
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || nextRetryAt != null) {
      map['next_retry_at'] = Variable<int>(nextRetryAt);
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  AlarmInstancesCompanion toCompanion(bool nullToAbsent) {
    return AlarmInstancesCompanion(
      id: Value(id),
      templateId: Value(templateId),
      scheduleDate: Value(scheduleDate),
      triggerAt: Value(triggerAt),
      shiftId: shiftId == null && nullToAbsent
          ? const Value.absent()
          : Value(shiftId),
      locked: Value(locked),
      platformAlarmId: Value(platformAlarmId),
      status: Value(status),
      payloadHash: Value(payloadHash),
      errorCode: errorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(errorCode),
      retryCount: Value(retryCount),
      nextRetryAt: nextRetryAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextRetryAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AlarmInstance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlarmInstance(
      id: serializer.fromJson<String>(json['id']),
      templateId: serializer.fromJson<String>(json['templateId']),
      scheduleDate: serializer.fromJson<String>(json['scheduleDate']),
      triggerAt: serializer.fromJson<int>(json['triggerAt']),
      shiftId: serializer.fromJson<String?>(json['shiftId']),
      locked: serializer.fromJson<int>(json['locked']),
      platformAlarmId: serializer.fromJson<String>(json['platformAlarmId']),
      status: serializer.fromJson<String>(json['status']),
      payloadHash: serializer.fromJson<String>(json['payloadHash']),
      errorCode: serializer.fromJson<String?>(json['errorCode']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      nextRetryAt: serializer.fromJson<int?>(json['nextRetryAt']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'templateId': serializer.toJson<String>(templateId),
      'scheduleDate': serializer.toJson<String>(scheduleDate),
      'triggerAt': serializer.toJson<int>(triggerAt),
      'shiftId': serializer.toJson<String?>(shiftId),
      'locked': serializer.toJson<int>(locked),
      'platformAlarmId': serializer.toJson<String>(platformAlarmId),
      'status': serializer.toJson<String>(status),
      'payloadHash': serializer.toJson<String>(payloadHash),
      'errorCode': serializer.toJson<String?>(errorCode),
      'retryCount': serializer.toJson<int>(retryCount),
      'nextRetryAt': serializer.toJson<int?>(nextRetryAt),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  AlarmInstance copyWith({
    String? id,
    String? templateId,
    String? scheduleDate,
    int? triggerAt,
    Value<String?> shiftId = const Value.absent(),
    int? locked,
    String? platformAlarmId,
    String? status,
    String? payloadHash,
    Value<String?> errorCode = const Value.absent(),
    int? retryCount,
    Value<int?> nextRetryAt = const Value.absent(),
    Value<int?> lastSyncedAt = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => AlarmInstance(
    id: id ?? this.id,
    templateId: templateId ?? this.templateId,
    scheduleDate: scheduleDate ?? this.scheduleDate,
    triggerAt: triggerAt ?? this.triggerAt,
    shiftId: shiftId.present ? shiftId.value : this.shiftId,
    locked: locked ?? this.locked,
    platformAlarmId: platformAlarmId ?? this.platformAlarmId,
    status: status ?? this.status,
    payloadHash: payloadHash ?? this.payloadHash,
    errorCode: errorCode.present ? errorCode.value : this.errorCode,
    retryCount: retryCount ?? this.retryCount,
    nextRetryAt: nextRetryAt.present ? nextRetryAt.value : this.nextRetryAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AlarmInstance copyWithCompanion(AlarmInstancesCompanion data) {
    return AlarmInstance(
      id: data.id.present ? data.id.value : this.id,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      scheduleDate: data.scheduleDate.present
          ? data.scheduleDate.value
          : this.scheduleDate,
      triggerAt: data.triggerAt.present ? data.triggerAt.value : this.triggerAt,
      shiftId: data.shiftId.present ? data.shiftId.value : this.shiftId,
      locked: data.locked.present ? data.locked.value : this.locked,
      platformAlarmId: data.platformAlarmId.present
          ? data.platformAlarmId.value
          : this.platformAlarmId,
      status: data.status.present ? data.status.value : this.status,
      payloadHash: data.payloadHash.present
          ? data.payloadHash.value
          : this.payloadHash,
      errorCode: data.errorCode.present ? data.errorCode.value : this.errorCode,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      nextRetryAt: data.nextRetryAt.present
          ? data.nextRetryAt.value
          : this.nextRetryAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlarmInstance(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('scheduleDate: $scheduleDate, ')
          ..write('triggerAt: $triggerAt, ')
          ..write('shiftId: $shiftId, ')
          ..write('locked: $locked, ')
          ..write('platformAlarmId: $platformAlarmId, ')
          ..write('status: $status, ')
          ..write('payloadHash: $payloadHash, ')
          ..write('errorCode: $errorCode, ')
          ..write('retryCount: $retryCount, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    templateId,
    scheduleDate,
    triggerAt,
    shiftId,
    locked,
    platformAlarmId,
    status,
    payloadHash,
    errorCode,
    retryCount,
    nextRetryAt,
    lastSyncedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlarmInstance &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.scheduleDate == this.scheduleDate &&
          other.triggerAt == this.triggerAt &&
          other.shiftId == this.shiftId &&
          other.locked == this.locked &&
          other.platformAlarmId == this.platformAlarmId &&
          other.status == this.status &&
          other.payloadHash == this.payloadHash &&
          other.errorCode == this.errorCode &&
          other.retryCount == this.retryCount &&
          other.nextRetryAt == this.nextRetryAt &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AlarmInstancesCompanion extends UpdateCompanion<AlarmInstance> {
  final Value<String> id;
  final Value<String> templateId;
  final Value<String> scheduleDate;
  final Value<int> triggerAt;
  final Value<String?> shiftId;
  final Value<int> locked;
  final Value<String> platformAlarmId;
  final Value<String> status;
  final Value<String> payloadHash;
  final Value<String?> errorCode;
  final Value<int> retryCount;
  final Value<int?> nextRetryAt;
  final Value<int?> lastSyncedAt;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const AlarmInstancesCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.scheduleDate = const Value.absent(),
    this.triggerAt = const Value.absent(),
    this.shiftId = const Value.absent(),
    this.locked = const Value.absent(),
    this.platformAlarmId = const Value.absent(),
    this.status = const Value.absent(),
    this.payloadHash = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlarmInstancesCompanion.insert({
    required String id,
    required String templateId,
    required String scheduleDate,
    required int triggerAt,
    this.shiftId = const Value.absent(),
    required int locked,
    required String platformAlarmId,
    required String status,
    required String payloadHash,
    this.errorCode = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       templateId = Value(templateId),
       scheduleDate = Value(scheduleDate),
       triggerAt = Value(triggerAt),
       locked = Value(locked),
       platformAlarmId = Value(platformAlarmId),
       status = Value(status),
       payloadHash = Value(payloadHash),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AlarmInstance> custom({
    Expression<String>? id,
    Expression<String>? templateId,
    Expression<String>? scheduleDate,
    Expression<int>? triggerAt,
    Expression<String>? shiftId,
    Expression<int>? locked,
    Expression<String>? platformAlarmId,
    Expression<String>? status,
    Expression<String>? payloadHash,
    Expression<String>? errorCode,
    Expression<int>? retryCount,
    Expression<int>? nextRetryAt,
    Expression<int>? lastSyncedAt,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (scheduleDate != null) 'schedule_date': scheduleDate,
      if (triggerAt != null) 'trigger_at': triggerAt,
      if (shiftId != null) 'shift_id': shiftId,
      if (locked != null) 'locked': locked,
      if (platformAlarmId != null) 'platform_alarm_id': platformAlarmId,
      if (status != null) 'status': status,
      if (payloadHash != null) 'payload_hash': payloadHash,
      if (errorCode != null) 'error_code': errorCode,
      if (retryCount != null) 'retry_count': retryCount,
      if (nextRetryAt != null) 'next_retry_at': nextRetryAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlarmInstancesCompanion copyWith({
    Value<String>? id,
    Value<String>? templateId,
    Value<String>? scheduleDate,
    Value<int>? triggerAt,
    Value<String?>? shiftId,
    Value<int>? locked,
    Value<String>? platformAlarmId,
    Value<String>? status,
    Value<String>? payloadHash,
    Value<String?>? errorCode,
    Value<int>? retryCount,
    Value<int?>? nextRetryAt,
    Value<int?>? lastSyncedAt,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return AlarmInstancesCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      scheduleDate: scheduleDate ?? this.scheduleDate,
      triggerAt: triggerAt ?? this.triggerAt,
      shiftId: shiftId ?? this.shiftId,
      locked: locked ?? this.locked,
      platformAlarmId: platformAlarmId ?? this.platformAlarmId,
      status: status ?? this.status,
      payloadHash: payloadHash ?? this.payloadHash,
      errorCode: errorCode ?? this.errorCode,
      retryCount: retryCount ?? this.retryCount,
      nextRetryAt: nextRetryAt ?? this.nextRetryAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
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
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (scheduleDate.present) {
      map['schedule_date'] = Variable<String>(scheduleDate.value);
    }
    if (triggerAt.present) {
      map['trigger_at'] = Variable<int>(triggerAt.value);
    }
    if (shiftId.present) {
      map['shift_id'] = Variable<String>(shiftId.value);
    }
    if (locked.present) {
      map['locked'] = Variable<int>(locked.value);
    }
    if (platformAlarmId.present) {
      map['platform_alarm_id'] = Variable<String>(platformAlarmId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (payloadHash.present) {
      map['payload_hash'] = Variable<String>(payloadHash.value);
    }
    if (errorCode.present) {
      map['error_code'] = Variable<String>(errorCode.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (nextRetryAt.present) {
      map['next_retry_at'] = Variable<int>(nextRetryAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
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
    return (StringBuffer('AlarmInstancesCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('scheduleDate: $scheduleDate, ')
          ..write('triggerAt: $triggerAt, ')
          ..write('shiftId: $shiftId, ')
          ..write('locked: $locked, ')
          ..write('platformAlarmId: $platformAlarmId, ')
          ..write('status: $status, ')
          ..write('payloadHash: $payloadHash, ')
          ..write('errorCode: $errorCode, ')
          ..write('retryCount: $retryCount, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttendanceRecordsTable extends AttendanceRecords
    with TableInfo<$AttendanceRecordsTable, AttendanceRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workDateMeta = const VerificationMeta(
    'workDate',
  );
  @override
  late final GeneratedColumn<String> workDate = GeneratedColumn<String>(
    'work_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clockInAtMeta = const VerificationMeta(
    'clockInAt',
  );
  @override
  late final GeneratedColumn<int> clockInAt = GeneratedColumn<int>(
    'clock_in_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clockOutAtMeta = const VerificationMeta(
    'clockOutAt',
  );
  @override
  late final GeneratedColumn<int> clockOutAt = GeneratedColumn<int>(
    'clock_out_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unpaidBreakMinutesMeta =
      const VerificationMeta('unpaidBreakMinutes');
  @override
  late final GeneratedColumn<int> unpaidBreakMinutes = GeneratedColumn<int>(
    'unpaid_break_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _editReasonMeta = const VerificationMeta(
    'editReason',
  );
  @override
  late final GeneratedColumn<String> editReason = GeneratedColumn<String>(
    'edit_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _createdTimezoneMeta = const VerificationMeta(
    'createdTimezone',
  );
  @override
  late final GeneratedColumn<String> createdTimezone = GeneratedColumn<String>(
    'created_timezone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confirmedMeta = const VerificationMeta(
    'confirmed',
  );
  @override
  late final GeneratedColumn<int> confirmed = GeneratedColumn<int>(
    'confirmed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(0),
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workDate,
    clockInAt,
    clockOutAt,
    unpaidBreakMinutes,
    source,
    status,
    editReason,
    note,
    createdTimezone,
    confirmed,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('work_date')) {
      context.handle(
        _workDateMeta,
        workDate.isAcceptableOrUnknown(data['work_date']!, _workDateMeta),
      );
    } else if (isInserting) {
      context.missing(_workDateMeta);
    }
    if (data.containsKey('clock_in_at')) {
      context.handle(
        _clockInAtMeta,
        clockInAt.isAcceptableOrUnknown(data['clock_in_at']!, _clockInAtMeta),
      );
    }
    if (data.containsKey('clock_out_at')) {
      context.handle(
        _clockOutAtMeta,
        clockOutAt.isAcceptableOrUnknown(
          data['clock_out_at']!,
          _clockOutAtMeta,
        ),
      );
    }
    if (data.containsKey('unpaid_break_minutes')) {
      context.handle(
        _unpaidBreakMinutesMeta,
        unpaidBreakMinutes.isAcceptableOrUnknown(
          data['unpaid_break_minutes']!,
          _unpaidBreakMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unpaidBreakMinutesMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('edit_reason')) {
      context.handle(
        _editReasonMeta,
        editReason.isAcceptableOrUnknown(data['edit_reason']!, _editReasonMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_timezone')) {
      context.handle(
        _createdTimezoneMeta,
        createdTimezone.isAcceptableOrUnknown(
          data['created_timezone']!,
          _createdTimezoneMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdTimezoneMeta);
    }
    if (data.containsKey('confirmed')) {
      context.handle(
        _confirmedMeta,
        confirmed.isAcceptableOrUnknown(data['confirmed']!, _confirmedMeta),
      );
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttendanceRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_date'],
      )!,
      clockInAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}clock_in_at'],
      ),
      clockOutAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}clock_out_at'],
      ),
      unpaidBreakMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unpaid_break_minutes'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      editReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}edit_reason'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdTimezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_timezone'],
      )!,
      confirmed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confirmed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $AttendanceRecordsTable createAlias(String alias) {
    return $AttendanceRecordsTable(attachedDatabase, alias);
  }
}

class AttendanceRecord extends DataClass
    implements Insertable<AttendanceRecord> {
  final String id;
  final String workDate;
  final int? clockInAt;
  final int? clockOutAt;
  final int unpaidBreakMinutes;
  final String source;
  final String status;
  final String? editReason;
  final String? note;
  final String createdTimezone;
  final int confirmed;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  const AttendanceRecord({
    required this.id,
    required this.workDate,
    this.clockInAt,
    this.clockOutAt,
    required this.unpaidBreakMinutes,
    required this.source,
    required this.status,
    this.editReason,
    this.note,
    required this.createdTimezone,
    required this.confirmed,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['work_date'] = Variable<String>(workDate);
    if (!nullToAbsent || clockInAt != null) {
      map['clock_in_at'] = Variable<int>(clockInAt);
    }
    if (!nullToAbsent || clockOutAt != null) {
      map['clock_out_at'] = Variable<int>(clockOutAt);
    }
    map['unpaid_break_minutes'] = Variable<int>(unpaidBreakMinutes);
    map['source'] = Variable<String>(source);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || editReason != null) {
      map['edit_reason'] = Variable<String>(editReason);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_timezone'] = Variable<String>(createdTimezone);
    map['confirmed'] = Variable<int>(confirmed);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  AttendanceRecordsCompanion toCompanion(bool nullToAbsent) {
    return AttendanceRecordsCompanion(
      id: Value(id),
      workDate: Value(workDate),
      clockInAt: clockInAt == null && nullToAbsent
          ? const Value.absent()
          : Value(clockInAt),
      clockOutAt: clockOutAt == null && nullToAbsent
          ? const Value.absent()
          : Value(clockOutAt),
      unpaidBreakMinutes: Value(unpaidBreakMinutes),
      source: Value(source),
      status: Value(status),
      editReason: editReason == null && nullToAbsent
          ? const Value.absent()
          : Value(editReason),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdTimezone: Value(createdTimezone),
      confirmed: Value(confirmed),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory AttendanceRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceRecord(
      id: serializer.fromJson<String>(json['id']),
      workDate: serializer.fromJson<String>(json['workDate']),
      clockInAt: serializer.fromJson<int?>(json['clockInAt']),
      clockOutAt: serializer.fromJson<int?>(json['clockOutAt']),
      unpaidBreakMinutes: serializer.fromJson<int>(json['unpaidBreakMinutes']),
      source: serializer.fromJson<String>(json['source']),
      status: serializer.fromJson<String>(json['status']),
      editReason: serializer.fromJson<String?>(json['editReason']),
      note: serializer.fromJson<String?>(json['note']),
      createdTimezone: serializer.fromJson<String>(json['createdTimezone']),
      confirmed: serializer.fromJson<int>(json['confirmed']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workDate': serializer.toJson<String>(workDate),
      'clockInAt': serializer.toJson<int?>(clockInAt),
      'clockOutAt': serializer.toJson<int?>(clockOutAt),
      'unpaidBreakMinutes': serializer.toJson<int>(unpaidBreakMinutes),
      'source': serializer.toJson<String>(source),
      'status': serializer.toJson<String>(status),
      'editReason': serializer.toJson<String?>(editReason),
      'note': serializer.toJson<String?>(note),
      'createdTimezone': serializer.toJson<String>(createdTimezone),
      'confirmed': serializer.toJson<int>(confirmed),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  AttendanceRecord copyWith({
    String? id,
    String? workDate,
    Value<int?> clockInAt = const Value.absent(),
    Value<int?> clockOutAt = const Value.absent(),
    int? unpaidBreakMinutes,
    String? source,
    String? status,
    Value<String?> editReason = const Value.absent(),
    Value<String?> note = const Value.absent(),
    String? createdTimezone,
    int? confirmed,
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => AttendanceRecord(
    id: id ?? this.id,
    workDate: workDate ?? this.workDate,
    clockInAt: clockInAt.present ? clockInAt.value : this.clockInAt,
    clockOutAt: clockOutAt.present ? clockOutAt.value : this.clockOutAt,
    unpaidBreakMinutes: unpaidBreakMinutes ?? this.unpaidBreakMinutes,
    source: source ?? this.source,
    status: status ?? this.status,
    editReason: editReason.present ? editReason.value : this.editReason,
    note: note.present ? note.value : this.note,
    createdTimezone: createdTimezone ?? this.createdTimezone,
    confirmed: confirmed ?? this.confirmed,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  AttendanceRecord copyWithCompanion(AttendanceRecordsCompanion data) {
    return AttendanceRecord(
      id: data.id.present ? data.id.value : this.id,
      workDate: data.workDate.present ? data.workDate.value : this.workDate,
      clockInAt: data.clockInAt.present ? data.clockInAt.value : this.clockInAt,
      clockOutAt: data.clockOutAt.present
          ? data.clockOutAt.value
          : this.clockOutAt,
      unpaidBreakMinutes: data.unpaidBreakMinutes.present
          ? data.unpaidBreakMinutes.value
          : this.unpaidBreakMinutes,
      source: data.source.present ? data.source.value : this.source,
      status: data.status.present ? data.status.value : this.status,
      editReason: data.editReason.present
          ? data.editReason.value
          : this.editReason,
      note: data.note.present ? data.note.value : this.note,
      createdTimezone: data.createdTimezone.present
          ? data.createdTimezone.value
          : this.createdTimezone,
      confirmed: data.confirmed.present ? data.confirmed.value : this.confirmed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceRecord(')
          ..write('id: $id, ')
          ..write('workDate: $workDate, ')
          ..write('clockInAt: $clockInAt, ')
          ..write('clockOutAt: $clockOutAt, ')
          ..write('unpaidBreakMinutes: $unpaidBreakMinutes, ')
          ..write('source: $source, ')
          ..write('status: $status, ')
          ..write('editReason: $editReason, ')
          ..write('note: $note, ')
          ..write('createdTimezone: $createdTimezone, ')
          ..write('confirmed: $confirmed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workDate,
    clockInAt,
    clockOutAt,
    unpaidBreakMinutes,
    source,
    status,
    editReason,
    note,
    createdTimezone,
    confirmed,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceRecord &&
          other.id == this.id &&
          other.workDate == this.workDate &&
          other.clockInAt == this.clockInAt &&
          other.clockOutAt == this.clockOutAt &&
          other.unpaidBreakMinutes == this.unpaidBreakMinutes &&
          other.source == this.source &&
          other.status == this.status &&
          other.editReason == this.editReason &&
          other.note == this.note &&
          other.createdTimezone == this.createdTimezone &&
          other.confirmed == this.confirmed &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class AttendanceRecordsCompanion extends UpdateCompanion<AttendanceRecord> {
  final Value<String> id;
  final Value<String> workDate;
  final Value<int?> clockInAt;
  final Value<int?> clockOutAt;
  final Value<int> unpaidBreakMinutes;
  final Value<String> source;
  final Value<String> status;
  final Value<String?> editReason;
  final Value<String?> note;
  final Value<String> createdTimezone;
  final Value<int> confirmed;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const AttendanceRecordsCompanion({
    this.id = const Value.absent(),
    this.workDate = const Value.absent(),
    this.clockInAt = const Value.absent(),
    this.clockOutAt = const Value.absent(),
    this.unpaidBreakMinutes = const Value.absent(),
    this.source = const Value.absent(),
    this.status = const Value.absent(),
    this.editReason = const Value.absent(),
    this.note = const Value.absent(),
    this.createdTimezone = const Value.absent(),
    this.confirmed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttendanceRecordsCompanion.insert({
    required String id,
    required String workDate,
    this.clockInAt = const Value.absent(),
    this.clockOutAt = const Value.absent(),
    required int unpaidBreakMinutes,
    required String source,
    required String status,
    this.editReason = const Value.absent(),
    this.note = const Value.absent(),
    required String createdTimezone,
    this.confirmed = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workDate = Value(workDate),
       unpaidBreakMinutes = Value(unpaidBreakMinutes),
       source = Value(source),
       status = Value(status),
       createdTimezone = Value(createdTimezone),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AttendanceRecord> custom({
    Expression<String>? id,
    Expression<String>? workDate,
    Expression<int>? clockInAt,
    Expression<int>? clockOutAt,
    Expression<int>? unpaidBreakMinutes,
    Expression<String>? source,
    Expression<String>? status,
    Expression<String>? editReason,
    Expression<String>? note,
    Expression<String>? createdTimezone,
    Expression<int>? confirmed,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workDate != null) 'work_date': workDate,
      if (clockInAt != null) 'clock_in_at': clockInAt,
      if (clockOutAt != null) 'clock_out_at': clockOutAt,
      if (unpaidBreakMinutes != null)
        'unpaid_break_minutes': unpaidBreakMinutes,
      if (source != null) 'source': source,
      if (status != null) 'status': status,
      if (editReason != null) 'edit_reason': editReason,
      if (note != null) 'note': note,
      if (createdTimezone != null) 'created_timezone': createdTimezone,
      if (confirmed != null) 'confirmed': confirmed,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttendanceRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? workDate,
    Value<int?>? clockInAt,
    Value<int?>? clockOutAt,
    Value<int>? unpaidBreakMinutes,
    Value<String>? source,
    Value<String>? status,
    Value<String?>? editReason,
    Value<String?>? note,
    Value<String>? createdTimezone,
    Value<int>? confirmed,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return AttendanceRecordsCompanion(
      id: id ?? this.id,
      workDate: workDate ?? this.workDate,
      clockInAt: clockInAt ?? this.clockInAt,
      clockOutAt: clockOutAt ?? this.clockOutAt,
      unpaidBreakMinutes: unpaidBreakMinutes ?? this.unpaidBreakMinutes,
      source: source ?? this.source,
      status: status ?? this.status,
      editReason: editReason ?? this.editReason,
      note: note ?? this.note,
      createdTimezone: createdTimezone ?? this.createdTimezone,
      confirmed: confirmed ?? this.confirmed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workDate.present) {
      map['work_date'] = Variable<String>(workDate.value);
    }
    if (clockInAt.present) {
      map['clock_in_at'] = Variable<int>(clockInAt.value);
    }
    if (clockOutAt.present) {
      map['clock_out_at'] = Variable<int>(clockOutAt.value);
    }
    if (unpaidBreakMinutes.present) {
      map['unpaid_break_minutes'] = Variable<int>(unpaidBreakMinutes.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (editReason.present) {
      map['edit_reason'] = Variable<String>(editReason.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdTimezone.present) {
      map['created_timezone'] = Variable<String>(createdTimezone.value);
    }
    if (confirmed.present) {
      map['confirmed'] = Variable<int>(confirmed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceRecordsCompanion(')
          ..write('id: $id, ')
          ..write('workDate: $workDate, ')
          ..write('clockInAt: $clockInAt, ')
          ..write('clockOutAt: $clockOutAt, ')
          ..write('unpaidBreakMinutes: $unpaidBreakMinutes, ')
          ..write('source: $source, ')
          ..write('status: $status, ')
          ..write('editReason: $editReason, ')
          ..write('note: $note, ')
          ..write('createdTimezone: $createdTimezone, ')
          ..write('confirmed: $confirmed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LeaveRecordsTable extends LeaveRecords
    with TableInfo<$LeaveRecordsTable, LeaveRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LeaveRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workDateMeta = const VerificationMeta(
    'workDate',
  );
  @override
  late final GeneratedColumn<String> workDate = GeneratedColumn<String>(
    'work_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _leaveTypeMeta = const VerificationMeta(
    'leaveType',
  );
  @override
  late final GeneratedColumn<String> leaveType = GeneratedColumn<String>(
    'leave_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<int> startAt = GeneratedColumn<int>(
    'start_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<int> endAt = GeneratedColumn<int>(
    'end_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paidMeta = const VerificationMeta('paid');
  @override
  late final GeneratedColumn<int> paid = GeneratedColumn<int>(
    'paid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deductionMinorMeta = const VerificationMeta(
    'deductionMinor',
  );
  @override
  late final GeneratedColumn<int> deductionMinor = GeneratedColumn<int>(
    'deduction_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workDate,
    leaveType,
    startAt,
    endAt,
    paid,
    deductionMinor,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'leave_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<LeaveRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('work_date')) {
      context.handle(
        _workDateMeta,
        workDate.isAcceptableOrUnknown(data['work_date']!, _workDateMeta),
      );
    } else if (isInserting) {
      context.missing(_workDateMeta);
    }
    if (data.containsKey('leave_type')) {
      context.handle(
        _leaveTypeMeta,
        leaveType.isAcceptableOrUnknown(data['leave_type']!, _leaveTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_leaveTypeMeta);
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    }
    if (data.containsKey('end_at')) {
      context.handle(
        _endAtMeta,
        endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta),
      );
    }
    if (data.containsKey('paid')) {
      context.handle(
        _paidMeta,
        paid.isAcceptableOrUnknown(data['paid']!, _paidMeta),
      );
    } else if (isInserting) {
      context.missing(_paidMeta);
    }
    if (data.containsKey('deduction_minor')) {
      context.handle(
        _deductionMinorMeta,
        deductionMinor.isAcceptableOrUnknown(
          data['deduction_minor']!,
          _deductionMinorMeta,
        ),
      );
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LeaveRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LeaveRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_date'],
      )!,
      leaveType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}leave_type'],
      )!,
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_at'],
      ),
      endAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_at'],
      ),
      paid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paid'],
      )!,
      deductionMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deduction_minor'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $LeaveRecordsTable createAlias(String alias) {
    return $LeaveRecordsTable(attachedDatabase, alias);
  }
}

class LeaveRecord extends DataClass implements Insertable<LeaveRecord> {
  final String id;
  final String workDate;
  final String leaveType;
  final int? startAt;
  final int? endAt;
  final int paid;
  final int? deductionMinor;
  final String? note;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  const LeaveRecord({
    required this.id,
    required this.workDate,
    required this.leaveType,
    this.startAt,
    this.endAt,
    required this.paid,
    this.deductionMinor,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['work_date'] = Variable<String>(workDate);
    map['leave_type'] = Variable<String>(leaveType);
    if (!nullToAbsent || startAt != null) {
      map['start_at'] = Variable<int>(startAt);
    }
    if (!nullToAbsent || endAt != null) {
      map['end_at'] = Variable<int>(endAt);
    }
    map['paid'] = Variable<int>(paid);
    if (!nullToAbsent || deductionMinor != null) {
      map['deduction_minor'] = Variable<int>(deductionMinor);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  LeaveRecordsCompanion toCompanion(bool nullToAbsent) {
    return LeaveRecordsCompanion(
      id: Value(id),
      workDate: Value(workDate),
      leaveType: Value(leaveType),
      startAt: startAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startAt),
      endAt: endAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endAt),
      paid: Value(paid),
      deductionMinor: deductionMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(deductionMinor),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory LeaveRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LeaveRecord(
      id: serializer.fromJson<String>(json['id']),
      workDate: serializer.fromJson<String>(json['workDate']),
      leaveType: serializer.fromJson<String>(json['leaveType']),
      startAt: serializer.fromJson<int?>(json['startAt']),
      endAt: serializer.fromJson<int?>(json['endAt']),
      paid: serializer.fromJson<int>(json['paid']),
      deductionMinor: serializer.fromJson<int?>(json['deductionMinor']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workDate': serializer.toJson<String>(workDate),
      'leaveType': serializer.toJson<String>(leaveType),
      'startAt': serializer.toJson<int?>(startAt),
      'endAt': serializer.toJson<int?>(endAt),
      'paid': serializer.toJson<int>(paid),
      'deductionMinor': serializer.toJson<int?>(deductionMinor),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  LeaveRecord copyWith({
    String? id,
    String? workDate,
    String? leaveType,
    Value<int?> startAt = const Value.absent(),
    Value<int?> endAt = const Value.absent(),
    int? paid,
    Value<int?> deductionMinor = const Value.absent(),
    Value<String?> note = const Value.absent(),
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => LeaveRecord(
    id: id ?? this.id,
    workDate: workDate ?? this.workDate,
    leaveType: leaveType ?? this.leaveType,
    startAt: startAt.present ? startAt.value : this.startAt,
    endAt: endAt.present ? endAt.value : this.endAt,
    paid: paid ?? this.paid,
    deductionMinor: deductionMinor.present
        ? deductionMinor.value
        : this.deductionMinor,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  LeaveRecord copyWithCompanion(LeaveRecordsCompanion data) {
    return LeaveRecord(
      id: data.id.present ? data.id.value : this.id,
      workDate: data.workDate.present ? data.workDate.value : this.workDate,
      leaveType: data.leaveType.present ? data.leaveType.value : this.leaveType,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
      paid: data.paid.present ? data.paid.value : this.paid,
      deductionMinor: data.deductionMinor.present
          ? data.deductionMinor.value
          : this.deductionMinor,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LeaveRecord(')
          ..write('id: $id, ')
          ..write('workDate: $workDate, ')
          ..write('leaveType: $leaveType, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('paid: $paid, ')
          ..write('deductionMinor: $deductionMinor, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workDate,
    leaveType,
    startAt,
    endAt,
    paid,
    deductionMinor,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LeaveRecord &&
          other.id == this.id &&
          other.workDate == this.workDate &&
          other.leaveType == this.leaveType &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt &&
          other.paid == this.paid &&
          other.deductionMinor == this.deductionMinor &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class LeaveRecordsCompanion extends UpdateCompanion<LeaveRecord> {
  final Value<String> id;
  final Value<String> workDate;
  final Value<String> leaveType;
  final Value<int?> startAt;
  final Value<int?> endAt;
  final Value<int> paid;
  final Value<int?> deductionMinor;
  final Value<String?> note;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const LeaveRecordsCompanion({
    this.id = const Value.absent(),
    this.workDate = const Value.absent(),
    this.leaveType = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    this.paid = const Value.absent(),
    this.deductionMinor = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LeaveRecordsCompanion.insert({
    required String id,
    required String workDate,
    required String leaveType,
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    required int paid,
    this.deductionMinor = const Value.absent(),
    this.note = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workDate = Value(workDate),
       leaveType = Value(leaveType),
       paid = Value(paid),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LeaveRecord> custom({
    Expression<String>? id,
    Expression<String>? workDate,
    Expression<String>? leaveType,
    Expression<int>? startAt,
    Expression<int>? endAt,
    Expression<int>? paid,
    Expression<int>? deductionMinor,
    Expression<String>? note,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workDate != null) 'work_date': workDate,
      if (leaveType != null) 'leave_type': leaveType,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
      if (paid != null) 'paid': paid,
      if (deductionMinor != null) 'deduction_minor': deductionMinor,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LeaveRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? workDate,
    Value<String>? leaveType,
    Value<int?>? startAt,
    Value<int?>? endAt,
    Value<int>? paid,
    Value<int?>? deductionMinor,
    Value<String?>? note,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return LeaveRecordsCompanion(
      id: id ?? this.id,
      workDate: workDate ?? this.workDate,
      leaveType: leaveType ?? this.leaveType,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      paid: paid ?? this.paid,
      deductionMinor: deductionMinor ?? this.deductionMinor,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workDate.present) {
      map['work_date'] = Variable<String>(workDate.value);
    }
    if (leaveType.present) {
      map['leave_type'] = Variable<String>(leaveType.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<int>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<int>(endAt.value);
    }
    if (paid.present) {
      map['paid'] = Variable<int>(paid.value);
    }
    if (deductionMinor.present) {
      map['deduction_minor'] = Variable<int>(deductionMinor.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeaveRecordsCompanion(')
          ..write('id: $id, ')
          ..write('workDate: $workDate, ')
          ..write('leaveType: $leaveType, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('paid: $paid, ')
          ..write('deductionMinor: $deductionMinor, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WageRulesTable extends WageRules
    with TableInfo<$WageRulesTable, WageRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WageRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
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
  static const VerificationMeta _baseRateMinorMeta = const VerificationMeta(
    'baseRateMinor',
  );
  @override
  late final GeneratedColumn<int> baseRateMinor = GeneratedColumn<int>(
    'base_rate_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _overtimeRatesJsonMeta = const VerificationMeta(
    'overtimeRatesJson',
  );
  @override
  late final GeneratedColumn<String> overtimeRatesJson =
      GeneratedColumn<String>(
        'overtime_rates_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _allowanceRulesJsonMeta =
      const VerificationMeta('allowanceRulesJson');
  @override
  late final GeneratedColumn<String> allowanceRulesJson =
      GeneratedColumn<String>(
        'allowance_rules_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _deductionRulesJsonMeta =
      const VerificationMeta('deductionRulesJson');
  @override
  late final GeneratedColumn<String> deductionRulesJson =
      GeneratedColumn<String>(
        'deduction_rules_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _periodStartDayMeta = const VerificationMeta(
    'periodStartDay',
  );
  @override
  late final GeneratedColumn<int> periodStartDay = GeneratedColumn<int>(
    'period_start_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roundingRuleJsonMeta = const VerificationMeta(
    'roundingRuleJson',
  );
  @override
  late final GeneratedColumn<String> roundingRuleJson = GeneratedColumn<String>(
    'rounding_rule_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confirmedOnlyMeta = const VerificationMeta(
    'confirmedOnly',
  );
  @override
  late final GeneratedColumn<int> confirmedOnly = GeneratedColumn<int>(
    'confirmed_only',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(0),
  );
  static const VerificationMeta _effectiveStartMeta = const VerificationMeta(
    'effectiveStart',
  );
  @override
  late final GeneratedColumn<String> effectiveStart = GeneratedColumn<String>(
    'effective_start',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _effectiveEndMeta = const VerificationMeta(
    'effectiveEnd',
  );
  @override
  late final GeneratedColumn<String> effectiveEnd = GeneratedColumn<String>(
    'effective_end',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    mode,
    currency,
    baseRateMinor,
    overtimeRatesJson,
    allowanceRulesJson,
    deductionRulesJson,
    periodStartDay,
    roundingRuleJson,
    confirmedOnly,
    effectiveStart,
    effectiveEnd,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wage_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<WageRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('base_rate_minor')) {
      context.handle(
        _baseRateMinorMeta,
        baseRateMinor.isAcceptableOrUnknown(
          data['base_rate_minor']!,
          _baseRateMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_baseRateMinorMeta);
    }
    if (data.containsKey('overtime_rates_json')) {
      context.handle(
        _overtimeRatesJsonMeta,
        overtimeRatesJson.isAcceptableOrUnknown(
          data['overtime_rates_json']!,
          _overtimeRatesJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_overtimeRatesJsonMeta);
    }
    if (data.containsKey('allowance_rules_json')) {
      context.handle(
        _allowanceRulesJsonMeta,
        allowanceRulesJson.isAcceptableOrUnknown(
          data['allowance_rules_json']!,
          _allowanceRulesJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_allowanceRulesJsonMeta);
    }
    if (data.containsKey('deduction_rules_json')) {
      context.handle(
        _deductionRulesJsonMeta,
        deductionRulesJson.isAcceptableOrUnknown(
          data['deduction_rules_json']!,
          _deductionRulesJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deductionRulesJsonMeta);
    }
    if (data.containsKey('period_start_day')) {
      context.handle(
        _periodStartDayMeta,
        periodStartDay.isAcceptableOrUnknown(
          data['period_start_day']!,
          _periodStartDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_periodStartDayMeta);
    }
    if (data.containsKey('rounding_rule_json')) {
      context.handle(
        _roundingRuleJsonMeta,
        roundingRuleJson.isAcceptableOrUnknown(
          data['rounding_rule_json']!,
          _roundingRuleJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_roundingRuleJsonMeta);
    }
    if (data.containsKey('confirmed_only')) {
      context.handle(
        _confirmedOnlyMeta,
        confirmedOnly.isAcceptableOrUnknown(
          data['confirmed_only']!,
          _confirmedOnlyMeta,
        ),
      );
    }
    if (data.containsKey('effective_start')) {
      context.handle(
        _effectiveStartMeta,
        effectiveStart.isAcceptableOrUnknown(
          data['effective_start']!,
          _effectiveStartMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_effectiveStartMeta);
    }
    if (data.containsKey('effective_end')) {
      context.handle(
        _effectiveEndMeta,
        effectiveEnd.isAcceptableOrUnknown(
          data['effective_end']!,
          _effectiveEndMeta,
        ),
      );
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
  WageRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WageRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      baseRateMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_rate_minor'],
      )!,
      overtimeRatesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}overtime_rates_json'],
      )!,
      allowanceRulesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allowance_rules_json'],
      )!,
      deductionRulesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deduction_rules_json'],
      )!,
      periodStartDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}period_start_day'],
      )!,
      roundingRuleJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rounding_rule_json'],
      )!,
      confirmedOnly: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confirmed_only'],
      )!,
      effectiveStart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effective_start'],
      )!,
      effectiveEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effective_end'],
      ),
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
  $WageRulesTable createAlias(String alias) {
    return $WageRulesTable(attachedDatabase, alias);
  }
}

class WageRule extends DataClass implements Insertable<WageRule> {
  final String id;
  final String mode;
  final String currency;
  final int baseRateMinor;
  final String overtimeRatesJson;
  final String allowanceRulesJson;
  final String deductionRulesJson;
  final int periodStartDay;
  final String roundingRuleJson;
  final int confirmedOnly;
  final String effectiveStart;
  final String? effectiveEnd;
  final int createdAt;
  final int updatedAt;
  const WageRule({
    required this.id,
    required this.mode,
    required this.currency,
    required this.baseRateMinor,
    required this.overtimeRatesJson,
    required this.allowanceRulesJson,
    required this.deductionRulesJson,
    required this.periodStartDay,
    required this.roundingRuleJson,
    required this.confirmedOnly,
    required this.effectiveStart,
    this.effectiveEnd,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['mode'] = Variable<String>(mode);
    map['currency'] = Variable<String>(currency);
    map['base_rate_minor'] = Variable<int>(baseRateMinor);
    map['overtime_rates_json'] = Variable<String>(overtimeRatesJson);
    map['allowance_rules_json'] = Variable<String>(allowanceRulesJson);
    map['deduction_rules_json'] = Variable<String>(deductionRulesJson);
    map['period_start_day'] = Variable<int>(periodStartDay);
    map['rounding_rule_json'] = Variable<String>(roundingRuleJson);
    map['confirmed_only'] = Variable<int>(confirmedOnly);
    map['effective_start'] = Variable<String>(effectiveStart);
    if (!nullToAbsent || effectiveEnd != null) {
      map['effective_end'] = Variable<String>(effectiveEnd);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  WageRulesCompanion toCompanion(bool nullToAbsent) {
    return WageRulesCompanion(
      id: Value(id),
      mode: Value(mode),
      currency: Value(currency),
      baseRateMinor: Value(baseRateMinor),
      overtimeRatesJson: Value(overtimeRatesJson),
      allowanceRulesJson: Value(allowanceRulesJson),
      deductionRulesJson: Value(deductionRulesJson),
      periodStartDay: Value(periodStartDay),
      roundingRuleJson: Value(roundingRuleJson),
      confirmedOnly: Value(confirmedOnly),
      effectiveStart: Value(effectiveStart),
      effectiveEnd: effectiveEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(effectiveEnd),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WageRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WageRule(
      id: serializer.fromJson<String>(json['id']),
      mode: serializer.fromJson<String>(json['mode']),
      currency: serializer.fromJson<String>(json['currency']),
      baseRateMinor: serializer.fromJson<int>(json['baseRateMinor']),
      overtimeRatesJson: serializer.fromJson<String>(json['overtimeRatesJson']),
      allowanceRulesJson: serializer.fromJson<String>(
        json['allowanceRulesJson'],
      ),
      deductionRulesJson: serializer.fromJson<String>(
        json['deductionRulesJson'],
      ),
      periodStartDay: serializer.fromJson<int>(json['periodStartDay']),
      roundingRuleJson: serializer.fromJson<String>(json['roundingRuleJson']),
      confirmedOnly: serializer.fromJson<int>(json['confirmedOnly']),
      effectiveStart: serializer.fromJson<String>(json['effectiveStart']),
      effectiveEnd: serializer.fromJson<String?>(json['effectiveEnd']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'mode': serializer.toJson<String>(mode),
      'currency': serializer.toJson<String>(currency),
      'baseRateMinor': serializer.toJson<int>(baseRateMinor),
      'overtimeRatesJson': serializer.toJson<String>(overtimeRatesJson),
      'allowanceRulesJson': serializer.toJson<String>(allowanceRulesJson),
      'deductionRulesJson': serializer.toJson<String>(deductionRulesJson),
      'periodStartDay': serializer.toJson<int>(periodStartDay),
      'roundingRuleJson': serializer.toJson<String>(roundingRuleJson),
      'confirmedOnly': serializer.toJson<int>(confirmedOnly),
      'effectiveStart': serializer.toJson<String>(effectiveStart),
      'effectiveEnd': serializer.toJson<String?>(effectiveEnd),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  WageRule copyWith({
    String? id,
    String? mode,
    String? currency,
    int? baseRateMinor,
    String? overtimeRatesJson,
    String? allowanceRulesJson,
    String? deductionRulesJson,
    int? periodStartDay,
    String? roundingRuleJson,
    int? confirmedOnly,
    String? effectiveStart,
    Value<String?> effectiveEnd = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => WageRule(
    id: id ?? this.id,
    mode: mode ?? this.mode,
    currency: currency ?? this.currency,
    baseRateMinor: baseRateMinor ?? this.baseRateMinor,
    overtimeRatesJson: overtimeRatesJson ?? this.overtimeRatesJson,
    allowanceRulesJson: allowanceRulesJson ?? this.allowanceRulesJson,
    deductionRulesJson: deductionRulesJson ?? this.deductionRulesJson,
    periodStartDay: periodStartDay ?? this.periodStartDay,
    roundingRuleJson: roundingRuleJson ?? this.roundingRuleJson,
    confirmedOnly: confirmedOnly ?? this.confirmedOnly,
    effectiveStart: effectiveStart ?? this.effectiveStart,
    effectiveEnd: effectiveEnd.present ? effectiveEnd.value : this.effectiveEnd,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WageRule copyWithCompanion(WageRulesCompanion data) {
    return WageRule(
      id: data.id.present ? data.id.value : this.id,
      mode: data.mode.present ? data.mode.value : this.mode,
      currency: data.currency.present ? data.currency.value : this.currency,
      baseRateMinor: data.baseRateMinor.present
          ? data.baseRateMinor.value
          : this.baseRateMinor,
      overtimeRatesJson: data.overtimeRatesJson.present
          ? data.overtimeRatesJson.value
          : this.overtimeRatesJson,
      allowanceRulesJson: data.allowanceRulesJson.present
          ? data.allowanceRulesJson.value
          : this.allowanceRulesJson,
      deductionRulesJson: data.deductionRulesJson.present
          ? data.deductionRulesJson.value
          : this.deductionRulesJson,
      periodStartDay: data.periodStartDay.present
          ? data.periodStartDay.value
          : this.periodStartDay,
      roundingRuleJson: data.roundingRuleJson.present
          ? data.roundingRuleJson.value
          : this.roundingRuleJson,
      confirmedOnly: data.confirmedOnly.present
          ? data.confirmedOnly.value
          : this.confirmedOnly,
      effectiveStart: data.effectiveStart.present
          ? data.effectiveStart.value
          : this.effectiveStart,
      effectiveEnd: data.effectiveEnd.present
          ? data.effectiveEnd.value
          : this.effectiveEnd,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WageRule(')
          ..write('id: $id, ')
          ..write('mode: $mode, ')
          ..write('currency: $currency, ')
          ..write('baseRateMinor: $baseRateMinor, ')
          ..write('overtimeRatesJson: $overtimeRatesJson, ')
          ..write('allowanceRulesJson: $allowanceRulesJson, ')
          ..write('deductionRulesJson: $deductionRulesJson, ')
          ..write('periodStartDay: $periodStartDay, ')
          ..write('roundingRuleJson: $roundingRuleJson, ')
          ..write('confirmedOnly: $confirmedOnly, ')
          ..write('effectiveStart: $effectiveStart, ')
          ..write('effectiveEnd: $effectiveEnd, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mode,
    currency,
    baseRateMinor,
    overtimeRatesJson,
    allowanceRulesJson,
    deductionRulesJson,
    periodStartDay,
    roundingRuleJson,
    confirmedOnly,
    effectiveStart,
    effectiveEnd,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WageRule &&
          other.id == this.id &&
          other.mode == this.mode &&
          other.currency == this.currency &&
          other.baseRateMinor == this.baseRateMinor &&
          other.overtimeRatesJson == this.overtimeRatesJson &&
          other.allowanceRulesJson == this.allowanceRulesJson &&
          other.deductionRulesJson == this.deductionRulesJson &&
          other.periodStartDay == this.periodStartDay &&
          other.roundingRuleJson == this.roundingRuleJson &&
          other.confirmedOnly == this.confirmedOnly &&
          other.effectiveStart == this.effectiveStart &&
          other.effectiveEnd == this.effectiveEnd &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WageRulesCompanion extends UpdateCompanion<WageRule> {
  final Value<String> id;
  final Value<String> mode;
  final Value<String> currency;
  final Value<int> baseRateMinor;
  final Value<String> overtimeRatesJson;
  final Value<String> allowanceRulesJson;
  final Value<String> deductionRulesJson;
  final Value<int> periodStartDay;
  final Value<String> roundingRuleJson;
  final Value<int> confirmedOnly;
  final Value<String> effectiveStart;
  final Value<String?> effectiveEnd;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const WageRulesCompanion({
    this.id = const Value.absent(),
    this.mode = const Value.absent(),
    this.currency = const Value.absent(),
    this.baseRateMinor = const Value.absent(),
    this.overtimeRatesJson = const Value.absent(),
    this.allowanceRulesJson = const Value.absent(),
    this.deductionRulesJson = const Value.absent(),
    this.periodStartDay = const Value.absent(),
    this.roundingRuleJson = const Value.absent(),
    this.confirmedOnly = const Value.absent(),
    this.effectiveStart = const Value.absent(),
    this.effectiveEnd = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WageRulesCompanion.insert({
    required String id,
    required String mode,
    required String currency,
    required int baseRateMinor,
    required String overtimeRatesJson,
    required String allowanceRulesJson,
    required String deductionRulesJson,
    required int periodStartDay,
    required String roundingRuleJson,
    this.confirmedOnly = const Value.absent(),
    required String effectiveStart,
    this.effectiveEnd = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       mode = Value(mode),
       currency = Value(currency),
       baseRateMinor = Value(baseRateMinor),
       overtimeRatesJson = Value(overtimeRatesJson),
       allowanceRulesJson = Value(allowanceRulesJson),
       deductionRulesJson = Value(deductionRulesJson),
       periodStartDay = Value(periodStartDay),
       roundingRuleJson = Value(roundingRuleJson),
       effectiveStart = Value(effectiveStart),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<WageRule> custom({
    Expression<String>? id,
    Expression<String>? mode,
    Expression<String>? currency,
    Expression<int>? baseRateMinor,
    Expression<String>? overtimeRatesJson,
    Expression<String>? allowanceRulesJson,
    Expression<String>? deductionRulesJson,
    Expression<int>? periodStartDay,
    Expression<String>? roundingRuleJson,
    Expression<int>? confirmedOnly,
    Expression<String>? effectiveStart,
    Expression<String>? effectiveEnd,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mode != null) 'mode': mode,
      if (currency != null) 'currency': currency,
      if (baseRateMinor != null) 'base_rate_minor': baseRateMinor,
      if (overtimeRatesJson != null) 'overtime_rates_json': overtimeRatesJson,
      if (allowanceRulesJson != null)
        'allowance_rules_json': allowanceRulesJson,
      if (deductionRulesJson != null)
        'deduction_rules_json': deductionRulesJson,
      if (periodStartDay != null) 'period_start_day': periodStartDay,
      if (roundingRuleJson != null) 'rounding_rule_json': roundingRuleJson,
      if (confirmedOnly != null) 'confirmed_only': confirmedOnly,
      if (effectiveStart != null) 'effective_start': effectiveStart,
      if (effectiveEnd != null) 'effective_end': effectiveEnd,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WageRulesCompanion copyWith({
    Value<String>? id,
    Value<String>? mode,
    Value<String>? currency,
    Value<int>? baseRateMinor,
    Value<String>? overtimeRatesJson,
    Value<String>? allowanceRulesJson,
    Value<String>? deductionRulesJson,
    Value<int>? periodStartDay,
    Value<String>? roundingRuleJson,
    Value<int>? confirmedOnly,
    Value<String>? effectiveStart,
    Value<String?>? effectiveEnd,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return WageRulesCompanion(
      id: id ?? this.id,
      mode: mode ?? this.mode,
      currency: currency ?? this.currency,
      baseRateMinor: baseRateMinor ?? this.baseRateMinor,
      overtimeRatesJson: overtimeRatesJson ?? this.overtimeRatesJson,
      allowanceRulesJson: allowanceRulesJson ?? this.allowanceRulesJson,
      deductionRulesJson: deductionRulesJson ?? this.deductionRulesJson,
      periodStartDay: periodStartDay ?? this.periodStartDay,
      roundingRuleJson: roundingRuleJson ?? this.roundingRuleJson,
      confirmedOnly: confirmedOnly ?? this.confirmedOnly,
      effectiveStart: effectiveStart ?? this.effectiveStart,
      effectiveEnd: effectiveEnd ?? this.effectiveEnd,
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
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (baseRateMinor.present) {
      map['base_rate_minor'] = Variable<int>(baseRateMinor.value);
    }
    if (overtimeRatesJson.present) {
      map['overtime_rates_json'] = Variable<String>(overtimeRatesJson.value);
    }
    if (allowanceRulesJson.present) {
      map['allowance_rules_json'] = Variable<String>(allowanceRulesJson.value);
    }
    if (deductionRulesJson.present) {
      map['deduction_rules_json'] = Variable<String>(deductionRulesJson.value);
    }
    if (periodStartDay.present) {
      map['period_start_day'] = Variable<int>(periodStartDay.value);
    }
    if (roundingRuleJson.present) {
      map['rounding_rule_json'] = Variable<String>(roundingRuleJson.value);
    }
    if (confirmedOnly.present) {
      map['confirmed_only'] = Variable<int>(confirmedOnly.value);
    }
    if (effectiveStart.present) {
      map['effective_start'] = Variable<String>(effectiveStart.value);
    }
    if (effectiveEnd.present) {
      map['effective_end'] = Variable<String>(effectiveEnd.value);
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
    return (StringBuffer('WageRulesCompanion(')
          ..write('id: $id, ')
          ..write('mode: $mode, ')
          ..write('currency: $currency, ')
          ..write('baseRateMinor: $baseRateMinor, ')
          ..write('overtimeRatesJson: $overtimeRatesJson, ')
          ..write('allowanceRulesJson: $allowanceRulesJson, ')
          ..write('deductionRulesJson: $deductionRulesJson, ')
          ..write('periodStartDay: $periodStartDay, ')
          ..write('roundingRuleJson: $roundingRuleJson, ')
          ..write('confirmedOnly: $confirmedOnly, ')
          ..write('effectiveStart: $effectiveStart, ')
          ..write('effectiveEnd: $effectiveEnd, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PayrollPeriodsTable extends PayrollPeriods
    with TableInfo<$PayrollPeriodsTable, PayrollPeriod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PayrollPeriodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
    'end_date',
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _calculatedMinorMeta = const VerificationMeta(
    'calculatedMinor',
  );
  @override
  late final GeneratedColumn<int> calculatedMinor = GeneratedColumn<int>(
    'calculated_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confirmedMinorMeta = const VerificationMeta(
    'confirmedMinor',
  );
  @override
  late final GeneratedColumn<int> confirmedMinor = GeneratedColumn<int>(
    'confirmed_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _calculationSnapshotJsonMeta =
      const VerificationMeta('calculationSnapshotJson');
  @override
  late final GeneratedColumn<String> calculationSnapshotJson =
      GeneratedColumn<String>(
        'calculation_snapshot_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _confirmedAtMeta = const VerificationMeta(
    'confirmedAt',
  );
  @override
  late final GeneratedColumn<int> confirmedAt = GeneratedColumn<int>(
    'confirmed_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    startDate,
    endDate,
    status,
    calculatedMinor,
    confirmedMinor,
    calculationSnapshotJson,
    confirmedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payroll_periods';
  @override
  VerificationContext validateIntegrity(
    Insertable<PayrollPeriod> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('calculated_minor')) {
      context.handle(
        _calculatedMinorMeta,
        calculatedMinor.isAcceptableOrUnknown(
          data['calculated_minor']!,
          _calculatedMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_calculatedMinorMeta);
    }
    if (data.containsKey('confirmed_minor')) {
      context.handle(
        _confirmedMinorMeta,
        confirmedMinor.isAcceptableOrUnknown(
          data['confirmed_minor']!,
          _confirmedMinorMeta,
        ),
      );
    }
    if (data.containsKey('calculation_snapshot_json')) {
      context.handle(
        _calculationSnapshotJsonMeta,
        calculationSnapshotJson.isAcceptableOrUnknown(
          data['calculation_snapshot_json']!,
          _calculationSnapshotJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_calculationSnapshotJsonMeta);
    }
    if (data.containsKey('confirmed_at')) {
      context.handle(
        _confirmedAtMeta,
        confirmedAt.isAcceptableOrUnknown(
          data['confirmed_at']!,
          _confirmedAtMeta,
        ),
      );
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
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {startDate, endDate},
  ];
  @override
  PayrollPeriod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PayrollPeriod(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      calculatedMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calculated_minor'],
      )!,
      confirmedMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confirmed_minor'],
      ),
      calculationSnapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calculation_snapshot_json'],
      )!,
      confirmedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confirmed_at'],
      ),
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
  $PayrollPeriodsTable createAlias(String alias) {
    return $PayrollPeriodsTable(attachedDatabase, alias);
  }
}

class PayrollPeriod extends DataClass implements Insertable<PayrollPeriod> {
  final String id;
  final String startDate;
  final String endDate;
  final String status;
  final int calculatedMinor;
  final int? confirmedMinor;
  final String calculationSnapshotJson;
  final int? confirmedAt;
  final int createdAt;
  final int updatedAt;
  const PayrollPeriod({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.calculatedMinor,
    this.confirmedMinor,
    required this.calculationSnapshotJson,
    this.confirmedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['start_date'] = Variable<String>(startDate);
    map['end_date'] = Variable<String>(endDate);
    map['status'] = Variable<String>(status);
    map['calculated_minor'] = Variable<int>(calculatedMinor);
    if (!nullToAbsent || confirmedMinor != null) {
      map['confirmed_minor'] = Variable<int>(confirmedMinor);
    }
    map['calculation_snapshot_json'] = Variable<String>(
      calculationSnapshotJson,
    );
    if (!nullToAbsent || confirmedAt != null) {
      map['confirmed_at'] = Variable<int>(confirmedAt);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  PayrollPeriodsCompanion toCompanion(bool nullToAbsent) {
    return PayrollPeriodsCompanion(
      id: Value(id),
      startDate: Value(startDate),
      endDate: Value(endDate),
      status: Value(status),
      calculatedMinor: Value(calculatedMinor),
      confirmedMinor: confirmedMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(confirmedMinor),
      calculationSnapshotJson: Value(calculationSnapshotJson),
      confirmedAt: confirmedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(confirmedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PayrollPeriod.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PayrollPeriod(
      id: serializer.fromJson<String>(json['id']),
      startDate: serializer.fromJson<String>(json['startDate']),
      endDate: serializer.fromJson<String>(json['endDate']),
      status: serializer.fromJson<String>(json['status']),
      calculatedMinor: serializer.fromJson<int>(json['calculatedMinor']),
      confirmedMinor: serializer.fromJson<int?>(json['confirmedMinor']),
      calculationSnapshotJson: serializer.fromJson<String>(
        json['calculationSnapshotJson'],
      ),
      confirmedAt: serializer.fromJson<int?>(json['confirmedAt']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startDate': serializer.toJson<String>(startDate),
      'endDate': serializer.toJson<String>(endDate),
      'status': serializer.toJson<String>(status),
      'calculatedMinor': serializer.toJson<int>(calculatedMinor),
      'confirmedMinor': serializer.toJson<int?>(confirmedMinor),
      'calculationSnapshotJson': serializer.toJson<String>(
        calculationSnapshotJson,
      ),
      'confirmedAt': serializer.toJson<int?>(confirmedAt),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  PayrollPeriod copyWith({
    String? id,
    String? startDate,
    String? endDate,
    String? status,
    int? calculatedMinor,
    Value<int?> confirmedMinor = const Value.absent(),
    String? calculationSnapshotJson,
    Value<int?> confirmedAt = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => PayrollPeriod(
    id: id ?? this.id,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    status: status ?? this.status,
    calculatedMinor: calculatedMinor ?? this.calculatedMinor,
    confirmedMinor: confirmedMinor.present
        ? confirmedMinor.value
        : this.confirmedMinor,
    calculationSnapshotJson:
        calculationSnapshotJson ?? this.calculationSnapshotJson,
    confirmedAt: confirmedAt.present ? confirmedAt.value : this.confirmedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PayrollPeriod copyWithCompanion(PayrollPeriodsCompanion data) {
    return PayrollPeriod(
      id: data.id.present ? data.id.value : this.id,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      status: data.status.present ? data.status.value : this.status,
      calculatedMinor: data.calculatedMinor.present
          ? data.calculatedMinor.value
          : this.calculatedMinor,
      confirmedMinor: data.confirmedMinor.present
          ? data.confirmedMinor.value
          : this.confirmedMinor,
      calculationSnapshotJson: data.calculationSnapshotJson.present
          ? data.calculationSnapshotJson.value
          : this.calculationSnapshotJson,
      confirmedAt: data.confirmedAt.present
          ? data.confirmedAt.value
          : this.confirmedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PayrollPeriod(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status, ')
          ..write('calculatedMinor: $calculatedMinor, ')
          ..write('confirmedMinor: $confirmedMinor, ')
          ..write('calculationSnapshotJson: $calculationSnapshotJson, ')
          ..write('confirmedAt: $confirmedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startDate,
    endDate,
    status,
    calculatedMinor,
    confirmedMinor,
    calculationSnapshotJson,
    confirmedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PayrollPeriod &&
          other.id == this.id &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.status == this.status &&
          other.calculatedMinor == this.calculatedMinor &&
          other.confirmedMinor == this.confirmedMinor &&
          other.calculationSnapshotJson == this.calculationSnapshotJson &&
          other.confirmedAt == this.confirmedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PayrollPeriodsCompanion extends UpdateCompanion<PayrollPeriod> {
  final Value<String> id;
  final Value<String> startDate;
  final Value<String> endDate;
  final Value<String> status;
  final Value<int> calculatedMinor;
  final Value<int?> confirmedMinor;
  final Value<String> calculationSnapshotJson;
  final Value<int?> confirmedAt;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const PayrollPeriodsCompanion({
    this.id = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.status = const Value.absent(),
    this.calculatedMinor = const Value.absent(),
    this.confirmedMinor = const Value.absent(),
    this.calculationSnapshotJson = const Value.absent(),
    this.confirmedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PayrollPeriodsCompanion.insert({
    required String id,
    required String startDate,
    required String endDate,
    required String status,
    required int calculatedMinor,
    this.confirmedMinor = const Value.absent(),
    required String calculationSnapshotJson,
    this.confirmedAt = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       startDate = Value(startDate),
       endDate = Value(endDate),
       status = Value(status),
       calculatedMinor = Value(calculatedMinor),
       calculationSnapshotJson = Value(calculationSnapshotJson),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PayrollPeriod> custom({
    Expression<String>? id,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<String>? status,
    Expression<int>? calculatedMinor,
    Expression<int>? confirmedMinor,
    Expression<String>? calculationSnapshotJson,
    Expression<int>? confirmedAt,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (status != null) 'status': status,
      if (calculatedMinor != null) 'calculated_minor': calculatedMinor,
      if (confirmedMinor != null) 'confirmed_minor': confirmedMinor,
      if (calculationSnapshotJson != null)
        'calculation_snapshot_json': calculationSnapshotJson,
      if (confirmedAt != null) 'confirmed_at': confirmedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PayrollPeriodsCompanion copyWith({
    Value<String>? id,
    Value<String>? startDate,
    Value<String>? endDate,
    Value<String>? status,
    Value<int>? calculatedMinor,
    Value<int?>? confirmedMinor,
    Value<String>? calculationSnapshotJson,
    Value<int?>? confirmedAt,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return PayrollPeriodsCompanion(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      calculatedMinor: calculatedMinor ?? this.calculatedMinor,
      confirmedMinor: confirmedMinor ?? this.confirmedMinor,
      calculationSnapshotJson:
          calculationSnapshotJson ?? this.calculationSnapshotJson,
      confirmedAt: confirmedAt ?? this.confirmedAt,
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
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (calculatedMinor.present) {
      map['calculated_minor'] = Variable<int>(calculatedMinor.value);
    }
    if (confirmedMinor.present) {
      map['confirmed_minor'] = Variable<int>(confirmedMinor.value);
    }
    if (calculationSnapshotJson.present) {
      map['calculation_snapshot_json'] = Variable<String>(
        calculationSnapshotJson.value,
      );
    }
    if (confirmedAt.present) {
      map['confirmed_at'] = Variable<int>(confirmedAt.value);
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
    return (StringBuffer('PayrollPeriodsCompanion(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status, ')
          ..write('calculatedMinor: $calculatedMinor, ')
          ..write('confirmedMinor: $confirmedMinor, ')
          ..write('calculationSnapshotJson: $calculationSnapshotJson, ')
          ..write('confirmedAt: $confirmedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiProviderConfigsTable extends AiProviderConfigs
    with TableInfo<$AiProviderConfigsTable, AiProviderConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiProviderConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerTypeMeta = const VerificationMeta(
    'providerType',
  );
  @override
  late final GeneratedColumn<String> providerType = GeneratedColumn<String>(
    'provider_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseUrlMeta = const VerificationMeta(
    'baseUrl',
  );
  @override
  late final GeneratedColumn<String> baseUrl = GeneratedColumn<String>(
    'base_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endpointPathMeta = const VerificationMeta(
    'endpointPath',
  );
  @override
  late final GeneratedColumn<String> endpointPath = GeneratedColumn<String>(
    'endpoint_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelNameMeta = const VerificationMeta(
    'modelName',
  );
  @override
  late final GeneratedColumn<String> modelName = GeneratedColumn<String>(
    'model_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _credentialRefMeta = const VerificationMeta(
    'credentialRef',
  );
  @override
  late final GeneratedColumn<String> credentialRef = GeneratedColumn<String>(
    'credential_ref',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customHeadersRefMeta = const VerificationMeta(
    'customHeadersRef',
  );
  @override
  late final GeneratedColumn<String> customHeadersRef = GeneratedColumn<String>(
    'custom_headers_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeoutSecondsMeta = const VerificationMeta(
    'timeoutSeconds',
  );
  @override
  late final GeneratedColumn<int> timeoutSeconds = GeneratedColumn<int>(
    'timeout_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxOutputTokensMeta = const VerificationMeta(
    'maxOutputTokens',
  );
  @override
  late final GeneratedColumn<int> maxOutputTokens = GeneratedColumn<int>(
    'max_output_tokens',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _streamEnabledMeta = const VerificationMeta(
    'streamEnabled',
  );
  @override
  late final GeneratedColumn<int> streamEnabled = GeneratedColumn<int>(
    'stream_enabled',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _connectionStatusMeta = const VerificationMeta(
    'connectionStatus',
  );
  @override
  late final GeneratedColumn<String> connectionStatus = GeneratedColumn<String>(
    'connection_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastTestedAtMeta = const VerificationMeta(
    'lastTestedAt',
  );
  @override
  late final GeneratedColumn<int> lastTestedAt = GeneratedColumn<int>(
    'last_tested_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    providerType,
    baseUrl,
    endpointPath,
    modelName,
    credentialRef,
    customHeadersRef,
    timeoutSeconds,
    maxOutputTokens,
    streamEnabled,
    connectionStatus,
    lastTestedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_provider_configs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiProviderConfig> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('provider_type')) {
      context.handle(
        _providerTypeMeta,
        providerType.isAcceptableOrUnknown(
          data['provider_type']!,
          _providerTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_providerTypeMeta);
    }
    if (data.containsKey('base_url')) {
      context.handle(
        _baseUrlMeta,
        baseUrl.isAcceptableOrUnknown(data['base_url']!, _baseUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_baseUrlMeta);
    }
    if (data.containsKey('endpoint_path')) {
      context.handle(
        _endpointPathMeta,
        endpointPath.isAcceptableOrUnknown(
          data['endpoint_path']!,
          _endpointPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_endpointPathMeta);
    }
    if (data.containsKey('model_name')) {
      context.handle(
        _modelNameMeta,
        modelName.isAcceptableOrUnknown(data['model_name']!, _modelNameMeta),
      );
    } else if (isInserting) {
      context.missing(_modelNameMeta);
    }
    if (data.containsKey('credential_ref')) {
      context.handle(
        _credentialRefMeta,
        credentialRef.isAcceptableOrUnknown(
          data['credential_ref']!,
          _credentialRefMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_credentialRefMeta);
    }
    if (data.containsKey('custom_headers_ref')) {
      context.handle(
        _customHeadersRefMeta,
        customHeadersRef.isAcceptableOrUnknown(
          data['custom_headers_ref']!,
          _customHeadersRefMeta,
        ),
      );
    }
    if (data.containsKey('timeout_seconds')) {
      context.handle(
        _timeoutSecondsMeta,
        timeoutSeconds.isAcceptableOrUnknown(
          data['timeout_seconds']!,
          _timeoutSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timeoutSecondsMeta);
    }
    if (data.containsKey('max_output_tokens')) {
      context.handle(
        _maxOutputTokensMeta,
        maxOutputTokens.isAcceptableOrUnknown(
          data['max_output_tokens']!,
          _maxOutputTokensMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxOutputTokensMeta);
    }
    if (data.containsKey('stream_enabled')) {
      context.handle(
        _streamEnabledMeta,
        streamEnabled.isAcceptableOrUnknown(
          data['stream_enabled']!,
          _streamEnabledMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_streamEnabledMeta);
    }
    if (data.containsKey('connection_status')) {
      context.handle(
        _connectionStatusMeta,
        connectionStatus.isAcceptableOrUnknown(
          data['connection_status']!,
          _connectionStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_connectionStatusMeta);
    }
    if (data.containsKey('last_tested_at')) {
      context.handle(
        _lastTestedAtMeta,
        lastTestedAt.isAcceptableOrUnknown(
          data['last_tested_at']!,
          _lastTestedAtMeta,
        ),
      );
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
  AiProviderConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiProviderConfig(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      providerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider_type'],
      )!,
      baseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_url'],
      )!,
      endpointPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}endpoint_path'],
      )!,
      modelName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_name'],
      )!,
      credentialRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}credential_ref'],
      )!,
      customHeadersRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_headers_ref'],
      ),
      timeoutSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timeout_seconds'],
      )!,
      maxOutputTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_output_tokens'],
      )!,
      streamEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stream_enabled'],
      )!,
      connectionStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}connection_status'],
      )!,
      lastTestedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_tested_at'],
      ),
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
  $AiProviderConfigsTable createAlias(String alias) {
    return $AiProviderConfigsTable(attachedDatabase, alias);
  }
}

class AiProviderConfig extends DataClass
    implements Insertable<AiProviderConfig> {
  final String id;
  final String providerType;
  final String baseUrl;
  final String endpointPath;
  final String modelName;
  final String credentialRef;
  final String? customHeadersRef;
  final int timeoutSeconds;
  final int maxOutputTokens;
  final int streamEnabled;
  final String connectionStatus;
  final int? lastTestedAt;
  final int createdAt;
  final int updatedAt;
  const AiProviderConfig({
    required this.id,
    required this.providerType,
    required this.baseUrl,
    required this.endpointPath,
    required this.modelName,
    required this.credentialRef,
    this.customHeadersRef,
    required this.timeoutSeconds,
    required this.maxOutputTokens,
    required this.streamEnabled,
    required this.connectionStatus,
    this.lastTestedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['provider_type'] = Variable<String>(providerType);
    map['base_url'] = Variable<String>(baseUrl);
    map['endpoint_path'] = Variable<String>(endpointPath);
    map['model_name'] = Variable<String>(modelName);
    map['credential_ref'] = Variable<String>(credentialRef);
    if (!nullToAbsent || customHeadersRef != null) {
      map['custom_headers_ref'] = Variable<String>(customHeadersRef);
    }
    map['timeout_seconds'] = Variable<int>(timeoutSeconds);
    map['max_output_tokens'] = Variable<int>(maxOutputTokens);
    map['stream_enabled'] = Variable<int>(streamEnabled);
    map['connection_status'] = Variable<String>(connectionStatus);
    if (!nullToAbsent || lastTestedAt != null) {
      map['last_tested_at'] = Variable<int>(lastTestedAt);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  AiProviderConfigsCompanion toCompanion(bool nullToAbsent) {
    return AiProviderConfigsCompanion(
      id: Value(id),
      providerType: Value(providerType),
      baseUrl: Value(baseUrl),
      endpointPath: Value(endpointPath),
      modelName: Value(modelName),
      credentialRef: Value(credentialRef),
      customHeadersRef: customHeadersRef == null && nullToAbsent
          ? const Value.absent()
          : Value(customHeadersRef),
      timeoutSeconds: Value(timeoutSeconds),
      maxOutputTokens: Value(maxOutputTokens),
      streamEnabled: Value(streamEnabled),
      connectionStatus: Value(connectionStatus),
      lastTestedAt: lastTestedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastTestedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AiProviderConfig.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiProviderConfig(
      id: serializer.fromJson<String>(json['id']),
      providerType: serializer.fromJson<String>(json['providerType']),
      baseUrl: serializer.fromJson<String>(json['baseUrl']),
      endpointPath: serializer.fromJson<String>(json['endpointPath']),
      modelName: serializer.fromJson<String>(json['modelName']),
      credentialRef: serializer.fromJson<String>(json['credentialRef']),
      customHeadersRef: serializer.fromJson<String?>(json['customHeadersRef']),
      timeoutSeconds: serializer.fromJson<int>(json['timeoutSeconds']),
      maxOutputTokens: serializer.fromJson<int>(json['maxOutputTokens']),
      streamEnabled: serializer.fromJson<int>(json['streamEnabled']),
      connectionStatus: serializer.fromJson<String>(json['connectionStatus']),
      lastTestedAt: serializer.fromJson<int?>(json['lastTestedAt']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'providerType': serializer.toJson<String>(providerType),
      'baseUrl': serializer.toJson<String>(baseUrl),
      'endpointPath': serializer.toJson<String>(endpointPath),
      'modelName': serializer.toJson<String>(modelName),
      'credentialRef': serializer.toJson<String>(credentialRef),
      'customHeadersRef': serializer.toJson<String?>(customHeadersRef),
      'timeoutSeconds': serializer.toJson<int>(timeoutSeconds),
      'maxOutputTokens': serializer.toJson<int>(maxOutputTokens),
      'streamEnabled': serializer.toJson<int>(streamEnabled),
      'connectionStatus': serializer.toJson<String>(connectionStatus),
      'lastTestedAt': serializer.toJson<int?>(lastTestedAt),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  AiProviderConfig copyWith({
    String? id,
    String? providerType,
    String? baseUrl,
    String? endpointPath,
    String? modelName,
    String? credentialRef,
    Value<String?> customHeadersRef = const Value.absent(),
    int? timeoutSeconds,
    int? maxOutputTokens,
    int? streamEnabled,
    String? connectionStatus,
    Value<int?> lastTestedAt = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => AiProviderConfig(
    id: id ?? this.id,
    providerType: providerType ?? this.providerType,
    baseUrl: baseUrl ?? this.baseUrl,
    endpointPath: endpointPath ?? this.endpointPath,
    modelName: modelName ?? this.modelName,
    credentialRef: credentialRef ?? this.credentialRef,
    customHeadersRef: customHeadersRef.present
        ? customHeadersRef.value
        : this.customHeadersRef,
    timeoutSeconds: timeoutSeconds ?? this.timeoutSeconds,
    maxOutputTokens: maxOutputTokens ?? this.maxOutputTokens,
    streamEnabled: streamEnabled ?? this.streamEnabled,
    connectionStatus: connectionStatus ?? this.connectionStatus,
    lastTestedAt: lastTestedAt.present ? lastTestedAt.value : this.lastTestedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AiProviderConfig copyWithCompanion(AiProviderConfigsCompanion data) {
    return AiProviderConfig(
      id: data.id.present ? data.id.value : this.id,
      providerType: data.providerType.present
          ? data.providerType.value
          : this.providerType,
      baseUrl: data.baseUrl.present ? data.baseUrl.value : this.baseUrl,
      endpointPath: data.endpointPath.present
          ? data.endpointPath.value
          : this.endpointPath,
      modelName: data.modelName.present ? data.modelName.value : this.modelName,
      credentialRef: data.credentialRef.present
          ? data.credentialRef.value
          : this.credentialRef,
      customHeadersRef: data.customHeadersRef.present
          ? data.customHeadersRef.value
          : this.customHeadersRef,
      timeoutSeconds: data.timeoutSeconds.present
          ? data.timeoutSeconds.value
          : this.timeoutSeconds,
      maxOutputTokens: data.maxOutputTokens.present
          ? data.maxOutputTokens.value
          : this.maxOutputTokens,
      streamEnabled: data.streamEnabled.present
          ? data.streamEnabled.value
          : this.streamEnabled,
      connectionStatus: data.connectionStatus.present
          ? data.connectionStatus.value
          : this.connectionStatus,
      lastTestedAt: data.lastTestedAt.present
          ? data.lastTestedAt.value
          : this.lastTestedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiProviderConfig(')
          ..write('id: $id, ')
          ..write('providerType: $providerType, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('endpointPath: $endpointPath, ')
          ..write('modelName: $modelName, ')
          ..write('credentialRef: $credentialRef, ')
          ..write('customHeadersRef: $customHeadersRef, ')
          ..write('timeoutSeconds: $timeoutSeconds, ')
          ..write('maxOutputTokens: $maxOutputTokens, ')
          ..write('streamEnabled: $streamEnabled, ')
          ..write('connectionStatus: $connectionStatus, ')
          ..write('lastTestedAt: $lastTestedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    providerType,
    baseUrl,
    endpointPath,
    modelName,
    credentialRef,
    customHeadersRef,
    timeoutSeconds,
    maxOutputTokens,
    streamEnabled,
    connectionStatus,
    lastTestedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiProviderConfig &&
          other.id == this.id &&
          other.providerType == this.providerType &&
          other.baseUrl == this.baseUrl &&
          other.endpointPath == this.endpointPath &&
          other.modelName == this.modelName &&
          other.credentialRef == this.credentialRef &&
          other.customHeadersRef == this.customHeadersRef &&
          other.timeoutSeconds == this.timeoutSeconds &&
          other.maxOutputTokens == this.maxOutputTokens &&
          other.streamEnabled == this.streamEnabled &&
          other.connectionStatus == this.connectionStatus &&
          other.lastTestedAt == this.lastTestedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AiProviderConfigsCompanion extends UpdateCompanion<AiProviderConfig> {
  final Value<String> id;
  final Value<String> providerType;
  final Value<String> baseUrl;
  final Value<String> endpointPath;
  final Value<String> modelName;
  final Value<String> credentialRef;
  final Value<String?> customHeadersRef;
  final Value<int> timeoutSeconds;
  final Value<int> maxOutputTokens;
  final Value<int> streamEnabled;
  final Value<String> connectionStatus;
  final Value<int?> lastTestedAt;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const AiProviderConfigsCompanion({
    this.id = const Value.absent(),
    this.providerType = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.endpointPath = const Value.absent(),
    this.modelName = const Value.absent(),
    this.credentialRef = const Value.absent(),
    this.customHeadersRef = const Value.absent(),
    this.timeoutSeconds = const Value.absent(),
    this.maxOutputTokens = const Value.absent(),
    this.streamEnabled = const Value.absent(),
    this.connectionStatus = const Value.absent(),
    this.lastTestedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiProviderConfigsCompanion.insert({
    required String id,
    required String providerType,
    required String baseUrl,
    required String endpointPath,
    required String modelName,
    required String credentialRef,
    this.customHeadersRef = const Value.absent(),
    required int timeoutSeconds,
    required int maxOutputTokens,
    required int streamEnabled,
    required String connectionStatus,
    this.lastTestedAt = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       providerType = Value(providerType),
       baseUrl = Value(baseUrl),
       endpointPath = Value(endpointPath),
       modelName = Value(modelName),
       credentialRef = Value(credentialRef),
       timeoutSeconds = Value(timeoutSeconds),
       maxOutputTokens = Value(maxOutputTokens),
       streamEnabled = Value(streamEnabled),
       connectionStatus = Value(connectionStatus),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AiProviderConfig> custom({
    Expression<String>? id,
    Expression<String>? providerType,
    Expression<String>? baseUrl,
    Expression<String>? endpointPath,
    Expression<String>? modelName,
    Expression<String>? credentialRef,
    Expression<String>? customHeadersRef,
    Expression<int>? timeoutSeconds,
    Expression<int>? maxOutputTokens,
    Expression<int>? streamEnabled,
    Expression<String>? connectionStatus,
    Expression<int>? lastTestedAt,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (providerType != null) 'provider_type': providerType,
      if (baseUrl != null) 'base_url': baseUrl,
      if (endpointPath != null) 'endpoint_path': endpointPath,
      if (modelName != null) 'model_name': modelName,
      if (credentialRef != null) 'credential_ref': credentialRef,
      if (customHeadersRef != null) 'custom_headers_ref': customHeadersRef,
      if (timeoutSeconds != null) 'timeout_seconds': timeoutSeconds,
      if (maxOutputTokens != null) 'max_output_tokens': maxOutputTokens,
      if (streamEnabled != null) 'stream_enabled': streamEnabled,
      if (connectionStatus != null) 'connection_status': connectionStatus,
      if (lastTestedAt != null) 'last_tested_at': lastTestedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiProviderConfigsCompanion copyWith({
    Value<String>? id,
    Value<String>? providerType,
    Value<String>? baseUrl,
    Value<String>? endpointPath,
    Value<String>? modelName,
    Value<String>? credentialRef,
    Value<String?>? customHeadersRef,
    Value<int>? timeoutSeconds,
    Value<int>? maxOutputTokens,
    Value<int>? streamEnabled,
    Value<String>? connectionStatus,
    Value<int?>? lastTestedAt,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return AiProviderConfigsCompanion(
      id: id ?? this.id,
      providerType: providerType ?? this.providerType,
      baseUrl: baseUrl ?? this.baseUrl,
      endpointPath: endpointPath ?? this.endpointPath,
      modelName: modelName ?? this.modelName,
      credentialRef: credentialRef ?? this.credentialRef,
      customHeadersRef: customHeadersRef ?? this.customHeadersRef,
      timeoutSeconds: timeoutSeconds ?? this.timeoutSeconds,
      maxOutputTokens: maxOutputTokens ?? this.maxOutputTokens,
      streamEnabled: streamEnabled ?? this.streamEnabled,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      lastTestedAt: lastTestedAt ?? this.lastTestedAt,
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
    if (providerType.present) {
      map['provider_type'] = Variable<String>(providerType.value);
    }
    if (baseUrl.present) {
      map['base_url'] = Variable<String>(baseUrl.value);
    }
    if (endpointPath.present) {
      map['endpoint_path'] = Variable<String>(endpointPath.value);
    }
    if (modelName.present) {
      map['model_name'] = Variable<String>(modelName.value);
    }
    if (credentialRef.present) {
      map['credential_ref'] = Variable<String>(credentialRef.value);
    }
    if (customHeadersRef.present) {
      map['custom_headers_ref'] = Variable<String>(customHeadersRef.value);
    }
    if (timeoutSeconds.present) {
      map['timeout_seconds'] = Variable<int>(timeoutSeconds.value);
    }
    if (maxOutputTokens.present) {
      map['max_output_tokens'] = Variable<int>(maxOutputTokens.value);
    }
    if (streamEnabled.present) {
      map['stream_enabled'] = Variable<int>(streamEnabled.value);
    }
    if (connectionStatus.present) {
      map['connection_status'] = Variable<String>(connectionStatus.value);
    }
    if (lastTestedAt.present) {
      map['last_tested_at'] = Variable<int>(lastTestedAt.value);
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
    return (StringBuffer('AiProviderConfigsCompanion(')
          ..write('id: $id, ')
          ..write('providerType: $providerType, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('endpointPath: $endpointPath, ')
          ..write('modelName: $modelName, ')
          ..write('credentialRef: $credentialRef, ')
          ..write('customHeadersRef: $customHeadersRef, ')
          ..write('timeoutSeconds: $timeoutSeconds, ')
          ..write('maxOutputTokens: $maxOutputTokens, ')
          ..write('streamEnabled: $streamEnabled, ')
          ..write('connectionStatus: $connectionStatus, ')
          ..write('lastTestedAt: $lastTestedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssistantPersonasTable extends AssistantPersonas
    with TableInfo<$AssistantPersonasTable, AssistantPersona> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssistantPersonasTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _presetTypeMeta = const VerificationMeta(
    'presetType',
  );
  @override
  late final GeneratedColumn<String> presetType = GeneratedColumn<String>(
    'preset_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customInstructionMeta = const VerificationMeta(
    'customInstruction',
  );
  @override
  late final GeneratedColumn<String> customInstruction =
      GeneratedColumn<String>(
        'custom_instruction',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _replyLengthMeta = const VerificationMeta(
    'replyLength',
  );
  @override
  late final GeneratedColumn<String> replyLength = GeneratedColumn<String>(
    'reply_length',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _initiativeLevelMeta = const VerificationMeta(
    'initiativeLevel',
  );
  @override
  late final GeneratedColumn<int> initiativeLevel = GeneratedColumn<int>(
    'initiative_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emojiLevelMeta = const VerificationMeta(
    'emojiLevel',
  );
  @override
  late final GeneratedColumn<int> emojiLevel = GeneratedColumn<int>(
    'emoji_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarAssetIdMeta = const VerificationMeta(
    'avatarAssetId',
  );
  @override
  late final GeneratedColumn<String> avatarAssetId = GeneratedColumn<String>(
    'avatar_asset_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduleReadMeta = const VerificationMeta(
    'scheduleRead',
  );
  @override
  late final GeneratedColumn<int> scheduleRead = GeneratedColumn<int>(
    'schedule_read',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attendanceReadMeta = const VerificationMeta(
    'attendanceRead',
  );
  @override
  late final GeneratedColumn<int> attendanceRead = GeneratedColumn<int>(
    'attendance_read',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wageReadMeta = const VerificationMeta(
    'wageRead',
  );
  @override
  late final GeneratedColumn<int> wageRead = GeneratedColumn<int>(
    'wage_read',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alarmReadMeta = const VerificationMeta(
    'alarmRead',
  );
  @override
  late final GeneratedColumn<int> alarmRead = GeneratedColumn<int>(
    'alarm_read',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesReadMeta = const VerificationMeta(
    'notesRead',
  );
  @override
  late final GeneratedColumn<int> notesRead = GeneratedColumn<int>(
    'notes_read',
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
    displayName,
    presetType,
    customInstruction,
    replyLength,
    initiativeLevel,
    emojiLevel,
    avatarAssetId,
    scheduleRead,
    attendanceRead,
    wageRead,
    alarmRead,
    notesRead,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assistant_personas';
  @override
  VerificationContext validateIntegrity(
    Insertable<AssistantPersona> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('preset_type')) {
      context.handle(
        _presetTypeMeta,
        presetType.isAcceptableOrUnknown(data['preset_type']!, _presetTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_presetTypeMeta);
    }
    if (data.containsKey('custom_instruction')) {
      context.handle(
        _customInstructionMeta,
        customInstruction.isAcceptableOrUnknown(
          data['custom_instruction']!,
          _customInstructionMeta,
        ),
      );
    }
    if (data.containsKey('reply_length')) {
      context.handle(
        _replyLengthMeta,
        replyLength.isAcceptableOrUnknown(
          data['reply_length']!,
          _replyLengthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_replyLengthMeta);
    }
    if (data.containsKey('initiative_level')) {
      context.handle(
        _initiativeLevelMeta,
        initiativeLevel.isAcceptableOrUnknown(
          data['initiative_level']!,
          _initiativeLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_initiativeLevelMeta);
    }
    if (data.containsKey('emoji_level')) {
      context.handle(
        _emojiLevelMeta,
        emojiLevel.isAcceptableOrUnknown(data['emoji_level']!, _emojiLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_emojiLevelMeta);
    }
    if (data.containsKey('avatar_asset_id')) {
      context.handle(
        _avatarAssetIdMeta,
        avatarAssetId.isAcceptableOrUnknown(
          data['avatar_asset_id']!,
          _avatarAssetIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_avatarAssetIdMeta);
    }
    if (data.containsKey('schedule_read')) {
      context.handle(
        _scheduleReadMeta,
        scheduleRead.isAcceptableOrUnknown(
          data['schedule_read']!,
          _scheduleReadMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduleReadMeta);
    }
    if (data.containsKey('attendance_read')) {
      context.handle(
        _attendanceReadMeta,
        attendanceRead.isAcceptableOrUnknown(
          data['attendance_read']!,
          _attendanceReadMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attendanceReadMeta);
    }
    if (data.containsKey('wage_read')) {
      context.handle(
        _wageReadMeta,
        wageRead.isAcceptableOrUnknown(data['wage_read']!, _wageReadMeta),
      );
    } else if (isInserting) {
      context.missing(_wageReadMeta);
    }
    if (data.containsKey('alarm_read')) {
      context.handle(
        _alarmReadMeta,
        alarmRead.isAcceptableOrUnknown(data['alarm_read']!, _alarmReadMeta),
      );
    } else if (isInserting) {
      context.missing(_alarmReadMeta);
    }
    if (data.containsKey('notes_read')) {
      context.handle(
        _notesReadMeta,
        notesRead.isAcceptableOrUnknown(data['notes_read']!, _notesReadMeta),
      );
    } else if (isInserting) {
      context.missing(_notesReadMeta);
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
  AssistantPersona map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssistantPersona(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      presetType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preset_type'],
      )!,
      customInstruction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_instruction'],
      ),
      replyLength: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reply_length'],
      )!,
      initiativeLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}initiative_level'],
      )!,
      emojiLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}emoji_level'],
      )!,
      avatarAssetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_asset_id'],
      )!,
      scheduleRead: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schedule_read'],
      )!,
      attendanceRead: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attendance_read'],
      )!,
      wageRead: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wage_read'],
      )!,
      alarmRead: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alarm_read'],
      )!,
      notesRead: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notes_read'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AssistantPersonasTable createAlias(String alias) {
    return $AssistantPersonasTable(attachedDatabase, alias);
  }
}

class AssistantPersona extends DataClass
    implements Insertable<AssistantPersona> {
  final String id;
  final String displayName;
  final String presetType;
  final String? customInstruction;
  final String replyLength;
  final int initiativeLevel;
  final int emojiLevel;
  final String avatarAssetId;
  final int scheduleRead;
  final int attendanceRead;
  final int wageRead;
  final int alarmRead;
  final int notesRead;
  final int updatedAt;
  const AssistantPersona({
    required this.id,
    required this.displayName,
    required this.presetType,
    this.customInstruction,
    required this.replyLength,
    required this.initiativeLevel,
    required this.emojiLevel,
    required this.avatarAssetId,
    required this.scheduleRead,
    required this.attendanceRead,
    required this.wageRead,
    required this.alarmRead,
    required this.notesRead,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['display_name'] = Variable<String>(displayName);
    map['preset_type'] = Variable<String>(presetType);
    if (!nullToAbsent || customInstruction != null) {
      map['custom_instruction'] = Variable<String>(customInstruction);
    }
    map['reply_length'] = Variable<String>(replyLength);
    map['initiative_level'] = Variable<int>(initiativeLevel);
    map['emoji_level'] = Variable<int>(emojiLevel);
    map['avatar_asset_id'] = Variable<String>(avatarAssetId);
    map['schedule_read'] = Variable<int>(scheduleRead);
    map['attendance_read'] = Variable<int>(attendanceRead);
    map['wage_read'] = Variable<int>(wageRead);
    map['alarm_read'] = Variable<int>(alarmRead);
    map['notes_read'] = Variable<int>(notesRead);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  AssistantPersonasCompanion toCompanion(bool nullToAbsent) {
    return AssistantPersonasCompanion(
      id: Value(id),
      displayName: Value(displayName),
      presetType: Value(presetType),
      customInstruction: customInstruction == null && nullToAbsent
          ? const Value.absent()
          : Value(customInstruction),
      replyLength: Value(replyLength),
      initiativeLevel: Value(initiativeLevel),
      emojiLevel: Value(emojiLevel),
      avatarAssetId: Value(avatarAssetId),
      scheduleRead: Value(scheduleRead),
      attendanceRead: Value(attendanceRead),
      wageRead: Value(wageRead),
      alarmRead: Value(alarmRead),
      notesRead: Value(notesRead),
      updatedAt: Value(updatedAt),
    );
  }

  factory AssistantPersona.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssistantPersona(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      presetType: serializer.fromJson<String>(json['presetType']),
      customInstruction: serializer.fromJson<String?>(
        json['customInstruction'],
      ),
      replyLength: serializer.fromJson<String>(json['replyLength']),
      initiativeLevel: serializer.fromJson<int>(json['initiativeLevel']),
      emojiLevel: serializer.fromJson<int>(json['emojiLevel']),
      avatarAssetId: serializer.fromJson<String>(json['avatarAssetId']),
      scheduleRead: serializer.fromJson<int>(json['scheduleRead']),
      attendanceRead: serializer.fromJson<int>(json['attendanceRead']),
      wageRead: serializer.fromJson<int>(json['wageRead']),
      alarmRead: serializer.fromJson<int>(json['alarmRead']),
      notesRead: serializer.fromJson<int>(json['notesRead']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String>(displayName),
      'presetType': serializer.toJson<String>(presetType),
      'customInstruction': serializer.toJson<String?>(customInstruction),
      'replyLength': serializer.toJson<String>(replyLength),
      'initiativeLevel': serializer.toJson<int>(initiativeLevel),
      'emojiLevel': serializer.toJson<int>(emojiLevel),
      'avatarAssetId': serializer.toJson<String>(avatarAssetId),
      'scheduleRead': serializer.toJson<int>(scheduleRead),
      'attendanceRead': serializer.toJson<int>(attendanceRead),
      'wageRead': serializer.toJson<int>(wageRead),
      'alarmRead': serializer.toJson<int>(alarmRead),
      'notesRead': serializer.toJson<int>(notesRead),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  AssistantPersona copyWith({
    String? id,
    String? displayName,
    String? presetType,
    Value<String?> customInstruction = const Value.absent(),
    String? replyLength,
    int? initiativeLevel,
    int? emojiLevel,
    String? avatarAssetId,
    int? scheduleRead,
    int? attendanceRead,
    int? wageRead,
    int? alarmRead,
    int? notesRead,
    int? updatedAt,
  }) => AssistantPersona(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    presetType: presetType ?? this.presetType,
    customInstruction: customInstruction.present
        ? customInstruction.value
        : this.customInstruction,
    replyLength: replyLength ?? this.replyLength,
    initiativeLevel: initiativeLevel ?? this.initiativeLevel,
    emojiLevel: emojiLevel ?? this.emojiLevel,
    avatarAssetId: avatarAssetId ?? this.avatarAssetId,
    scheduleRead: scheduleRead ?? this.scheduleRead,
    attendanceRead: attendanceRead ?? this.attendanceRead,
    wageRead: wageRead ?? this.wageRead,
    alarmRead: alarmRead ?? this.alarmRead,
    notesRead: notesRead ?? this.notesRead,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AssistantPersona copyWithCompanion(AssistantPersonasCompanion data) {
    return AssistantPersona(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      presetType: data.presetType.present
          ? data.presetType.value
          : this.presetType,
      customInstruction: data.customInstruction.present
          ? data.customInstruction.value
          : this.customInstruction,
      replyLength: data.replyLength.present
          ? data.replyLength.value
          : this.replyLength,
      initiativeLevel: data.initiativeLevel.present
          ? data.initiativeLevel.value
          : this.initiativeLevel,
      emojiLevel: data.emojiLevel.present
          ? data.emojiLevel.value
          : this.emojiLevel,
      avatarAssetId: data.avatarAssetId.present
          ? data.avatarAssetId.value
          : this.avatarAssetId,
      scheduleRead: data.scheduleRead.present
          ? data.scheduleRead.value
          : this.scheduleRead,
      attendanceRead: data.attendanceRead.present
          ? data.attendanceRead.value
          : this.attendanceRead,
      wageRead: data.wageRead.present ? data.wageRead.value : this.wageRead,
      alarmRead: data.alarmRead.present ? data.alarmRead.value : this.alarmRead,
      notesRead: data.notesRead.present ? data.notesRead.value : this.notesRead,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssistantPersona(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('presetType: $presetType, ')
          ..write('customInstruction: $customInstruction, ')
          ..write('replyLength: $replyLength, ')
          ..write('initiativeLevel: $initiativeLevel, ')
          ..write('emojiLevel: $emojiLevel, ')
          ..write('avatarAssetId: $avatarAssetId, ')
          ..write('scheduleRead: $scheduleRead, ')
          ..write('attendanceRead: $attendanceRead, ')
          ..write('wageRead: $wageRead, ')
          ..write('alarmRead: $alarmRead, ')
          ..write('notesRead: $notesRead, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    presetType,
    customInstruction,
    replyLength,
    initiativeLevel,
    emojiLevel,
    avatarAssetId,
    scheduleRead,
    attendanceRead,
    wageRead,
    alarmRead,
    notesRead,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssistantPersona &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.presetType == this.presetType &&
          other.customInstruction == this.customInstruction &&
          other.replyLength == this.replyLength &&
          other.initiativeLevel == this.initiativeLevel &&
          other.emojiLevel == this.emojiLevel &&
          other.avatarAssetId == this.avatarAssetId &&
          other.scheduleRead == this.scheduleRead &&
          other.attendanceRead == this.attendanceRead &&
          other.wageRead == this.wageRead &&
          other.alarmRead == this.alarmRead &&
          other.notesRead == this.notesRead &&
          other.updatedAt == this.updatedAt);
}

class AssistantPersonasCompanion extends UpdateCompanion<AssistantPersona> {
  final Value<String> id;
  final Value<String> displayName;
  final Value<String> presetType;
  final Value<String?> customInstruction;
  final Value<String> replyLength;
  final Value<int> initiativeLevel;
  final Value<int> emojiLevel;
  final Value<String> avatarAssetId;
  final Value<int> scheduleRead;
  final Value<int> attendanceRead;
  final Value<int> wageRead;
  final Value<int> alarmRead;
  final Value<int> notesRead;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const AssistantPersonasCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.presetType = const Value.absent(),
    this.customInstruction = const Value.absent(),
    this.replyLength = const Value.absent(),
    this.initiativeLevel = const Value.absent(),
    this.emojiLevel = const Value.absent(),
    this.avatarAssetId = const Value.absent(),
    this.scheduleRead = const Value.absent(),
    this.attendanceRead = const Value.absent(),
    this.wageRead = const Value.absent(),
    this.alarmRead = const Value.absent(),
    this.notesRead = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssistantPersonasCompanion.insert({
    required String id,
    required String displayName,
    required String presetType,
    this.customInstruction = const Value.absent(),
    required String replyLength,
    required int initiativeLevel,
    required int emojiLevel,
    required String avatarAssetId,
    required int scheduleRead,
    required int attendanceRead,
    required int wageRead,
    required int alarmRead,
    required int notesRead,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       displayName = Value(displayName),
       presetType = Value(presetType),
       replyLength = Value(replyLength),
       initiativeLevel = Value(initiativeLevel),
       emojiLevel = Value(emojiLevel),
       avatarAssetId = Value(avatarAssetId),
       scheduleRead = Value(scheduleRead),
       attendanceRead = Value(attendanceRead),
       wageRead = Value(wageRead),
       alarmRead = Value(alarmRead),
       notesRead = Value(notesRead),
       updatedAt = Value(updatedAt);
  static Insertable<AssistantPersona> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<String>? presetType,
    Expression<String>? customInstruction,
    Expression<String>? replyLength,
    Expression<int>? initiativeLevel,
    Expression<int>? emojiLevel,
    Expression<String>? avatarAssetId,
    Expression<int>? scheduleRead,
    Expression<int>? attendanceRead,
    Expression<int>? wageRead,
    Expression<int>? alarmRead,
    Expression<int>? notesRead,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (presetType != null) 'preset_type': presetType,
      if (customInstruction != null) 'custom_instruction': customInstruction,
      if (replyLength != null) 'reply_length': replyLength,
      if (initiativeLevel != null) 'initiative_level': initiativeLevel,
      if (emojiLevel != null) 'emoji_level': emojiLevel,
      if (avatarAssetId != null) 'avatar_asset_id': avatarAssetId,
      if (scheduleRead != null) 'schedule_read': scheduleRead,
      if (attendanceRead != null) 'attendance_read': attendanceRead,
      if (wageRead != null) 'wage_read': wageRead,
      if (alarmRead != null) 'alarm_read': alarmRead,
      if (notesRead != null) 'notes_read': notesRead,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssistantPersonasCompanion copyWith({
    Value<String>? id,
    Value<String>? displayName,
    Value<String>? presetType,
    Value<String?>? customInstruction,
    Value<String>? replyLength,
    Value<int>? initiativeLevel,
    Value<int>? emojiLevel,
    Value<String>? avatarAssetId,
    Value<int>? scheduleRead,
    Value<int>? attendanceRead,
    Value<int>? wageRead,
    Value<int>? alarmRead,
    Value<int>? notesRead,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return AssistantPersonasCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      presetType: presetType ?? this.presetType,
      customInstruction: customInstruction ?? this.customInstruction,
      replyLength: replyLength ?? this.replyLength,
      initiativeLevel: initiativeLevel ?? this.initiativeLevel,
      emojiLevel: emojiLevel ?? this.emojiLevel,
      avatarAssetId: avatarAssetId ?? this.avatarAssetId,
      scheduleRead: scheduleRead ?? this.scheduleRead,
      attendanceRead: attendanceRead ?? this.attendanceRead,
      wageRead: wageRead ?? this.wageRead,
      alarmRead: alarmRead ?? this.alarmRead,
      notesRead: notesRead ?? this.notesRead,
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
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (presetType.present) {
      map['preset_type'] = Variable<String>(presetType.value);
    }
    if (customInstruction.present) {
      map['custom_instruction'] = Variable<String>(customInstruction.value);
    }
    if (replyLength.present) {
      map['reply_length'] = Variable<String>(replyLength.value);
    }
    if (initiativeLevel.present) {
      map['initiative_level'] = Variable<int>(initiativeLevel.value);
    }
    if (emojiLevel.present) {
      map['emoji_level'] = Variable<int>(emojiLevel.value);
    }
    if (avatarAssetId.present) {
      map['avatar_asset_id'] = Variable<String>(avatarAssetId.value);
    }
    if (scheduleRead.present) {
      map['schedule_read'] = Variable<int>(scheduleRead.value);
    }
    if (attendanceRead.present) {
      map['attendance_read'] = Variable<int>(attendanceRead.value);
    }
    if (wageRead.present) {
      map['wage_read'] = Variable<int>(wageRead.value);
    }
    if (alarmRead.present) {
      map['alarm_read'] = Variable<int>(alarmRead.value);
    }
    if (notesRead.present) {
      map['notes_read'] = Variable<int>(notesRead.value);
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
    return (StringBuffer('AssistantPersonasCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('presetType: $presetType, ')
          ..write('customInstruction: $customInstruction, ')
          ..write('replyLength: $replyLength, ')
          ..write('initiativeLevel: $initiativeLevel, ')
          ..write('emojiLevel: $emojiLevel, ')
          ..write('avatarAssetId: $avatarAssetId, ')
          ..write('scheduleRead: $scheduleRead, ')
          ..write('attendanceRead: $attendanceRead, ')
          ..write('wageRead: $wageRead, ')
          ..write('alarmRead: $alarmRead, ')
          ..write('notesRead: $notesRead, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConversationsTable extends Conversations
    with TableInfo<$ConversationsTable, Conversation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelSnapshotJsonMeta = const VerificationMeta(
    'modelSnapshotJson',
  );
  @override
  late final GeneratedColumn<String> modelSnapshotJson =
      GeneratedColumn<String>(
        'model_snapshot_json',
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
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<int> archivedAt = GeneratedColumn<int>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    modelSnapshotJson,
    createdAt,
    updatedAt,
    archivedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Conversation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('model_snapshot_json')) {
      context.handle(
        _modelSnapshotJsonMeta,
        modelSnapshotJson.isAcceptableOrUnknown(
          data['model_snapshot_json']!,
          _modelSnapshotJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_modelSnapshotJsonMeta);
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
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Conversation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Conversation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      modelSnapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_snapshot_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}archived_at'],
      ),
    );
  }

  @override
  $ConversationsTable createAlias(String alias) {
    return $ConversationsTable(attachedDatabase, alias);
  }
}

class Conversation extends DataClass implements Insertable<Conversation> {
  final String id;
  final String title;
  final String modelSnapshotJson;
  final int createdAt;
  final int updatedAt;
  final int? archivedAt;
  const Conversation({
    required this.id,
    required this.title,
    required this.modelSnapshotJson,
    required this.createdAt,
    required this.updatedAt,
    this.archivedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['model_snapshot_json'] = Variable<String>(modelSnapshotJson);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<int>(archivedAt);
    }
    return map;
  }

  ConversationsCompanion toCompanion(bool nullToAbsent) {
    return ConversationsCompanion(
      id: Value(id),
      title: Value(title),
      modelSnapshotJson: Value(modelSnapshotJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
    );
  }

  factory Conversation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Conversation(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      modelSnapshotJson: serializer.fromJson<String>(json['modelSnapshotJson']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      archivedAt: serializer.fromJson<int?>(json['archivedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'modelSnapshotJson': serializer.toJson<String>(modelSnapshotJson),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'archivedAt': serializer.toJson<int?>(archivedAt),
    };
  }

  Conversation copyWith({
    String? id,
    String? title,
    String? modelSnapshotJson,
    int? createdAt,
    int? updatedAt,
    Value<int?> archivedAt = const Value.absent(),
  }) => Conversation(
    id: id ?? this.id,
    title: title ?? this.title,
    modelSnapshotJson: modelSnapshotJson ?? this.modelSnapshotJson,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
  );
  Conversation copyWithCompanion(ConversationsCompanion data) {
    return Conversation(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      modelSnapshotJson: data.modelSnapshotJson.present
          ? data.modelSnapshotJson.value
          : this.modelSnapshotJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Conversation(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('modelSnapshotJson: $modelSnapshotJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    modelSnapshotJson,
    createdAt,
    updatedAt,
    archivedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Conversation &&
          other.id == this.id &&
          other.title == this.title &&
          other.modelSnapshotJson == this.modelSnapshotJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.archivedAt == this.archivedAt);
}

class ConversationsCompanion extends UpdateCompanion<Conversation> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> modelSnapshotJson;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> archivedAt;
  final Value<int> rowid;
  const ConversationsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.modelSnapshotJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConversationsCompanion.insert({
    required String id,
    required String title,
    required String modelSnapshotJson,
    required int createdAt,
    required int updatedAt,
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       modelSnapshotJson = Value(modelSnapshotJson),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Conversation> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? modelSnapshotJson,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? archivedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (modelSnapshotJson != null) 'model_snapshot_json': modelSnapshotJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConversationsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? modelSnapshotJson,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? archivedAt,
    Value<int>? rowid,
  }) {
    return ConversationsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      modelSnapshotJson: modelSnapshotJson ?? this.modelSnapshotJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      archivedAt: archivedAt ?? this.archivedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (modelSnapshotJson.present) {
      map['model_snapshot_json'] = Variable<String>(modelSnapshotJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<int>(archivedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('modelSnapshotJson: $modelSnapshotJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES conversations (id)',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toolCallIdMeta = const VerificationMeta(
    'toolCallId',
  );
  @override
  late final GeneratedColumn<String> toolCallId = GeneratedColumn<String>(
    'tool_call_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localOnlyMeta = const VerificationMeta(
    'localOnly',
  );
  @override
  late final GeneratedColumn<int> localOnly = GeneratedColumn<int>(
    'local_only',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    conversationId,
    role,
    content,
    contentType,
    toolCallId,
    localOnly,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Message> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('tool_call_id')) {
      context.handle(
        _toolCallIdMeta,
        toolCallId.isAcceptableOrUnknown(
          data['tool_call_id']!,
          _toolCallIdMeta,
        ),
      );
    }
    if (data.containsKey('local_only')) {
      context.handle(
        _localOnlyMeta,
        localOnly.isAcceptableOrUnknown(data['local_only']!, _localOnlyMeta),
      );
    } else if (isInserting) {
      context.missing(_localOnlyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversation_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      )!,
      toolCallId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tool_call_id'],
      ),
      localOnly: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_only'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final String id;
  final String conversationId;
  final String role;
  final String content;
  final String contentType;
  final String? toolCallId;
  final int localOnly;
  final int createdAt;
  const Message({
    required this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    required this.contentType,
    this.toolCallId,
    required this.localOnly,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['conversation_id'] = Variable<String>(conversationId);
    map['role'] = Variable<String>(role);
    map['content'] = Variable<String>(content);
    map['content_type'] = Variable<String>(contentType);
    if (!nullToAbsent || toolCallId != null) {
      map['tool_call_id'] = Variable<String>(toolCallId);
    }
    map['local_only'] = Variable<int>(localOnly);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      role: Value(role),
      content: Value(content),
      contentType: Value(contentType),
      toolCallId: toolCallId == null && nullToAbsent
          ? const Value.absent()
          : Value(toolCallId),
      localOnly: Value(localOnly),
      createdAt: Value(createdAt),
    );
  }

  factory Message.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<String>(json['id']),
      conversationId: serializer.fromJson<String>(json['conversationId']),
      role: serializer.fromJson<String>(json['role']),
      content: serializer.fromJson<String>(json['content']),
      contentType: serializer.fromJson<String>(json['contentType']),
      toolCallId: serializer.fromJson<String?>(json['toolCallId']),
      localOnly: serializer.fromJson<int>(json['localOnly']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'conversationId': serializer.toJson<String>(conversationId),
      'role': serializer.toJson<String>(role),
      'content': serializer.toJson<String>(content),
      'contentType': serializer.toJson<String>(contentType),
      'toolCallId': serializer.toJson<String?>(toolCallId),
      'localOnly': serializer.toJson<int>(localOnly),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  Message copyWith({
    String? id,
    String? conversationId,
    String? role,
    String? content,
    String? contentType,
    Value<String?> toolCallId = const Value.absent(),
    int? localOnly,
    int? createdAt,
  }) => Message(
    id: id ?? this.id,
    conversationId: conversationId ?? this.conversationId,
    role: role ?? this.role,
    content: content ?? this.content,
    contentType: contentType ?? this.contentType,
    toolCallId: toolCallId.present ? toolCallId.value : this.toolCallId,
    localOnly: localOnly ?? this.localOnly,
    createdAt: createdAt ?? this.createdAt,
  );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      id: data.id.present ? data.id.value : this.id,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      role: data.role.present ? data.role.value : this.role,
      content: data.content.present ? data.content.value : this.content,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      toolCallId: data.toolCallId.present
          ? data.toolCallId.value
          : this.toolCallId,
      localOnly: data.localOnly.present ? data.localOnly.value : this.localOnly,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('contentType: $contentType, ')
          ..write('toolCallId: $toolCallId, ')
          ..write('localOnly: $localOnly, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    conversationId,
    role,
    content,
    contentType,
    toolCallId,
    localOnly,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.conversationId == this.conversationId &&
          other.role == this.role &&
          other.content == this.content &&
          other.contentType == this.contentType &&
          other.toolCallId == this.toolCallId &&
          other.localOnly == this.localOnly &&
          other.createdAt == this.createdAt);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<String> id;
  final Value<String> conversationId;
  final Value<String> role;
  final Value<String> content;
  final Value<String> contentType;
  final Value<String?> toolCallId;
  final Value<int> localOnly;
  final Value<int> createdAt;
  final Value<int> rowid;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.role = const Value.absent(),
    this.content = const Value.absent(),
    this.contentType = const Value.absent(),
    this.toolCallId = const Value.absent(),
    this.localOnly = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagesCompanion.insert({
    required String id,
    required String conversationId,
    required String role,
    required String content,
    required String contentType,
    this.toolCallId = const Value.absent(),
    required int localOnly,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       conversationId = Value(conversationId),
       role = Value(role),
       content = Value(content),
       contentType = Value(contentType),
       localOnly = Value(localOnly),
       createdAt = Value(createdAt);
  static Insertable<Message> custom({
    Expression<String>? id,
    Expression<String>? conversationId,
    Expression<String>? role,
    Expression<String>? content,
    Expression<String>? contentType,
    Expression<String>? toolCallId,
    Expression<int>? localOnly,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conversationId != null) 'conversation_id': conversationId,
      if (role != null) 'role': role,
      if (content != null) 'content': content,
      if (contentType != null) 'content_type': contentType,
      if (toolCallId != null) 'tool_call_id': toolCallId,
      if (localOnly != null) 'local_only': localOnly,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagesCompanion copyWith({
    Value<String>? id,
    Value<String>? conversationId,
    Value<String>? role,
    Value<String>? content,
    Value<String>? contentType,
    Value<String?>? toolCallId,
    Value<int>? localOnly,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return MessagesCompanion(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      role: role ?? this.role,
      content: content ?? this.content,
      contentType: contentType ?? this.contentType,
      toolCallId: toolCallId ?? this.toolCallId,
      localOnly: localOnly ?? this.localOnly,
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
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (toolCallId.present) {
      map['tool_call_id'] = Variable<String>(toolCallId.value);
    }
    if (localOnly.present) {
      map['local_only'] = Variable<int>(localOnly.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('contentType: $contentType, ')
          ..write('toolCallId: $toolCallId, ')
          ..write('localOnly: $localOnly, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiActionsTable extends AiActions
    with TableInfo<$AiActionsTable, AiAction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiActionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES conversations (id)',
    ),
  );
  static const VerificationMeta _actionTypeMeta = const VerificationMeta(
    'actionType',
  );
  @override
  late final GeneratedColumn<String> actionType = GeneratedColumn<String>(
    'action_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toolNameMeta = const VerificationMeta(
    'toolName',
  );
  @override
  late final GeneratedColumn<String> toolName = GeneratedColumn<String>(
    'tool_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proposedPayloadJsonMeta =
      const VerificationMeta('proposedPayloadJson');
  @override
  late final GeneratedColumn<String> proposedPayloadJson =
      GeneratedColumn<String>(
        'proposed_payload_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _validatedPayloadJsonMeta =
      const VerificationMeta('validatedPayloadJson');
  @override
  late final GeneratedColumn<String> validatedPayloadJson =
      GeneratedColumn<String>(
        'validated_payload_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _beforeSnapshotJsonMeta =
      const VerificationMeta('beforeSnapshotJson');
  @override
  late final GeneratedColumn<String> beforeSnapshotJson =
      GeneratedColumn<String>(
        'before_snapshot_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _afterSnapshotJsonMeta = const VerificationMeta(
    'afterSnapshotJson',
  );
  @override
  late final GeneratedColumn<String> afterSnapshotJson =
      GeneratedColumn<String>(
        'after_snapshot_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
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
  static const VerificationMeta _confirmationTokenHashMeta =
      const VerificationMeta('confirmationTokenHash');
  @override
  late final GeneratedColumn<String> confirmationTokenHash =
      GeneratedColumn<String>(
        'confirmation_token_hash',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  @override
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _inputVersionMeta = const VerificationMeta(
    'inputVersion',
  );
  @override
  late final GeneratedColumn<String> inputVersion = GeneratedColumn<String>(
    'input_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<int> expiresAt = GeneratedColumn<int>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confirmedAtMeta = const VerificationMeta(
    'confirmedAt',
  );
  @override
  late final GeneratedColumn<int> confirmedAt = GeneratedColumn<int>(
    'confirmed_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _executedAtMeta = const VerificationMeta(
    'executedAt',
  );
  @override
  late final GeneratedColumn<int> executedAt = GeneratedColumn<int>(
    'executed_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _undoneAtMeta = const VerificationMeta(
    'undoneAt',
  );
  @override
  late final GeneratedColumn<int> undoneAt = GeneratedColumn<int>(
    'undone_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    conversationId,
    actionType,
    toolName,
    proposedPayloadJson,
    validatedPayloadJson,
    beforeSnapshotJson,
    afterSnapshotJson,
    status,
    confirmationTokenHash,
    idempotencyKey,
    inputVersion,
    expiresAt,
    confirmedAt,
    executedAt,
    undoneAt,
    errorCode,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_actions';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiAction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('action_type')) {
      context.handle(
        _actionTypeMeta,
        actionType.isAcceptableOrUnknown(data['action_type']!, _actionTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_actionTypeMeta);
    }
    if (data.containsKey('tool_name')) {
      context.handle(
        _toolNameMeta,
        toolName.isAcceptableOrUnknown(data['tool_name']!, _toolNameMeta),
      );
    } else if (isInserting) {
      context.missing(_toolNameMeta);
    }
    if (data.containsKey('proposed_payload_json')) {
      context.handle(
        _proposedPayloadJsonMeta,
        proposedPayloadJson.isAcceptableOrUnknown(
          data['proposed_payload_json']!,
          _proposedPayloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proposedPayloadJsonMeta);
    }
    if (data.containsKey('validated_payload_json')) {
      context.handle(
        _validatedPayloadJsonMeta,
        validatedPayloadJson.isAcceptableOrUnknown(
          data['validated_payload_json']!,
          _validatedPayloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_validatedPayloadJsonMeta);
    }
    if (data.containsKey('before_snapshot_json')) {
      context.handle(
        _beforeSnapshotJsonMeta,
        beforeSnapshotJson.isAcceptableOrUnknown(
          data['before_snapshot_json']!,
          _beforeSnapshotJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_beforeSnapshotJsonMeta);
    }
    if (data.containsKey('after_snapshot_json')) {
      context.handle(
        _afterSnapshotJsonMeta,
        afterSnapshotJson.isAcceptableOrUnknown(
          data['after_snapshot_json']!,
          _afterSnapshotJsonMeta,
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
    if (data.containsKey('confirmation_token_hash')) {
      context.handle(
        _confirmationTokenHashMeta,
        confirmationTokenHash.isAcceptableOrUnknown(
          data['confirmation_token_hash']!,
          _confirmationTokenHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_confirmationTokenHashMeta);
    }
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idempotencyKeyMeta);
    }
    if (data.containsKey('input_version')) {
      context.handle(
        _inputVersionMeta,
        inputVersion.isAcceptableOrUnknown(
          data['input_version']!,
          _inputVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inputVersionMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('confirmed_at')) {
      context.handle(
        _confirmedAtMeta,
        confirmedAt.isAcceptableOrUnknown(
          data['confirmed_at']!,
          _confirmedAtMeta,
        ),
      );
    }
    if (data.containsKey('executed_at')) {
      context.handle(
        _executedAtMeta,
        executedAt.isAcceptableOrUnknown(data['executed_at']!, _executedAtMeta),
      );
    }
    if (data.containsKey('undone_at')) {
      context.handle(
        _undoneAtMeta,
        undoneAt.isAcceptableOrUnknown(data['undone_at']!, _undoneAtMeta),
      );
    }
    if (data.containsKey('error_code')) {
      context.handle(
        _errorCodeMeta,
        errorCode.isAcceptableOrUnknown(data['error_code']!, _errorCodeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiAction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiAction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversation_id'],
      )!,
      actionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action_type'],
      )!,
      toolName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tool_name'],
      )!,
      proposedPayloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proposed_payload_json'],
      )!,
      validatedPayloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}validated_payload_json'],
      )!,
      beforeSnapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}before_snapshot_json'],
      )!,
      afterSnapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}after_snapshot_json'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      confirmationTokenHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}confirmation_token_hash'],
      )!,
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      )!,
      inputVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}input_version'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expires_at'],
      )!,
      confirmedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confirmed_at'],
      ),
      executedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}executed_at'],
      ),
      undoneAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}undone_at'],
      ),
      errorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_code'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AiActionsTable createAlias(String alias) {
    return $AiActionsTable(attachedDatabase, alias);
  }
}

class AiAction extends DataClass implements Insertable<AiAction> {
  final String id;
  final String conversationId;
  final String actionType;
  final String toolName;
  final String proposedPayloadJson;
  final String validatedPayloadJson;
  final String beforeSnapshotJson;
  final String? afterSnapshotJson;
  final String status;
  final String confirmationTokenHash;
  final String idempotencyKey;
  final String inputVersion;
  final int expiresAt;
  final int? confirmedAt;
  final int? executedAt;
  final int? undoneAt;
  final String? errorCode;
  final int createdAt;
  const AiAction({
    required this.id,
    required this.conversationId,
    required this.actionType,
    required this.toolName,
    required this.proposedPayloadJson,
    required this.validatedPayloadJson,
    required this.beforeSnapshotJson,
    this.afterSnapshotJson,
    required this.status,
    required this.confirmationTokenHash,
    required this.idempotencyKey,
    required this.inputVersion,
    required this.expiresAt,
    this.confirmedAt,
    this.executedAt,
    this.undoneAt,
    this.errorCode,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['conversation_id'] = Variable<String>(conversationId);
    map['action_type'] = Variable<String>(actionType);
    map['tool_name'] = Variable<String>(toolName);
    map['proposed_payload_json'] = Variable<String>(proposedPayloadJson);
    map['validated_payload_json'] = Variable<String>(validatedPayloadJson);
    map['before_snapshot_json'] = Variable<String>(beforeSnapshotJson);
    if (!nullToAbsent || afterSnapshotJson != null) {
      map['after_snapshot_json'] = Variable<String>(afterSnapshotJson);
    }
    map['status'] = Variable<String>(status);
    map['confirmation_token_hash'] = Variable<String>(confirmationTokenHash);
    map['idempotency_key'] = Variable<String>(idempotencyKey);
    map['input_version'] = Variable<String>(inputVersion);
    map['expires_at'] = Variable<int>(expiresAt);
    if (!nullToAbsent || confirmedAt != null) {
      map['confirmed_at'] = Variable<int>(confirmedAt);
    }
    if (!nullToAbsent || executedAt != null) {
      map['executed_at'] = Variable<int>(executedAt);
    }
    if (!nullToAbsent || undoneAt != null) {
      map['undone_at'] = Variable<int>(undoneAt);
    }
    if (!nullToAbsent || errorCode != null) {
      map['error_code'] = Variable<String>(errorCode);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  AiActionsCompanion toCompanion(bool nullToAbsent) {
    return AiActionsCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      actionType: Value(actionType),
      toolName: Value(toolName),
      proposedPayloadJson: Value(proposedPayloadJson),
      validatedPayloadJson: Value(validatedPayloadJson),
      beforeSnapshotJson: Value(beforeSnapshotJson),
      afterSnapshotJson: afterSnapshotJson == null && nullToAbsent
          ? const Value.absent()
          : Value(afterSnapshotJson),
      status: Value(status),
      confirmationTokenHash: Value(confirmationTokenHash),
      idempotencyKey: Value(idempotencyKey),
      inputVersion: Value(inputVersion),
      expiresAt: Value(expiresAt),
      confirmedAt: confirmedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(confirmedAt),
      executedAt: executedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(executedAt),
      undoneAt: undoneAt == null && nullToAbsent
          ? const Value.absent()
          : Value(undoneAt),
      errorCode: errorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(errorCode),
      createdAt: Value(createdAt),
    );
  }

  factory AiAction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiAction(
      id: serializer.fromJson<String>(json['id']),
      conversationId: serializer.fromJson<String>(json['conversationId']),
      actionType: serializer.fromJson<String>(json['actionType']),
      toolName: serializer.fromJson<String>(json['toolName']),
      proposedPayloadJson: serializer.fromJson<String>(
        json['proposedPayloadJson'],
      ),
      validatedPayloadJson: serializer.fromJson<String>(
        json['validatedPayloadJson'],
      ),
      beforeSnapshotJson: serializer.fromJson<String>(
        json['beforeSnapshotJson'],
      ),
      afterSnapshotJson: serializer.fromJson<String?>(
        json['afterSnapshotJson'],
      ),
      status: serializer.fromJson<String>(json['status']),
      confirmationTokenHash: serializer.fromJson<String>(
        json['confirmationTokenHash'],
      ),
      idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),
      inputVersion: serializer.fromJson<String>(json['inputVersion']),
      expiresAt: serializer.fromJson<int>(json['expiresAt']),
      confirmedAt: serializer.fromJson<int?>(json['confirmedAt']),
      executedAt: serializer.fromJson<int?>(json['executedAt']),
      undoneAt: serializer.fromJson<int?>(json['undoneAt']),
      errorCode: serializer.fromJson<String?>(json['errorCode']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'conversationId': serializer.toJson<String>(conversationId),
      'actionType': serializer.toJson<String>(actionType),
      'toolName': serializer.toJson<String>(toolName),
      'proposedPayloadJson': serializer.toJson<String>(proposedPayloadJson),
      'validatedPayloadJson': serializer.toJson<String>(validatedPayloadJson),
      'beforeSnapshotJson': serializer.toJson<String>(beforeSnapshotJson),
      'afterSnapshotJson': serializer.toJson<String?>(afterSnapshotJson),
      'status': serializer.toJson<String>(status),
      'confirmationTokenHash': serializer.toJson<String>(confirmationTokenHash),
      'idempotencyKey': serializer.toJson<String>(idempotencyKey),
      'inputVersion': serializer.toJson<String>(inputVersion),
      'expiresAt': serializer.toJson<int>(expiresAt),
      'confirmedAt': serializer.toJson<int?>(confirmedAt),
      'executedAt': serializer.toJson<int?>(executedAt),
      'undoneAt': serializer.toJson<int?>(undoneAt),
      'errorCode': serializer.toJson<String?>(errorCode),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  AiAction copyWith({
    String? id,
    String? conversationId,
    String? actionType,
    String? toolName,
    String? proposedPayloadJson,
    String? validatedPayloadJson,
    String? beforeSnapshotJson,
    Value<String?> afterSnapshotJson = const Value.absent(),
    String? status,
    String? confirmationTokenHash,
    String? idempotencyKey,
    String? inputVersion,
    int? expiresAt,
    Value<int?> confirmedAt = const Value.absent(),
    Value<int?> executedAt = const Value.absent(),
    Value<int?> undoneAt = const Value.absent(),
    Value<String?> errorCode = const Value.absent(),
    int? createdAt,
  }) => AiAction(
    id: id ?? this.id,
    conversationId: conversationId ?? this.conversationId,
    actionType: actionType ?? this.actionType,
    toolName: toolName ?? this.toolName,
    proposedPayloadJson: proposedPayloadJson ?? this.proposedPayloadJson,
    validatedPayloadJson: validatedPayloadJson ?? this.validatedPayloadJson,
    beforeSnapshotJson: beforeSnapshotJson ?? this.beforeSnapshotJson,
    afterSnapshotJson: afterSnapshotJson.present
        ? afterSnapshotJson.value
        : this.afterSnapshotJson,
    status: status ?? this.status,
    confirmationTokenHash: confirmationTokenHash ?? this.confirmationTokenHash,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    inputVersion: inputVersion ?? this.inputVersion,
    expiresAt: expiresAt ?? this.expiresAt,
    confirmedAt: confirmedAt.present ? confirmedAt.value : this.confirmedAt,
    executedAt: executedAt.present ? executedAt.value : this.executedAt,
    undoneAt: undoneAt.present ? undoneAt.value : this.undoneAt,
    errorCode: errorCode.present ? errorCode.value : this.errorCode,
    createdAt: createdAt ?? this.createdAt,
  );
  AiAction copyWithCompanion(AiActionsCompanion data) {
    return AiAction(
      id: data.id.present ? data.id.value : this.id,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      actionType: data.actionType.present
          ? data.actionType.value
          : this.actionType,
      toolName: data.toolName.present ? data.toolName.value : this.toolName,
      proposedPayloadJson: data.proposedPayloadJson.present
          ? data.proposedPayloadJson.value
          : this.proposedPayloadJson,
      validatedPayloadJson: data.validatedPayloadJson.present
          ? data.validatedPayloadJson.value
          : this.validatedPayloadJson,
      beforeSnapshotJson: data.beforeSnapshotJson.present
          ? data.beforeSnapshotJson.value
          : this.beforeSnapshotJson,
      afterSnapshotJson: data.afterSnapshotJson.present
          ? data.afterSnapshotJson.value
          : this.afterSnapshotJson,
      status: data.status.present ? data.status.value : this.status,
      confirmationTokenHash: data.confirmationTokenHash.present
          ? data.confirmationTokenHash.value
          : this.confirmationTokenHash,
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
      inputVersion: data.inputVersion.present
          ? data.inputVersion.value
          : this.inputVersion,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      confirmedAt: data.confirmedAt.present
          ? data.confirmedAt.value
          : this.confirmedAt,
      executedAt: data.executedAt.present
          ? data.executedAt.value
          : this.executedAt,
      undoneAt: data.undoneAt.present ? data.undoneAt.value : this.undoneAt,
      errorCode: data.errorCode.present ? data.errorCode.value : this.errorCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiAction(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('actionType: $actionType, ')
          ..write('toolName: $toolName, ')
          ..write('proposedPayloadJson: $proposedPayloadJson, ')
          ..write('validatedPayloadJson: $validatedPayloadJson, ')
          ..write('beforeSnapshotJson: $beforeSnapshotJson, ')
          ..write('afterSnapshotJson: $afterSnapshotJson, ')
          ..write('status: $status, ')
          ..write('confirmationTokenHash: $confirmationTokenHash, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('inputVersion: $inputVersion, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('confirmedAt: $confirmedAt, ')
          ..write('executedAt: $executedAt, ')
          ..write('undoneAt: $undoneAt, ')
          ..write('errorCode: $errorCode, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    conversationId,
    actionType,
    toolName,
    proposedPayloadJson,
    validatedPayloadJson,
    beforeSnapshotJson,
    afterSnapshotJson,
    status,
    confirmationTokenHash,
    idempotencyKey,
    inputVersion,
    expiresAt,
    confirmedAt,
    executedAt,
    undoneAt,
    errorCode,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiAction &&
          other.id == this.id &&
          other.conversationId == this.conversationId &&
          other.actionType == this.actionType &&
          other.toolName == this.toolName &&
          other.proposedPayloadJson == this.proposedPayloadJson &&
          other.validatedPayloadJson == this.validatedPayloadJson &&
          other.beforeSnapshotJson == this.beforeSnapshotJson &&
          other.afterSnapshotJson == this.afterSnapshotJson &&
          other.status == this.status &&
          other.confirmationTokenHash == this.confirmationTokenHash &&
          other.idempotencyKey == this.idempotencyKey &&
          other.inputVersion == this.inputVersion &&
          other.expiresAt == this.expiresAt &&
          other.confirmedAt == this.confirmedAt &&
          other.executedAt == this.executedAt &&
          other.undoneAt == this.undoneAt &&
          other.errorCode == this.errorCode &&
          other.createdAt == this.createdAt);
}

class AiActionsCompanion extends UpdateCompanion<AiAction> {
  final Value<String> id;
  final Value<String> conversationId;
  final Value<String> actionType;
  final Value<String> toolName;
  final Value<String> proposedPayloadJson;
  final Value<String> validatedPayloadJson;
  final Value<String> beforeSnapshotJson;
  final Value<String?> afterSnapshotJson;
  final Value<String> status;
  final Value<String> confirmationTokenHash;
  final Value<String> idempotencyKey;
  final Value<String> inputVersion;
  final Value<int> expiresAt;
  final Value<int?> confirmedAt;
  final Value<int?> executedAt;
  final Value<int?> undoneAt;
  final Value<String?> errorCode;
  final Value<int> createdAt;
  final Value<int> rowid;
  const AiActionsCompanion({
    this.id = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.actionType = const Value.absent(),
    this.toolName = const Value.absent(),
    this.proposedPayloadJson = const Value.absent(),
    this.validatedPayloadJson = const Value.absent(),
    this.beforeSnapshotJson = const Value.absent(),
    this.afterSnapshotJson = const Value.absent(),
    this.status = const Value.absent(),
    this.confirmationTokenHash = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.inputVersion = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.confirmedAt = const Value.absent(),
    this.executedAt = const Value.absent(),
    this.undoneAt = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiActionsCompanion.insert({
    required String id,
    required String conversationId,
    required String actionType,
    required String toolName,
    required String proposedPayloadJson,
    required String validatedPayloadJson,
    required String beforeSnapshotJson,
    this.afterSnapshotJson = const Value.absent(),
    required String status,
    required String confirmationTokenHash,
    required String idempotencyKey,
    required String inputVersion,
    required int expiresAt,
    this.confirmedAt = const Value.absent(),
    this.executedAt = const Value.absent(),
    this.undoneAt = const Value.absent(),
    this.errorCode = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       conversationId = Value(conversationId),
       actionType = Value(actionType),
       toolName = Value(toolName),
       proposedPayloadJson = Value(proposedPayloadJson),
       validatedPayloadJson = Value(validatedPayloadJson),
       beforeSnapshotJson = Value(beforeSnapshotJson),
       status = Value(status),
       confirmationTokenHash = Value(confirmationTokenHash),
       idempotencyKey = Value(idempotencyKey),
       inputVersion = Value(inputVersion),
       expiresAt = Value(expiresAt),
       createdAt = Value(createdAt);
  static Insertable<AiAction> custom({
    Expression<String>? id,
    Expression<String>? conversationId,
    Expression<String>? actionType,
    Expression<String>? toolName,
    Expression<String>? proposedPayloadJson,
    Expression<String>? validatedPayloadJson,
    Expression<String>? beforeSnapshotJson,
    Expression<String>? afterSnapshotJson,
    Expression<String>? status,
    Expression<String>? confirmationTokenHash,
    Expression<String>? idempotencyKey,
    Expression<String>? inputVersion,
    Expression<int>? expiresAt,
    Expression<int>? confirmedAt,
    Expression<int>? executedAt,
    Expression<int>? undoneAt,
    Expression<String>? errorCode,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conversationId != null) 'conversation_id': conversationId,
      if (actionType != null) 'action_type': actionType,
      if (toolName != null) 'tool_name': toolName,
      if (proposedPayloadJson != null)
        'proposed_payload_json': proposedPayloadJson,
      if (validatedPayloadJson != null)
        'validated_payload_json': validatedPayloadJson,
      if (beforeSnapshotJson != null)
        'before_snapshot_json': beforeSnapshotJson,
      if (afterSnapshotJson != null) 'after_snapshot_json': afterSnapshotJson,
      if (status != null) 'status': status,
      if (confirmationTokenHash != null)
        'confirmation_token_hash': confirmationTokenHash,
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      if (inputVersion != null) 'input_version': inputVersion,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (confirmedAt != null) 'confirmed_at': confirmedAt,
      if (executedAt != null) 'executed_at': executedAt,
      if (undoneAt != null) 'undone_at': undoneAt,
      if (errorCode != null) 'error_code': errorCode,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiActionsCompanion copyWith({
    Value<String>? id,
    Value<String>? conversationId,
    Value<String>? actionType,
    Value<String>? toolName,
    Value<String>? proposedPayloadJson,
    Value<String>? validatedPayloadJson,
    Value<String>? beforeSnapshotJson,
    Value<String?>? afterSnapshotJson,
    Value<String>? status,
    Value<String>? confirmationTokenHash,
    Value<String>? idempotencyKey,
    Value<String>? inputVersion,
    Value<int>? expiresAt,
    Value<int?>? confirmedAt,
    Value<int?>? executedAt,
    Value<int?>? undoneAt,
    Value<String?>? errorCode,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return AiActionsCompanion(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      actionType: actionType ?? this.actionType,
      toolName: toolName ?? this.toolName,
      proposedPayloadJson: proposedPayloadJson ?? this.proposedPayloadJson,
      validatedPayloadJson: validatedPayloadJson ?? this.validatedPayloadJson,
      beforeSnapshotJson: beforeSnapshotJson ?? this.beforeSnapshotJson,
      afterSnapshotJson: afterSnapshotJson ?? this.afterSnapshotJson,
      status: status ?? this.status,
      confirmationTokenHash:
          confirmationTokenHash ?? this.confirmationTokenHash,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      inputVersion: inputVersion ?? this.inputVersion,
      expiresAt: expiresAt ?? this.expiresAt,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      executedAt: executedAt ?? this.executedAt,
      undoneAt: undoneAt ?? this.undoneAt,
      errorCode: errorCode ?? this.errorCode,
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
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (actionType.present) {
      map['action_type'] = Variable<String>(actionType.value);
    }
    if (toolName.present) {
      map['tool_name'] = Variable<String>(toolName.value);
    }
    if (proposedPayloadJson.present) {
      map['proposed_payload_json'] = Variable<String>(
        proposedPayloadJson.value,
      );
    }
    if (validatedPayloadJson.present) {
      map['validated_payload_json'] = Variable<String>(
        validatedPayloadJson.value,
      );
    }
    if (beforeSnapshotJson.present) {
      map['before_snapshot_json'] = Variable<String>(beforeSnapshotJson.value);
    }
    if (afterSnapshotJson.present) {
      map['after_snapshot_json'] = Variable<String>(afterSnapshotJson.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (confirmationTokenHash.present) {
      map['confirmation_token_hash'] = Variable<String>(
        confirmationTokenHash.value,
      );
    }
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    if (inputVersion.present) {
      map['input_version'] = Variable<String>(inputVersion.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<int>(expiresAt.value);
    }
    if (confirmedAt.present) {
      map['confirmed_at'] = Variable<int>(confirmedAt.value);
    }
    if (executedAt.present) {
      map['executed_at'] = Variable<int>(executedAt.value);
    }
    if (undoneAt.present) {
      map['undone_at'] = Variable<int>(undoneAt.value);
    }
    if (errorCode.present) {
      map['error_code'] = Variable<String>(errorCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiActionsCompanion(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('actionType: $actionType, ')
          ..write('toolName: $toolName, ')
          ..write('proposedPayloadJson: $proposedPayloadJson, ')
          ..write('validatedPayloadJson: $validatedPayloadJson, ')
          ..write('beforeSnapshotJson: $beforeSnapshotJson, ')
          ..write('afterSnapshotJson: $afterSnapshotJson, ')
          ..write('status: $status, ')
          ..write('confirmationTokenHash: $confirmationTokenHash, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('inputVersion: $inputVersion, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('confirmedAt: $confirmedAt, ')
          ..write('executedAt: $executedAt, ')
          ..write('undoneAt: $undoneAt, ')
          ..write('errorCode: $errorCode, ')
          ..write('createdAt: $createdAt, ')
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
  late final $ShiftTemplatesTable shiftTemplates = $ShiftTemplatesTable(this);
  late final $ScheduleRulesTable scheduleRules = $ScheduleRulesTable(this);
  late final $DayOverridesTable dayOverrides = $DayOverridesTable(this);
  late final $HolidayRecordsTable holidayRecords = $HolidayRecordsTable(this);
  late final $CalendarDayCacheTable calendarDayCache = $CalendarDayCacheTable(
    this,
  );
  late final $ChangeLogTable changeLog = $ChangeLogTable(this);
  late final $AlarmTemplatesTable alarmTemplates = $AlarmTemplatesTable(this);
  late final $ShiftAlarmTemplatesTable shiftAlarmTemplates =
      $ShiftAlarmTemplatesTable(this);
  late final $AlarmInstancesTable alarmInstances = $AlarmInstancesTable(this);
  late final $AttendanceRecordsTable attendanceRecords =
      $AttendanceRecordsTable(this);
  late final $LeaveRecordsTable leaveRecords = $LeaveRecordsTable(this);
  late final $WageRulesTable wageRules = $WageRulesTable(this);
  late final $PayrollPeriodsTable payrollPeriods = $PayrollPeriodsTable(this);
  late final $AiProviderConfigsTable aiProviderConfigs =
      $AiProviderConfigsTable(this);
  late final $AssistantPersonasTable assistantPersonas =
      $AssistantPersonasTable(this);
  late final $ConversationsTable conversations = $ConversationsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $AiActionsTable aiActions = $AiActionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    databaseMetadata,
    userSettings,
    shiftTemplates,
    scheduleRules,
    dayOverrides,
    holidayRecords,
    calendarDayCache,
    changeLog,
    alarmTemplates,
    shiftAlarmTemplates,
    alarmInstances,
    attendanceRecords,
    leaveRecords,
    wageRules,
    payrollPeriods,
    aiProviderConfigs,
    assistantPersonas,
    conversations,
    messages,
    aiActions,
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
typedef $$ShiftTemplatesTableCreateCompanionBuilder =
    ShiftTemplatesCompanion Function({
      required String id,
      required String name,
      required String shortName,
      Value<int?> startMinute,
      Value<int?> endMinute,
      required int crossDay,
      required int unpaidBreakMinutes,
      Value<int?> plannedPaidMinutes,
      required int colorArgb,
      required int isWorkday,
      required int enabled,
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$ShiftTemplatesTableUpdateCompanionBuilder =
    ShiftTemplatesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> shortName,
      Value<int?> startMinute,
      Value<int?> endMinute,
      Value<int> crossDay,
      Value<int> unpaidBreakMinutes,
      Value<int?> plannedPaidMinutes,
      Value<int> colorArgb,
      Value<int> isWorkday,
      Value<int> enabled,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$ShiftTemplatesTableReferences
    extends BaseReferences<_$AppDatabase, $ShiftTemplatesTable, ShiftTemplate> {
  $$ShiftTemplatesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$DayOverridesTable, List<DayOverride>>
  _dayOverridesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dayOverrides,
    aliasName: 'shift_templates__id__day_overrides__shift_template_id',
  );

  $$DayOverridesTableProcessedTableManager get dayOverridesRefs {
    final manager = $$DayOverridesTableTableManager($_db, $_db.dayOverrides)
        .filter(
          (f) => f.shiftTemplateId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_dayOverridesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ShiftAlarmTemplatesTable,
    List<ShiftAlarmTemplate>
  >
  _shiftAlarmTemplatesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.shiftAlarmTemplates,
        aliasName:
            'shift_templates__id__shift_alarm_templates__shift_template_id',
      );

  $$ShiftAlarmTemplatesTableProcessedTableManager get shiftAlarmTemplatesRefs {
    final manager =
        $$ShiftAlarmTemplatesTableTableManager(
          $_db,
          $_db.shiftAlarmTemplates,
        ).filter(
          (f) => f.shiftTemplateId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _shiftAlarmTemplatesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ShiftTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $ShiftTemplatesTable> {
  $$ShiftTemplatesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shortName => $composableBuilder(
    column: $table.shortName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endMinute => $composableBuilder(
    column: $table.endMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get crossDay => $composableBuilder(
    column: $table.crossDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unpaidBreakMinutes => $composableBuilder(
    column: $table.unpaidBreakMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedPaidMinutes => $composableBuilder(
    column: $table.plannedPaidMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorArgb => $composableBuilder(
    column: $table.colorArgb,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isWorkday => $composableBuilder(
    column: $table.isWorkday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get enabled => $composableBuilder(
    column: $table.enabled,
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

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> dayOverridesRefs(
    Expression<bool> Function($$DayOverridesTableFilterComposer f) f,
  ) {
    final $$DayOverridesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dayOverrides,
      getReferencedColumn: (t) => t.shiftTemplateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DayOverridesTableFilterComposer(
            $db: $db,
            $table: $db.dayOverrides,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> shiftAlarmTemplatesRefs(
    Expression<bool> Function($$ShiftAlarmTemplatesTableFilterComposer f) f,
  ) {
    final $$ShiftAlarmTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shiftAlarmTemplates,
      getReferencedColumn: (t) => t.shiftTemplateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftAlarmTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.shiftAlarmTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShiftTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ShiftTemplatesTable> {
  $$ShiftTemplatesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortName => $composableBuilder(
    column: $table.shortName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endMinute => $composableBuilder(
    column: $table.endMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get crossDay => $composableBuilder(
    column: $table.crossDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unpaidBreakMinutes => $composableBuilder(
    column: $table.unpaidBreakMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedPaidMinutes => $composableBuilder(
    column: $table.plannedPaidMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorArgb => $composableBuilder(
    column: $table.colorArgb,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isWorkday => $composableBuilder(
    column: $table.isWorkday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get enabled => $composableBuilder(
    column: $table.enabled,
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

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShiftTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShiftTemplatesTable> {
  $$ShiftTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get shortName =>
      $composableBuilder(column: $table.shortName, builder: (column) => column);

  GeneratedColumn<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endMinute =>
      $composableBuilder(column: $table.endMinute, builder: (column) => column);

  GeneratedColumn<int> get crossDay =>
      $composableBuilder(column: $table.crossDay, builder: (column) => column);

  GeneratedColumn<int> get unpaidBreakMinutes => $composableBuilder(
    column: $table.unpaidBreakMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get plannedPaidMinutes => $composableBuilder(
    column: $table.plannedPaidMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorArgb =>
      $composableBuilder(column: $table.colorArgb, builder: (column) => column);

  GeneratedColumn<int> get isWorkday =>
      $composableBuilder(column: $table.isWorkday, builder: (column) => column);

  GeneratedColumn<int> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> dayOverridesRefs<T extends Object>(
    Expression<T> Function($$DayOverridesTableAnnotationComposer a) f,
  ) {
    final $$DayOverridesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dayOverrides,
      getReferencedColumn: (t) => t.shiftTemplateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DayOverridesTableAnnotationComposer(
            $db: $db,
            $table: $db.dayOverrides,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> shiftAlarmTemplatesRefs<T extends Object>(
    Expression<T> Function($$ShiftAlarmTemplatesTableAnnotationComposer a) f,
  ) {
    final $$ShiftAlarmTemplatesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.shiftAlarmTemplates,
          getReferencedColumn: (t) => t.shiftTemplateId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ShiftAlarmTemplatesTableAnnotationComposer(
                $db: $db,
                $table: $db.shiftAlarmTemplates,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ShiftTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShiftTemplatesTable,
          ShiftTemplate,
          $$ShiftTemplatesTableFilterComposer,
          $$ShiftTemplatesTableOrderingComposer,
          $$ShiftTemplatesTableAnnotationComposer,
          $$ShiftTemplatesTableCreateCompanionBuilder,
          $$ShiftTemplatesTableUpdateCompanionBuilder,
          (ShiftTemplate, $$ShiftTemplatesTableReferences),
          ShiftTemplate,
          PrefetchHooks Function({
            bool dayOverridesRefs,
            bool shiftAlarmTemplatesRefs,
          })
        > {
  $$ShiftTemplatesTableTableManager(
    _$AppDatabase db,
    $ShiftTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShiftTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShiftTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShiftTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> shortName = const Value.absent(),
                Value<int?> startMinute = const Value.absent(),
                Value<int?> endMinute = const Value.absent(),
                Value<int> crossDay = const Value.absent(),
                Value<int> unpaidBreakMinutes = const Value.absent(),
                Value<int?> plannedPaidMinutes = const Value.absent(),
                Value<int> colorArgb = const Value.absent(),
                Value<int> isWorkday = const Value.absent(),
                Value<int> enabled = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShiftTemplatesCompanion(
                id: id,
                name: name,
                shortName: shortName,
                startMinute: startMinute,
                endMinute: endMinute,
                crossDay: crossDay,
                unpaidBreakMinutes: unpaidBreakMinutes,
                plannedPaidMinutes: plannedPaidMinutes,
                colorArgb: colorArgb,
                isWorkday: isWorkday,
                enabled: enabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String shortName,
                Value<int?> startMinute = const Value.absent(),
                Value<int?> endMinute = const Value.absent(),
                required int crossDay,
                required int unpaidBreakMinutes,
                Value<int?> plannedPaidMinutes = const Value.absent(),
                required int colorArgb,
                required int isWorkday,
                required int enabled,
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShiftTemplatesCompanion.insert(
                id: id,
                name: name,
                shortName: shortName,
                startMinute: startMinute,
                endMinute: endMinute,
                crossDay: crossDay,
                unpaidBreakMinutes: unpaidBreakMinutes,
                plannedPaidMinutes: plannedPaidMinutes,
                colorArgb: colorArgb,
                isWorkday: isWorkday,
                enabled: enabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ShiftTemplatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({dayOverridesRefs = false, shiftAlarmTemplatesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (dayOverridesRefs) db.dayOverrides,
                    if (shiftAlarmTemplatesRefs) db.shiftAlarmTemplates,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (dayOverridesRefs)
                        await $_getPrefetchedData<
                          ShiftTemplate,
                          $ShiftTemplatesTable,
                          DayOverride
                        >(
                          currentTable: table,
                          referencedTable: $$ShiftTemplatesTableReferences
                              ._dayOverridesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShiftTemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).dayOverridesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shiftTemplateId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (shiftAlarmTemplatesRefs)
                        await $_getPrefetchedData<
                          ShiftTemplate,
                          $ShiftTemplatesTable,
                          ShiftAlarmTemplate
                        >(
                          currentTable: table,
                          referencedTable: $$ShiftTemplatesTableReferences
                              ._shiftAlarmTemplatesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShiftTemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).shiftAlarmTemplatesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shiftTemplateId == item.id,
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

typedef $$ShiftTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShiftTemplatesTable,
      ShiftTemplate,
      $$ShiftTemplatesTableFilterComposer,
      $$ShiftTemplatesTableOrderingComposer,
      $$ShiftTemplatesTableAnnotationComposer,
      $$ShiftTemplatesTableCreateCompanionBuilder,
      $$ShiftTemplatesTableUpdateCompanionBuilder,
      (ShiftTemplate, $$ShiftTemplatesTableReferences),
      ShiftTemplate,
      PrefetchHooks Function({
        bool dayOverridesRefs,
        bool shiftAlarmTemplatesRefs,
      })
    >;
typedef $$ScheduleRulesTableCreateCompanionBuilder =
    ScheduleRulesCompanion Function({
      required String id,
      required String name,
      required String ruleType,
      required String anchorDate,
      Value<int?> cycleLengthDays,
      required String cyclePayloadJson,
      required String effectiveStart,
      Value<String?> effectiveEnd,
      required int priority,
      required int enabled,
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$ScheduleRulesTableUpdateCompanionBuilder =
    ScheduleRulesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> ruleType,
      Value<String> anchorDate,
      Value<int?> cycleLengthDays,
      Value<String> cyclePayloadJson,
      Value<String> effectiveStart,
      Value<String?> effectiveEnd,
      Value<int> priority,
      Value<int> enabled,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

class $$ScheduleRulesTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduleRulesTable> {
  $$ScheduleRulesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get anchorDate => $composableBuilder(
    column: $table.anchorDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cycleLengthDays => $composableBuilder(
    column: $table.cycleLengthDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cyclePayloadJson => $composableBuilder(
    column: $table.cyclePayloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectiveStart => $composableBuilder(
    column: $table.effectiveStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectiveEnd => $composableBuilder(
    column: $table.effectiveEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get enabled => $composableBuilder(
    column: $table.enabled,
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

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScheduleRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduleRulesTable> {
  $$ScheduleRulesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get anchorDate => $composableBuilder(
    column: $table.anchorDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cycleLengthDays => $composableBuilder(
    column: $table.cycleLengthDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cyclePayloadJson => $composableBuilder(
    column: $table.cyclePayloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectiveStart => $composableBuilder(
    column: $table.effectiveStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectiveEnd => $composableBuilder(
    column: $table.effectiveEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get enabled => $composableBuilder(
    column: $table.enabled,
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

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScheduleRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduleRulesTable> {
  $$ScheduleRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get ruleType =>
      $composableBuilder(column: $table.ruleType, builder: (column) => column);

  GeneratedColumn<String> get anchorDate => $composableBuilder(
    column: $table.anchorDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cycleLengthDays => $composableBuilder(
    column: $table.cycleLengthDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cyclePayloadJson => $composableBuilder(
    column: $table.cyclePayloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get effectiveStart => $composableBuilder(
    column: $table.effectiveStart,
    builder: (column) => column,
  );

  GeneratedColumn<String> get effectiveEnd => $composableBuilder(
    column: $table.effectiveEnd,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<int> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$ScheduleRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScheduleRulesTable,
          ScheduleRule,
          $$ScheduleRulesTableFilterComposer,
          $$ScheduleRulesTableOrderingComposer,
          $$ScheduleRulesTableAnnotationComposer,
          $$ScheduleRulesTableCreateCompanionBuilder,
          $$ScheduleRulesTableUpdateCompanionBuilder,
          (
            ScheduleRule,
            BaseReferences<_$AppDatabase, $ScheduleRulesTable, ScheduleRule>,
          ),
          ScheduleRule,
          PrefetchHooks Function()
        > {
  $$ScheduleRulesTableTableManager(_$AppDatabase db, $ScheduleRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduleRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScheduleRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScheduleRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> ruleType = const Value.absent(),
                Value<String> anchorDate = const Value.absent(),
                Value<int?> cycleLengthDays = const Value.absent(),
                Value<String> cyclePayloadJson = const Value.absent(),
                Value<String> effectiveStart = const Value.absent(),
                Value<String?> effectiveEnd = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> enabled = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScheduleRulesCompanion(
                id: id,
                name: name,
                ruleType: ruleType,
                anchorDate: anchorDate,
                cycleLengthDays: cycleLengthDays,
                cyclePayloadJson: cyclePayloadJson,
                effectiveStart: effectiveStart,
                effectiveEnd: effectiveEnd,
                priority: priority,
                enabled: enabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String ruleType,
                required String anchorDate,
                Value<int?> cycleLengthDays = const Value.absent(),
                required String cyclePayloadJson,
                required String effectiveStart,
                Value<String?> effectiveEnd = const Value.absent(),
                required int priority,
                required int enabled,
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScheduleRulesCompanion.insert(
                id: id,
                name: name,
                ruleType: ruleType,
                anchorDate: anchorDate,
                cycleLengthDays: cycleLengthDays,
                cyclePayloadJson: cyclePayloadJson,
                effectiveStart: effectiveStart,
                effectiveEnd: effectiveEnd,
                priority: priority,
                enabled: enabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScheduleRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScheduleRulesTable,
      ScheduleRule,
      $$ScheduleRulesTableFilterComposer,
      $$ScheduleRulesTableOrderingComposer,
      $$ScheduleRulesTableAnnotationComposer,
      $$ScheduleRulesTableCreateCompanionBuilder,
      $$ScheduleRulesTableUpdateCompanionBuilder,
      (
        ScheduleRule,
        BaseReferences<_$AppDatabase, $ScheduleRulesTable, ScheduleRule>,
      ),
      ScheduleRule,
      PrefetchHooks Function()
    >;
typedef $$DayOverridesTableCreateCompanionBuilder =
    DayOverridesCompanion Function({
      required String id,
      required String workDate,
      required String status,
      Value<String?> shiftTemplateId,
      Value<String?> shiftSnapshotJson,
      required String overrideType,
      Value<String?> reason,
      Value<String?> note,
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$DayOverridesTableUpdateCompanionBuilder =
    DayOverridesCompanion Function({
      Value<String> id,
      Value<String> workDate,
      Value<String> status,
      Value<String?> shiftTemplateId,
      Value<String?> shiftSnapshotJson,
      Value<String> overrideType,
      Value<String?> reason,
      Value<String?> note,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$DayOverridesTableReferences
    extends BaseReferences<_$AppDatabase, $DayOverridesTable, DayOverride> {
  $$DayOverridesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShiftTemplatesTable _shiftTemplateIdTable(_$AppDatabase db) => db
      .shiftTemplates
      .createAlias('day_overrides__shift_template_id__shift_templates__id');

  $$ShiftTemplatesTableProcessedTableManager? get shiftTemplateId {
    final $_column = $_itemColumn<String>('shift_template_id');
    if ($_column == null) return null;
    final manager = $$ShiftTemplatesTableTableManager(
      $_db,
      $_db.shiftTemplates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shiftTemplateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DayOverridesTableFilterComposer
    extends Composer<_$AppDatabase, $DayOverridesTable> {
  $$DayOverridesTableFilterComposer({
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

  ColumnFilters<String> get workDate => $composableBuilder(
    column: $table.workDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shiftSnapshotJson => $composableBuilder(
    column: $table.shiftSnapshotJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overrideType => $composableBuilder(
    column: $table.overrideType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
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

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ShiftTemplatesTableFilterComposer get shiftTemplateId {
    final $$ShiftTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shiftTemplateId,
      referencedTable: $db.shiftTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.shiftTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DayOverridesTableOrderingComposer
    extends Composer<_$AppDatabase, $DayOverridesTable> {
  $$DayOverridesTableOrderingComposer({
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

  ColumnOrderings<String> get workDate => $composableBuilder(
    column: $table.workDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shiftSnapshotJson => $composableBuilder(
    column: $table.shiftSnapshotJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overrideType => $composableBuilder(
    column: $table.overrideType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
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

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ShiftTemplatesTableOrderingComposer get shiftTemplateId {
    final $$ShiftTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shiftTemplateId,
      referencedTable: $db.shiftTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.shiftTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DayOverridesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DayOverridesTable> {
  $$DayOverridesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workDate =>
      $composableBuilder(column: $table.workDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get shiftSnapshotJson => $composableBuilder(
    column: $table.shiftSnapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get overrideType => $composableBuilder(
    column: $table.overrideType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$ShiftTemplatesTableAnnotationComposer get shiftTemplateId {
    final $$ShiftTemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shiftTemplateId,
      referencedTable: $db.shiftTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftTemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.shiftTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DayOverridesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DayOverridesTable,
          DayOverride,
          $$DayOverridesTableFilterComposer,
          $$DayOverridesTableOrderingComposer,
          $$DayOverridesTableAnnotationComposer,
          $$DayOverridesTableCreateCompanionBuilder,
          $$DayOverridesTableUpdateCompanionBuilder,
          (DayOverride, $$DayOverridesTableReferences),
          DayOverride,
          PrefetchHooks Function({bool shiftTemplateId})
        > {
  $$DayOverridesTableTableManager(_$AppDatabase db, $DayOverridesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DayOverridesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DayOverridesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DayOverridesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> shiftTemplateId = const Value.absent(),
                Value<String?> shiftSnapshotJson = const Value.absent(),
                Value<String> overrideType = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DayOverridesCompanion(
                id: id,
                workDate: workDate,
                status: status,
                shiftTemplateId: shiftTemplateId,
                shiftSnapshotJson: shiftSnapshotJson,
                overrideType: overrideType,
                reason: reason,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workDate,
                required String status,
                Value<String?> shiftTemplateId = const Value.absent(),
                Value<String?> shiftSnapshotJson = const Value.absent(),
                required String overrideType,
                Value<String?> reason = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DayOverridesCompanion.insert(
                id: id,
                workDate: workDate,
                status: status,
                shiftTemplateId: shiftTemplateId,
                shiftSnapshotJson: shiftSnapshotJson,
                overrideType: overrideType,
                reason: reason,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DayOverridesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shiftTemplateId = false}) {
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
                    if (shiftTemplateId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.shiftTemplateId,
                                referencedTable: $$DayOverridesTableReferences
                                    ._shiftTemplateIdTable(db),
                                referencedColumn: $$DayOverridesTableReferences
                                    ._shiftTemplateIdTable(db)
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

typedef $$DayOverridesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DayOverridesTable,
      DayOverride,
      $$DayOverridesTableFilterComposer,
      $$DayOverridesTableOrderingComposer,
      $$DayOverridesTableAnnotationComposer,
      $$DayOverridesTableCreateCompanionBuilder,
      $$DayOverridesTableUpdateCompanionBuilder,
      (DayOverride, $$DayOverridesTableReferences),
      DayOverride,
      PrefetchHooks Function({bool shiftTemplateId})
    >;
typedef $$HolidayRecordsTableCreateCompanionBuilder =
    HolidayRecordsCompanion Function({
      required String workDate,
      required String region,
      required String name,
      required String dayType,
      required String dataVersion,
      Value<int?> publishedAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$HolidayRecordsTableUpdateCompanionBuilder =
    HolidayRecordsCompanion Function({
      Value<String> workDate,
      Value<String> region,
      Value<String> name,
      Value<String> dayType,
      Value<String> dataVersion,
      Value<int?> publishedAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$HolidayRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $HolidayRecordsTable> {
  $$HolidayRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get workDate => $composableBuilder(
    column: $table.workDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dayType => $composableBuilder(
    column: $table.dayType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dataVersion => $composableBuilder(
    column: $table.dataVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HolidayRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $HolidayRecordsTable> {
  $$HolidayRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get workDate => $composableBuilder(
    column: $table.workDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dayType => $composableBuilder(
    column: $table.dayType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dataVersion => $composableBuilder(
    column: $table.dataVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HolidayRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HolidayRecordsTable> {
  $$HolidayRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get workDate =>
      $composableBuilder(column: $table.workDate, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get dayType =>
      $composableBuilder(column: $table.dayType, builder: (column) => column);

  GeneratedColumn<String> get dataVersion => $composableBuilder(
    column: $table.dataVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$HolidayRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HolidayRecordsTable,
          HolidayRecord,
          $$HolidayRecordsTableFilterComposer,
          $$HolidayRecordsTableOrderingComposer,
          $$HolidayRecordsTableAnnotationComposer,
          $$HolidayRecordsTableCreateCompanionBuilder,
          $$HolidayRecordsTableUpdateCompanionBuilder,
          (
            HolidayRecord,
            BaseReferences<_$AppDatabase, $HolidayRecordsTable, HolidayRecord>,
          ),
          HolidayRecord,
          PrefetchHooks Function()
        > {
  $$HolidayRecordsTableTableManager(
    _$AppDatabase db,
    $HolidayRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HolidayRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HolidayRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HolidayRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> workDate = const Value.absent(),
                Value<String> region = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> dayType = const Value.absent(),
                Value<String> dataVersion = const Value.absent(),
                Value<int?> publishedAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HolidayRecordsCompanion(
                workDate: workDate,
                region: region,
                name: name,
                dayType: dayType,
                dataVersion: dataVersion,
                publishedAt: publishedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String workDate,
                required String region,
                required String name,
                required String dayType,
                required String dataVersion,
                Value<int?> publishedAt = const Value.absent(),
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => HolidayRecordsCompanion.insert(
                workDate: workDate,
                region: region,
                name: name,
                dayType: dayType,
                dataVersion: dataVersion,
                publishedAt: publishedAt,
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

typedef $$HolidayRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HolidayRecordsTable,
      HolidayRecord,
      $$HolidayRecordsTableFilterComposer,
      $$HolidayRecordsTableOrderingComposer,
      $$HolidayRecordsTableAnnotationComposer,
      $$HolidayRecordsTableCreateCompanionBuilder,
      $$HolidayRecordsTableUpdateCompanionBuilder,
      (
        HolidayRecord,
        BaseReferences<_$AppDatabase, $HolidayRecordsTable, HolidayRecord>,
      ),
      HolidayRecord,
      PrefetchHooks Function()
    >;
typedef $$CalendarDayCacheTableCreateCompanionBuilder =
    CalendarDayCacheCompanion Function({
      required String workDate,
      required String resolvedStatus,
      Value<String?> shiftSnapshotJson,
      required String sourceType,
      Value<String?> sourceId,
      required int plannedMinutes,
      required int resolverVersion,
      required String inputVersion,
      required int resolvedAt,
      Value<int> rowid,
    });
typedef $$CalendarDayCacheTableUpdateCompanionBuilder =
    CalendarDayCacheCompanion Function({
      Value<String> workDate,
      Value<String> resolvedStatus,
      Value<String?> shiftSnapshotJson,
      Value<String> sourceType,
      Value<String?> sourceId,
      Value<int> plannedMinutes,
      Value<int> resolverVersion,
      Value<String> inputVersion,
      Value<int> resolvedAt,
      Value<int> rowid,
    });

class $$CalendarDayCacheTableFilterComposer
    extends Composer<_$AppDatabase, $CalendarDayCacheTable> {
  $$CalendarDayCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get workDate => $composableBuilder(
    column: $table.workDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resolvedStatus => $composableBuilder(
    column: $table.resolvedStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shiftSnapshotJson => $composableBuilder(
    column: $table.shiftSnapshotJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get resolverVersion => $composableBuilder(
    column: $table.resolverVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inputVersion => $composableBuilder(
    column: $table.inputVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CalendarDayCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $CalendarDayCacheTable> {
  $$CalendarDayCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get workDate => $composableBuilder(
    column: $table.workDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resolvedStatus => $composableBuilder(
    column: $table.resolvedStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shiftSnapshotJson => $composableBuilder(
    column: $table.shiftSnapshotJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get resolverVersion => $composableBuilder(
    column: $table.resolverVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inputVersion => $composableBuilder(
    column: $table.inputVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CalendarDayCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $CalendarDayCacheTable> {
  $$CalendarDayCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get workDate =>
      $composableBuilder(column: $table.workDate, builder: (column) => column);

  GeneratedColumn<String> get resolvedStatus => $composableBuilder(
    column: $table.resolvedStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shiftSnapshotJson => $composableBuilder(
    column: $table.shiftSnapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get resolverVersion => $composableBuilder(
    column: $table.resolverVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get inputVersion => $composableBuilder(
    column: $table.inputVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => column,
  );
}

class $$CalendarDayCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CalendarDayCacheTable,
          CalendarDayCacheData,
          $$CalendarDayCacheTableFilterComposer,
          $$CalendarDayCacheTableOrderingComposer,
          $$CalendarDayCacheTableAnnotationComposer,
          $$CalendarDayCacheTableCreateCompanionBuilder,
          $$CalendarDayCacheTableUpdateCompanionBuilder,
          (
            CalendarDayCacheData,
            BaseReferences<
              _$AppDatabase,
              $CalendarDayCacheTable,
              CalendarDayCacheData
            >,
          ),
          CalendarDayCacheData,
          PrefetchHooks Function()
        > {
  $$CalendarDayCacheTableTableManager(
    _$AppDatabase db,
    $CalendarDayCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalendarDayCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CalendarDayCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CalendarDayCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> workDate = const Value.absent(),
                Value<String> resolvedStatus = const Value.absent(),
                Value<String?> shiftSnapshotJson = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String?> sourceId = const Value.absent(),
                Value<int> plannedMinutes = const Value.absent(),
                Value<int> resolverVersion = const Value.absent(),
                Value<String> inputVersion = const Value.absent(),
                Value<int> resolvedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CalendarDayCacheCompanion(
                workDate: workDate,
                resolvedStatus: resolvedStatus,
                shiftSnapshotJson: shiftSnapshotJson,
                sourceType: sourceType,
                sourceId: sourceId,
                plannedMinutes: plannedMinutes,
                resolverVersion: resolverVersion,
                inputVersion: inputVersion,
                resolvedAt: resolvedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String workDate,
                required String resolvedStatus,
                Value<String?> shiftSnapshotJson = const Value.absent(),
                required String sourceType,
                Value<String?> sourceId = const Value.absent(),
                required int plannedMinutes,
                required int resolverVersion,
                required String inputVersion,
                required int resolvedAt,
                Value<int> rowid = const Value.absent(),
              }) => CalendarDayCacheCompanion.insert(
                workDate: workDate,
                resolvedStatus: resolvedStatus,
                shiftSnapshotJson: shiftSnapshotJson,
                sourceType: sourceType,
                sourceId: sourceId,
                plannedMinutes: plannedMinutes,
                resolverVersion: resolverVersion,
                inputVersion: inputVersion,
                resolvedAt: resolvedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CalendarDayCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CalendarDayCacheTable,
      CalendarDayCacheData,
      $$CalendarDayCacheTableFilterComposer,
      $$CalendarDayCacheTableOrderingComposer,
      $$CalendarDayCacheTableAnnotationComposer,
      $$CalendarDayCacheTableCreateCompanionBuilder,
      $$CalendarDayCacheTableUpdateCompanionBuilder,
      (
        CalendarDayCacheData,
        BaseReferences<
          _$AppDatabase,
          $CalendarDayCacheTable,
          CalendarDayCacheData
        >,
      ),
      CalendarDayCacheData,
      PrefetchHooks Function()
    >;
typedef $$ChangeLogTableCreateCompanionBuilder =
    ChangeLogCompanion Function({
      required String id,
      required String entityType,
      required String entityId,
      required String changeType,
      Value<String?> beforeSnapshotJson,
      Value<String?> afterSnapshotJson,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$ChangeLogTableUpdateCompanionBuilder =
    ChangeLogCompanion Function({
      Value<String> id,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> changeType,
      Value<String?> beforeSnapshotJson,
      Value<String?> afterSnapshotJson,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$ChangeLogTableFilterComposer
    extends Composer<_$AppDatabase, $ChangeLogTable> {
  $$ChangeLogTableFilterComposer({
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

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changeType => $composableBuilder(
    column: $table.changeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get beforeSnapshotJson => $composableBuilder(
    column: $table.beforeSnapshotJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get afterSnapshotJson => $composableBuilder(
    column: $table.afterSnapshotJson,
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

class $$ChangeLogTableOrderingComposer
    extends Composer<_$AppDatabase, $ChangeLogTable> {
  $$ChangeLogTableOrderingComposer({
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

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changeType => $composableBuilder(
    column: $table.changeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get beforeSnapshotJson => $composableBuilder(
    column: $table.beforeSnapshotJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get afterSnapshotJson => $composableBuilder(
    column: $table.afterSnapshotJson,
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

class $$ChangeLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChangeLogTable> {
  $$ChangeLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get changeType => $composableBuilder(
    column: $table.changeType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get beforeSnapshotJson => $composableBuilder(
    column: $table.beforeSnapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get afterSnapshotJson => $composableBuilder(
    column: $table.afterSnapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ChangeLogTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChangeLogTable,
          ChangeLogData,
          $$ChangeLogTableFilterComposer,
          $$ChangeLogTableOrderingComposer,
          $$ChangeLogTableAnnotationComposer,
          $$ChangeLogTableCreateCompanionBuilder,
          $$ChangeLogTableUpdateCompanionBuilder,
          (
            ChangeLogData,
            BaseReferences<_$AppDatabase, $ChangeLogTable, ChangeLogData>,
          ),
          ChangeLogData,
          PrefetchHooks Function()
        > {
  $$ChangeLogTableTableManager(_$AppDatabase db, $ChangeLogTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChangeLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChangeLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChangeLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> changeType = const Value.absent(),
                Value<String?> beforeSnapshotJson = const Value.absent(),
                Value<String?> afterSnapshotJson = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChangeLogCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                changeType: changeType,
                beforeSnapshotJson: beforeSnapshotJson,
                afterSnapshotJson: afterSnapshotJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entityType,
                required String entityId,
                required String changeType,
                Value<String?> beforeSnapshotJson = const Value.absent(),
                Value<String?> afterSnapshotJson = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ChangeLogCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                changeType: changeType,
                beforeSnapshotJson: beforeSnapshotJson,
                afterSnapshotJson: afterSnapshotJson,
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

typedef $$ChangeLogTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChangeLogTable,
      ChangeLogData,
      $$ChangeLogTableFilterComposer,
      $$ChangeLogTableOrderingComposer,
      $$ChangeLogTableAnnotationComposer,
      $$ChangeLogTableCreateCompanionBuilder,
      $$ChangeLogTableUpdateCompanionBuilder,
      (
        ChangeLogData,
        BaseReferences<_$AppDatabase, $ChangeLogTable, ChangeLogData>,
      ),
      ChangeLogData,
      PrefetchHooks Function()
    >;
typedef $$AlarmTemplatesTableCreateCompanionBuilder =
    AlarmTemplatesCompanion Function({
      required String id,
      required String name,
      required String mode,
      Value<int?> fixedMinute,
      Value<int?> offsetMinutes,
      Value<String?> soundId,
      required int vibrate,
      Value<int> volumeRamp,
      required int snoozeMinutes,
      required int maxSnoozeCount,
      required int enabled,
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$AlarmTemplatesTableUpdateCompanionBuilder =
    AlarmTemplatesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> mode,
      Value<int?> fixedMinute,
      Value<int?> offsetMinutes,
      Value<String?> soundId,
      Value<int> vibrate,
      Value<int> volumeRamp,
      Value<int> snoozeMinutes,
      Value<int> maxSnoozeCount,
      Value<int> enabled,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$AlarmTemplatesTableReferences
    extends BaseReferences<_$AppDatabase, $AlarmTemplatesTable, AlarmTemplate> {
  $$AlarmTemplatesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $ShiftAlarmTemplatesTable,
    List<ShiftAlarmTemplate>
  >
  _shiftAlarmTemplatesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.shiftAlarmTemplates,
        aliasName:
            'alarm_templates__id__shift_alarm_templates__alarm_template_id',
      );

  $$ShiftAlarmTemplatesTableProcessedTableManager get shiftAlarmTemplatesRefs {
    final manager =
        $$ShiftAlarmTemplatesTableTableManager(
          $_db,
          $_db.shiftAlarmTemplates,
        ).filter(
          (f) => f.alarmTemplateId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _shiftAlarmTemplatesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AlarmInstancesTable, List<AlarmInstance>>
  _alarmInstancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.alarmInstances,
    aliasName: 'alarm_templates__id__alarm_instances__template_id',
  );

  $$AlarmInstancesTableProcessedTableManager get alarmInstancesRefs {
    final manager = $$AlarmInstancesTableTableManager(
      $_db,
      $_db.alarmInstances,
    ).filter((f) => f.templateId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_alarmInstancesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AlarmTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $AlarmTemplatesTable> {
  $$AlarmTemplatesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fixedMinute => $composableBuilder(
    column: $table.fixedMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get offsetMinutes => $composableBuilder(
    column: $table.offsetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get soundId => $composableBuilder(
    column: $table.soundId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vibrate => $composableBuilder(
    column: $table.vibrate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get volumeRamp => $composableBuilder(
    column: $table.volumeRamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxSnoozeCount => $composableBuilder(
    column: $table.maxSnoozeCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get enabled => $composableBuilder(
    column: $table.enabled,
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

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> shiftAlarmTemplatesRefs(
    Expression<bool> Function($$ShiftAlarmTemplatesTableFilterComposer f) f,
  ) {
    final $$ShiftAlarmTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shiftAlarmTemplates,
      getReferencedColumn: (t) => t.alarmTemplateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftAlarmTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.shiftAlarmTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> alarmInstancesRefs(
    Expression<bool> Function($$AlarmInstancesTableFilterComposer f) f,
  ) {
    final $$AlarmInstancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.alarmInstances,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlarmInstancesTableFilterComposer(
            $db: $db,
            $table: $db.alarmInstances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AlarmTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $AlarmTemplatesTable> {
  $$AlarmTemplatesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fixedMinute => $composableBuilder(
    column: $table.fixedMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get offsetMinutes => $composableBuilder(
    column: $table.offsetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get soundId => $composableBuilder(
    column: $table.soundId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vibrate => $composableBuilder(
    column: $table.vibrate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get volumeRamp => $composableBuilder(
    column: $table.volumeRamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxSnoozeCount => $composableBuilder(
    column: $table.maxSnoozeCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get enabled => $composableBuilder(
    column: $table.enabled,
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

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AlarmTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlarmTemplatesTable> {
  $$AlarmTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<int> get fixedMinute => $composableBuilder(
    column: $table.fixedMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get offsetMinutes => $composableBuilder(
    column: $table.offsetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get soundId =>
      $composableBuilder(column: $table.soundId, builder: (column) => column);

  GeneratedColumn<int> get vibrate =>
      $composableBuilder(column: $table.vibrate, builder: (column) => column);

  GeneratedColumn<int> get volumeRamp => $composableBuilder(
    column: $table.volumeRamp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxSnoozeCount => $composableBuilder(
    column: $table.maxSnoozeCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> shiftAlarmTemplatesRefs<T extends Object>(
    Expression<T> Function($$ShiftAlarmTemplatesTableAnnotationComposer a) f,
  ) {
    final $$ShiftAlarmTemplatesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.shiftAlarmTemplates,
          getReferencedColumn: (t) => t.alarmTemplateId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ShiftAlarmTemplatesTableAnnotationComposer(
                $db: $db,
                $table: $db.shiftAlarmTemplates,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> alarmInstancesRefs<T extends Object>(
    Expression<T> Function($$AlarmInstancesTableAnnotationComposer a) f,
  ) {
    final $$AlarmInstancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.alarmInstances,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlarmInstancesTableAnnotationComposer(
            $db: $db,
            $table: $db.alarmInstances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AlarmTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AlarmTemplatesTable,
          AlarmTemplate,
          $$AlarmTemplatesTableFilterComposer,
          $$AlarmTemplatesTableOrderingComposer,
          $$AlarmTemplatesTableAnnotationComposer,
          $$AlarmTemplatesTableCreateCompanionBuilder,
          $$AlarmTemplatesTableUpdateCompanionBuilder,
          (AlarmTemplate, $$AlarmTemplatesTableReferences),
          AlarmTemplate,
          PrefetchHooks Function({
            bool shiftAlarmTemplatesRefs,
            bool alarmInstancesRefs,
          })
        > {
  $$AlarmTemplatesTableTableManager(
    _$AppDatabase db,
    $AlarmTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlarmTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlarmTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlarmTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<int?> fixedMinute = const Value.absent(),
                Value<int?> offsetMinutes = const Value.absent(),
                Value<String?> soundId = const Value.absent(),
                Value<int> vibrate = const Value.absent(),
                Value<int> volumeRamp = const Value.absent(),
                Value<int> snoozeMinutes = const Value.absent(),
                Value<int> maxSnoozeCount = const Value.absent(),
                Value<int> enabled = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AlarmTemplatesCompanion(
                id: id,
                name: name,
                mode: mode,
                fixedMinute: fixedMinute,
                offsetMinutes: offsetMinutes,
                soundId: soundId,
                vibrate: vibrate,
                volumeRamp: volumeRamp,
                snoozeMinutes: snoozeMinutes,
                maxSnoozeCount: maxSnoozeCount,
                enabled: enabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String mode,
                Value<int?> fixedMinute = const Value.absent(),
                Value<int?> offsetMinutes = const Value.absent(),
                Value<String?> soundId = const Value.absent(),
                required int vibrate,
                Value<int> volumeRamp = const Value.absent(),
                required int snoozeMinutes,
                required int maxSnoozeCount,
                required int enabled,
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AlarmTemplatesCompanion.insert(
                id: id,
                name: name,
                mode: mode,
                fixedMinute: fixedMinute,
                offsetMinutes: offsetMinutes,
                soundId: soundId,
                vibrate: vibrate,
                volumeRamp: volumeRamp,
                snoozeMinutes: snoozeMinutes,
                maxSnoozeCount: maxSnoozeCount,
                enabled: enabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AlarmTemplatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({shiftAlarmTemplatesRefs = false, alarmInstancesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (shiftAlarmTemplatesRefs) db.shiftAlarmTemplates,
                    if (alarmInstancesRefs) db.alarmInstances,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (shiftAlarmTemplatesRefs)
                        await $_getPrefetchedData<
                          AlarmTemplate,
                          $AlarmTemplatesTable,
                          ShiftAlarmTemplate
                        >(
                          currentTable: table,
                          referencedTable: $$AlarmTemplatesTableReferences
                              ._shiftAlarmTemplatesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AlarmTemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).shiftAlarmTemplatesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.alarmTemplateId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (alarmInstancesRefs)
                        await $_getPrefetchedData<
                          AlarmTemplate,
                          $AlarmTemplatesTable,
                          AlarmInstance
                        >(
                          currentTable: table,
                          referencedTable: $$AlarmTemplatesTableReferences
                              ._alarmInstancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AlarmTemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).alarmInstancesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.templateId == item.id,
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

typedef $$AlarmTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AlarmTemplatesTable,
      AlarmTemplate,
      $$AlarmTemplatesTableFilterComposer,
      $$AlarmTemplatesTableOrderingComposer,
      $$AlarmTemplatesTableAnnotationComposer,
      $$AlarmTemplatesTableCreateCompanionBuilder,
      $$AlarmTemplatesTableUpdateCompanionBuilder,
      (AlarmTemplate, $$AlarmTemplatesTableReferences),
      AlarmTemplate,
      PrefetchHooks Function({
        bool shiftAlarmTemplatesRefs,
        bool alarmInstancesRefs,
      })
    >;
typedef $$ShiftAlarmTemplatesTableCreateCompanionBuilder =
    ShiftAlarmTemplatesCompanion Function({
      required String id,
      required String shiftTemplateId,
      required String alarmTemplateId,
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$ShiftAlarmTemplatesTableUpdateCompanionBuilder =
    ShiftAlarmTemplatesCompanion Function({
      Value<String> id,
      Value<String> shiftTemplateId,
      Value<String> alarmTemplateId,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$ShiftAlarmTemplatesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ShiftAlarmTemplatesTable,
          ShiftAlarmTemplate
        > {
  $$ShiftAlarmTemplatesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ShiftTemplatesTable _shiftTemplateIdTable(_$AppDatabase db) =>
      db.shiftTemplates.createAlias(
        'shift_alarm_templates__shift_template_id__shift_templates__id',
      );

  $$ShiftTemplatesTableProcessedTableManager get shiftTemplateId {
    final $_column = $_itemColumn<String>('shift_template_id')!;

    final manager = $$ShiftTemplatesTableTableManager(
      $_db,
      $_db.shiftTemplates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shiftTemplateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AlarmTemplatesTable _alarmTemplateIdTable(_$AppDatabase db) =>
      db.alarmTemplates.createAlias(
        'shift_alarm_templates__alarm_template_id__alarm_templates__id',
      );

  $$AlarmTemplatesTableProcessedTableManager get alarmTemplateId {
    final $_column = $_itemColumn<String>('alarm_template_id')!;

    final manager = $$AlarmTemplatesTableTableManager(
      $_db,
      $_db.alarmTemplates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_alarmTemplateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ShiftAlarmTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $ShiftAlarmTemplatesTable> {
  $$ShiftAlarmTemplatesTableFilterComposer({
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

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ShiftTemplatesTableFilterComposer get shiftTemplateId {
    final $$ShiftTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shiftTemplateId,
      referencedTable: $db.shiftTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.shiftTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AlarmTemplatesTableFilterComposer get alarmTemplateId {
    final $$AlarmTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.alarmTemplateId,
      referencedTable: $db.alarmTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlarmTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.alarmTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShiftAlarmTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ShiftAlarmTemplatesTable> {
  $$ShiftAlarmTemplatesTableOrderingComposer({
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

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ShiftTemplatesTableOrderingComposer get shiftTemplateId {
    final $$ShiftTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shiftTemplateId,
      referencedTable: $db.shiftTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.shiftTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AlarmTemplatesTableOrderingComposer get alarmTemplateId {
    final $$AlarmTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.alarmTemplateId,
      referencedTable: $db.alarmTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlarmTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.alarmTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShiftAlarmTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShiftAlarmTemplatesTable> {
  $$ShiftAlarmTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$ShiftTemplatesTableAnnotationComposer get shiftTemplateId {
    final $$ShiftTemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shiftTemplateId,
      referencedTable: $db.shiftTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftTemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.shiftTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AlarmTemplatesTableAnnotationComposer get alarmTemplateId {
    final $$AlarmTemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.alarmTemplateId,
      referencedTable: $db.alarmTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlarmTemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.alarmTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShiftAlarmTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShiftAlarmTemplatesTable,
          ShiftAlarmTemplate,
          $$ShiftAlarmTemplatesTableFilterComposer,
          $$ShiftAlarmTemplatesTableOrderingComposer,
          $$ShiftAlarmTemplatesTableAnnotationComposer,
          $$ShiftAlarmTemplatesTableCreateCompanionBuilder,
          $$ShiftAlarmTemplatesTableUpdateCompanionBuilder,
          (ShiftAlarmTemplate, $$ShiftAlarmTemplatesTableReferences),
          ShiftAlarmTemplate,
          PrefetchHooks Function({bool shiftTemplateId, bool alarmTemplateId})
        > {
  $$ShiftAlarmTemplatesTableTableManager(
    _$AppDatabase db,
    $ShiftAlarmTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShiftAlarmTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShiftAlarmTemplatesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ShiftAlarmTemplatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shiftTemplateId = const Value.absent(),
                Value<String> alarmTemplateId = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShiftAlarmTemplatesCompanion(
                id: id,
                shiftTemplateId: shiftTemplateId,
                alarmTemplateId: alarmTemplateId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shiftTemplateId,
                required String alarmTemplateId,
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShiftAlarmTemplatesCompanion.insert(
                id: id,
                shiftTemplateId: shiftTemplateId,
                alarmTemplateId: alarmTemplateId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ShiftAlarmTemplatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({shiftTemplateId = false, alarmTemplateId = false}) {
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
                        if (shiftTemplateId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.shiftTemplateId,
                                    referencedTable:
                                        $$ShiftAlarmTemplatesTableReferences
                                            ._shiftTemplateIdTable(db),
                                    referencedColumn:
                                        $$ShiftAlarmTemplatesTableReferences
                                            ._shiftTemplateIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (alarmTemplateId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.alarmTemplateId,
                                    referencedTable:
                                        $$ShiftAlarmTemplatesTableReferences
                                            ._alarmTemplateIdTable(db),
                                    referencedColumn:
                                        $$ShiftAlarmTemplatesTableReferences
                                            ._alarmTemplateIdTable(db)
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

typedef $$ShiftAlarmTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShiftAlarmTemplatesTable,
      ShiftAlarmTemplate,
      $$ShiftAlarmTemplatesTableFilterComposer,
      $$ShiftAlarmTemplatesTableOrderingComposer,
      $$ShiftAlarmTemplatesTableAnnotationComposer,
      $$ShiftAlarmTemplatesTableCreateCompanionBuilder,
      $$ShiftAlarmTemplatesTableUpdateCompanionBuilder,
      (ShiftAlarmTemplate, $$ShiftAlarmTemplatesTableReferences),
      ShiftAlarmTemplate,
      PrefetchHooks Function({bool shiftTemplateId, bool alarmTemplateId})
    >;
typedef $$AlarmInstancesTableCreateCompanionBuilder =
    AlarmInstancesCompanion Function({
      required String id,
      required String templateId,
      required String scheduleDate,
      required int triggerAt,
      Value<String?> shiftId,
      required int locked,
      required String platformAlarmId,
      required String status,
      required String payloadHash,
      Value<String?> errorCode,
      Value<int> retryCount,
      Value<int?> nextRetryAt,
      Value<int?> lastSyncedAt,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$AlarmInstancesTableUpdateCompanionBuilder =
    AlarmInstancesCompanion Function({
      Value<String> id,
      Value<String> templateId,
      Value<String> scheduleDate,
      Value<int> triggerAt,
      Value<String?> shiftId,
      Value<int> locked,
      Value<String> platformAlarmId,
      Value<String> status,
      Value<String> payloadHash,
      Value<String?> errorCode,
      Value<int> retryCount,
      Value<int?> nextRetryAt,
      Value<int?> lastSyncedAt,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

final class $$AlarmInstancesTableReferences
    extends BaseReferences<_$AppDatabase, $AlarmInstancesTable, AlarmInstance> {
  $$AlarmInstancesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AlarmTemplatesTable _templateIdTable(_$AppDatabase db) => db
      .alarmTemplates
      .createAlias('alarm_instances__template_id__alarm_templates__id');

  $$AlarmTemplatesTableProcessedTableManager get templateId {
    final $_column = $_itemColumn<String>('template_id')!;

    final manager = $$AlarmTemplatesTableTableManager(
      $_db,
      $_db.alarmTemplates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AlarmInstancesTableFilterComposer
    extends Composer<_$AppDatabase, $AlarmInstancesTable> {
  $$AlarmInstancesTableFilterComposer({
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

  ColumnFilters<String> get scheduleDate => $composableBuilder(
    column: $table.scheduleDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get triggerAt => $composableBuilder(
    column: $table.triggerAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shiftId => $composableBuilder(
    column: $table.shiftId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get locked => $composableBuilder(
    column: $table.locked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platformAlarmId => $composableBuilder(
    column: $table.platformAlarmId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadHash => $composableBuilder(
    column: $table.payloadHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
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

  $$AlarmTemplatesTableFilterComposer get templateId {
    final $$AlarmTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.alarmTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlarmTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.alarmTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AlarmInstancesTableOrderingComposer
    extends Composer<_$AppDatabase, $AlarmInstancesTable> {
  $$AlarmInstancesTableOrderingComposer({
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

  ColumnOrderings<String> get scheduleDate => $composableBuilder(
    column: $table.scheduleDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get triggerAt => $composableBuilder(
    column: $table.triggerAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shiftId => $composableBuilder(
    column: $table.shiftId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get locked => $composableBuilder(
    column: $table.locked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platformAlarmId => $composableBuilder(
    column: $table.platformAlarmId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadHash => $composableBuilder(
    column: $table.payloadHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
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

  $$AlarmTemplatesTableOrderingComposer get templateId {
    final $$AlarmTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.alarmTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlarmTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.alarmTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AlarmInstancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlarmInstancesTable> {
  $$AlarmInstancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get scheduleDate => $composableBuilder(
    column: $table.scheduleDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get triggerAt =>
      $composableBuilder(column: $table.triggerAt, builder: (column) => column);

  GeneratedColumn<String> get shiftId =>
      $composableBuilder(column: $table.shiftId, builder: (column) => column);

  GeneratedColumn<int> get locked =>
      $composableBuilder(column: $table.locked, builder: (column) => column);

  GeneratedColumn<String> get platformAlarmId => $composableBuilder(
    column: $table.platformAlarmId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get payloadHash => $composableBuilder(
    column: $table.payloadHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorCode =>
      $composableBuilder(column: $table.errorCode, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AlarmTemplatesTableAnnotationComposer get templateId {
    final $$AlarmTemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.alarmTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlarmTemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.alarmTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AlarmInstancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AlarmInstancesTable,
          AlarmInstance,
          $$AlarmInstancesTableFilterComposer,
          $$AlarmInstancesTableOrderingComposer,
          $$AlarmInstancesTableAnnotationComposer,
          $$AlarmInstancesTableCreateCompanionBuilder,
          $$AlarmInstancesTableUpdateCompanionBuilder,
          (AlarmInstance, $$AlarmInstancesTableReferences),
          AlarmInstance,
          PrefetchHooks Function({bool templateId})
        > {
  $$AlarmInstancesTableTableManager(
    _$AppDatabase db,
    $AlarmInstancesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlarmInstancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlarmInstancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlarmInstancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> templateId = const Value.absent(),
                Value<String> scheduleDate = const Value.absent(),
                Value<int> triggerAt = const Value.absent(),
                Value<String?> shiftId = const Value.absent(),
                Value<int> locked = const Value.absent(),
                Value<String> platformAlarmId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> payloadHash = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<int?> nextRetryAt = const Value.absent(),
                Value<int?> lastSyncedAt = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AlarmInstancesCompanion(
                id: id,
                templateId: templateId,
                scheduleDate: scheduleDate,
                triggerAt: triggerAt,
                shiftId: shiftId,
                locked: locked,
                platformAlarmId: platformAlarmId,
                status: status,
                payloadHash: payloadHash,
                errorCode: errorCode,
                retryCount: retryCount,
                nextRetryAt: nextRetryAt,
                lastSyncedAt: lastSyncedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String templateId,
                required String scheduleDate,
                required int triggerAt,
                Value<String?> shiftId = const Value.absent(),
                required int locked,
                required String platformAlarmId,
                required String status,
                required String payloadHash,
                Value<String?> errorCode = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<int?> nextRetryAt = const Value.absent(),
                Value<int?> lastSyncedAt = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AlarmInstancesCompanion.insert(
                id: id,
                templateId: templateId,
                scheduleDate: scheduleDate,
                triggerAt: triggerAt,
                shiftId: shiftId,
                locked: locked,
                platformAlarmId: platformAlarmId,
                status: status,
                payloadHash: payloadHash,
                errorCode: errorCode,
                retryCount: retryCount,
                nextRetryAt: nextRetryAt,
                lastSyncedAt: lastSyncedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AlarmInstancesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({templateId = false}) {
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
                    if (templateId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.templateId,
                                referencedTable: $$AlarmInstancesTableReferences
                                    ._templateIdTable(db),
                                referencedColumn:
                                    $$AlarmInstancesTableReferences
                                        ._templateIdTable(db)
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

typedef $$AlarmInstancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AlarmInstancesTable,
      AlarmInstance,
      $$AlarmInstancesTableFilterComposer,
      $$AlarmInstancesTableOrderingComposer,
      $$AlarmInstancesTableAnnotationComposer,
      $$AlarmInstancesTableCreateCompanionBuilder,
      $$AlarmInstancesTableUpdateCompanionBuilder,
      (AlarmInstance, $$AlarmInstancesTableReferences),
      AlarmInstance,
      PrefetchHooks Function({bool templateId})
    >;
typedef $$AttendanceRecordsTableCreateCompanionBuilder =
    AttendanceRecordsCompanion Function({
      required String id,
      required String workDate,
      Value<int?> clockInAt,
      Value<int?> clockOutAt,
      required int unpaidBreakMinutes,
      required String source,
      required String status,
      Value<String?> editReason,
      Value<String?> note,
      required String createdTimezone,
      Value<int> confirmed,
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$AttendanceRecordsTableUpdateCompanionBuilder =
    AttendanceRecordsCompanion Function({
      Value<String> id,
      Value<String> workDate,
      Value<int?> clockInAt,
      Value<int?> clockOutAt,
      Value<int> unpaidBreakMinutes,
      Value<String> source,
      Value<String> status,
      Value<String?> editReason,
      Value<String?> note,
      Value<String> createdTimezone,
      Value<int> confirmed,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

class $$AttendanceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceRecordsTable> {
  $$AttendanceRecordsTableFilterComposer({
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

  ColumnFilters<String> get workDate => $composableBuilder(
    column: $table.workDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get clockInAt => $composableBuilder(
    column: $table.clockInAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get clockOutAt => $composableBuilder(
    column: $table.clockOutAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unpaidBreakMinutes => $composableBuilder(
    column: $table.unpaidBreakMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get editReason => $composableBuilder(
    column: $table.editReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdTimezone => $composableBuilder(
    column: $table.createdTimezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confirmed => $composableBuilder(
    column: $table.confirmed,
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

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttendanceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceRecordsTable> {
  $$AttendanceRecordsTableOrderingComposer({
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

  ColumnOrderings<String> get workDate => $composableBuilder(
    column: $table.workDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get clockInAt => $composableBuilder(
    column: $table.clockInAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get clockOutAt => $composableBuilder(
    column: $table.clockOutAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unpaidBreakMinutes => $composableBuilder(
    column: $table.unpaidBreakMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get editReason => $composableBuilder(
    column: $table.editReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdTimezone => $composableBuilder(
    column: $table.createdTimezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confirmed => $composableBuilder(
    column: $table.confirmed,
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

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttendanceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceRecordsTable> {
  $$AttendanceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workDate =>
      $composableBuilder(column: $table.workDate, builder: (column) => column);

  GeneratedColumn<int> get clockInAt =>
      $composableBuilder(column: $table.clockInAt, builder: (column) => column);

  GeneratedColumn<int> get clockOutAt => $composableBuilder(
    column: $table.clockOutAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unpaidBreakMinutes => $composableBuilder(
    column: $table.unpaidBreakMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get editReason => $composableBuilder(
    column: $table.editReason,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get createdTimezone => $composableBuilder(
    column: $table.createdTimezone,
    builder: (column) => column,
  );

  GeneratedColumn<int> get confirmed =>
      $composableBuilder(column: $table.confirmed, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$AttendanceRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceRecordsTable,
          AttendanceRecord,
          $$AttendanceRecordsTableFilterComposer,
          $$AttendanceRecordsTableOrderingComposer,
          $$AttendanceRecordsTableAnnotationComposer,
          $$AttendanceRecordsTableCreateCompanionBuilder,
          $$AttendanceRecordsTableUpdateCompanionBuilder,
          (
            AttendanceRecord,
            BaseReferences<
              _$AppDatabase,
              $AttendanceRecordsTable,
              AttendanceRecord
            >,
          ),
          AttendanceRecord,
          PrefetchHooks Function()
        > {
  $$AttendanceRecordsTableTableManager(
    _$AppDatabase db,
    $AttendanceRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workDate = const Value.absent(),
                Value<int?> clockInAt = const Value.absent(),
                Value<int?> clockOutAt = const Value.absent(),
                Value<int> unpaidBreakMinutes = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> editReason = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> createdTimezone = const Value.absent(),
                Value<int> confirmed = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceRecordsCompanion(
                id: id,
                workDate: workDate,
                clockInAt: clockInAt,
                clockOutAt: clockOutAt,
                unpaidBreakMinutes: unpaidBreakMinutes,
                source: source,
                status: status,
                editReason: editReason,
                note: note,
                createdTimezone: createdTimezone,
                confirmed: confirmed,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workDate,
                Value<int?> clockInAt = const Value.absent(),
                Value<int?> clockOutAt = const Value.absent(),
                required int unpaidBreakMinutes,
                required String source,
                required String status,
                Value<String?> editReason = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required String createdTimezone,
                Value<int> confirmed = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceRecordsCompanion.insert(
                id: id,
                workDate: workDate,
                clockInAt: clockInAt,
                clockOutAt: clockOutAt,
                unpaidBreakMinutes: unpaidBreakMinutes,
                source: source,
                status: status,
                editReason: editReason,
                note: note,
                createdTimezone: createdTimezone,
                confirmed: confirmed,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttendanceRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceRecordsTable,
      AttendanceRecord,
      $$AttendanceRecordsTableFilterComposer,
      $$AttendanceRecordsTableOrderingComposer,
      $$AttendanceRecordsTableAnnotationComposer,
      $$AttendanceRecordsTableCreateCompanionBuilder,
      $$AttendanceRecordsTableUpdateCompanionBuilder,
      (
        AttendanceRecord,
        BaseReferences<
          _$AppDatabase,
          $AttendanceRecordsTable,
          AttendanceRecord
        >,
      ),
      AttendanceRecord,
      PrefetchHooks Function()
    >;
typedef $$LeaveRecordsTableCreateCompanionBuilder =
    LeaveRecordsCompanion Function({
      required String id,
      required String workDate,
      required String leaveType,
      Value<int?> startAt,
      Value<int?> endAt,
      required int paid,
      Value<int?> deductionMinor,
      Value<String?> note,
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$LeaveRecordsTableUpdateCompanionBuilder =
    LeaveRecordsCompanion Function({
      Value<String> id,
      Value<String> workDate,
      Value<String> leaveType,
      Value<int?> startAt,
      Value<int?> endAt,
      Value<int> paid,
      Value<int?> deductionMinor,
      Value<String?> note,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

class $$LeaveRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $LeaveRecordsTable> {
  $$LeaveRecordsTableFilterComposer({
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

  ColumnFilters<String> get workDate => $composableBuilder(
    column: $table.workDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get leaveType => $composableBuilder(
    column: $table.leaveType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paid => $composableBuilder(
    column: $table.paid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deductionMinor => $composableBuilder(
    column: $table.deductionMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
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

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LeaveRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $LeaveRecordsTable> {
  $$LeaveRecordsTableOrderingComposer({
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

  ColumnOrderings<String> get workDate => $composableBuilder(
    column: $table.workDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get leaveType => $composableBuilder(
    column: $table.leaveType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paid => $composableBuilder(
    column: $table.paid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deductionMinor => $composableBuilder(
    column: $table.deductionMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
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

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LeaveRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LeaveRecordsTable> {
  $$LeaveRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workDate =>
      $composableBuilder(column: $table.workDate, builder: (column) => column);

  GeneratedColumn<String> get leaveType =>
      $composableBuilder(column: $table.leaveType, builder: (column) => column);

  GeneratedColumn<int> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<int> get endAt =>
      $composableBuilder(column: $table.endAt, builder: (column) => column);

  GeneratedColumn<int> get paid =>
      $composableBuilder(column: $table.paid, builder: (column) => column);

  GeneratedColumn<int> get deductionMinor => $composableBuilder(
    column: $table.deductionMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$LeaveRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LeaveRecordsTable,
          LeaveRecord,
          $$LeaveRecordsTableFilterComposer,
          $$LeaveRecordsTableOrderingComposer,
          $$LeaveRecordsTableAnnotationComposer,
          $$LeaveRecordsTableCreateCompanionBuilder,
          $$LeaveRecordsTableUpdateCompanionBuilder,
          (
            LeaveRecord,
            BaseReferences<_$AppDatabase, $LeaveRecordsTable, LeaveRecord>,
          ),
          LeaveRecord,
          PrefetchHooks Function()
        > {
  $$LeaveRecordsTableTableManager(_$AppDatabase db, $LeaveRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LeaveRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LeaveRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LeaveRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workDate = const Value.absent(),
                Value<String> leaveType = const Value.absent(),
                Value<int?> startAt = const Value.absent(),
                Value<int?> endAt = const Value.absent(),
                Value<int> paid = const Value.absent(),
                Value<int?> deductionMinor = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LeaveRecordsCompanion(
                id: id,
                workDate: workDate,
                leaveType: leaveType,
                startAt: startAt,
                endAt: endAt,
                paid: paid,
                deductionMinor: deductionMinor,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workDate,
                required String leaveType,
                Value<int?> startAt = const Value.absent(),
                Value<int?> endAt = const Value.absent(),
                required int paid,
                Value<int?> deductionMinor = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LeaveRecordsCompanion.insert(
                id: id,
                workDate: workDate,
                leaveType: leaveType,
                startAt: startAt,
                endAt: endAt,
                paid: paid,
                deductionMinor: deductionMinor,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LeaveRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LeaveRecordsTable,
      LeaveRecord,
      $$LeaveRecordsTableFilterComposer,
      $$LeaveRecordsTableOrderingComposer,
      $$LeaveRecordsTableAnnotationComposer,
      $$LeaveRecordsTableCreateCompanionBuilder,
      $$LeaveRecordsTableUpdateCompanionBuilder,
      (
        LeaveRecord,
        BaseReferences<_$AppDatabase, $LeaveRecordsTable, LeaveRecord>,
      ),
      LeaveRecord,
      PrefetchHooks Function()
    >;
typedef $$WageRulesTableCreateCompanionBuilder =
    WageRulesCompanion Function({
      required String id,
      required String mode,
      required String currency,
      required int baseRateMinor,
      required String overtimeRatesJson,
      required String allowanceRulesJson,
      required String deductionRulesJson,
      required int periodStartDay,
      required String roundingRuleJson,
      Value<int> confirmedOnly,
      required String effectiveStart,
      Value<String?> effectiveEnd,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$WageRulesTableUpdateCompanionBuilder =
    WageRulesCompanion Function({
      Value<String> id,
      Value<String> mode,
      Value<String> currency,
      Value<int> baseRateMinor,
      Value<String> overtimeRatesJson,
      Value<String> allowanceRulesJson,
      Value<String> deductionRulesJson,
      Value<int> periodStartDay,
      Value<String> roundingRuleJson,
      Value<int> confirmedOnly,
      Value<String> effectiveStart,
      Value<String?> effectiveEnd,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$WageRulesTableFilterComposer
    extends Composer<_$AppDatabase, $WageRulesTable> {
  $$WageRulesTableFilterComposer({
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

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseRateMinor => $composableBuilder(
    column: $table.baseRateMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overtimeRatesJson => $composableBuilder(
    column: $table.overtimeRatesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allowanceRulesJson => $composableBuilder(
    column: $table.allowanceRulesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deductionRulesJson => $composableBuilder(
    column: $table.deductionRulesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get periodStartDay => $composableBuilder(
    column: $table.periodStartDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roundingRuleJson => $composableBuilder(
    column: $table.roundingRuleJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confirmedOnly => $composableBuilder(
    column: $table.confirmedOnly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectiveStart => $composableBuilder(
    column: $table.effectiveStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectiveEnd => $composableBuilder(
    column: $table.effectiveEnd,
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

class $$WageRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $WageRulesTable> {
  $$WageRulesTableOrderingComposer({
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

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseRateMinor => $composableBuilder(
    column: $table.baseRateMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overtimeRatesJson => $composableBuilder(
    column: $table.overtimeRatesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allowanceRulesJson => $composableBuilder(
    column: $table.allowanceRulesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deductionRulesJson => $composableBuilder(
    column: $table.deductionRulesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get periodStartDay => $composableBuilder(
    column: $table.periodStartDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roundingRuleJson => $composableBuilder(
    column: $table.roundingRuleJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confirmedOnly => $composableBuilder(
    column: $table.confirmedOnly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectiveStart => $composableBuilder(
    column: $table.effectiveStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectiveEnd => $composableBuilder(
    column: $table.effectiveEnd,
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

class $$WageRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WageRulesTable> {
  $$WageRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get baseRateMinor => $composableBuilder(
    column: $table.baseRateMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get overtimeRatesJson => $composableBuilder(
    column: $table.overtimeRatesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get allowanceRulesJson => $composableBuilder(
    column: $table.allowanceRulesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deductionRulesJson => $composableBuilder(
    column: $table.deductionRulesJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get periodStartDay => $composableBuilder(
    column: $table.periodStartDay,
    builder: (column) => column,
  );

  GeneratedColumn<String> get roundingRuleJson => $composableBuilder(
    column: $table.roundingRuleJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get confirmedOnly => $composableBuilder(
    column: $table.confirmedOnly,
    builder: (column) => column,
  );

  GeneratedColumn<String> get effectiveStart => $composableBuilder(
    column: $table.effectiveStart,
    builder: (column) => column,
  );

  GeneratedColumn<String> get effectiveEnd => $composableBuilder(
    column: $table.effectiveEnd,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WageRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WageRulesTable,
          WageRule,
          $$WageRulesTableFilterComposer,
          $$WageRulesTableOrderingComposer,
          $$WageRulesTableAnnotationComposer,
          $$WageRulesTableCreateCompanionBuilder,
          $$WageRulesTableUpdateCompanionBuilder,
          (WageRule, BaseReferences<_$AppDatabase, $WageRulesTable, WageRule>),
          WageRule,
          PrefetchHooks Function()
        > {
  $$WageRulesTableTableManager(_$AppDatabase db, $WageRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WageRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WageRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WageRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> baseRateMinor = const Value.absent(),
                Value<String> overtimeRatesJson = const Value.absent(),
                Value<String> allowanceRulesJson = const Value.absent(),
                Value<String> deductionRulesJson = const Value.absent(),
                Value<int> periodStartDay = const Value.absent(),
                Value<String> roundingRuleJson = const Value.absent(),
                Value<int> confirmedOnly = const Value.absent(),
                Value<String> effectiveStart = const Value.absent(),
                Value<String?> effectiveEnd = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WageRulesCompanion(
                id: id,
                mode: mode,
                currency: currency,
                baseRateMinor: baseRateMinor,
                overtimeRatesJson: overtimeRatesJson,
                allowanceRulesJson: allowanceRulesJson,
                deductionRulesJson: deductionRulesJson,
                periodStartDay: periodStartDay,
                roundingRuleJson: roundingRuleJson,
                confirmedOnly: confirmedOnly,
                effectiveStart: effectiveStart,
                effectiveEnd: effectiveEnd,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String mode,
                required String currency,
                required int baseRateMinor,
                required String overtimeRatesJson,
                required String allowanceRulesJson,
                required String deductionRulesJson,
                required int periodStartDay,
                required String roundingRuleJson,
                Value<int> confirmedOnly = const Value.absent(),
                required String effectiveStart,
                Value<String?> effectiveEnd = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => WageRulesCompanion.insert(
                id: id,
                mode: mode,
                currency: currency,
                baseRateMinor: baseRateMinor,
                overtimeRatesJson: overtimeRatesJson,
                allowanceRulesJson: allowanceRulesJson,
                deductionRulesJson: deductionRulesJson,
                periodStartDay: periodStartDay,
                roundingRuleJson: roundingRuleJson,
                confirmedOnly: confirmedOnly,
                effectiveStart: effectiveStart,
                effectiveEnd: effectiveEnd,
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

typedef $$WageRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WageRulesTable,
      WageRule,
      $$WageRulesTableFilterComposer,
      $$WageRulesTableOrderingComposer,
      $$WageRulesTableAnnotationComposer,
      $$WageRulesTableCreateCompanionBuilder,
      $$WageRulesTableUpdateCompanionBuilder,
      (WageRule, BaseReferences<_$AppDatabase, $WageRulesTable, WageRule>),
      WageRule,
      PrefetchHooks Function()
    >;
typedef $$PayrollPeriodsTableCreateCompanionBuilder =
    PayrollPeriodsCompanion Function({
      required String id,
      required String startDate,
      required String endDate,
      required String status,
      required int calculatedMinor,
      Value<int?> confirmedMinor,
      required String calculationSnapshotJson,
      Value<int?> confirmedAt,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$PayrollPeriodsTableUpdateCompanionBuilder =
    PayrollPeriodsCompanion Function({
      Value<String> id,
      Value<String> startDate,
      Value<String> endDate,
      Value<String> status,
      Value<int> calculatedMinor,
      Value<int?> confirmedMinor,
      Value<String> calculationSnapshotJson,
      Value<int?> confirmedAt,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$PayrollPeriodsTableFilterComposer
    extends Composer<_$AppDatabase, $PayrollPeriodsTable> {
  $$PayrollPeriodsTableFilterComposer({
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

  ColumnFilters<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calculatedMinor => $composableBuilder(
    column: $table.calculatedMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confirmedMinor => $composableBuilder(
    column: $table.confirmedMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calculationSnapshotJson => $composableBuilder(
    column: $table.calculationSnapshotJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confirmedAt => $composableBuilder(
    column: $table.confirmedAt,
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

class $$PayrollPeriodsTableOrderingComposer
    extends Composer<_$AppDatabase, $PayrollPeriodsTable> {
  $$PayrollPeriodsTableOrderingComposer({
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

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calculatedMinor => $composableBuilder(
    column: $table.calculatedMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confirmedMinor => $composableBuilder(
    column: $table.confirmedMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calculationSnapshotJson => $composableBuilder(
    column: $table.calculationSnapshotJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confirmedAt => $composableBuilder(
    column: $table.confirmedAt,
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

class $$PayrollPeriodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PayrollPeriodsTable> {
  $$PayrollPeriodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get calculatedMinor => $composableBuilder(
    column: $table.calculatedMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get confirmedMinor => $composableBuilder(
    column: $table.confirmedMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get calculationSnapshotJson => $composableBuilder(
    column: $table.calculationSnapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get confirmedAt => $composableBuilder(
    column: $table.confirmedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PayrollPeriodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PayrollPeriodsTable,
          PayrollPeriod,
          $$PayrollPeriodsTableFilterComposer,
          $$PayrollPeriodsTableOrderingComposer,
          $$PayrollPeriodsTableAnnotationComposer,
          $$PayrollPeriodsTableCreateCompanionBuilder,
          $$PayrollPeriodsTableUpdateCompanionBuilder,
          (
            PayrollPeriod,
            BaseReferences<_$AppDatabase, $PayrollPeriodsTable, PayrollPeriod>,
          ),
          PayrollPeriod,
          PrefetchHooks Function()
        > {
  $$PayrollPeriodsTableTableManager(
    _$AppDatabase db,
    $PayrollPeriodsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PayrollPeriodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PayrollPeriodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PayrollPeriodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> startDate = const Value.absent(),
                Value<String> endDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> calculatedMinor = const Value.absent(),
                Value<int?> confirmedMinor = const Value.absent(),
                Value<String> calculationSnapshotJson = const Value.absent(),
                Value<int?> confirmedAt = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PayrollPeriodsCompanion(
                id: id,
                startDate: startDate,
                endDate: endDate,
                status: status,
                calculatedMinor: calculatedMinor,
                confirmedMinor: confirmedMinor,
                calculationSnapshotJson: calculationSnapshotJson,
                confirmedAt: confirmedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String startDate,
                required String endDate,
                required String status,
                required int calculatedMinor,
                Value<int?> confirmedMinor = const Value.absent(),
                required String calculationSnapshotJson,
                Value<int?> confirmedAt = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PayrollPeriodsCompanion.insert(
                id: id,
                startDate: startDate,
                endDate: endDate,
                status: status,
                calculatedMinor: calculatedMinor,
                confirmedMinor: confirmedMinor,
                calculationSnapshotJson: calculationSnapshotJson,
                confirmedAt: confirmedAt,
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

typedef $$PayrollPeriodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PayrollPeriodsTable,
      PayrollPeriod,
      $$PayrollPeriodsTableFilterComposer,
      $$PayrollPeriodsTableOrderingComposer,
      $$PayrollPeriodsTableAnnotationComposer,
      $$PayrollPeriodsTableCreateCompanionBuilder,
      $$PayrollPeriodsTableUpdateCompanionBuilder,
      (
        PayrollPeriod,
        BaseReferences<_$AppDatabase, $PayrollPeriodsTable, PayrollPeriod>,
      ),
      PayrollPeriod,
      PrefetchHooks Function()
    >;
typedef $$AiProviderConfigsTableCreateCompanionBuilder =
    AiProviderConfigsCompanion Function({
      required String id,
      required String providerType,
      required String baseUrl,
      required String endpointPath,
      required String modelName,
      required String credentialRef,
      Value<String?> customHeadersRef,
      required int timeoutSeconds,
      required int maxOutputTokens,
      required int streamEnabled,
      required String connectionStatus,
      Value<int?> lastTestedAt,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$AiProviderConfigsTableUpdateCompanionBuilder =
    AiProviderConfigsCompanion Function({
      Value<String> id,
      Value<String> providerType,
      Value<String> baseUrl,
      Value<String> endpointPath,
      Value<String> modelName,
      Value<String> credentialRef,
      Value<String?> customHeadersRef,
      Value<int> timeoutSeconds,
      Value<int> maxOutputTokens,
      Value<int> streamEnabled,
      Value<String> connectionStatus,
      Value<int?> lastTestedAt,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$AiProviderConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $AiProviderConfigsTable> {
  $$AiProviderConfigsTableFilterComposer({
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

  ColumnFilters<String> get providerType => $composableBuilder(
    column: $table.providerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endpointPath => $composableBuilder(
    column: $table.endpointPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelName => $composableBuilder(
    column: $table.modelName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get credentialRef => $composableBuilder(
    column: $table.credentialRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customHeadersRef => $composableBuilder(
    column: $table.customHeadersRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeoutSeconds => $composableBuilder(
    column: $table.timeoutSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxOutputTokens => $composableBuilder(
    column: $table.maxOutputTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streamEnabled => $composableBuilder(
    column: $table.streamEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get connectionStatus => $composableBuilder(
    column: $table.connectionStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastTestedAt => $composableBuilder(
    column: $table.lastTestedAt,
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

class $$AiProviderConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $AiProviderConfigsTable> {
  $$AiProviderConfigsTableOrderingComposer({
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

  ColumnOrderings<String> get providerType => $composableBuilder(
    column: $table.providerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endpointPath => $composableBuilder(
    column: $table.endpointPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelName => $composableBuilder(
    column: $table.modelName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get credentialRef => $composableBuilder(
    column: $table.credentialRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customHeadersRef => $composableBuilder(
    column: $table.customHeadersRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeoutSeconds => $composableBuilder(
    column: $table.timeoutSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxOutputTokens => $composableBuilder(
    column: $table.maxOutputTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streamEnabled => $composableBuilder(
    column: $table.streamEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get connectionStatus => $composableBuilder(
    column: $table.connectionStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastTestedAt => $composableBuilder(
    column: $table.lastTestedAt,
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

class $$AiProviderConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiProviderConfigsTable> {
  $$AiProviderConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get providerType => $composableBuilder(
    column: $table.providerType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get baseUrl =>
      $composableBuilder(column: $table.baseUrl, builder: (column) => column);

  GeneratedColumn<String> get endpointPath => $composableBuilder(
    column: $table.endpointPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modelName =>
      $composableBuilder(column: $table.modelName, builder: (column) => column);

  GeneratedColumn<String> get credentialRef => $composableBuilder(
    column: $table.credentialRef,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customHeadersRef => $composableBuilder(
    column: $table.customHeadersRef,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timeoutSeconds => $composableBuilder(
    column: $table.timeoutSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxOutputTokens => $composableBuilder(
    column: $table.maxOutputTokens,
    builder: (column) => column,
  );

  GeneratedColumn<int> get streamEnabled => $composableBuilder(
    column: $table.streamEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get connectionStatus => $composableBuilder(
    column: $table.connectionStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastTestedAt => $composableBuilder(
    column: $table.lastTestedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AiProviderConfigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiProviderConfigsTable,
          AiProviderConfig,
          $$AiProviderConfigsTableFilterComposer,
          $$AiProviderConfigsTableOrderingComposer,
          $$AiProviderConfigsTableAnnotationComposer,
          $$AiProviderConfigsTableCreateCompanionBuilder,
          $$AiProviderConfigsTableUpdateCompanionBuilder,
          (
            AiProviderConfig,
            BaseReferences<
              _$AppDatabase,
              $AiProviderConfigsTable,
              AiProviderConfig
            >,
          ),
          AiProviderConfig,
          PrefetchHooks Function()
        > {
  $$AiProviderConfigsTableTableManager(
    _$AppDatabase db,
    $AiProviderConfigsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiProviderConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiProviderConfigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiProviderConfigsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> providerType = const Value.absent(),
                Value<String> baseUrl = const Value.absent(),
                Value<String> endpointPath = const Value.absent(),
                Value<String> modelName = const Value.absent(),
                Value<String> credentialRef = const Value.absent(),
                Value<String?> customHeadersRef = const Value.absent(),
                Value<int> timeoutSeconds = const Value.absent(),
                Value<int> maxOutputTokens = const Value.absent(),
                Value<int> streamEnabled = const Value.absent(),
                Value<String> connectionStatus = const Value.absent(),
                Value<int?> lastTestedAt = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiProviderConfigsCompanion(
                id: id,
                providerType: providerType,
                baseUrl: baseUrl,
                endpointPath: endpointPath,
                modelName: modelName,
                credentialRef: credentialRef,
                customHeadersRef: customHeadersRef,
                timeoutSeconds: timeoutSeconds,
                maxOutputTokens: maxOutputTokens,
                streamEnabled: streamEnabled,
                connectionStatus: connectionStatus,
                lastTestedAt: lastTestedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String providerType,
                required String baseUrl,
                required String endpointPath,
                required String modelName,
                required String credentialRef,
                Value<String?> customHeadersRef = const Value.absent(),
                required int timeoutSeconds,
                required int maxOutputTokens,
                required int streamEnabled,
                required String connectionStatus,
                Value<int?> lastTestedAt = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AiProviderConfigsCompanion.insert(
                id: id,
                providerType: providerType,
                baseUrl: baseUrl,
                endpointPath: endpointPath,
                modelName: modelName,
                credentialRef: credentialRef,
                customHeadersRef: customHeadersRef,
                timeoutSeconds: timeoutSeconds,
                maxOutputTokens: maxOutputTokens,
                streamEnabled: streamEnabled,
                connectionStatus: connectionStatus,
                lastTestedAt: lastTestedAt,
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

typedef $$AiProviderConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiProviderConfigsTable,
      AiProviderConfig,
      $$AiProviderConfigsTableFilterComposer,
      $$AiProviderConfigsTableOrderingComposer,
      $$AiProviderConfigsTableAnnotationComposer,
      $$AiProviderConfigsTableCreateCompanionBuilder,
      $$AiProviderConfigsTableUpdateCompanionBuilder,
      (
        AiProviderConfig,
        BaseReferences<
          _$AppDatabase,
          $AiProviderConfigsTable,
          AiProviderConfig
        >,
      ),
      AiProviderConfig,
      PrefetchHooks Function()
    >;
typedef $$AssistantPersonasTableCreateCompanionBuilder =
    AssistantPersonasCompanion Function({
      required String id,
      required String displayName,
      required String presetType,
      Value<String?> customInstruction,
      required String replyLength,
      required int initiativeLevel,
      required int emojiLevel,
      required String avatarAssetId,
      required int scheduleRead,
      required int attendanceRead,
      required int wageRead,
      required int alarmRead,
      required int notesRead,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$AssistantPersonasTableUpdateCompanionBuilder =
    AssistantPersonasCompanion Function({
      Value<String> id,
      Value<String> displayName,
      Value<String> presetType,
      Value<String?> customInstruction,
      Value<String> replyLength,
      Value<int> initiativeLevel,
      Value<int> emojiLevel,
      Value<String> avatarAssetId,
      Value<int> scheduleRead,
      Value<int> attendanceRead,
      Value<int> wageRead,
      Value<int> alarmRead,
      Value<int> notesRead,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$AssistantPersonasTableFilterComposer
    extends Composer<_$AppDatabase, $AssistantPersonasTable> {
  $$AssistantPersonasTableFilterComposer({
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

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get presetType => $composableBuilder(
    column: $table.presetType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customInstruction => $composableBuilder(
    column: $table.customInstruction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get replyLength => $composableBuilder(
    column: $table.replyLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get initiativeLevel => $composableBuilder(
    column: $table.initiativeLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get emojiLevel => $composableBuilder(
    column: $table.emojiLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarAssetId => $composableBuilder(
    column: $table.avatarAssetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scheduleRead => $composableBuilder(
    column: $table.scheduleRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attendanceRead => $composableBuilder(
    column: $table.attendanceRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wageRead => $composableBuilder(
    column: $table.wageRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get alarmRead => $composableBuilder(
    column: $table.alarmRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notesRead => $composableBuilder(
    column: $table.notesRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AssistantPersonasTableOrderingComposer
    extends Composer<_$AppDatabase, $AssistantPersonasTable> {
  $$AssistantPersonasTableOrderingComposer({
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

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get presetType => $composableBuilder(
    column: $table.presetType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customInstruction => $composableBuilder(
    column: $table.customInstruction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get replyLength => $composableBuilder(
    column: $table.replyLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get initiativeLevel => $composableBuilder(
    column: $table.initiativeLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get emojiLevel => $composableBuilder(
    column: $table.emojiLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarAssetId => $composableBuilder(
    column: $table.avatarAssetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduleRead => $composableBuilder(
    column: $table.scheduleRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attendanceRead => $composableBuilder(
    column: $table.attendanceRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wageRead => $composableBuilder(
    column: $table.wageRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get alarmRead => $composableBuilder(
    column: $table.alarmRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notesRead => $composableBuilder(
    column: $table.notesRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AssistantPersonasTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssistantPersonasTable> {
  $$AssistantPersonasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get presetType => $composableBuilder(
    column: $table.presetType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customInstruction => $composableBuilder(
    column: $table.customInstruction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get replyLength => $composableBuilder(
    column: $table.replyLength,
    builder: (column) => column,
  );

  GeneratedColumn<int> get initiativeLevel => $composableBuilder(
    column: $table.initiativeLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get emojiLevel => $composableBuilder(
    column: $table.emojiLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarAssetId => $composableBuilder(
    column: $table.avatarAssetId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scheduleRead => $composableBuilder(
    column: $table.scheduleRead,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attendanceRead => $composableBuilder(
    column: $table.attendanceRead,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wageRead =>
      $composableBuilder(column: $table.wageRead, builder: (column) => column);

  GeneratedColumn<int> get alarmRead =>
      $composableBuilder(column: $table.alarmRead, builder: (column) => column);

  GeneratedColumn<int> get notesRead =>
      $composableBuilder(column: $table.notesRead, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AssistantPersonasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AssistantPersonasTable,
          AssistantPersona,
          $$AssistantPersonasTableFilterComposer,
          $$AssistantPersonasTableOrderingComposer,
          $$AssistantPersonasTableAnnotationComposer,
          $$AssistantPersonasTableCreateCompanionBuilder,
          $$AssistantPersonasTableUpdateCompanionBuilder,
          (
            AssistantPersona,
            BaseReferences<
              _$AppDatabase,
              $AssistantPersonasTable,
              AssistantPersona
            >,
          ),
          AssistantPersona,
          PrefetchHooks Function()
        > {
  $$AssistantPersonasTableTableManager(
    _$AppDatabase db,
    $AssistantPersonasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssistantPersonasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssistantPersonasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssistantPersonasTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> presetType = const Value.absent(),
                Value<String?> customInstruction = const Value.absent(),
                Value<String> replyLength = const Value.absent(),
                Value<int> initiativeLevel = const Value.absent(),
                Value<int> emojiLevel = const Value.absent(),
                Value<String> avatarAssetId = const Value.absent(),
                Value<int> scheduleRead = const Value.absent(),
                Value<int> attendanceRead = const Value.absent(),
                Value<int> wageRead = const Value.absent(),
                Value<int> alarmRead = const Value.absent(),
                Value<int> notesRead = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssistantPersonasCompanion(
                id: id,
                displayName: displayName,
                presetType: presetType,
                customInstruction: customInstruction,
                replyLength: replyLength,
                initiativeLevel: initiativeLevel,
                emojiLevel: emojiLevel,
                avatarAssetId: avatarAssetId,
                scheduleRead: scheduleRead,
                attendanceRead: attendanceRead,
                wageRead: wageRead,
                alarmRead: alarmRead,
                notesRead: notesRead,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String displayName,
                required String presetType,
                Value<String?> customInstruction = const Value.absent(),
                required String replyLength,
                required int initiativeLevel,
                required int emojiLevel,
                required String avatarAssetId,
                required int scheduleRead,
                required int attendanceRead,
                required int wageRead,
                required int alarmRead,
                required int notesRead,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AssistantPersonasCompanion.insert(
                id: id,
                displayName: displayName,
                presetType: presetType,
                customInstruction: customInstruction,
                replyLength: replyLength,
                initiativeLevel: initiativeLevel,
                emojiLevel: emojiLevel,
                avatarAssetId: avatarAssetId,
                scheduleRead: scheduleRead,
                attendanceRead: attendanceRead,
                wageRead: wageRead,
                alarmRead: alarmRead,
                notesRead: notesRead,
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

typedef $$AssistantPersonasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AssistantPersonasTable,
      AssistantPersona,
      $$AssistantPersonasTableFilterComposer,
      $$AssistantPersonasTableOrderingComposer,
      $$AssistantPersonasTableAnnotationComposer,
      $$AssistantPersonasTableCreateCompanionBuilder,
      $$AssistantPersonasTableUpdateCompanionBuilder,
      (
        AssistantPersona,
        BaseReferences<
          _$AppDatabase,
          $AssistantPersonasTable,
          AssistantPersona
        >,
      ),
      AssistantPersona,
      PrefetchHooks Function()
    >;
typedef $$ConversationsTableCreateCompanionBuilder =
    ConversationsCompanion Function({
      required String id,
      required String title,
      required String modelSnapshotJson,
      required int createdAt,
      required int updatedAt,
      Value<int?> archivedAt,
      Value<int> rowid,
    });
typedef $$ConversationsTableUpdateCompanionBuilder =
    ConversationsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> modelSnapshotJson,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> archivedAt,
      Value<int> rowid,
    });

final class $$ConversationsTableReferences
    extends BaseReferences<_$AppDatabase, $ConversationsTable, Conversation> {
  $$ConversationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$MessagesTable, List<Message>> _messagesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.messages,
    aliasName: 'conversations__id__messages__conversation_id',
  );

  $$MessagesTableProcessedTableManager get messagesRefs {
    final manager = $$MessagesTableTableManager(
      $_db,
      $_db.messages,
    ).filter((f) => f.conversationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_messagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AiActionsTable, List<AiAction>>
  _aiActionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.aiActions,
    aliasName: 'conversations__id__ai_actions__conversation_id',
  );

  $$AiActionsTableProcessedTableManager get aiActionsRefs {
    final manager = $$AiActionsTableTableManager(
      $_db,
      $_db.aiActions,
    ).filter((f) => f.conversationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_aiActionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ConversationsTableFilterComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelSnapshotJson => $composableBuilder(
    column: $table.modelSnapshotJson,
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

  ColumnFilters<int> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> messagesRefs(
    Expression<bool> Function($$MessagesTableFilterComposer f) f,
  ) {
    final $$MessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.conversationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessagesTableFilterComposer(
            $db: $db,
            $table: $db.messages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> aiActionsRefs(
    Expression<bool> Function($$AiActionsTableFilterComposer f) f,
  ) {
    final $$AiActionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiActions,
      getReferencedColumn: (t) => t.conversationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiActionsTableFilterComposer(
            $db: $db,
            $table: $db.aiActions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ConversationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelSnapshotJson => $composableBuilder(
    column: $table.modelSnapshotJson,
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

  ColumnOrderings<int> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConversationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get modelSnapshotJson => $composableBuilder(
    column: $table.modelSnapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  Expression<T> messagesRefs<T extends Object>(
    Expression<T> Function($$MessagesTableAnnotationComposer a) f,
  ) {
    final $$MessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.conversationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.messages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> aiActionsRefs<T extends Object>(
    Expression<T> Function($$AiActionsTableAnnotationComposer a) f,
  ) {
    final $$AiActionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiActions,
      getReferencedColumn: (t) => t.conversationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiActionsTableAnnotationComposer(
            $db: $db,
            $table: $db.aiActions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ConversationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConversationsTable,
          Conversation,
          $$ConversationsTableFilterComposer,
          $$ConversationsTableOrderingComposer,
          $$ConversationsTableAnnotationComposer,
          $$ConversationsTableCreateCompanionBuilder,
          $$ConversationsTableUpdateCompanionBuilder,
          (Conversation, $$ConversationsTableReferences),
          Conversation,
          PrefetchHooks Function({bool messagesRefs, bool aiActionsRefs})
        > {
  $$ConversationsTableTableManager(_$AppDatabase db, $ConversationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConversationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConversationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConversationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> modelSnapshotJson = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConversationsCompanion(
                id: id,
                title: title,
                modelSnapshotJson: modelSnapshotJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String modelSnapshotJson,
                required int createdAt,
                required int updatedAt,
                Value<int?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConversationsCompanion.insert(
                id: id,
                title: title,
                modelSnapshotJson: modelSnapshotJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ConversationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({messagesRefs = false, aiActionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (messagesRefs) db.messages,
                    if (aiActionsRefs) db.aiActions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (messagesRefs)
                        await $_getPrefetchedData<
                          Conversation,
                          $ConversationsTable,
                          Message
                        >(
                          currentTable: table,
                          referencedTable: $$ConversationsTableReferences
                              ._messagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ConversationsTableReferences(
                                db,
                                table,
                                p0,
                              ).messagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.conversationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (aiActionsRefs)
                        await $_getPrefetchedData<
                          Conversation,
                          $ConversationsTable,
                          AiAction
                        >(
                          currentTable: table,
                          referencedTable: $$ConversationsTableReferences
                              ._aiActionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ConversationsTableReferences(
                                db,
                                table,
                                p0,
                              ).aiActionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.conversationId == item.id,
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

typedef $$ConversationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConversationsTable,
      Conversation,
      $$ConversationsTableFilterComposer,
      $$ConversationsTableOrderingComposer,
      $$ConversationsTableAnnotationComposer,
      $$ConversationsTableCreateCompanionBuilder,
      $$ConversationsTableUpdateCompanionBuilder,
      (Conversation, $$ConversationsTableReferences),
      Conversation,
      PrefetchHooks Function({bool messagesRefs, bool aiActionsRefs})
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      required String id,
      required String conversationId,
      required String role,
      required String content,
      required String contentType,
      Value<String?> toolCallId,
      required int localOnly,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<String> id,
      Value<String> conversationId,
      Value<String> role,
      Value<String> content,
      Value<String> contentType,
      Value<String?> toolCallId,
      Value<int> localOnly,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$MessagesTableReferences
    extends BaseReferences<_$AppDatabase, $MessagesTable, Message> {
  $$MessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ConversationsTable _conversationIdTable(_$AppDatabase db) => db
      .conversations
      .createAlias('messages__conversation_id__conversations__id');

  $$ConversationsTableProcessedTableManager get conversationId {
    final $_column = $_itemColumn<String>('conversation_id')!;

    final manager = $$ConversationsTableTableManager(
      $_db,
      $_db.conversations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
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

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toolCallId => $composableBuilder(
    column: $table.toolCallId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localOnly => $composableBuilder(
    column: $table.localOnly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ConversationsTableFilterComposer get conversationId {
    final $$ConversationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.conversations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConversationsTableFilterComposer(
            $db: $db,
            $table: $db.conversations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
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

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toolCallId => $composableBuilder(
    column: $table.toolCallId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localOnly => $composableBuilder(
    column: $table.localOnly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ConversationsTableOrderingComposer get conversationId {
    final $$ConversationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.conversations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConversationsTableOrderingComposer(
            $db: $db,
            $table: $db.conversations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toolCallId => $composableBuilder(
    column: $table.toolCallId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get localOnly =>
      $composableBuilder(column: $table.localOnly, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ConversationsTableAnnotationComposer get conversationId {
    final $$ConversationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.conversations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConversationsTableAnnotationComposer(
            $db: $db,
            $table: $db.conversations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessagesTable,
          Message,
          $$MessagesTableFilterComposer,
          $$MessagesTableOrderingComposer,
          $$MessagesTableAnnotationComposer,
          $$MessagesTableCreateCompanionBuilder,
          $$MessagesTableUpdateCompanionBuilder,
          (Message, $$MessagesTableReferences),
          Message,
          PrefetchHooks Function({bool conversationId})
        > {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> conversationId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<String?> toolCallId = const Value.absent(),
                Value<int> localOnly = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion(
                id: id,
                conversationId: conversationId,
                role: role,
                content: content,
                contentType: contentType,
                toolCallId: toolCallId,
                localOnly: localOnly,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String conversationId,
                required String role,
                required String content,
                required String contentType,
                Value<String?> toolCallId = const Value.absent(),
                required int localOnly,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion.insert(
                id: id,
                conversationId: conversationId,
                role: role,
                content: content,
                contentType: contentType,
                toolCallId: toolCallId,
                localOnly: localOnly,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MessagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({conversationId = false}) {
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
                    if (conversationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.conversationId,
                                referencedTable: $$MessagesTableReferences
                                    ._conversationIdTable(db),
                                referencedColumn: $$MessagesTableReferences
                                    ._conversationIdTable(db)
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

typedef $$MessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessagesTable,
      Message,
      $$MessagesTableFilterComposer,
      $$MessagesTableOrderingComposer,
      $$MessagesTableAnnotationComposer,
      $$MessagesTableCreateCompanionBuilder,
      $$MessagesTableUpdateCompanionBuilder,
      (Message, $$MessagesTableReferences),
      Message,
      PrefetchHooks Function({bool conversationId})
    >;
typedef $$AiActionsTableCreateCompanionBuilder =
    AiActionsCompanion Function({
      required String id,
      required String conversationId,
      required String actionType,
      required String toolName,
      required String proposedPayloadJson,
      required String validatedPayloadJson,
      required String beforeSnapshotJson,
      Value<String?> afterSnapshotJson,
      required String status,
      required String confirmationTokenHash,
      required String idempotencyKey,
      required String inputVersion,
      required int expiresAt,
      Value<int?> confirmedAt,
      Value<int?> executedAt,
      Value<int?> undoneAt,
      Value<String?> errorCode,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$AiActionsTableUpdateCompanionBuilder =
    AiActionsCompanion Function({
      Value<String> id,
      Value<String> conversationId,
      Value<String> actionType,
      Value<String> toolName,
      Value<String> proposedPayloadJson,
      Value<String> validatedPayloadJson,
      Value<String> beforeSnapshotJson,
      Value<String?> afterSnapshotJson,
      Value<String> status,
      Value<String> confirmationTokenHash,
      Value<String> idempotencyKey,
      Value<String> inputVersion,
      Value<int> expiresAt,
      Value<int?> confirmedAt,
      Value<int?> executedAt,
      Value<int?> undoneAt,
      Value<String?> errorCode,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$AiActionsTableReferences
    extends BaseReferences<_$AppDatabase, $AiActionsTable, AiAction> {
  $$AiActionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ConversationsTable _conversationIdTable(_$AppDatabase db) => db
      .conversations
      .createAlias('ai_actions__conversation_id__conversations__id');

  $$ConversationsTableProcessedTableManager get conversationId {
    final $_column = $_itemColumn<String>('conversation_id')!;

    final manager = $$ConversationsTableTableManager(
      $_db,
      $_db.conversations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AiActionsTableFilterComposer
    extends Composer<_$AppDatabase, $AiActionsTable> {
  $$AiActionsTableFilterComposer({
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

  ColumnFilters<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toolName => $composableBuilder(
    column: $table.toolName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proposedPayloadJson => $composableBuilder(
    column: $table.proposedPayloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get validatedPayloadJson => $composableBuilder(
    column: $table.validatedPayloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get beforeSnapshotJson => $composableBuilder(
    column: $table.beforeSnapshotJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get afterSnapshotJson => $composableBuilder(
    column: $table.afterSnapshotJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get confirmationTokenHash => $composableBuilder(
    column: $table.confirmationTokenHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inputVersion => $composableBuilder(
    column: $table.inputVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confirmedAt => $composableBuilder(
    column: $table.confirmedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get executedAt => $composableBuilder(
    column: $table.executedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get undoneAt => $composableBuilder(
    column: $table.undoneAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ConversationsTableFilterComposer get conversationId {
    final $$ConversationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.conversations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConversationsTableFilterComposer(
            $db: $db,
            $table: $db.conversations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiActionsTableOrderingComposer
    extends Composer<_$AppDatabase, $AiActionsTable> {
  $$AiActionsTableOrderingComposer({
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

  ColumnOrderings<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toolName => $composableBuilder(
    column: $table.toolName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proposedPayloadJson => $composableBuilder(
    column: $table.proposedPayloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get validatedPayloadJson => $composableBuilder(
    column: $table.validatedPayloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get beforeSnapshotJson => $composableBuilder(
    column: $table.beforeSnapshotJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get afterSnapshotJson => $composableBuilder(
    column: $table.afterSnapshotJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get confirmationTokenHash => $composableBuilder(
    column: $table.confirmationTokenHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inputVersion => $composableBuilder(
    column: $table.inputVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confirmedAt => $composableBuilder(
    column: $table.confirmedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get executedAt => $composableBuilder(
    column: $table.executedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get undoneAt => $composableBuilder(
    column: $table.undoneAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ConversationsTableOrderingComposer get conversationId {
    final $$ConversationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.conversations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConversationsTableOrderingComposer(
            $db: $db,
            $table: $db.conversations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiActionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiActionsTable> {
  $$AiActionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toolName =>
      $composableBuilder(column: $table.toolName, builder: (column) => column);

  GeneratedColumn<String> get proposedPayloadJson => $composableBuilder(
    column: $table.proposedPayloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get validatedPayloadJson => $composableBuilder(
    column: $table.validatedPayloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get beforeSnapshotJson => $composableBuilder(
    column: $table.beforeSnapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get afterSnapshotJson => $composableBuilder(
    column: $table.afterSnapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get confirmationTokenHash => $composableBuilder(
    column: $table.confirmationTokenHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get inputVersion => $composableBuilder(
    column: $table.inputVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<int> get confirmedAt => $composableBuilder(
    column: $table.confirmedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get executedAt => $composableBuilder(
    column: $table.executedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get undoneAt =>
      $composableBuilder(column: $table.undoneAt, builder: (column) => column);

  GeneratedColumn<String> get errorCode =>
      $composableBuilder(column: $table.errorCode, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ConversationsTableAnnotationComposer get conversationId {
    final $$ConversationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.conversations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConversationsTableAnnotationComposer(
            $db: $db,
            $table: $db.conversations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AiActionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiActionsTable,
          AiAction,
          $$AiActionsTableFilterComposer,
          $$AiActionsTableOrderingComposer,
          $$AiActionsTableAnnotationComposer,
          $$AiActionsTableCreateCompanionBuilder,
          $$AiActionsTableUpdateCompanionBuilder,
          (AiAction, $$AiActionsTableReferences),
          AiAction,
          PrefetchHooks Function({bool conversationId})
        > {
  $$AiActionsTableTableManager(_$AppDatabase db, $AiActionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiActionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiActionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiActionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> conversationId = const Value.absent(),
                Value<String> actionType = const Value.absent(),
                Value<String> toolName = const Value.absent(),
                Value<String> proposedPayloadJson = const Value.absent(),
                Value<String> validatedPayloadJson = const Value.absent(),
                Value<String> beforeSnapshotJson = const Value.absent(),
                Value<String?> afterSnapshotJson = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> confirmationTokenHash = const Value.absent(),
                Value<String> idempotencyKey = const Value.absent(),
                Value<String> inputVersion = const Value.absent(),
                Value<int> expiresAt = const Value.absent(),
                Value<int?> confirmedAt = const Value.absent(),
                Value<int?> executedAt = const Value.absent(),
                Value<int?> undoneAt = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiActionsCompanion(
                id: id,
                conversationId: conversationId,
                actionType: actionType,
                toolName: toolName,
                proposedPayloadJson: proposedPayloadJson,
                validatedPayloadJson: validatedPayloadJson,
                beforeSnapshotJson: beforeSnapshotJson,
                afterSnapshotJson: afterSnapshotJson,
                status: status,
                confirmationTokenHash: confirmationTokenHash,
                idempotencyKey: idempotencyKey,
                inputVersion: inputVersion,
                expiresAt: expiresAt,
                confirmedAt: confirmedAt,
                executedAt: executedAt,
                undoneAt: undoneAt,
                errorCode: errorCode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String conversationId,
                required String actionType,
                required String toolName,
                required String proposedPayloadJson,
                required String validatedPayloadJson,
                required String beforeSnapshotJson,
                Value<String?> afterSnapshotJson = const Value.absent(),
                required String status,
                required String confirmationTokenHash,
                required String idempotencyKey,
                required String inputVersion,
                required int expiresAt,
                Value<int?> confirmedAt = const Value.absent(),
                Value<int?> executedAt = const Value.absent(),
                Value<int?> undoneAt = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => AiActionsCompanion.insert(
                id: id,
                conversationId: conversationId,
                actionType: actionType,
                toolName: toolName,
                proposedPayloadJson: proposedPayloadJson,
                validatedPayloadJson: validatedPayloadJson,
                beforeSnapshotJson: beforeSnapshotJson,
                afterSnapshotJson: afterSnapshotJson,
                status: status,
                confirmationTokenHash: confirmationTokenHash,
                idempotencyKey: idempotencyKey,
                inputVersion: inputVersion,
                expiresAt: expiresAt,
                confirmedAt: confirmedAt,
                executedAt: executedAt,
                undoneAt: undoneAt,
                errorCode: errorCode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AiActionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({conversationId = false}) {
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
                    if (conversationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.conversationId,
                                referencedTable: $$AiActionsTableReferences
                                    ._conversationIdTable(db),
                                referencedColumn: $$AiActionsTableReferences
                                    ._conversationIdTable(db)
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

typedef $$AiActionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiActionsTable,
      AiAction,
      $$AiActionsTableFilterComposer,
      $$AiActionsTableOrderingComposer,
      $$AiActionsTableAnnotationComposer,
      $$AiActionsTableCreateCompanionBuilder,
      $$AiActionsTableUpdateCompanionBuilder,
      (AiAction, $$AiActionsTableReferences),
      AiAction,
      PrefetchHooks Function({bool conversationId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DatabaseMetadataTableTableManager get databaseMetadata =>
      $$DatabaseMetadataTableTableManager(_db, _db.databaseMetadata);
  $$UserSettingsTableTableManager get userSettings =>
      $$UserSettingsTableTableManager(_db, _db.userSettings);
  $$ShiftTemplatesTableTableManager get shiftTemplates =>
      $$ShiftTemplatesTableTableManager(_db, _db.shiftTemplates);
  $$ScheduleRulesTableTableManager get scheduleRules =>
      $$ScheduleRulesTableTableManager(_db, _db.scheduleRules);
  $$DayOverridesTableTableManager get dayOverrides =>
      $$DayOverridesTableTableManager(_db, _db.dayOverrides);
  $$HolidayRecordsTableTableManager get holidayRecords =>
      $$HolidayRecordsTableTableManager(_db, _db.holidayRecords);
  $$CalendarDayCacheTableTableManager get calendarDayCache =>
      $$CalendarDayCacheTableTableManager(_db, _db.calendarDayCache);
  $$ChangeLogTableTableManager get changeLog =>
      $$ChangeLogTableTableManager(_db, _db.changeLog);
  $$AlarmTemplatesTableTableManager get alarmTemplates =>
      $$AlarmTemplatesTableTableManager(_db, _db.alarmTemplates);
  $$ShiftAlarmTemplatesTableTableManager get shiftAlarmTemplates =>
      $$ShiftAlarmTemplatesTableTableManager(_db, _db.shiftAlarmTemplates);
  $$AlarmInstancesTableTableManager get alarmInstances =>
      $$AlarmInstancesTableTableManager(_db, _db.alarmInstances);
  $$AttendanceRecordsTableTableManager get attendanceRecords =>
      $$AttendanceRecordsTableTableManager(_db, _db.attendanceRecords);
  $$LeaveRecordsTableTableManager get leaveRecords =>
      $$LeaveRecordsTableTableManager(_db, _db.leaveRecords);
  $$WageRulesTableTableManager get wageRules =>
      $$WageRulesTableTableManager(_db, _db.wageRules);
  $$PayrollPeriodsTableTableManager get payrollPeriods =>
      $$PayrollPeriodsTableTableManager(_db, _db.payrollPeriods);
  $$AiProviderConfigsTableTableManager get aiProviderConfigs =>
      $$AiProviderConfigsTableTableManager(_db, _db.aiProviderConfigs);
  $$AssistantPersonasTableTableManager get assistantPersonas =>
      $$AssistantPersonasTableTableManager(_db, _db.assistantPersonas);
  $$ConversationsTableTableManager get conversations =>
      $$ConversationsTableTableManager(_db, _db.conversations);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$AiActionsTableTableManager get aiActions =>
      $$AiActionsTableTableManager(_db, _db.aiActions);
}
