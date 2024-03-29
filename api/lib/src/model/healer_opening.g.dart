// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'healer_opening.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HealerOpening extends HealerOpening {
  @override
  final String? id;
  @override
  final String userId;
  @override
  final String? roomId;
  @override
  final OpeningType type;
  @override
  final Healer? user;
  @override
  final OpeningRepeatType? repeat;
  @override
  final DateTime start;
  @override
  final DateTime end;

  factory _$HealerOpening([void Function(HealerOpeningBuilder)? updates]) =>
      (new HealerOpeningBuilder()..update(updates))._build();

  _$HealerOpening._(
      {this.id,
      required this.userId,
      this.roomId,
      required this.type,
      this.user,
      this.repeat,
      required this.start,
      required this.end})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(userId, r'HealerOpening', 'userId');
    BuiltValueNullFieldError.checkNotNull(type, r'HealerOpening', 'type');
    BuiltValueNullFieldError.checkNotNull(start, r'HealerOpening', 'start');
    BuiltValueNullFieldError.checkNotNull(end, r'HealerOpening', 'end');
  }

  @override
  HealerOpening rebuild(void Function(HealerOpeningBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HealerOpeningBuilder toBuilder() => new HealerOpeningBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HealerOpening &&
        id == other.id &&
        userId == other.userId &&
        roomId == other.roomId &&
        type == other.type &&
        user == other.user &&
        repeat == other.repeat &&
        start == other.start &&
        end == other.end;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, id.hashCode), userId.hashCode),
                            roomId.hashCode),
                        type.hashCode),
                    user.hashCode),
                repeat.hashCode),
            start.hashCode),
        end.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HealerOpening')
          ..add('id', id)
          ..add('userId', userId)
          ..add('roomId', roomId)
          ..add('type', type)
          ..add('user', user)
          ..add('repeat', repeat)
          ..add('start', start)
          ..add('end', end))
        .toString();
  }
}

class HealerOpeningBuilder
    implements Builder<HealerOpening, HealerOpeningBuilder> {
  _$HealerOpening? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  OpeningType? _type;
  OpeningType? get type => _$this._type;
  set type(OpeningType? type) => _$this._type = type;

  HealerBuilder? _user;
  HealerBuilder get user => _$this._user ??= new HealerBuilder();
  set user(HealerBuilder? user) => _$this._user = user;

  OpeningRepeatType? _repeat;
  OpeningRepeatType? get repeat => _$this._repeat;
  set repeat(OpeningRepeatType? repeat) => _$this._repeat = repeat;

  DateTime? _start;
  DateTime? get start => _$this._start;
  set start(DateTime? start) => _$this._start = start;

  DateTime? _end;
  DateTime? get end => _$this._end;
  set end(DateTime? end) => _$this._end = end;

  HealerOpeningBuilder() {
    HealerOpening._defaults(this);
  }

  HealerOpeningBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _roomId = $v.roomId;
      _type = $v.type;
      _user = $v.user?.toBuilder();
      _repeat = $v.repeat;
      _start = $v.start;
      _end = $v.end;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HealerOpening other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HealerOpening;
  }

  @override
  void update(void Function(HealerOpeningBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HealerOpening build() => _build();

  _$HealerOpening _build() {
    _$HealerOpening _$result;
    try {
      _$result = _$v ??
          new _$HealerOpening._(
              id: id,
              userId: BuiltValueNullFieldError.checkNotNull(
                  userId, r'HealerOpening', 'userId'),
              roomId: roomId,
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'HealerOpening', 'type'),
              user: _user?.build(),
              repeat: repeat,
              start: BuiltValueNullFieldError.checkNotNull(
                  start, r'HealerOpening', 'start'),
              end: BuiltValueNullFieldError.checkNotNull(
                  end, r'HealerOpening', 'end'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'HealerOpening', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
