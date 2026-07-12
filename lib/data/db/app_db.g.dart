// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _battingStyleMeta = const VerificationMeta(
    'battingStyle',
  );
  @override
  late final GeneratedColumn<String> battingStyle = GeneratedColumn<String>(
    'batting_style',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bowlingStyleMeta = const VerificationMeta(
    'bowlingStyle',
  );
  @override
  late final GeneratedColumn<String> bowlingStyle = GeneratedColumn<String>(
    'bowling_style',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PlayerRole?, String> role =
      GeneratedColumn<String>(
        'role',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<PlayerRole?>($PlayersTable.$converterrolen);
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    nickname,
    battingStyle,
    bowlingStyle,
    role,
    photoPath,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(
    Insertable<Player> instance, {
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
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    }
    if (data.containsKey('batting_style')) {
      context.handle(
        _battingStyleMeta,
        battingStyle.isAcceptableOrUnknown(
          data['batting_style']!,
          _battingStyleMeta,
        ),
      );
    }
    if (data.containsKey('bowling_style')) {
      context.handle(
        _bowlingStyleMeta,
        bowlingStyle.isAcceptableOrUnknown(
          data['bowling_style']!,
          _bowlingStyleMeta,
        ),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
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
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      ),
      battingStyle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batting_style'],
      ),
      bowlingStyle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bowling_style'],
      ),
      role: $PlayersTable.$converterrolen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}role'],
        ),
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PlayerRole, String, String> $converterrole =
      const EnumNameConverter<PlayerRole>(PlayerRole.values);
  static JsonTypeConverter2<PlayerRole?, String?, String?> $converterrolen =
      JsonTypeConverter2.asNullable($converterrole);
}

class Player extends DataClass implements Insertable<Player> {
  final String id;
  final String name;
  final String? nickname;
  final String? battingStyle;
  final String? bowlingStyle;
  final PlayerRole? role;
  final String? photoPath;
  final DateTime createdAt;
  const Player({
    required this.id,
    required this.name,
    this.nickname,
    this.battingStyle,
    this.bowlingStyle,
    this.role,
    this.photoPath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    if (!nullToAbsent || battingStyle != null) {
      map['batting_style'] = Variable<String>(battingStyle);
    }
    if (!nullToAbsent || bowlingStyle != null) {
      map['bowling_style'] = Variable<String>(bowlingStyle);
    }
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String>($PlayersTable.$converterrolen.toSql(role));
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      name: Value(name),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      battingStyle: battingStyle == null && nullToAbsent
          ? const Value.absent()
          : Value(battingStyle),
      bowlingStyle: bowlingStyle == null && nullToAbsent
          ? const Value.absent()
          : Value(bowlingStyle),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      createdAt: Value(createdAt),
    );
  }

