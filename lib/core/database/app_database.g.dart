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
          PrefetchHooks Function({bool dayOverridesRefs})
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
          prefetchHooksCallback: ({dayOverridesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (dayOverridesRefs) db.dayOverrides],
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
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
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
      PrefetchHooks Function({bool dayOverridesRefs})
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
}
