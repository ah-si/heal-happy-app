// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserEvent extends UserEvent {
  @override
  final String id;
  @override
  final User patient;
  @override
  final Healer healer;
  @override
  final DateTime start;
  @override
  final DateTime end;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String link;

  factory _$UserEvent([void Function(UserEventBuilder)? updates]) =>
      (new UserEventBuilder()..update(updates)).build();

  _$UserEvent._(
      {required this.id,
      required this.patient,
      required this.healer,
      required this.start,
      required this.end,
      required this.name,
      this.description,
      required this.link})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'UserEvent', 'id');
    BuiltValueNullFieldError.checkNotNull(patient, 'UserEvent', 'patient');
    BuiltValueNullFieldError.checkNotNull(healer, 'UserEvent', 'healer');
    BuiltValueNullFieldError.checkNotNull(start, 'UserEvent', 'start');
    BuiltValueNullFieldError.checkNotNull(end, 'UserEvent', 'end');
    BuiltValueNullFieldError.checkNotNull(name, 'UserEvent', 'name');
    BuiltValueNullFieldError.checkNotNull(link, 'UserEvent', 'link');
  }

  @override
  UserEvent rebuild(void Function(UserEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserEventBuilder toBuilder() => new UserEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserEvent &&
        id == other.id &&
        patient == other.patient &&
        healer == other.healer &&
        start == other.start &&
        end == other.end &&
        name == other.name &&
        description == other.description &&
        link == other.link;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, id.hashCode), patient.hashCode),
                            healer.hashCode),
                        start.hashCode),
                    end.hashCode),
                name.hashCode),
            description.hashCode),
        link.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserEvent')
          ..add('id', id)
          ..add('patient', patient)
          ..add('healer', healer)
          ..add('start', start)
          ..add('end', end)
          ..add('name', name)
          ..add('description', description)
          ..add('link', link))
        .toString();
  }
}

class UserEventBuilder implements Builder<UserEvent, UserEventBuilder> {
  _$UserEvent? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  UserBuilder? _patient;
  UserBuilder get patient => _$this._patient ??= new UserBuilder();
  set patient(UserBuilder? patient) => _$this._patient = patient;

  HealerBuilder? _healer;
  HealerBuilder get healer => _$this._healer ??= new HealerBuilder();
  set healer(HealerBuilder? healer) => _$this._healer = healer;

  DateTime? _start;
  DateTime? get start => _$this._start;
  set start(DateTime? start) => _$this._start = start;

  DateTime? _end;
  DateTime? get end => _$this._end;
  set end(DateTime? end) => _$this._end = end;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _link;
  String? get link => _$this._link;
  set link(String? link) => _$this._link = link;

  UserEventBuilder() {
    UserEvent._defaults(this);
  }

  UserEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _patient = $v.patient.toBuilder();
      _healer = $v.healer.toBuilder();
      _start = $v.start;
      _end = $v.end;
      _name = $v.name;
      _description = $v.description;
      _link = $v.link;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserEvent other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserEvent;
  }

  @override
  void update(void Function(UserEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserEvent build() {
    _$UserEvent _$result;
    try {
      _$result = _$v ??
          new _$UserEvent._(
              id: BuiltValueNullFieldError.checkNotNull(id, 'UserEvent', 'id'),
              patient: patient.build(),
              healer: healer.build(),
              start: BuiltValueNullFieldError.checkNotNull(
                  start, 'UserEvent', 'start'),
              end: BuiltValueNullFieldError.checkNotNull(
                  end, 'UserEvent', 'end'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, 'UserEvent', 'name'),
              description: description,
              link: BuiltValueNullFieldError.checkNotNull(
                  link, 'UserEvent', 'link'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'patient';
        patient.build();
        _$failedField = 'healer';
        healer.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