  factory Player.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      battingStyle: serializer.fromJson<String?>(json['battingStyle']),
      bowlingStyle: serializer.fromJson<String?>(json['bowlingStyle']),
      role: $PlayersTable.$converterrolen.fromJson(
        serializer.fromJson<String?>(json['role']),
      ),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'nickname': serializer.toJson<String?>(nickname),
      'battingStyle': serializer.toJson<String?>(battingStyle),
      'bowlingStyle': serializer.toJson<String?>(bowlingStyle),
      'role': serializer.toJson<String?>(
        $PlayersTable.$converterrolen.toJson(role),
      ),
      'photoPath': serializer.toJson<String?>(photoPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Player copyWith({
    String? id,
    String? name,
    Value<String?> nickname = const Value.absent(),
    Value<String?> battingStyle = const Value.absent(),
    Value<String?> bowlingStyle = const Value.absent(),
    Value<PlayerRole?> role = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    DateTime? createdAt,
  }) => Player(
    id: id ?? this.id,
    name: name ?? this.name,
    nickname: nickname.present ? nickname.value : this.nickname,
    battingStyle: battingStyle.present ? battingStyle.value : this.battingStyle,
    bowlingStyle: bowlingStyle.present ? bowlingStyle.value : this.bowlingStyle,
    role: role.present ? role.value : this.role,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    createdAt: createdAt ?? this.createdAt,
  );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      battingStyle: data.battingStyle.present
          ? data.battingStyle.value
          : this.battingStyle,
      bowlingStyle: data.bowlingStyle.present
          ? data.bowlingStyle.value
          : this.bowlingStyle,
      role: data.role.present ? data.role.value : this.role,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nickname: $nickname, ')
          ..write('battingStyle: $battingStyle, ')
          ..write('bowlingStyle: $bowlingStyle, ')
          ..write('role: $role, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    nickname,
    battingStyle,
    bowlingStyle,
    role,
    photoPath,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.name == this.name &&
          other.nickname == this.nickname &&
          other.battingStyle == this.battingStyle &&
          other.bowlingStyle == this.bowlingStyle &&
          other.role == this.role &&
          other.photoPath == this.photoPath &&
          other.createdAt == this.createdAt);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> nickname;
  final Value<String?> battingStyle;
  final Value<String?> bowlingStyle;
  final Value<PlayerRole?> role;
  final Value<String?> photoPath;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nickname = const Value.absent(),
    this.battingStyle = const Value.absent(),
    this.bowlingStyle = const Value.absent(),
    this.role = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayersCompanion.insert({
    required String id,
    required String name,
    this.nickname = const Value.absent(),
    this.battingStyle = const Value.absent(),
    this.bowlingStyle = const Value.absent(),
    this.role = const Value.absent(),
    this.photoPath = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Player> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? nickname,
    Expression<String>? battingStyle,
    Expression<String>? bowlingStyle,
    Expression<String>? role,
    Expression<String>? photoPath,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nickname != null) 'nickname': nickname,
      if (battingStyle != null) 'batting_style': battingStyle,
      if (bowlingStyle != null) 'bowling_style': bowlingStyle,
      if (role != null) 'role': role,
      if (photoPath != null) 'photo_path': photoPath,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? nickname,
    Value<String?>? battingStyle,
    Value<String?>? bowlingStyle,
    Value<PlayerRole?>? role,
    Value<String?>? photoPath,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PlayersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      battingStyle: battingStyle ?? this.battingStyle,
      bowlingStyle: bowlingStyle ?? this.bowlingStyle,
      role: role ?? this.role,
      photoPath: photoPath ?? this.photoPath,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (battingStyle.present) {
      map['batting_style'] = Variable<String>(battingStyle.value);
    }
    if (bowlingStyle.present) {
      map['bowling_style'] = Variable<String>(bowlingStyle.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(
        $PlayersTable.$converterrolen.toSql(role.value),
      );
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
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
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nickname: $nickname, ')
          ..write('battingStyle: $battingStyle, ')
          ..write('bowlingStyle: $bowlingStyle, ')
          ..write('role: $role, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TeamsTable extends Teams with TableInfo<$TeamsTable, Team> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamsTable(this.attachedDatabase, [this._alias]);
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _logoPathMeta = const VerificationMeta(
    'logoPath',
  );
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
    'logo_path',
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    shortName,
    logoPath,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teams';
  @override
  VerificationContext validateIntegrity(
    Insertable<Team> instance, {
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
    }
    if (data.containsKey('logo_path')) {
      context.handle(
        _logoPathMeta,
        logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta),
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
  Team map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Team(
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
      ),
      logoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TeamsTable createAlias(String alias) {
    return $TeamsTable(attachedDatabase, alias);
  }
}

class Team extends DataClass implements Insertable<Team> {
  final String id;
  final String name;
  final String? shortName;
  final String? logoPath;
  final DateTime createdAt;
  const Team({
    required this.id,
    required this.name,
    this.shortName,
    this.logoPath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || shortName != null) {
      map['short_name'] = Variable<String>(shortName);
    }
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TeamsCompanion toCompanion(bool nullToAbsent) {
    return TeamsCompanion(
      id: Value(id),
      name: Value(name),
      shortName: shortName == null && nullToAbsent
          ? const Value.absent()
          : Value(shortName),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
      createdAt: Value(createdAt),
    );
  }

  factory Team.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Team(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      shortName: serializer.fromJson<String?>(json['shortName']),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'shortName': serializer.toJson<String?>(shortName),
      'logoPath': serializer.toJson<String?>(logoPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Team copyWith({
    String? id,
    String? name,
    Value<String?> shortName = const Value.absent(),
    Value<String?> logoPath = const Value.absent(),
    DateTime? createdAt,
  }) => Team(
    id: id ?? this.id,
    name: name ?? this.name,
    shortName: shortName.present ? shortName.value : this.shortName,
    logoPath: logoPath.present ? logoPath.value : this.logoPath,
    createdAt: createdAt ?? this.createdAt,
  );
  Team copyWithCompanion(TeamsCompanion data) {
    return Team(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      shortName: data.shortName.present ? data.shortName.value : this.shortName,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Team(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shortName: $shortName, ')
          ..write('logoPath: $logoPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, shortName, logoPath, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Team &&
          other.id == this.id &&
          other.name == this.name &&
          other.shortName == this.shortName &&
          other.logoPath == this.logoPath &&
          other.createdAt == this.createdAt);
}

class TeamsCompanion extends UpdateCompanion<Team> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> shortName;
  final Value<String?> logoPath;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TeamsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.shortName = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeamsCompanion.insert({
    required String id,
    required String name,
    this.shortName = const Value.absent(),
    this.logoPath = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Team> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? shortName,
    Expression<String>? logoPath,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (shortName != null) 'short_name': shortName,
      if (logoPath != null) 'logo_path': logoPath,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeamsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? shortName,
    Value<String?>? logoPath,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TeamsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      logoPath: logoPath ?? this.logoPath,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (shortName.present) {
      map['short_name'] = Variable<String>(shortName.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
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
    return (StringBuffer('TeamsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shortName: $shortName, ')
          ..write('logoPath: $logoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TeamPlayersTable extends TeamPlayers
    with TableInfo<$TeamPlayersTable, TeamPlayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamPlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jerseyNoMeta = const VerificationMeta(
    'jerseyNo',
  );
  @override
  late final GeneratedColumn<int> jerseyNo = GeneratedColumn<int>(
    'jersey_no',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [teamId, playerId, jerseyNo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'team_players';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeamPlayer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('jersey_no')) {
      context.handle(
        _jerseyNoMeta,
        jerseyNo.isAcceptableOrUnknown(data['jersey_no']!, _jerseyNoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {teamId, playerId};
  @override
  TeamPlayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamPlayer(
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_id'],
      )!,
      jerseyNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jersey_no'],
      ),
    );
  }

  @override
  $TeamPlayersTable createAlias(String alias) {
    return $TeamPlayersTable(attachedDatabase, alias);
  }
}

class TeamPlayer extends DataClass implements Insertable<TeamPlayer> {
  final String teamId;
  final String playerId;
  final int? jerseyNo;
  const TeamPlayer({
    required this.teamId,
    required this.playerId,
    this.jerseyNo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['team_id'] = Variable<String>(teamId);
    map['player_id'] = Variable<String>(playerId);
    if (!nullToAbsent || jerseyNo != null) {
      map['jersey_no'] = Variable<int>(jerseyNo);
    }
    return map;
  }

  TeamPlayersCompanion toCompanion(bool nullToAbsent) {
    return TeamPlayersCompanion(
      teamId: Value(teamId),
      playerId: Value(playerId),
      jerseyNo: jerseyNo == null && nullToAbsent
          ? const Value.absent()
          : Value(jerseyNo),
    );
  }

  factory TeamPlayer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamPlayer(
      teamId: serializer.fromJson<String>(json['teamId']),
      playerId: serializer.fromJson<String>(json['playerId']),
      jerseyNo: serializer.fromJson<int?>(json['jerseyNo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'teamId': serializer.toJson<String>(teamId),
      'playerId': serializer.toJson<String>(playerId),
      'jerseyNo': serializer.toJson<int?>(jerseyNo),
    };
  }

  TeamPlayer copyWith({
    String? teamId,
    String? playerId,
    Value<int?> jerseyNo = const Value.absent(),
  }) => TeamPlayer(
    teamId: teamId ?? this.teamId,
    playerId: playerId ?? this.playerId,
    jerseyNo: jerseyNo.present ? jerseyNo.value : this.jerseyNo,
  );
  TeamPlayer copyWithCompanion(TeamPlayersCompanion data) {
    return TeamPlayer(
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      jerseyNo: data.jerseyNo.present ? data.jerseyNo.value : this.jerseyNo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamPlayer(')
          ..write('teamId: $teamId, ')
          ..write('playerId: $playerId, ')
          ..write('jerseyNo: $jerseyNo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(teamId, playerId, jerseyNo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamPlayer &&
          other.teamId == this.teamId &&
          other.playerId == this.playerId &&
          other.jerseyNo == this.jerseyNo);
}

class TeamPlayersCompanion extends UpdateCompanion<TeamPlayer> {
  final Value<String> teamId;
  final Value<String> playerId;
  final Value<int?> jerseyNo;
  final Value<int> rowid;
  const TeamPlayersCompanion({
    this.teamId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.jerseyNo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeamPlayersCompanion.insert({
    required String teamId,
    required String playerId,
    this.jerseyNo = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : teamId = Value(teamId),
       playerId = Value(playerId);
  static Insertable<TeamPlayer> custom({
    Expression<String>? teamId,
    Expression<String>? playerId,
    Expression<int>? jerseyNo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (teamId != null) 'team_id': teamId,
      if (playerId != null) 'player_id': playerId,
      if (jerseyNo != null) 'jersey_no': jerseyNo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeamPlayersCompanion copyWith({
    Value<String>? teamId,
    Value<String>? playerId,
    Value<int?>? jerseyNo,
    Value<int>? rowid,
  }) {
    return TeamPlayersCompanion(
      teamId: teamId ?? this.teamId,
      playerId: playerId ?? this.playerId,
      jerseyNo: jerseyNo ?? this.jerseyNo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (jerseyNo.present) {
      map['jersey_no'] = Variable<int>(jerseyNo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamPlayersCompanion(')
          ..write('teamId: $teamId, ')
          ..write('playerId: $playerId, ')
          ..write('jerseyNo: $jerseyNo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MatchesTable extends Matches with TableInfo<$MatchesTable, MatchRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchesTable(this.attachedDatabase, [this._alias]);
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
    'format',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rulesJsonMeta = const VerificationMeta(
    'rulesJson',
  );
  @override
  late final GeneratedColumn<String> rulesJson = GeneratedColumn<String>(
    'rules_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamAIdMeta = const VerificationMeta(
    'teamAId',
  );
  @override
  late final GeneratedColumn<String> teamAId = GeneratedColumn<String>(
    'team_a_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamBIdMeta = const VerificationMeta(
    'teamBId',
  );
  @override
  late final GeneratedColumn<String> teamBId = GeneratedColumn<String>(
    'team_b_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueMeta = const VerificationMeta('venue');
  @override
  late final GeneratedColumn<String> venue = GeneratedColumn<String>(
    'venue',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateLocalMeta = const VerificationMeta(
    'dateLocal',
  );
  @override
  late final GeneratedColumn<DateTime> dateLocal = GeneratedColumn<DateTime>(
    'date_local',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MatchType, String> matchType =
      GeneratedColumn<String>(
        'match_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('standalone'),
      ).withConverter<MatchType>($MatchesTable.$convertermatchType);
  static const VerificationMeta _jokerPlayerIdMeta = const VerificationMeta(
    'jokerPlayerId',
  );
  @override
  late final GeneratedColumn<String> jokerPlayerId = GeneratedColumn<String>(
    'joker_player_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tossWinnerTeamIdMeta = const VerificationMeta(
    'tossWinnerTeamId',
  );
  @override
  late final GeneratedColumn<String> tossWinnerTeamId = GeneratedColumn<String>(
    'toss_winner_team_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TossDecision?, String>
  tossDecision = GeneratedColumn<String>(
    'toss_decision',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<TossDecision?>($MatchesTable.$convertertossDecisionn);
  @override
  late final GeneratedColumnWithTypeConverter<MatchStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('notStarted'),
      ).withConverter<MatchStatus>($MatchesTable.$converterstatus);
  static const VerificationMeta _resultJsonMeta = const VerificationMeta(
    'resultJson',
  );
  @override
  late final GeneratedColumn<String> resultJson = GeneratedColumn<String>(
    'result_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tournamentIdMeta = const VerificationMeta(
    'tournamentId',
  );
  @override
  late final GeneratedColumn<String> tournamentId = GeneratedColumn<String>(
    'tournament_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _eventCursorMeta = const VerificationMeta(
    'eventCursor',
  );
  @override
  late final GeneratedColumn<int> eventCursor = GeneratedColumn<int>(
    'event_cursor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    format,
    rulesJson,
    teamAId,
    teamBId,
    venue,
    dateLocal,
    matchType,
    jokerPlayerId,
    tossWinnerTeamId,
    tossDecision,
    status,
    resultJson,
    tournamentId,
    eventCursor,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'matches';
  @override
  VerificationContext validateIntegrity(
    Insertable<MatchRow> instance, {
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
    }
    if (data.containsKey('format')) {
      context.handle(
        _formatMeta,
        format.isAcceptableOrUnknown(data['format']!, _formatMeta),
      );
    } else if (isInserting) {
      context.missing(_formatMeta);
    }
    if (data.containsKey('rules_json')) {
      context.handle(
        _rulesJsonMeta,
        rulesJson.isAcceptableOrUnknown(data['rules_json']!, _rulesJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_rulesJsonMeta);
    }
    if (data.containsKey('team_a_id')) {
      context.handle(
        _teamAIdMeta,
        teamAId.isAcceptableOrUnknown(data['team_a_id']!, _teamAIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamAIdMeta);
    }
    if (data.containsKey('team_b_id')) {
      context.handle(
        _teamBIdMeta,
        teamBId.isAcceptableOrUnknown(data['team_b_id']!, _teamBIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamBIdMeta);
    }
    if (data.containsKey('venue')) {
      context.handle(
        _venueMeta,
        venue.isAcceptableOrUnknown(data['venue']!, _venueMeta),
      );
    }
    if (data.containsKey('date_local')) {
      context.handle(
        _dateLocalMeta,
        dateLocal.isAcceptableOrUnknown(data['date_local']!, _dateLocalMeta),
      );
    } else if (isInserting) {
      context.missing(_dateLocalMeta);
    }
    if (data.containsKey('joker_player_id')) {
      context.handle(
        _jokerPlayerIdMeta,
        jokerPlayerId.isAcceptableOrUnknown(
          data['joker_player_id']!,
          _jokerPlayerIdMeta,
        ),
      );
    }
    if (data.containsKey('toss_winner_team_id')) {
      context.handle(
        _tossWinnerTeamIdMeta,
        tossWinnerTeamId.isAcceptableOrUnknown(
          data['toss_winner_team_id']!,
          _tossWinnerTeamIdMeta,
        ),
      );
    }
    if (data.containsKey('result_json')) {
      context.handle(
        _resultJsonMeta,
        resultJson.isAcceptableOrUnknown(data['result_json']!, _resultJsonMeta),
      );
    }
    if (data.containsKey('tournament_id')) {
      context.handle(
        _tournamentIdMeta,
        tournamentId.isAcceptableOrUnknown(
          data['tournament_id']!,
          _tournamentIdMeta,
        ),
      );
    }
    if (data.containsKey('event_cursor')) {
      context.handle(
        _eventCursorMeta,
        eventCursor.isAcceptableOrUnknown(
          data['event_cursor']!,
          _eventCursorMeta,
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
  MatchRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      format: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}format'],
      )!,
      rulesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rules_json'],
      )!,
      teamAId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_a_id'],
      )!,
      teamBId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_b_id'],
      )!,
      venue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue'],
      ),
      dateLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_local'],
      )!,
      matchType: $MatchesTable.$convertermatchType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}match_type'],
        )!,
      ),
      jokerPlayerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}joker_player_id'],
      ),
      tossWinnerTeamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}toss_winner_team_id'],
      ),
      tossDecision: $MatchesTable.$convertertossDecisionn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}toss_decision'],
        ),
      ),
      status: $MatchesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      resultJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result_json'],
      ),
      tournamentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tournament_id'],
      ),
      eventCursor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_cursor'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MatchesTable createAlias(String alias) {
    return $MatchesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MatchType, String, String> $convertermatchType =
      const EnumNameConverter<MatchType>(MatchType.values);
  static JsonTypeConverter2<TossDecision, String, String>
  $convertertossDecision = const EnumNameConverter<TossDecision>(
    TossDecision.values,
  );
  static JsonTypeConverter2<TossDecision?, String?, String?>
  $convertertossDecisionn = JsonTypeConverter2.asNullable(
    $convertertossDecision,
  );
  static JsonTypeConverter2<MatchStatus, String, String> $converterstatus =
      const EnumNameConverter<MatchStatus>(MatchStatus.values);
}

class MatchRow extends DataClass implements Insertable<MatchRow> {
  final String id;
  final String? title;

  /// Preset id the match was created from (e.g. 'box_cricket', 'custom').
  final String format;

  /// Serialised [MatchRules].
  final String rulesJson;
  final String teamAId;
  final String teamBId;
  final String? venue;
  final DateTime dateLocal;

  /// Standalone vs part of a tournament (CricScore prompts for this at setup).
  final MatchType matchType;

  /// The pooled player designated as the joker (plays for both sides), if any.
  final String? jokerPlayerId;
  final String? tossWinnerTeamId;
  final TossDecision? tossDecision;
  final MatchStatus status;

  /// Serialised [MatchResult]; null until completed.
  final String? resultJson;
  final String? tournamentId;

  /// Undo/redo cursor: events with seq <= cursor are "live".
  final int eventCursor;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MatchRow({
    required this.id,
    this.title,
    required this.format,
    required this.rulesJson,
    required this.teamAId,
    required this.teamBId,
    this.venue,
    required this.dateLocal,
    required this.matchType,
    this.jokerPlayerId,
    this.tossWinnerTeamId,
    this.tossDecision,
    required this.status,
    this.resultJson,
    this.tournamentId,
    required this.eventCursor,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['format'] = Variable<String>(format);
    map['rules_json'] = Variable<String>(rulesJson);
    map['team_a_id'] = Variable<String>(teamAId);
    map['team_b_id'] = Variable<String>(teamBId);
    if (!nullToAbsent || venue != null) {
      map['venue'] = Variable<String>(venue);
    }
    map['date_local'] = Variable<DateTime>(dateLocal);
    {
      map['match_type'] = Variable<String>(
        $MatchesTable.$convertermatchType.toSql(matchType),
      );
    }
    if (!nullToAbsent || jokerPlayerId != null) {
      map['joker_player_id'] = Variable<String>(jokerPlayerId);
    }
    if (!nullToAbsent || tossWinnerTeamId != null) {
      map['toss_winner_team_id'] = Variable<String>(tossWinnerTeamId);
    }
    if (!nullToAbsent || tossDecision != null) {
      map['toss_decision'] = Variable<String>(
        $MatchesTable.$convertertossDecisionn.toSql(tossDecision),
      );
    }
    {
      map['status'] = Variable<String>(
        $MatchesTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || resultJson != null) {
      map['result_json'] = Variable<String>(resultJson);
    }
    if (!nullToAbsent || tournamentId != null) {
      map['tournament_id'] = Variable<String>(tournamentId);
    }
    map['event_cursor'] = Variable<int>(eventCursor);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MatchesCompanion toCompanion(bool nullToAbsent) {
    return MatchesCompanion(
      id: Value(id),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      format: Value(format),
      rulesJson: Value(rulesJson),
      teamAId: Value(teamAId),
      teamBId: Value(teamBId),
      venue: venue == null && nullToAbsent
          ? const Value.absent()
          : Value(venue),
      dateLocal: Value(dateLocal),
      matchType: Value(matchType),
      jokerPlayerId: jokerPlayerId == null && nullToAbsent
          ? const Value.absent()
          : Value(jokerPlayerId),
      tossWinnerTeamId: tossWinnerTeamId == null && nullToAbsent
          ? const Value.absent()
          : Value(tossWinnerTeamId),
      tossDecision: tossDecision == null && nullToAbsent
          ? const Value.absent()
          : Value(tossDecision),
      status: Value(status),
      resultJson: resultJson == null && nullToAbsent
          ? const Value.absent()
          : Value(resultJson),
      tournamentId: tournamentId == null && nullToAbsent
          ? const Value.absent()
          : Value(tournamentId),
      eventCursor: Value(eventCursor),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MatchRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      format: serializer.fromJson<String>(json['format']),
      rulesJson: serializer.fromJson<String>(json['rulesJson']),
      teamAId: serializer.fromJson<String>(json['teamAId']),
      teamBId: serializer.fromJson<String>(json['teamBId']),
      venue: serializer.fromJson<String?>(json['venue']),
      dateLocal: serializer.fromJson<DateTime>(json['dateLocal']),
      matchType: $MatchesTable.$convertermatchType.fromJson(
        serializer.fromJson<String>(json['matchType']),
      ),
      jokerPlayerId: serializer.fromJson<String?>(json['jokerPlayerId']),
      tossWinnerTeamId: serializer.fromJson<String?>(json['tossWinnerTeamId']),
      tossDecision: $MatchesTable.$convertertossDecisionn.fromJson(
        serializer.fromJson<String?>(json['tossDecision']),
      ),
      status: $MatchesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      resultJson: serializer.fromJson<String?>(json['resultJson']),
      tournamentId: serializer.fromJson<String?>(json['tournamentId']),
      eventCursor: serializer.fromJson<int>(json['eventCursor']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String?>(title),
      'format': serializer.toJson<String>(format),
      'rulesJson': serializer.toJson<String>(rulesJson),
      'teamAId': serializer.toJson<String>(teamAId),
      'teamBId': serializer.toJson<String>(teamBId),
      'venue': serializer.toJson<String?>(venue),
      'dateLocal': serializer.toJson<DateTime>(dateLocal),
      'matchType': serializer.toJson<String>(
        $MatchesTable.$convertermatchType.toJson(matchType),
      ),
      'jokerPlayerId': serializer.toJson<String?>(jokerPlayerId),
      'tossWinnerTeamId': serializer.toJson<String?>(tossWinnerTeamId),
      'tossDecision': serializer.toJson<String?>(
        $MatchesTable.$convertertossDecisionn.toJson(tossDecision),
      ),
      'status': serializer.toJson<String>(
        $MatchesTable.$converterstatus.toJson(status),
      ),
      'resultJson': serializer.toJson<String?>(resultJson),
      'tournamentId': serializer.toJson<String?>(tournamentId),
      'eventCursor': serializer.toJson<int>(eventCursor),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MatchRow copyWith({
    String? id,
    Value<String?> title = const Value.absent(),
    String? format,
    String? rulesJson,
    String? teamAId,
    String? teamBId,
    Value<String?> venue = const Value.absent(),
    DateTime? dateLocal,
    MatchType? matchType,
    Value<String?> jokerPlayerId = const Value.absent(),
    Value<String?> tossWinnerTeamId = const Value.absent(),
    Value<TossDecision?> tossDecision = const Value.absent(),
    MatchStatus? status,
    Value<String?> resultJson = const Value.absent(),
    Value<String?> tournamentId = const Value.absent(),
    int? eventCursor,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MatchRow(
    id: id ?? this.id,
    title: title.present ? title.value : this.title,
    format: format ?? this.format,
    rulesJson: rulesJson ?? this.rulesJson,
    teamAId: teamAId ?? this.teamAId,
    teamBId: teamBId ?? this.teamBId,
    venue: venue.present ? venue.value : this.venue,
    dateLocal: dateLocal ?? this.dateLocal,
    matchType: matchType ?? this.matchType,
    jokerPlayerId: jokerPlayerId.present
        ? jokerPlayerId.value
        : this.jokerPlayerId,
    tossWinnerTeamId: tossWinnerTeamId.present
        ? tossWinnerTeamId.value
        : this.tossWinnerTeamId,
    tossDecision: tossDecision.present ? tossDecision.value : this.tossDecision,
    status: status ?? this.status,
    resultJson: resultJson.present ? resultJson.value : this.resultJson,
    tournamentId: tournamentId.present ? tournamentId.value : this.tournamentId,
    eventCursor: eventCursor ?? this.eventCursor,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MatchRow copyWithCompanion(MatchesCompanion data) {
    return MatchRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      format: data.format.present ? data.format.value : this.format,
      rulesJson: data.rulesJson.present ? data.rulesJson.value : this.rulesJson,
      teamAId: data.teamAId.present ? data.teamAId.value : this.teamAId,
      teamBId: data.teamBId.present ? data.teamBId.value : this.teamBId,
      venue: data.venue.present ? data.venue.value : this.venue,
      dateLocal: data.dateLocal.present ? data.dateLocal.value : this.dateLocal,
      matchType: data.matchType.present ? data.matchType.value : this.matchType,
      jokerPlayerId: data.jokerPlayerId.present
          ? data.jokerPlayerId.value
          : this.jokerPlayerId,
      tossWinnerTeamId: data.tossWinnerTeamId.present
          ? data.tossWinnerTeamId.value
          : this.tossWinnerTeamId,
      tossDecision: data.tossDecision.present
          ? data.tossDecision.value
          : this.tossDecision,
      status: data.status.present ? data.status.value : this.status,
      resultJson: data.resultJson.present
          ? data.resultJson.value
          : this.resultJson,
      tournamentId: data.tournamentId.present
          ? data.tournamentId.value
          : this.tournamentId,
      eventCursor: data.eventCursor.present
          ? data.eventCursor.value
          : this.eventCursor,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('format: $format, ')
          ..write('rulesJson: $rulesJson, ')
          ..write('teamAId: $teamAId, ')
          ..write('teamBId: $teamBId, ')
          ..write('venue: $venue, ')
          ..write('dateLocal: $dateLocal, ')
          ..write('matchType: $matchType, ')
          ..write('jokerPlayerId: $jokerPlayerId, ')
          ..write('tossWinnerTeamId: $tossWinnerTeamId, ')
          ..write('tossDecision: $tossDecision, ')
          ..write('status: $status, ')
          ..write('resultJson: $resultJson, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('eventCursor: $eventCursor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    format,
    rulesJson,
    teamAId,
    teamBId,
    venue,
    dateLocal,
    matchType,
    jokerPlayerId,
    tossWinnerTeamId,
    tossDecision,
    status,
    resultJson,
    tournamentId,
    eventCursor,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.format == this.format &&
          other.rulesJson == this.rulesJson &&
          other.teamAId == this.teamAId &&
          other.teamBId == this.teamBId &&
          other.venue == this.venue &&
          other.dateLocal == this.dateLocal &&
          other.matchType == this.matchType &&
          other.jokerPlayerId == this.jokerPlayerId &&
          other.tossWinnerTeamId == this.tossWinnerTeamId &&
          other.tossDecision == this.tossDecision &&
          other.status == this.status &&
          other.resultJson == this.resultJson &&
          other.tournamentId == this.tournamentId &&
          other.eventCursor == this.eventCursor &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MatchesCompanion extends UpdateCompanion<MatchRow> {
  final Value<String> id;
  final Value<String?> title;
  final Value<String> format;
  final Value<String> rulesJson;
  final Value<String> teamAId;
  final Value<String> teamBId;
  final Value<String?> venue;
  final Value<DateTime> dateLocal;
  final Value<MatchType> matchType;
  final Value<String?> jokerPlayerId;
  final Value<String?> tossWinnerTeamId;
  final Value<TossDecision?> tossDecision;
  final Value<MatchStatus> status;
  final Value<String?> resultJson;
  final Value<String?> tournamentId;
  final Value<int> eventCursor;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MatchesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.format = const Value.absent(),
    this.rulesJson = const Value.absent(),
    this.teamAId = const Value.absent(),
    this.teamBId = const Value.absent(),
    this.venue = const Value.absent(),
    this.dateLocal = const Value.absent(),
    this.matchType = const Value.absent(),
    this.jokerPlayerId = const Value.absent(),
    this.tossWinnerTeamId = const Value.absent(),
    this.tossDecision = const Value.absent(),
    this.status = const Value.absent(),
    this.resultJson = const Value.absent(),
    this.tournamentId = const Value.absent(),
    this.eventCursor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MatchesCompanion.insert({
    required String id,
    this.title = const Value.absent(),
    required String format,
    required String rulesJson,
    required String teamAId,
    required String teamBId,
    this.venue = const Value.absent(),
    required DateTime dateLocal,
    this.matchType = const Value.absent(),
    this.jokerPlayerId = const Value.absent(),
    this.tossWinnerTeamId = const Value.absent(),
    this.tossDecision = const Value.absent(),
    this.status = const Value.absent(),
    this.resultJson = const Value.absent(),
    this.tournamentId = const Value.absent(),
    this.eventCursor = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       format = Value(format),
       rulesJson = Value(rulesJson),
       teamAId = Value(teamAId),
       teamBId = Value(teamBId),
       dateLocal = Value(dateLocal),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MatchRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? format,
    Expression<String>? rulesJson,
    Expression<String>? teamAId,
    Expression<String>? teamBId,
    Expression<String>? venue,
    Expression<DateTime>? dateLocal,
    Expression<String>? matchType,
    Expression<String>? jokerPlayerId,
    Expression<String>? tossWinnerTeamId,
    Expression<String>? tossDecision,
    Expression<String>? status,
    Expression<String>? resultJson,
    Expression<String>? tournamentId,
    Expression<int>? eventCursor,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (format != null) 'format': format,
      if (rulesJson != null) 'rules_json': rulesJson,
      if (teamAId != null) 'team_a_id': teamAId,
      if (teamBId != null) 'team_b_id': teamBId,
      if (venue != null) 'venue': venue,
      if (dateLocal != null) 'date_local': dateLocal,
      if (matchType != null) 'match_type': matchType,
      if (jokerPlayerId != null) 'joker_player_id': jokerPlayerId,
      if (tossWinnerTeamId != null) 'toss_winner_team_id': tossWinnerTeamId,
      if (tossDecision != null) 'toss_decision': tossDecision,
      if (status != null) 'status': status,
      if (resultJson != null) 'result_json': resultJson,
      if (tournamentId != null) 'tournament_id': tournamentId,
      if (eventCursor != null) 'event_cursor': eventCursor,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MatchesCompanion copyWith({
    Value<String>? id,
    Value<String?>? title,
    Value<String>? format,
    Value<String>? rulesJson,
    Value<String>? teamAId,
    Value<String>? teamBId,
    Value<String?>? venue,
    Value<DateTime>? dateLocal,
    Value<MatchType>? matchType,
    Value<String?>? jokerPlayerId,
    Value<String?>? tossWinnerTeamId,
    Value<TossDecision?>? tossDecision,
    Value<MatchStatus>? status,
    Value<String?>? resultJson,
    Value<String?>? tournamentId,
    Value<int>? eventCursor,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MatchesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      format: format ?? this.format,
      rulesJson: rulesJson ?? this.rulesJson,
      teamAId: teamAId ?? this.teamAId,
      teamBId: teamBId ?? this.teamBId,
      venue: venue ?? this.venue,
      dateLocal: dateLocal ?? this.dateLocal,
      matchType: matchType ?? this.matchType,
      jokerPlayerId: jokerPlayerId ?? this.jokerPlayerId,
      tossWinnerTeamId: tossWinnerTeamId ?? this.tossWinnerTeamId,
      tossDecision: tossDecision ?? this.tossDecision,
      status: status ?? this.status,
      resultJson: resultJson ?? this.resultJson,
      tournamentId: tournamentId ?? this.tournamentId,
      eventCursor: eventCursor ?? this.eventCursor,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (rulesJson.present) {
      map['rules_json'] = Variable<String>(rulesJson.value);
    }
    if (teamAId.present) {
      map['team_a_id'] = Variable<String>(teamAId.value);
    }
    if (teamBId.present) {
      map['team_b_id'] = Variable<String>(teamBId.value);
    }
    if (venue.present) {
      map['venue'] = Variable<String>(venue.value);
    }
    if (dateLocal.present) {
      map['date_local'] = Variable<DateTime>(dateLocal.value);
    }
    if (matchType.present) {
      map['match_type'] = Variable<String>(
        $MatchesTable.$convertermatchType.toSql(matchType.value),
      );
    }
    if (jokerPlayerId.present) {
      map['joker_player_id'] = Variable<String>(jokerPlayerId.value);
    }
    if (tossWinnerTeamId.present) {
      map['toss_winner_team_id'] = Variable<String>(tossWinnerTeamId.value);
    }
    if (tossDecision.present) {
      map['toss_decision'] = Variable<String>(
        $MatchesTable.$convertertossDecisionn.toSql(tossDecision.value),
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $MatchesTable.$converterstatus.toSql(status.value),
      );
    }
    if (resultJson.present) {
      map['result_json'] = Variable<String>(resultJson.value);
    }
    if (tournamentId.present) {
      map['tournament_id'] = Variable<String>(tournamentId.value);
    }
    if (eventCursor.present) {
      map['event_cursor'] = Variable<int>(eventCursor.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
    return (StringBuffer('MatchesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('format: $format, ')
          ..write('rulesJson: $rulesJson, ')
          ..write('teamAId: $teamAId, ')
          ..write('teamBId: $teamBId, ')
          ..write('venue: $venue, ')
          ..write('dateLocal: $dateLocal, ')
          ..write('matchType: $matchType, ')
          ..write('jokerPlayerId: $jokerPlayerId, ')
          ..write('tossWinnerTeamId: $tossWinnerTeamId, ')
          ..write('tossDecision: $tossDecision, ')
          ..write('status: $status, ')
          ..write('resultJson: $resultJson, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('eventCursor: $eventCursor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MatchPlayersTable extends MatchPlayers
    with TableInfo<$MatchPlayersTable, MatchPlayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchPlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _matchIdMeta = const VerificationMeta(
    'matchId',
  );
  @override
  late final GeneratedColumn<String> matchId = GeneratedColumn<String>(
    'match_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _battingOrderMeta = const VerificationMeta(
    'battingOrder',
  );
  @override
  late final GeneratedColumn<int> battingOrder = GeneratedColumn<int>(
    'batting_order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCaptainMeta = const VerificationMeta(
    'isCaptain',
  );
  @override
  late final GeneratedColumn<bool> isCaptain = GeneratedColumn<bool>(
    'is_captain',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_captain" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isKeeperMeta = const VerificationMeta(
    'isKeeper',
  );
  @override
  late final GeneratedColumn<bool> isKeeper = GeneratedColumn<bool>(
    'is_keeper',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_keeper" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    matchId,
    teamId,
    playerId,
    battingOrder,
    isCaptain,
    isKeeper,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'match_players';
  @override
  VerificationContext validateIntegrity(
    Insertable<MatchPlayer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('match_id')) {
      context.handle(
        _matchIdMeta,
        matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('batting_order')) {
      context.handle(
        _battingOrderMeta,
        battingOrder.isAcceptableOrUnknown(
          data['batting_order']!,
          _battingOrderMeta,
        ),
      );
    }
    if (data.containsKey('is_captain')) {
      context.handle(
        _isCaptainMeta,
        isCaptain.isAcceptableOrUnknown(data['is_captain']!, _isCaptainMeta),
      );
    }
    if (data.containsKey('is_keeper')) {
      context.handle(
        _isKeeperMeta,
        isKeeper.isAcceptableOrUnknown(data['is_keeper']!, _isKeeperMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {matchId, playerId};
  @override
  MatchPlayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchPlayer(
      matchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_id'],
      )!,
      battingOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}batting_order'],
      ),
      isCaptain: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_captain'],
      )!,
      isKeeper: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_keeper'],
      )!,
    );
  }

  @override
  $MatchPlayersTable createAlias(String alias) {
    return $MatchPlayersTable(attachedDatabase, alias);
  }
}

class MatchPlayer extends DataClass implements Insertable<MatchPlayer> {
  final String matchId;
  final String teamId;
  final String playerId;
  final int? battingOrder;
  final bool isCaptain;
  final bool isKeeper;
  const MatchPlayer({
    required this.matchId,
    required this.teamId,
    required this.playerId,
    this.battingOrder,
    required this.isCaptain,
    required this.isKeeper,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['match_id'] = Variable<String>(matchId);
    map['team_id'] = Variable<String>(teamId);
    map['player_id'] = Variable<String>(playerId);
    if (!nullToAbsent || battingOrder != null) {
      map['batting_order'] = Variable<int>(battingOrder);
    }
    map['is_captain'] = Variable<bool>(isCaptain);
    map['is_keeper'] = Variable<bool>(isKeeper);
    return map;
  }

  MatchPlayersCompanion toCompanion(bool nullToAbsent) {
    return MatchPlayersCompanion(
      matchId: Value(matchId),
      teamId: Value(teamId),
      playerId: Value(playerId),
      battingOrder: battingOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(battingOrder),
      isCaptain: Value(isCaptain),
      isKeeper: Value(isKeeper),
    );
  }

  factory MatchPlayer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchPlayer(
      matchId: serializer.fromJson<String>(json['matchId']),
      teamId: serializer.fromJson<String>(json['teamId']),
      playerId: serializer.fromJson<String>(json['playerId']),
      battingOrder: serializer.fromJson<int?>(json['battingOrder']),
      isCaptain: serializer.fromJson<bool>(json['isCaptain']),
      isKeeper: serializer.fromJson<bool>(json['isKeeper']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'matchId': serializer.toJson<String>(matchId),
      'teamId': serializer.toJson<String>(teamId),
      'playerId': serializer.toJson<String>(playerId),
      'battingOrder': serializer.toJson<int?>(battingOrder),
      'isCaptain': serializer.toJson<bool>(isCaptain),
      'isKeeper': serializer.toJson<bool>(isKeeper),
    };
  }

  MatchPlayer copyWith({
    String? matchId,
    String? teamId,
    String? playerId,
    Value<int?> battingOrder = const Value.absent(),
    bool? isCaptain,
    bool? isKeeper,
  }) => MatchPlayer(
    matchId: matchId ?? this.matchId,
    teamId: teamId ?? this.teamId,
    playerId: playerId ?? this.playerId,
    battingOrder: battingOrder.present ? battingOrder.value : this.battingOrder,
    isCaptain: isCaptain ?? this.isCaptain,
    isKeeper: isKeeper ?? this.isKeeper,
  );
  MatchPlayer copyWithCompanion(MatchPlayersCompanion data) {
    return MatchPlayer(
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      battingOrder: data.battingOrder.present
          ? data.battingOrder.value
          : this.battingOrder,
      isCaptain: data.isCaptain.present ? data.isCaptain.value : this.isCaptain,
      isKeeper: data.isKeeper.present ? data.isKeeper.value : this.isKeeper,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchPlayer(')
          ..write('matchId: $matchId, ')
          ..write('teamId: $teamId, ')
          ..write('playerId: $playerId, ')
          ..write('battingOrder: $battingOrder, ')
          ..write('isCaptain: $isCaptain, ')
          ..write('isKeeper: $isKeeper')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(matchId, teamId, playerId, battingOrder, isCaptain, isKeeper);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchPlayer &&
          other.matchId == this.matchId &&
          other.teamId == this.teamId &&
          other.playerId == this.playerId &&
          other.battingOrder == this.battingOrder &&
          other.isCaptain == this.isCaptain &&
          other.isKeeper == this.isKeeper);
}

class MatchPlayersCompanion extends UpdateCompanion<MatchPlayer> {
  final Value<String> matchId;
  final Value<String> teamId;
  final Value<String> playerId;
  final Value<int?> battingOrder;
  final Value<bool> isCaptain;
  final Value<bool> isKeeper;
  final Value<int> rowid;
  const MatchPlayersCompanion({
    this.matchId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.battingOrder = const Value.absent(),
    this.isCaptain = const Value.absent(),
    this.isKeeper = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MatchPlayersCompanion.insert({
    required String matchId,
    required String teamId,
    required String playerId,
    this.battingOrder = const Value.absent(),
    this.isCaptain = const Value.absent(),
    this.isKeeper = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : matchId = Value(matchId),
       teamId = Value(teamId),
       playerId = Value(playerId);
  static Insertable<MatchPlayer> custom({
    Expression<String>? matchId,
    Expression<String>? teamId,
    Expression<String>? playerId,
    Expression<int>? battingOrder,
    Expression<bool>? isCaptain,
    Expression<bool>? isKeeper,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (matchId != null) 'match_id': matchId,
      if (teamId != null) 'team_id': teamId,
      if (playerId != null) 'player_id': playerId,
      if (battingOrder != null) 'batting_order': battingOrder,
      if (isCaptain != null) 'is_captain': isCaptain,
      if (isKeeper != null) 'is_keeper': isKeeper,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MatchPlayersCompanion copyWith({
    Value<String>? matchId,
    Value<String>? teamId,
    Value<String>? playerId,
    Value<int?>? battingOrder,
    Value<bool>? isCaptain,
    Value<bool>? isKeeper,
    Value<int>? rowid,
  }) {
    return MatchPlayersCompanion(
      matchId: matchId ?? this.matchId,
      teamId: teamId ?? this.teamId,
      playerId: playerId ?? this.playerId,
      battingOrder: battingOrder ?? this.battingOrder,
      isCaptain: isCaptain ?? this.isCaptain,
      isKeeper: isKeeper ?? this.isKeeper,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (matchId.present) {
      map['match_id'] = Variable<String>(matchId.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (battingOrder.present) {
      map['batting_order'] = Variable<int>(battingOrder.value);
    }
    if (isCaptain.present) {
      map['is_captain'] = Variable<bool>(isCaptain.value);
    }
    if (isKeeper.present) {
      map['is_keeper'] = Variable<bool>(isKeeper.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchPlayersCompanion(')
          ..write('matchId: $matchId, ')
          ..write('teamId: $teamId, ')
          ..write('playerId: $playerId, ')
          ..write('battingOrder: $battingOrder, ')
          ..write('isCaptain: $isCaptain, ')
          ..write('isKeeper: $isKeeper, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _matchIdMeta = const VerificationMeta(
    'matchId',
  );
  @override
  late final GeneratedColumn<String> matchId = GeneratedColumn<String>(
    'match_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seqMeta = const VerificationMeta('seq');
  @override
  late final GeneratedColumn<int> seq = GeneratedColumn<int>(
    'seq',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    matchId,
    seq,
    type,
    payloadJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(
    Insertable<Event> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('match_id')) {
      context.handle(
        _matchIdMeta,
        matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('seq')) {
      context.handle(
        _seqMeta,
        seq.isAcceptableOrUnknown(data['seq']!, _seqMeta),
      );
    } else if (isInserting) {
      context.missing(_seqMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
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
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      matchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_id'],
      )!,
      seq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seq'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final int id;
  final String matchId;

  /// Per-match ordering (1-based).
  final int seq;

  /// Event kind: matchCreated / inningsStarted / ball / penalty /
  /// batterReplaced / endInnings / superOverStart ...
  final String type;

  /// Full serialised event (e.g. a [BallEvent]).
  final String payloadJson;
  final DateTime createdAt;
  const Event({
    required this.id,
    required this.matchId,
    required this.seq,
    required this.type,
    required this.payloadJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['match_id'] = Variable<String>(matchId);
    map['seq'] = Variable<int>(seq);
    map['type'] = Variable<String>(type);
    map['payload_json'] = Variable<String>(payloadJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      matchId: Value(matchId),
      seq: Value(seq),
      type: Value(type),
      payloadJson: Value(payloadJson),
      createdAt: Value(createdAt),
    );
  }

  factory Event.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      matchId: serializer.fromJson<String>(json['matchId']),
      seq: serializer.fromJson<int>(json['seq']),
      type: serializer.fromJson<String>(json['type']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matchId': serializer.toJson<String>(matchId),
      'seq': serializer.toJson<int>(seq),
      'type': serializer.toJson<String>(type),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Event copyWith({
    int? id,
    String? matchId,
    int? seq,
    String? type,
    String? payloadJson,
    DateTime? createdAt,
  }) => Event(
    id: id ?? this.id,
    matchId: matchId ?? this.matchId,
    seq: seq ?? this.seq,
    type: type ?? this.type,
    payloadJson: payloadJson ?? this.payloadJson,
    createdAt: createdAt ?? this.createdAt,
  );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      seq: data.seq.present ? data.seq.value : this.seq,
      type: data.type.present ? data.type.value : this.type,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('seq: $seq, ')
          ..write('type: $type, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, matchId, seq, type, payloadJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.matchId == this.matchId &&
          other.seq == this.seq &&
          other.type == this.type &&
          other.payloadJson == this.payloadJson &&
          other.createdAt == this.createdAt);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String> matchId;
  final Value<int> seq;
  final Value<String> type;
  final Value<String> payloadJson;
  final Value<DateTime> createdAt;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.matchId = const Value.absent(),
    this.seq = const Value.absent(),
    this.type = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required String matchId,
    required int seq,
    required String type,
    required String payloadJson,
    required DateTime createdAt,
  }) : matchId = Value(matchId),
       seq = Value(seq),
       type = Value(type),
       payloadJson = Value(payloadJson),
       createdAt = Value(createdAt);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<String>? matchId,
    Expression<int>? seq,
    Expression<String>? type,
    Expression<String>? payloadJson,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchId != null) 'match_id': matchId,
      if (seq != null) 'seq': seq,
      if (type != null) 'type': type,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  EventsCompanion copyWith({
    Value<int>? id,
    Value<String>? matchId,
    Value<int>? seq,
    Value<String>? type,
    Value<String>? payloadJson,
    Value<DateTime>? createdAt,
  }) {
    return EventsCompanion(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      seq: seq ?? this.seq,
      type: type ?? this.type,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (matchId.present) {
      map['match_id'] = Variable<String>(matchId.value);
    }
    if (seq.present) {
      map['seq'] = Variable<int>(seq.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('seq: $seq, ')
          ..write('type: $type, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TournamentsTable extends Tournaments
    with TableInfo<$TournamentsTable, Tournament> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TournamentsTable(this.attachedDatabase, [this._alias]);
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
  @override
  late final GeneratedColumnWithTypeConverter<TournamentFormat, String> format =
      GeneratedColumn<String>(
        'format',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('roundRobin'),
      ).withConverter<TournamentFormat>($TournamentsTable.$converterformat);
  static const VerificationMeta _rulesJsonMeta = const VerificationMeta(
    'rulesJson',
  );
  @override
  late final GeneratedColumn<String> rulesJson = GeneratedColumn<String>(
    'rules_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pointsWinMeta = const VerificationMeta(
    'pointsWin',
  );
  @override
  late final GeneratedColumn<int> pointsWin = GeneratedColumn<int>(
    'points_win',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _pointsTieMeta = const VerificationMeta(
    'pointsTie',
  );
  @override
  late final GeneratedColumn<int> pointsTie = GeneratedColumn<int>(
    'points_tie',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _pointsNoResultMeta = const VerificationMeta(
    'pointsNoResult',
  );
  @override
  late final GeneratedColumn<int> pointsNoResult = GeneratedColumn<int>(
    'points_no_result',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _pointsLossMeta = const VerificationMeta(
    'pointsLoss',
  );
  @override
  late final GeneratedColumn<int> pointsLoss = GeneratedColumn<int>(
    'points_loss',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _tieBreakOrderJsonMeta = const VerificationMeta(
    'tieBreakOrderJson',
  );
  @override
  late final GeneratedColumn<String> tieBreakOrderJson =
      GeneratedColumn<String>(
        'tie_break_order_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('["nrr","headToHead"]'),
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    format,
    rulesJson,
    startDate,
    endDate,
    pointsWin,
    pointsTie,
    pointsNoResult,
    pointsLoss,
    tieBreakOrderJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tournaments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tournament> instance, {
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
    if (data.containsKey('rules_json')) {
      context.handle(
        _rulesJsonMeta,
        rulesJson.isAcceptableOrUnknown(data['rules_json']!, _rulesJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_rulesJsonMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('points_win')) {
      context.handle(
        _pointsWinMeta,
        pointsWin.isAcceptableOrUnknown(data['points_win']!, _pointsWinMeta),
      );
    }
    if (data.containsKey('points_tie')) {
      context.handle(
        _pointsTieMeta,
        pointsTie.isAcceptableOrUnknown(data['points_tie']!, _pointsTieMeta),
      );
    }
    if (data.containsKey('points_no_result')) {
      context.handle(
        _pointsNoResultMeta,
        pointsNoResult.isAcceptableOrUnknown(
          data['points_no_result']!,
          _pointsNoResultMeta,
        ),
      );
    }
    if (data.containsKey('points_loss')) {
      context.handle(
        _pointsLossMeta,
        pointsLoss.isAcceptableOrUnknown(data['points_loss']!, _pointsLossMeta),
      );
    }
    if (data.containsKey('tie_break_order_json')) {
      context.handle(
        _tieBreakOrderJsonMeta,
        tieBreakOrderJson.isAcceptableOrUnknown(
          data['tie_break_order_json']!,
          _tieBreakOrderJsonMeta,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tournament map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tournament(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      format: $TournamentsTable.$converterformat.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}format'],
        )!,
      ),
      rulesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rules_json'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      ),
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      pointsWin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points_win'],
      )!,
      pointsTie: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points_tie'],
      )!,
      pointsNoResult: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points_no_result'],
      )!,
      pointsLoss: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points_loss'],
      )!,
      tieBreakOrderJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tie_break_order_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TournamentsTable createAlias(String alias) {
    return $TournamentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TournamentFormat, String, String> $converterformat =
      const EnumNameConverter<TournamentFormat>(TournamentFormat.values);
}

class Tournament extends DataClass implements Insertable<Tournament> {
  final String id;
  final String name;

  /// Fixture structure: league / roundRobin / knockout.
  final TournamentFormat format;
  final String rulesJson;
  final DateTime? startDate;
  final DateTime? endDate;
  final int pointsWin;
  final int pointsTie;
  final int pointsNoResult;
  final int pointsLoss;

  /// JSON array of tie-break keys, e.g. ["nrr","headToHead"].
  final String tieBreakOrderJson;
  final DateTime createdAt;
  const Tournament({
    required this.id,
    required this.name,
    required this.format,
    required this.rulesJson,
    this.startDate,
    this.endDate,
    required this.pointsWin,
    required this.pointsTie,
    required this.pointsNoResult,
    required this.pointsLoss,
    required this.tieBreakOrderJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    {
      map['format'] = Variable<String>(
        $TournamentsTable.$converterformat.toSql(format),
      );
    }
    map['rules_json'] = Variable<String>(rulesJson);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['points_win'] = Variable<int>(pointsWin);
    map['points_tie'] = Variable<int>(pointsTie);
    map['points_no_result'] = Variable<int>(pointsNoResult);
    map['points_loss'] = Variable<int>(pointsLoss);
    map['tie_break_order_json'] = Variable<String>(tieBreakOrderJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TournamentsCompanion toCompanion(bool nullToAbsent) {
    return TournamentsCompanion(
      id: Value(id),
      name: Value(name),
      format: Value(format),
      rulesJson: Value(rulesJson),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      pointsWin: Value(pointsWin),
      pointsTie: Value(pointsTie),
      pointsNoResult: Value(pointsNoResult),
      pointsLoss: Value(pointsLoss),
      tieBreakOrderJson: Value(tieBreakOrderJson),
      createdAt: Value(createdAt),
    );
  }

  factory Tournament.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tournament(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      format: $TournamentsTable.$converterformat.fromJson(
        serializer.fromJson<String>(json['format']),
      ),
      rulesJson: serializer.fromJson<String>(json['rulesJson']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      pointsWin: serializer.fromJson<int>(json['pointsWin']),
      pointsTie: serializer.fromJson<int>(json['pointsTie']),
      pointsNoResult: serializer.fromJson<int>(json['pointsNoResult']),
      pointsLoss: serializer.fromJson<int>(json['pointsLoss']),
      tieBreakOrderJson: serializer.fromJson<String>(json['tieBreakOrderJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'format': serializer.toJson<String>(
        $TournamentsTable.$converterformat.toJson(format),
      ),
      'rulesJson': serializer.toJson<String>(rulesJson),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'pointsWin': serializer.toJson<int>(pointsWin),
      'pointsTie': serializer.toJson<int>(pointsTie),
      'pointsNoResult': serializer.toJson<int>(pointsNoResult),
      'pointsLoss': serializer.toJson<int>(pointsLoss),
      'tieBreakOrderJson': serializer.toJson<String>(tieBreakOrderJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Tournament copyWith({
    String? id,
    String? name,
    TournamentFormat? format,
    String? rulesJson,
    Value<DateTime?> startDate = const Value.absent(),
    Value<DateTime?> endDate = const Value.absent(),
    int? pointsWin,
    int? pointsTie,
    int? pointsNoResult,
    int? pointsLoss,
    String? tieBreakOrderJson,
    DateTime? createdAt,
  }) => Tournament(
    id: id ?? this.id,
    name: name ?? this.name,
    format: format ?? this.format,
    rulesJson: rulesJson ?? this.rulesJson,
    startDate: startDate.present ? startDate.value : this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    pointsWin: pointsWin ?? this.pointsWin,
    pointsTie: pointsTie ?? this.pointsTie,
    pointsNoResult: pointsNoResult ?? this.pointsNoResult,
    pointsLoss: pointsLoss ?? this.pointsLoss,
    tieBreakOrderJson: tieBreakOrderJson ?? this.tieBreakOrderJson,
    createdAt: createdAt ?? this.createdAt,
  );
  Tournament copyWithCompanion(TournamentsCompanion data) {
    return Tournament(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      format: data.format.present ? data.format.value : this.format,
      rulesJson: data.rulesJson.present ? data.rulesJson.value : this.rulesJson,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      pointsWin: data.pointsWin.present ? data.pointsWin.value : this.pointsWin,
      pointsTie: data.pointsTie.present ? data.pointsTie.value : this.pointsTie,
      pointsNoResult: data.pointsNoResult.present
          ? data.pointsNoResult.value
          : this.pointsNoResult,
      pointsLoss: data.pointsLoss.present
          ? data.pointsLoss.value
          : this.pointsLoss,
      tieBreakOrderJson: data.tieBreakOrderJson.present
          ? data.tieBreakOrderJson.value
          : this.tieBreakOrderJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tournament(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('format: $format, ')
          ..write('rulesJson: $rulesJson, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('pointsWin: $pointsWin, ')
          ..write('pointsTie: $pointsTie, ')
          ..write('pointsNoResult: $pointsNoResult, ')
          ..write('pointsLoss: $pointsLoss, ')
          ..write('tieBreakOrderJson: $tieBreakOrderJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    format,
    rulesJson,
    startDate,
    endDate,
    pointsWin,
    pointsTie,
    pointsNoResult,
    pointsLoss,
    tieBreakOrderJson,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tournament &&
          other.id == this.id &&
          other.name == this.name &&
          other.format == this.format &&
          other.rulesJson == this.rulesJson &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.pointsWin == this.pointsWin &&
          other.pointsTie == this.pointsTie &&
          other.pointsNoResult == this.pointsNoResult &&
          other.pointsLoss == this.pointsLoss &&
          other.tieBreakOrderJson == this.tieBreakOrderJson &&
          other.createdAt == this.createdAt);
}

class TournamentsCompanion extends UpdateCompanion<Tournament> {
  final Value<String> id;
  final Value<String> name;
  final Value<TournamentFormat> format;
  final Value<String> rulesJson;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<int> pointsWin;
  final Value<int> pointsTie;
  final Value<int> pointsNoResult;
  final Value<int> pointsLoss;
  final Value<String> tieBreakOrderJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TournamentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.format = const Value.absent(),
    this.rulesJson = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.pointsWin = const Value.absent(),
    this.pointsTie = const Value.absent(),
    this.pointsNoResult = const Value.absent(),
    this.pointsLoss = const Value.absent(),
    this.tieBreakOrderJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TournamentsCompanion.insert({
    required String id,
    required String name,
    this.format = const Value.absent(),
    required String rulesJson,
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.pointsWin = const Value.absent(),
    this.pointsTie = const Value.absent(),
    this.pointsNoResult = const Value.absent(),
    this.pointsLoss = const Value.absent(),
    this.tieBreakOrderJson = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       rulesJson = Value(rulesJson),
       createdAt = Value(createdAt);
  static Insertable<Tournament> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? format,
    Expression<String>? rulesJson,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? pointsWin,
    Expression<int>? pointsTie,
    Expression<int>? pointsNoResult,
    Expression<int>? pointsLoss,
    Expression<String>? tieBreakOrderJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (format != null) 'format': format,
      if (rulesJson != null) 'rules_json': rulesJson,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (pointsWin != null) 'points_win': pointsWin,
      if (pointsTie != null) 'points_tie': pointsTie,
      if (pointsNoResult != null) 'points_no_result': pointsNoResult,
      if (pointsLoss != null) 'points_loss': pointsLoss,
      if (tieBreakOrderJson != null) 'tie_break_order_json': tieBreakOrderJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TournamentsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<TournamentFormat>? format,
    Value<String>? rulesJson,
    Value<DateTime?>? startDate,
    Value<DateTime?>? endDate,
    Value<int>? pointsWin,
    Value<int>? pointsTie,
    Value<int>? pointsNoResult,
    Value<int>? pointsLoss,
    Value<String>? tieBreakOrderJson,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TournamentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      format: format ?? this.format,
      rulesJson: rulesJson ?? this.rulesJson,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      pointsWin: pointsWin ?? this.pointsWin,
      pointsTie: pointsTie ?? this.pointsTie,
      pointsNoResult: pointsNoResult ?? this.pointsNoResult,
      pointsLoss: pointsLoss ?? this.pointsLoss,
      tieBreakOrderJson: tieBreakOrderJson ?? this.tieBreakOrderJson,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(
        $TournamentsTable.$converterformat.toSql(format.value),
      );
    }
    if (rulesJson.present) {
      map['rules_json'] = Variable<String>(rulesJson.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (pointsWin.present) {
      map['points_win'] = Variable<int>(pointsWin.value);
    }
    if (pointsTie.present) {
      map['points_tie'] = Variable<int>(pointsTie.value);
    }
    if (pointsNoResult.present) {
      map['points_no_result'] = Variable<int>(pointsNoResult.value);
    }
    if (pointsLoss.present) {
      map['points_loss'] = Variable<int>(pointsLoss.value);
    }
    if (tieBreakOrderJson.present) {
      map['tie_break_order_json'] = Variable<String>(tieBreakOrderJson.value);
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
    return (StringBuffer('TournamentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('format: $format, ')
          ..write('rulesJson: $rulesJson, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('pointsWin: $pointsWin, ')
          ..write('pointsTie: $pointsTie, ')
          ..write('pointsNoResult: $pointsNoResult, ')
          ..write('pointsLoss: $pointsLoss, ')
          ..write('tieBreakOrderJson: $tieBreakOrderJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TournamentTeamsTable extends TournamentTeams
    with TableInfo<$TournamentTeamsTable, TournamentTeam> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TournamentTeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tournamentIdMeta = const VerificationMeta(
    'tournamentId',
  );
  @override
  late final GeneratedColumn<String> tournamentId = GeneratedColumn<String>(
    'tournament_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [tournamentId, teamId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tournament_teams';
  @override
  VerificationContext validateIntegrity(
    Insertable<TournamentTeam> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tournament_id')) {
      context.handle(
        _tournamentIdMeta,
        tournamentId.isAcceptableOrUnknown(
          data['tournament_id']!,
          _tournamentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tournamentIdMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tournamentId, teamId};
  @override
  TournamentTeam map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TournamentTeam(
      tournamentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tournament_id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
    );
  }

  @override
  $TournamentTeamsTable createAlias(String alias) {
    return $TournamentTeamsTable(attachedDatabase, alias);
  }
}

class TournamentTeam extends DataClass implements Insertable<TournamentTeam> {
  final String tournamentId;
  final String teamId;
  const TournamentTeam({required this.tournamentId, required this.teamId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tournament_id'] = Variable<String>(tournamentId);
    map['team_id'] = Variable<String>(teamId);
    return map;
  }

  TournamentTeamsCompanion toCompanion(bool nullToAbsent) {
    return TournamentTeamsCompanion(
      tournamentId: Value(tournamentId),
      teamId: Value(teamId),
    );
  }

  factory TournamentTeam.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TournamentTeam(
      tournamentId: serializer.fromJson<String>(json['tournamentId']),
      teamId: serializer.fromJson<String>(json['teamId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tournamentId': serializer.toJson<String>(tournamentId),
      'teamId': serializer.toJson<String>(teamId),
    };
  }

  TournamentTeam copyWith({String? tournamentId, String? teamId}) =>
      TournamentTeam(
        tournamentId: tournamentId ?? this.tournamentId,
        teamId: teamId ?? this.teamId,
      );
  TournamentTeam copyWithCompanion(TournamentTeamsCompanion data) {
    return TournamentTeam(
      tournamentId: data.tournamentId.present
          ? data.tournamentId.value
          : this.tournamentId,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TournamentTeam(')
          ..write('tournamentId: $tournamentId, ')
          ..write('teamId: $teamId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(tournamentId, teamId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TournamentTeam &&
          other.tournamentId == this.tournamentId &&
          other.teamId == this.teamId);
}

class TournamentTeamsCompanion extends UpdateCompanion<TournamentTeam> {
  final Value<String> tournamentId;
  final Value<String> teamId;
  final Value<int> rowid;
  const TournamentTeamsCompanion({
    this.tournamentId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TournamentTeamsCompanion.insert({
    required String tournamentId,
    required String teamId,
    this.rowid = const Value.absent(),
  }) : tournamentId = Value(tournamentId),
       teamId = Value(teamId);
  static Insertable<TournamentTeam> custom({
    Expression<String>? tournamentId,
    Expression<String>? teamId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tournamentId != null) 'tournament_id': tournamentId,
      if (teamId != null) 'team_id': teamId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TournamentTeamsCompanion copyWith({
    Value<String>? tournamentId,
    Value<String>? teamId,
    Value<int>? rowid,
  }) {
    return TournamentTeamsCompanion(
      tournamentId: tournamentId ?? this.tournamentId,
      teamId: teamId ?? this.teamId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tournamentId.present) {
      map['tournament_id'] = Variable<String>(tournamentId.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TournamentTeamsCompanion(')
          ..write('tournamentId: $tournamentId, ')
          ..write('teamId: $teamId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FixturesTable extends Fixtures with TableInfo<$FixturesTable, Fixture> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FixturesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tournamentIdMeta = const VerificationMeta(
    'tournamentId',
  );
  @override
  late final GeneratedColumn<String> tournamentId = GeneratedColumn<String>(
    'tournament_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roundMeta = const VerificationMeta('round');
  @override
  late final GeneratedColumn<int> round = GeneratedColumn<int>(
    'round',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _teamAIdMeta = const VerificationMeta(
    'teamAId',
  );
  @override
  late final GeneratedColumn<String> teamAId = GeneratedColumn<String>(
    'team_a_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamBIdMeta = const VerificationMeta(
    'teamBId',
  );
  @override
  late final GeneratedColumn<String> teamBId = GeneratedColumn<String>(
    'team_b_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledDateMeta = const VerificationMeta(
    'scheduledDate',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledDate =
      GeneratedColumn<DateTime>(
        'scheduled_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _matchIdMeta = const VerificationMeta(
    'matchId',
  );
  @override
  late final GeneratedColumn<String> matchId = GeneratedColumn<String>(
    'match_id',
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
    requiredDuringInsert: false,
    defaultValue: const Constant('scheduled'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tournamentId,
    round,
    teamAId,
    teamBId,
    scheduledDate,
    matchId,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fixtures';
  @override
  VerificationContext validateIntegrity(
    Insertable<Fixture> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tournament_id')) {
      context.handle(
        _tournamentIdMeta,
        tournamentId.isAcceptableOrUnknown(
          data['tournament_id']!,
          _tournamentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tournamentIdMeta);
    }
    if (data.containsKey('round')) {
      context.handle(
        _roundMeta,
        round.isAcceptableOrUnknown(data['round']!, _roundMeta),
      );
    }
    if (data.containsKey('team_a_id')) {
      context.handle(
        _teamAIdMeta,
        teamAId.isAcceptableOrUnknown(data['team_a_id']!, _teamAIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamAIdMeta);
    }
    if (data.containsKey('team_b_id')) {
      context.handle(
        _teamBIdMeta,
        teamBId.isAcceptableOrUnknown(data['team_b_id']!, _teamBIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamBIdMeta);
    }
    if (data.containsKey('scheduled_date')) {
      context.handle(
        _scheduledDateMeta,
        scheduledDate.isAcceptableOrUnknown(
          data['scheduled_date']!,
          _scheduledDateMeta,
        ),
      );
    }
    if (data.containsKey('match_id')) {
      context.handle(
        _matchIdMeta,
        matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Fixture map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Fixture(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tournamentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tournament_id'],
      )!,
      round: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}round'],
      ),
      teamAId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_a_id'],
      )!,
      teamBId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_b_id'],
      )!,
      scheduledDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_date'],
      ),
      matchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $FixturesTable createAlias(String alias) {
    return $FixturesTable(attachedDatabase, alias);
  }
}

class Fixture extends DataClass implements Insertable<Fixture> {
  final String id;
  final String tournamentId;
  final int? round;
  final String teamAId;
  final String teamBId;
  final DateTime? scheduledDate;
  final String? matchId;
  final String status;
  const Fixture({
    required this.id,
    required this.tournamentId,
    this.round,
    required this.teamAId,
    required this.teamBId,
    this.scheduledDate,
    this.matchId,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tournament_id'] = Variable<String>(tournamentId);
    if (!nullToAbsent || round != null) {
      map['round'] = Variable<int>(round);
    }
    map['team_a_id'] = Variable<String>(teamAId);
    map['team_b_id'] = Variable<String>(teamBId);
    if (!nullToAbsent || scheduledDate != null) {
      map['scheduled_date'] = Variable<DateTime>(scheduledDate);
    }
    if (!nullToAbsent || matchId != null) {
      map['match_id'] = Variable<String>(matchId);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  FixturesCompanion toCompanion(bool nullToAbsent) {
    return FixturesCompanion(
      id: Value(id),
      tournamentId: Value(tournamentId),
      round: round == null && nullToAbsent
          ? const Value.absent()
          : Value(round),
      teamAId: Value(teamAId),
      teamBId: Value(teamBId),
      scheduledDate: scheduledDate == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledDate),
      matchId: matchId == null && nullToAbsent
          ? const Value.absent()
          : Value(matchId),
      status: Value(status),
    );
  }

  factory Fixture.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Fixture(
      id: serializer.fromJson<String>(json['id']),
      tournamentId: serializer.fromJson<String>(json['tournamentId']),
      round: serializer.fromJson<int?>(json['round']),
      teamAId: serializer.fromJson<String>(json['teamAId']),
      teamBId: serializer.fromJson<String>(json['teamBId']),
      scheduledDate: serializer.fromJson<DateTime?>(json['scheduledDate']),
      matchId: serializer.fromJson<String?>(json['matchId']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tournamentId': serializer.toJson<String>(tournamentId),
      'round': serializer.toJson<int?>(round),
      'teamAId': serializer.toJson<String>(teamAId),
      'teamBId': serializer.toJson<String>(teamBId),
      'scheduledDate': serializer.toJson<DateTime?>(scheduledDate),
      'matchId': serializer.toJson<String?>(matchId),
      'status': serializer.toJson<String>(status),
    };
  }

  Fixture copyWith({
    String? id,
    String? tournamentId,
    Value<int?> round = const Value.absent(),
    String? teamAId,
    String? teamBId,
    Value<DateTime?> scheduledDate = const Value.absent(),
    Value<String?> matchId = const Value.absent(),
    String? status,
  }) => Fixture(
    id: id ?? this.id,
    tournamentId: tournamentId ?? this.tournamentId,
    round: round.present ? round.value : this.round,
    teamAId: teamAId ?? this.teamAId,
    teamBId: teamBId ?? this.teamBId,
    scheduledDate: scheduledDate.present
        ? scheduledDate.value
        : this.scheduledDate,
    matchId: matchId.present ? matchId.value : this.matchId,
    status: status ?? this.status,
  );
  Fixture copyWithCompanion(FixturesCompanion data) {
    return Fixture(
      id: data.id.present ? data.id.value : this.id,
      tournamentId: data.tournamentId.present
          ? data.tournamentId.value
          : this.tournamentId,
      round: data.round.present ? data.round.value : this.round,
      teamAId: data.teamAId.present ? data.teamAId.value : this.teamAId,
      teamBId: data.teamBId.present ? data.teamBId.value : this.teamBId,
      scheduledDate: data.scheduledDate.present
          ? data.scheduledDate.value
          : this.scheduledDate,
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Fixture(')
          ..write('id: $id, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('round: $round, ')
          ..write('teamAId: $teamAId, ')
          ..write('teamBId: $teamBId, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('matchId: $matchId, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tournamentId,
    round,
    teamAId,
    teamBId,
    scheduledDate,
    matchId,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Fixture &&
          other.id == this.id &&
          other.tournamentId == this.tournamentId &&
          other.round == this.round &&
          other.teamAId == this.teamAId &&
          other.teamBId == this.teamBId &&
          other.scheduledDate == this.scheduledDate &&
          other.matchId == this.matchId &&
          other.status == this.status);
}

class FixturesCompanion extends UpdateCompanion<Fixture> {
  final Value<String> id;
  final Value<String> tournamentId;
  final Value<int?> round;
  final Value<String> teamAId;
  final Value<String> teamBId;
  final Value<DateTime?> scheduledDate;
  final Value<String?> matchId;
  final Value<String> status;
  final Value<int> rowid;
  const FixturesCompanion({
    this.id = const Value.absent(),
    this.tournamentId = const Value.absent(),
    this.round = const Value.absent(),
    this.teamAId = const Value.absent(),
    this.teamBId = const Value.absent(),
    this.scheduledDate = const Value.absent(),
    this.matchId = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FixturesCompanion.insert({
    required String id,
    required String tournamentId,
    this.round = const Value.absent(),
    required String teamAId,
    required String teamBId,
    this.scheduledDate = const Value.absent(),
    this.matchId = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tournamentId = Value(tournamentId),
       teamAId = Value(teamAId),
       teamBId = Value(teamBId);
  static Insertable<Fixture> custom({
    Expression<String>? id,
    Expression<String>? tournamentId,
    Expression<int>? round,
    Expression<String>? teamAId,
    Expression<String>? teamBId,
    Expression<DateTime>? scheduledDate,
    Expression<String>? matchId,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tournamentId != null) 'tournament_id': tournamentId,
      if (round != null) 'round': round,
      if (teamAId != null) 'team_a_id': teamAId,
      if (teamBId != null) 'team_b_id': teamBId,
      if (scheduledDate != null) 'scheduled_date': scheduledDate,
      if (matchId != null) 'match_id': matchId,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FixturesCompanion copyWith({
    Value<String>? id,
    Value<String>? tournamentId,
    Value<int?>? round,
    Value<String>? teamAId,
    Value<String>? teamBId,
    Value<DateTime?>? scheduledDate,
    Value<String?>? matchId,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return FixturesCompanion(
      id: id ?? this.id,
      tournamentId: tournamentId ?? this.tournamentId,
      round: round ?? this.round,
      teamAId: teamAId ?? this.teamAId,
      teamBId: teamBId ?? this.teamBId,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      matchId: matchId ?? this.matchId,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tournamentId.present) {
      map['tournament_id'] = Variable<String>(tournamentId.value);
    }
    if (round.present) {
      map['round'] = Variable<int>(round.value);
    }
    if (teamAId.present) {
      map['team_a_id'] = Variable<String>(teamAId.value);
    }
    if (teamBId.present) {
      map['team_b_id'] = Variable<String>(teamBId.value);
    }
    if (scheduledDate.present) {
      map['scheduled_date'] = Variable<DateTime>(scheduledDate.value);
    }
    if (matchId.present) {
      map['match_id'] = Variable<String>(matchId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FixturesCompanion(')
          ..write('id: $id, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('round: $round, ')
          ..write('teamAId: $teamAId, ')
          ..write('teamBId: $teamBId, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('matchId: $matchId, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $PlayersTable players = $PlayersTable(this);
  late final $TeamsTable teams = $TeamsTable(this);
  late final $TeamPlayersTable teamPlayers = $TeamPlayersTable(this);
  late final $MatchesTable matches = $MatchesTable(this);
  late final $MatchPlayersTable matchPlayers = $MatchPlayersTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $TournamentsTable tournaments = $TournamentsTable(this);
  late final $TournamentTeamsTable tournamentTeams = $TournamentTeamsTable(
    this,
  );
  late final $FixturesTable fixtures = $FixturesTable(this);
  late final Index idxTeamPlayerPlayer = Index(
    'idx_team_player_player',
    'CREATE INDEX idx_team_player_player ON team_players (player_id)',
  );
  late final Index idxMatchStatus = Index(
    'idx_match_status',
    'CREATE INDEX idx_match_status ON matches (status)',
  );
  late final Index idxMatchTournament = Index(
    'idx_match_tournament',
    'CREATE INDEX idx_match_tournament ON matches (tournament_id)',
  );
  late final Index idxMatchPlayerMatch = Index(
    'idx_match_player_match',
    'CREATE INDEX idx_match_player_match ON match_players (match_id)',
  );
  late final Index idxEventMatchSeq = Index(
    'idx_event_match_seq',
    'CREATE UNIQUE INDEX idx_event_match_seq ON events (match_id, seq)',
  );
  late final PlayerDao playerDao = PlayerDao(this as AppDb);
  late final TeamDao teamDao = TeamDao(this as AppDb);
  late final MatchDao matchDao = MatchDao(this as AppDb);
  late final EventDao eventDao = EventDao(this as AppDb);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    players,
    teams,
    teamPlayers,
    matches,
    matchPlayers,
    events,
    tournaments,
    tournamentTeams,
    fixtures,
    idxTeamPlayerPlayer,
    idxMatchStatus,
    idxMatchTournament,
    idxMatchPlayerMatch,
    idxEventMatchSeq,
  ];
}

typedef $$PlayersTableCreateCompanionBuilder =
    PlayersCompanion Function({
      required String id,
      required String name,
      Value<String?> nickname,
      Value<String?> battingStyle,
      Value<String?> bowlingStyle,
      Value<PlayerRole?> role,
      Value<String?> photoPath,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$PlayersTableUpdateCompanionBuilder =
    PlayersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> nickname,
      Value<String?> battingStyle,
      Value<String?> bowlingStyle,
      Value<PlayerRole?> role,
      Value<String?> photoPath,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$PlayersTableFilterComposer extends Composer<_$AppDb, $PlayersTable> {
  $$PlayersTableFilterComposer({
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

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get battingStyle => $composableBuilder(
    column: $table.battingStyle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bowlingStyle => $composableBuilder(
    column: $table.bowlingStyle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PlayerRole?, PlayerRole, String> get role =>
      $composableBuilder(
        column: $table.role,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlayersTableOrderingComposer extends Composer<_$AppDb, $PlayersTable> {
  $$PlayersTableOrderingComposer({
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

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get battingStyle => $composableBuilder(
    column: $table.battingStyle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bowlingStyle => $composableBuilder(
    column: $table.bowlingStyle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlayersTableAnnotationComposer
    extends Composer<_$AppDb, $PlayersTable> {
  $$PlayersTableAnnotationComposer({
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

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<String> get battingStyle => $composableBuilder(
    column: $table.battingStyle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bowlingStyle => $composableBuilder(
    column: $table.bowlingStyle,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<PlayerRole?, String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PlayersTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $PlayersTable,
          Player,
          $$PlayersTableFilterComposer,
          $$PlayersTableOrderingComposer,
          $$PlayersTableAnnotationComposer,
          $$PlayersTableCreateCompanionBuilder,
          $$PlayersTableUpdateCompanionBuilder,
          (Player, BaseReferences<_$AppDb, $PlayersTable, Player>),
          Player,
          PrefetchHooks Function()
        > {
  $$PlayersTableTableManager(_$AppDb db, $PlayersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> nickname = const Value.absent(),
                Value<String?> battingStyle = const Value.absent(),
                Value<String?> bowlingStyle = const Value.absent(),
                Value<PlayerRole?> role = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayersCompanion(
                id: id,
                name: name,
                nickname: nickname,
                battingStyle: battingStyle,
                bowlingStyle: bowlingStyle,
                role: role,
                photoPath: photoPath,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> nickname = const Value.absent(),
                Value<String?> battingStyle = const Value.absent(),
                Value<String?> bowlingStyle = const Value.absent(),
                Value<PlayerRole?> role = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => PlayersCompanion.insert(
                id: id,
                name: name,
                nickname: nickname,
                battingStyle: battingStyle,
                bowlingStyle: bowlingStyle,
                role: role,
                photoPath: photoPath,
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

typedef $$PlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $PlayersTable,
      Player,
      $$PlayersTableFilterComposer,
      $$PlayersTableOrderingComposer,
      $$PlayersTableAnnotationComposer,
      $$PlayersTableCreateCompanionBuilder,
      $$PlayersTableUpdateCompanionBuilder,
      (Player, BaseReferences<_$AppDb, $PlayersTable, Player>),
      Player,
      PrefetchHooks Function()
    >;
typedef $$TeamsTableCreateCompanionBuilder =
    TeamsCompanion Function({
      required String id,
      required String name,
      Value<String?> shortName,
      Value<String?> logoPath,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$TeamsTableUpdateCompanionBuilder =
    TeamsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> shortName,
      Value<String?> logoPath,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$TeamsTableFilterComposer extends Composer<_$AppDb, $TeamsTable> {
  $$TeamsTableFilterComposer({
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

  ColumnFilters<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TeamsTableOrderingComposer extends Composer<_$AppDb, $TeamsTable> {
  $$TeamsTableOrderingComposer({
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

  ColumnOrderings<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeamsTableAnnotationComposer extends Composer<_$AppDb, $TeamsTable> {
  $$TeamsTableAnnotationComposer({
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

  GeneratedColumn<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TeamsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $TeamsTable,
          Team,
          $$TeamsTableFilterComposer,
          $$TeamsTableOrderingComposer,
          $$TeamsTableAnnotationComposer,
          $$TeamsTableCreateCompanionBuilder,
          $$TeamsTableUpdateCompanionBuilder,
          (Team, BaseReferences<_$AppDb, $TeamsTable, Team>),
          Team,
          PrefetchHooks Function()
        > {
  $$TeamsTableTableManager(_$AppDb db, $TeamsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> shortName = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeamsCompanion(
                id: id,
                name: name,
                shortName: shortName,
                logoPath: logoPath,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> shortName = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => TeamsCompanion.insert(
                id: id,
                name: name,
                shortName: shortName,
                logoPath: logoPath,
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

typedef $$TeamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $TeamsTable,
      Team,
      $$TeamsTableFilterComposer,
      $$TeamsTableOrderingComposer,
      $$TeamsTableAnnotationComposer,
      $$TeamsTableCreateCompanionBuilder,
      $$TeamsTableUpdateCompanionBuilder,
      (Team, BaseReferences<_$AppDb, $TeamsTable, Team>),
      Team,
      PrefetchHooks Function()
    >;
typedef $$TeamPlayersTableCreateCompanionBuilder =
    TeamPlayersCompanion Function({
      required String teamId,
      required String playerId,
      Value<int?> jerseyNo,
      Value<int> rowid,
    });
typedef $$TeamPlayersTableUpdateCompanionBuilder =
    TeamPlayersCompanion Function({
      Value<String> teamId,
      Value<String> playerId,
      Value<int?> jerseyNo,
      Value<int> rowid,
    });

class $$TeamPlayersTableFilterComposer
    extends Composer<_$AppDb, $TeamPlayersTable> {
  $$TeamPlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jerseyNo => $composableBuilder(
    column: $table.jerseyNo,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TeamPlayersTableOrderingComposer
    extends Composer<_$AppDb, $TeamPlayersTable> {
  $$TeamPlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jerseyNo => $composableBuilder(
    column: $table.jerseyNo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeamPlayersTableAnnotationComposer
    extends Composer<_$AppDb, $TeamPlayersTable> {
  $$TeamPlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get playerId =>
      $composableBuilder(column: $table.playerId, builder: (column) => column);

  GeneratedColumn<int> get jerseyNo =>
      $composableBuilder(column: $table.jerseyNo, builder: (column) => column);
}

class $$TeamPlayersTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $TeamPlayersTable,
          TeamPlayer,
          $$TeamPlayersTableFilterComposer,
          $$TeamPlayersTableOrderingComposer,
          $$TeamPlayersTableAnnotationComposer,
          $$TeamPlayersTableCreateCompanionBuilder,
          $$TeamPlayersTableUpdateCompanionBuilder,
          (TeamPlayer, BaseReferences<_$AppDb, $TeamPlayersTable, TeamPlayer>),
          TeamPlayer,
          PrefetchHooks Function()
        > {
  $$TeamPlayersTableTableManager(_$AppDb db, $TeamPlayersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamPlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamPlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamPlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> teamId = const Value.absent(),
                Value<String> playerId = const Value.absent(),
                Value<int?> jerseyNo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeamPlayersCompanion(
                teamId: teamId,
                playerId: playerId,
                jerseyNo: jerseyNo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String teamId,
                required String playerId,
                Value<int?> jerseyNo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeamPlayersCompanion.insert(
                teamId: teamId,
                playerId: playerId,
                jerseyNo: jerseyNo,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TeamPlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $TeamPlayersTable,
      TeamPlayer,
      $$TeamPlayersTableFilterComposer,
      $$TeamPlayersTableOrderingComposer,
      $$TeamPlayersTableAnnotationComposer,
      $$TeamPlayersTableCreateCompanionBuilder,
      $$TeamPlayersTableUpdateCompanionBuilder,
      (TeamPlayer, BaseReferences<_$AppDb, $TeamPlayersTable, TeamPlayer>),
      TeamPlayer,
      PrefetchHooks Function()
    >;
typedef $$MatchesTableCreateCompanionBuilder =
    MatchesCompanion Function({
      required String id,
      Value<String?> title,
      required String format,
      required String rulesJson,
      required String teamAId,
      required String teamBId,
      Value<String?> venue,
      required DateTime dateLocal,
      Value<MatchType> matchType,
      Value<String?> jokerPlayerId,
      Value<String?> tossWinnerTeamId,
      Value<TossDecision?> tossDecision,
      Value<MatchStatus> status,
      Value<String?> resultJson,
      Value<String?> tournamentId,
      Value<int> eventCursor,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MatchesTableUpdateCompanionBuilder =
    MatchesCompanion Function({
      Value<String> id,
      Value<String?> title,
      Value<String> format,
      Value<String> rulesJson,
      Value<String> teamAId,
      Value<String> teamBId,
      Value<String?> venue,
      Value<DateTime> dateLocal,
      Value<MatchType> matchType,
      Value<String?> jokerPlayerId,
      Value<String?> tossWinnerTeamId,
      Value<TossDecision?> tossDecision,
      Value<MatchStatus> status,
      Value<String?> resultJson,
      Value<String?> tournamentId,
      Value<int> eventCursor,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$MatchesTableFilterComposer extends Composer<_$AppDb, $MatchesTable> {
  $$MatchesTableFilterComposer({
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

  ColumnFilters<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rulesJson => $composableBuilder(
    column: $table.rulesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamAId => $composableBuilder(
    column: $table.teamAId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamBId => $composableBuilder(
    column: $table.teamBId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venue => $composableBuilder(
    column: $table.venue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateLocal => $composableBuilder(
    column: $table.dateLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MatchType, MatchType, String> get matchType =>
      $composableBuilder(
        column: $table.matchType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get jokerPlayerId => $composableBuilder(
    column: $table.jokerPlayerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tossWinnerTeamId => $composableBuilder(
    column: $table.tossWinnerTeamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TossDecision?, TossDecision, String>
  get tossDecision => $composableBuilder(
    column: $table.tossDecision,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<MatchStatus, MatchStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tournamentId => $composableBuilder(
    column: $table.tournamentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get eventCursor => $composableBuilder(
    column: $table.eventCursor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MatchesTableOrderingComposer extends Composer<_$AppDb, $MatchesTable> {
  $$MatchesTableOrderingComposer({
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

  ColumnOrderings<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rulesJson => $composableBuilder(
    column: $table.rulesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamAId => $composableBuilder(
    column: $table.teamAId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamBId => $composableBuilder(
    column: $table.teamBId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venue => $composableBuilder(
    column: $table.venue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateLocal => $composableBuilder(
    column: $table.dateLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchType => $composableBuilder(
    column: $table.matchType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jokerPlayerId => $composableBuilder(
    column: $table.jokerPlayerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tossWinnerTeamId => $composableBuilder(
    column: $table.tossWinnerTeamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tossDecision => $composableBuilder(
    column: $table.tossDecision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tournamentId => $composableBuilder(
    column: $table.tournamentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get eventCursor => $composableBuilder(
    column: $table.eventCursor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MatchesTableAnnotationComposer
    extends Composer<_$AppDb, $MatchesTable> {
  $$MatchesTableAnnotationComposer({
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

  GeneratedColumn<String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<String> get rulesJson =>
      $composableBuilder(column: $table.rulesJson, builder: (column) => column);

  GeneratedColumn<String> get teamAId =>
      $composableBuilder(column: $table.teamAId, builder: (column) => column);

  GeneratedColumn<String> get teamBId =>
      $composableBuilder(column: $table.teamBId, builder: (column) => column);

  GeneratedColumn<String> get venue =>
      $composableBuilder(column: $table.venue, builder: (column) => column);

  GeneratedColumn<DateTime> get dateLocal =>
      $composableBuilder(column: $table.dateLocal, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MatchType, String> get matchType =>
      $composableBuilder(column: $table.matchType, builder: (column) => column);

  GeneratedColumn<String> get jokerPlayerId => $composableBuilder(
    column: $table.jokerPlayerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tossWinnerTeamId => $composableBuilder(
    column: $table.tossWinnerTeamId,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<TossDecision?, String> get tossDecision =>
      $composableBuilder(
        column: $table.tossDecision,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<MatchStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tournamentId => $composableBuilder(
    column: $table.tournamentId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get eventCursor => $composableBuilder(
    column: $table.eventCursor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MatchesTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $MatchesTable,
          MatchRow,
          $$MatchesTableFilterComposer,
          $$MatchesTableOrderingComposer,
          $$MatchesTableAnnotationComposer,
          $$MatchesTableCreateCompanionBuilder,
          $$MatchesTableUpdateCompanionBuilder,
          (MatchRow, BaseReferences<_$AppDb, $MatchesTable, MatchRow>),
          MatchRow,
          PrefetchHooks Function()
        > {
  $$MatchesTableTableManager(_$AppDb db, $MatchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String> format = const Value.absent(),
                Value<String> rulesJson = const Value.absent(),
                Value<String> teamAId = const Value.absent(),
                Value<String> teamBId = const Value.absent(),
                Value<String?> venue = const Value.absent(),
                Value<DateTime> dateLocal = const Value.absent(),
                Value<MatchType> matchType = const Value.absent(),
                Value<String?> jokerPlayerId = const Value.absent(),
                Value<String?> tossWinnerTeamId = const Value.absent(),
                Value<TossDecision?> tossDecision = const Value.absent(),
                Value<MatchStatus> status = const Value.absent(),
                Value<String?> resultJson = const Value.absent(),
                Value<String?> tournamentId = const Value.absent(),
                Value<int> eventCursor = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MatchesCompanion(
                id: id,
                title: title,
                format: format,
                rulesJson: rulesJson,
                teamAId: teamAId,
                teamBId: teamBId,
                venue: venue,
                dateLocal: dateLocal,
                matchType: matchType,
                jokerPlayerId: jokerPlayerId,
                tossWinnerTeamId: tossWinnerTeamId,
                tossDecision: tossDecision,
                status: status,
                resultJson: resultJson,
                tournamentId: tournamentId,
                eventCursor: eventCursor,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> title = const Value.absent(),
                required String format,
                required String rulesJson,
                required String teamAId,
                required String teamBId,
                Value<String?> venue = const Value.absent(),
                required DateTime dateLocal,
                Value<MatchType> matchType = const Value.absent(),
                Value<String?> jokerPlayerId = const Value.absent(),
                Value<String?> tossWinnerTeamId = const Value.absent(),
                Value<TossDecision?> tossDecision = const Value.absent(),
                Value<MatchStatus> status = const Value.absent(),
                Value<String?> resultJson = const Value.absent(),
                Value<String?> tournamentId = const Value.absent(),
                Value<int> eventCursor = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MatchesCompanion.insert(
                id: id,
                title: title,
                format: format,
                rulesJson: rulesJson,
                teamAId: teamAId,
                teamBId: teamBId,
                venue: venue,
                dateLocal: dateLocal,
                matchType: matchType,
                jokerPlayerId: jokerPlayerId,
                tossWinnerTeamId: tossWinnerTeamId,
                tossDecision: tossDecision,
                status: status,
                resultJson: resultJson,
                tournamentId: tournamentId,
                eventCursor: eventCursor,
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

typedef $$MatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $MatchesTable,
      MatchRow,
      $$MatchesTableFilterComposer,
      $$MatchesTableOrderingComposer,
      $$MatchesTableAnnotationComposer,
      $$MatchesTableCreateCompanionBuilder,
      $$MatchesTableUpdateCompanionBuilder,
      (MatchRow, BaseReferences<_$AppDb, $MatchesTable, MatchRow>),
      MatchRow,
      PrefetchHooks Function()
    >;
typedef $$MatchPlayersTableCreateCompanionBuilder =
    MatchPlayersCompanion Function({
      required String matchId,
      required String teamId,
      required String playerId,
      Value<int?> battingOrder,
      Value<bool> isCaptain,
      Value<bool> isKeeper,
      Value<int> rowid,
    });
typedef $$MatchPlayersTableUpdateCompanionBuilder =
    MatchPlayersCompanion Function({
      Value<String> matchId,
      Value<String> teamId,
      Value<String> playerId,
      Value<int?> battingOrder,
      Value<bool> isCaptain,
      Value<bool> isKeeper,
      Value<int> rowid,
    });

class $$MatchPlayersTableFilterComposer
    extends Composer<_$AppDb, $MatchPlayersTable> {
  $$MatchPlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get battingOrder => $composableBuilder(
    column: $table.battingOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCaptain => $composableBuilder(
    column: $table.isCaptain,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isKeeper => $composableBuilder(
    column: $table.isKeeper,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MatchPlayersTableOrderingComposer
    extends Composer<_$AppDb, $MatchPlayersTable> {
  $$MatchPlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get battingOrder => $composableBuilder(
    column: $table.battingOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCaptain => $composableBuilder(
    column: $table.isCaptain,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isKeeper => $composableBuilder(
    column: $table.isKeeper,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MatchPlayersTableAnnotationComposer
    extends Composer<_$AppDb, $MatchPlayersTable> {
  $$MatchPlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get matchId =>
      $composableBuilder(column: $table.matchId, builder: (column) => column);

  GeneratedColumn<String> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get playerId =>
      $composableBuilder(column: $table.playerId, builder: (column) => column);

  GeneratedColumn<int> get battingOrder => $composableBuilder(
    column: $table.battingOrder,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCaptain =>
      $composableBuilder(column: $table.isCaptain, builder: (column) => column);

  GeneratedColumn<bool> get isKeeper =>
      $composableBuilder(column: $table.isKeeper, builder: (column) => column);
}

class $$MatchPlayersTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $MatchPlayersTable,
          MatchPlayer,
          $$MatchPlayersTableFilterComposer,
          $$MatchPlayersTableOrderingComposer,
          $$MatchPlayersTableAnnotationComposer,
          $$MatchPlayersTableCreateCompanionBuilder,
          $$MatchPlayersTableUpdateCompanionBuilder,
          (
            MatchPlayer,
            BaseReferences<_$AppDb, $MatchPlayersTable, MatchPlayer>,
          ),
          MatchPlayer,
          PrefetchHooks Function()
        > {
  $$MatchPlayersTableTableManager(_$AppDb db, $MatchPlayersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchPlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchPlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchPlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> matchId = const Value.absent(),
                Value<String> teamId = const Value.absent(),
                Value<String> playerId = const Value.absent(),
                Value<int?> battingOrder = const Value.absent(),
                Value<bool> isCaptain = const Value.absent(),
                Value<bool> isKeeper = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MatchPlayersCompanion(
                matchId: matchId,
                teamId: teamId,
                playerId: playerId,
                battingOrder: battingOrder,
                isCaptain: isCaptain,
                isKeeper: isKeeper,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String matchId,
                required String teamId,
                required String playerId,
                Value<int?> battingOrder = const Value.absent(),
                Value<bool> isCaptain = const Value.absent(),
                Value<bool> isKeeper = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MatchPlayersCompanion.insert(
                matchId: matchId,
                teamId: teamId,
                playerId: playerId,
                battingOrder: battingOrder,
                isCaptain: isCaptain,
                isKeeper: isKeeper,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MatchPlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $MatchPlayersTable,
      MatchPlayer,
      $$MatchPlayersTableFilterComposer,
      $$MatchPlayersTableOrderingComposer,
      $$MatchPlayersTableAnnotationComposer,
      $$MatchPlayersTableCreateCompanionBuilder,
      $$MatchPlayersTableUpdateCompanionBuilder,
      (MatchPlayer, BaseReferences<_$AppDb, $MatchPlayersTable, MatchPlayer>),
      MatchPlayer,
      PrefetchHooks Function()
    >;
typedef $$EventsTableCreateCompanionBuilder =
    EventsCompanion Function({
      Value<int> id,
      required String matchId,
      required int seq,
      required String type,
      required String payloadJson,
      required DateTime createdAt,
    });
typedef $$EventsTableUpdateCompanionBuilder =
    EventsCompanion Function({
      Value<int> id,
      Value<String> matchId,
      Value<int> seq,
      Value<String> type,
      Value<String> payloadJson,
      Value<DateTime> createdAt,
    });

class $$EventsTableFilterComposer extends Composer<_$AppDb, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EventsTableOrderingComposer extends Composer<_$AppDb, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventsTableAnnotationComposer extends Composer<_$AppDb, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get matchId =>
      $composableBuilder(column: $table.matchId, builder: (column) => column);

  GeneratedColumn<int> get seq =>
      $composableBuilder(column: $table.seq, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$EventsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $EventsTable,
          Event,
          $$EventsTableFilterComposer,
          $$EventsTableOrderingComposer,
          $$EventsTableAnnotationComposer,
          $$EventsTableCreateCompanionBuilder,
          $$EventsTableUpdateCompanionBuilder,
          (Event, BaseReferences<_$AppDb, $EventsTable, Event>),
          Event,
          PrefetchHooks Function()
        > {
  $$EventsTableTableManager(_$AppDb db, $EventsTable table)
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
                Value<int> id = const Value.absent(),
                Value<String> matchId = const Value.absent(),
                Value<int> seq = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EventsCompanion(
                id: id,
                matchId: matchId,
                seq: seq,
                type: type,
                payloadJson: payloadJson,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String matchId,
                required int seq,
                required String type,
                required String payloadJson,
                required DateTime createdAt,
              }) => EventsCompanion.insert(
                id: id,
                matchId: matchId,
                seq: seq,
                type: type,
                payloadJson: payloadJson,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $EventsTable,
      Event,
      $$EventsTableFilterComposer,
      $$EventsTableOrderingComposer,
      $$EventsTableAnnotationComposer,
      $$EventsTableCreateCompanionBuilder,
      $$EventsTableUpdateCompanionBuilder,
      (Event, BaseReferences<_$AppDb, $EventsTable, Event>),
      Event,
      PrefetchHooks Function()
    >;
typedef $$TournamentsTableCreateCompanionBuilder =
    TournamentsCompanion Function({
      required String id,
      required String name,
      Value<TournamentFormat> format,
      required String rulesJson,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      Value<int> pointsWin,
      Value<int> pointsTie,
      Value<int> pointsNoResult,
      Value<int> pointsLoss,
      Value<String> tieBreakOrderJson,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$TournamentsTableUpdateCompanionBuilder =
    TournamentsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<TournamentFormat> format,
      Value<String> rulesJson,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      Value<int> pointsWin,
      Value<int> pointsTie,
      Value<int> pointsNoResult,
      Value<int> pointsLoss,
      Value<String> tieBreakOrderJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$TournamentsTableFilterComposer
    extends Composer<_$AppDb, $TournamentsTable> {
  $$TournamentsTableFilterComposer({
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

  ColumnWithTypeConverterFilters<TournamentFormat, TournamentFormat, String>
  get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get rulesJson => $composableBuilder(
    column: $table.rulesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointsWin => $composableBuilder(
    column: $table.pointsWin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointsTie => $composableBuilder(
    column: $table.pointsTie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointsNoResult => $composableBuilder(
    column: $table.pointsNoResult,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointsLoss => $composableBuilder(
    column: $table.pointsLoss,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tieBreakOrderJson => $composableBuilder(
    column: $table.tieBreakOrderJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TournamentsTableOrderingComposer
    extends Composer<_$AppDb, $TournamentsTable> {
  $$TournamentsTableOrderingComposer({
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

  ColumnOrderings<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rulesJson => $composableBuilder(
    column: $table.rulesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointsWin => $composableBuilder(
    column: $table.pointsWin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointsTie => $composableBuilder(
    column: $table.pointsTie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointsNoResult => $composableBuilder(
    column: $table.pointsNoResult,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointsLoss => $composableBuilder(
    column: $table.pointsLoss,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tieBreakOrderJson => $composableBuilder(
    column: $table.tieBreakOrderJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TournamentsTableAnnotationComposer
    extends Composer<_$AppDb, $TournamentsTable> {
  $$TournamentsTableAnnotationComposer({
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

  GeneratedColumnWithTypeConverter<TournamentFormat, String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<String> get rulesJson =>
      $composableBuilder(column: $table.rulesJson, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get pointsWin =>
      $composableBuilder(column: $table.pointsWin, builder: (column) => column);

  GeneratedColumn<int> get pointsTie =>
      $composableBuilder(column: $table.pointsTie, builder: (column) => column);

  GeneratedColumn<int> get pointsNoResult => $composableBuilder(
    column: $table.pointsNoResult,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pointsLoss => $composableBuilder(
    column: $table.pointsLoss,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tieBreakOrderJson => $composableBuilder(
    column: $table.tieBreakOrderJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TournamentsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $TournamentsTable,
          Tournament,
          $$TournamentsTableFilterComposer,
          $$TournamentsTableOrderingComposer,
          $$TournamentsTableAnnotationComposer,
          $$TournamentsTableCreateCompanionBuilder,
          $$TournamentsTableUpdateCompanionBuilder,
          (Tournament, BaseReferences<_$AppDb, $TournamentsTable, Tournament>),
          Tournament,
          PrefetchHooks Function()
        > {
  $$TournamentsTableTableManager(_$AppDb db, $TournamentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TournamentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TournamentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TournamentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<TournamentFormat> format = const Value.absent(),
                Value<String> rulesJson = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<int> pointsWin = const Value.absent(),
                Value<int> pointsTie = const Value.absent(),
                Value<int> pointsNoResult = const Value.absent(),
                Value<int> pointsLoss = const Value.absent(),
                Value<String> tieBreakOrderJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TournamentsCompanion(
                id: id,
                name: name,
                format: format,
                rulesJson: rulesJson,
                startDate: startDate,
                endDate: endDate,
                pointsWin: pointsWin,
                pointsTie: pointsTie,
                pointsNoResult: pointsNoResult,
                pointsLoss: pointsLoss,
                tieBreakOrderJson: tieBreakOrderJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<TournamentFormat> format = const Value.absent(),
                required String rulesJson,
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<int> pointsWin = const Value.absent(),
                Value<int> pointsTie = const Value.absent(),
                Value<int> pointsNoResult = const Value.absent(),
                Value<int> pointsLoss = const Value.absent(),
                Value<String> tieBreakOrderJson = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => TournamentsCompanion.insert(
                id: id,
                name: name,
                format: format,
                rulesJson: rulesJson,
                startDate: startDate,
                endDate: endDate,
                pointsWin: pointsWin,
                pointsTie: pointsTie,
                pointsNoResult: pointsNoResult,
                pointsLoss: pointsLoss,
                tieBreakOrderJson: tieBreakOrderJson,
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

typedef $$TournamentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $TournamentsTable,
      Tournament,
      $$TournamentsTableFilterComposer,
      $$TournamentsTableOrderingComposer,
      $$TournamentsTableAnnotationComposer,
      $$TournamentsTableCreateCompanionBuilder,
      $$TournamentsTableUpdateCompanionBuilder,
      (Tournament, BaseReferences<_$AppDb, $TournamentsTable, Tournament>),
      Tournament,
      PrefetchHooks Function()
    >;
typedef $$TournamentTeamsTableCreateCompanionBuilder =
    TournamentTeamsCompanion Function({
      required String tournamentId,
      required String teamId,
      Value<int> rowid,
    });
typedef $$TournamentTeamsTableUpdateCompanionBuilder =
    TournamentTeamsCompanion Function({
      Value<String> tournamentId,
      Value<String> teamId,
      Value<int> rowid,
    });

class $$TournamentTeamsTableFilterComposer
    extends Composer<_$AppDb, $TournamentTeamsTable> {
  $$TournamentTeamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get tournamentId => $composableBuilder(
    column: $table.tournamentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TournamentTeamsTableOrderingComposer
    extends Composer<_$AppDb, $TournamentTeamsTable> {
  $$TournamentTeamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get tournamentId => $composableBuilder(
    column: $table.tournamentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TournamentTeamsTableAnnotationComposer
    extends Composer<_$AppDb, $TournamentTeamsTable> {
  $$TournamentTeamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get tournamentId => $composableBuilder(
    column: $table.tournamentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);
}

class $$TournamentTeamsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $TournamentTeamsTable,
          TournamentTeam,
          $$TournamentTeamsTableFilterComposer,
          $$TournamentTeamsTableOrderingComposer,
          $$TournamentTeamsTableAnnotationComposer,
          $$TournamentTeamsTableCreateCompanionBuilder,
          $$TournamentTeamsTableUpdateCompanionBuilder,
          (
            TournamentTeam,
            BaseReferences<_$AppDb, $TournamentTeamsTable, TournamentTeam>,
          ),
          TournamentTeam,
          PrefetchHooks Function()
        > {
  $$TournamentTeamsTableTableManager(_$AppDb db, $TournamentTeamsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TournamentTeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TournamentTeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TournamentTeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> tournamentId = const Value.absent(),
                Value<String> teamId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TournamentTeamsCompanion(
                tournamentId: tournamentId,
                teamId: teamId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String tournamentId,
                required String teamId,
                Value<int> rowid = const Value.absent(),
              }) => TournamentTeamsCompanion.insert(
                tournamentId: tournamentId,
                teamId: teamId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TournamentTeamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $TournamentTeamsTable,
      TournamentTeam,
      $$TournamentTeamsTableFilterComposer,
      $$TournamentTeamsTableOrderingComposer,
      $$TournamentTeamsTableAnnotationComposer,
      $$TournamentTeamsTableCreateCompanionBuilder,
      $$TournamentTeamsTableUpdateCompanionBuilder,
      (
        TournamentTeam,
        BaseReferences<_$AppDb, $TournamentTeamsTable, TournamentTeam>,
      ),
      TournamentTeam,
      PrefetchHooks Function()
    >;
typedef $$FixturesTableCreateCompanionBuilder =
    FixturesCompanion Function({
      required String id,
      required String tournamentId,
      Value<int?> round,
      required String teamAId,
      required String teamBId,
      Value<DateTime?> scheduledDate,
      Value<String?> matchId,
      Value<String> status,
      Value<int> rowid,
    });
typedef $$FixturesTableUpdateCompanionBuilder =
    FixturesCompanion Function({
      Value<String> id,
      Value<String> tournamentId,
      Value<int?> round,
      Value<String> teamAId,
      Value<String> teamBId,
      Value<DateTime?> scheduledDate,
      Value<String?> matchId,
      Value<String> status,
      Value<int> rowid,
    });

class $$FixturesTableFilterComposer extends Composer<_$AppDb, $FixturesTable> {
  $$FixturesTableFilterComposer({
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

  ColumnFilters<String> get tournamentId => $composableBuilder(
    column: $table.tournamentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get round => $composableBuilder(
    column: $table.round,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamAId => $composableBuilder(
    column: $table.teamAId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamBId => $composableBuilder(
    column: $table.teamBId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FixturesTableOrderingComposer
    extends Composer<_$AppDb, $FixturesTable> {
  $$FixturesTableOrderingComposer({
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

  ColumnOrderings<String> get tournamentId => $composableBuilder(
    column: $table.tournamentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get round => $composableBuilder(
    column: $table.round,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamAId => $composableBuilder(
    column: $table.teamAId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamBId => $composableBuilder(
    column: $table.teamBId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FixturesTableAnnotationComposer
    extends Composer<_$AppDb, $FixturesTable> {
  $$FixturesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tournamentId => $composableBuilder(
    column: $table.tournamentId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get round =>
      $composableBuilder(column: $table.round, builder: (column) => column);

  GeneratedColumn<String> get teamAId =>
      $composableBuilder(column: $table.teamAId, builder: (column) => column);

  GeneratedColumn<String> get teamBId =>
      $composableBuilder(column: $table.teamBId, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get matchId =>
      $composableBuilder(column: $table.matchId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$FixturesTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $FixturesTable,
          Fixture,
          $$FixturesTableFilterComposer,
          $$FixturesTableOrderingComposer,
          $$FixturesTableAnnotationComposer,
          $$FixturesTableCreateCompanionBuilder,
          $$FixturesTableUpdateCompanionBuilder,
          (Fixture, BaseReferences<_$AppDb, $FixturesTable, Fixture>),
          Fixture,
          PrefetchHooks Function()
        > {
  $$FixturesTableTableManager(_$AppDb db, $FixturesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FixturesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FixturesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FixturesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tournamentId = const Value.absent(),
                Value<int?> round = const Value.absent(),
                Value<String> teamAId = const Value.absent(),
                Value<String> teamBId = const Value.absent(),
                Value<DateTime?> scheduledDate = const Value.absent(),
                Value<String?> matchId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FixturesCompanion(
                id: id,
                tournamentId: tournamentId,
                round: round,
                teamAId: teamAId,
                teamBId: teamBId,
                scheduledDate: scheduledDate,
                matchId: matchId,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tournamentId,
                Value<int?> round = const Value.absent(),
                required String teamAId,
                required String teamBId,
                Value<DateTime?> scheduledDate = const Value.absent(),
                Value<String?> matchId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FixturesCompanion.insert(
                id: id,
                tournamentId: tournamentId,
                round: round,
                teamAId: teamAId,
                teamBId: teamBId,
                scheduledDate: scheduledDate,
                matchId: matchId,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FixturesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $FixturesTable,
      Fixture,
      $$FixturesTableFilterComposer,
      $$FixturesTableOrderingComposer,
      $$FixturesTableAnnotationComposer,
      $$FixturesTableCreateCompanionBuilder,
      $$FixturesTableUpdateCompanionBuilder,
      (Fixture, BaseReferences<_$AppDb, $FixturesTable, Fixture>),
      Fixture,
      PrefetchHooks Function()
    >;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db, _db.teams);
  $$TeamPlayersTableTableManager get teamPlayers =>
      $$TeamPlayersTableTableManager(_db, _db.teamPlayers);
  $$MatchesTableTableManager get matches =>
      $$MatchesTableTableManager(_db, _db.matches);
  $$MatchPlayersTableTableManager get matchPlayers =>
      $$MatchPlayersTableTableManager(_db, _db.matchPlayers);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$TournamentsTableTableManager get tournaments =>
      $$TournamentsTableTableManager(_db, _db.tournaments);
  $$TournamentTeamsTableTableManager get tournamentTeams =>
      $$TournamentTeamsTableTableManager(_db, _db.tournamentTeams);
  $$FixturesTableTableManager get fixtures =>
      $$FixturesTableTableManager(_db, _db.fixtures);
}
