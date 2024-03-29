// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserEvent extends UserEvent {
  @override
  final String id;
  @override
  final String? patientToken;
  @override
  final MinimalUser patient;
  @override
  final Healer healer;
  @override
  final OfficeRoom? room;
  @override
  final Office? office;
  @override
  final bool isUrgent;
  @override
  final bool isHealerPresent;
  @override
  final bool isPatientPresent;
  @override
  final bool isCancelled;
  @override
  final HealerEventType type;
  @override
  final DateTime createdAt;
  @override
  final DateTime start;
  @override
  final DateTime end;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? cancelledDescription;
  @override
  final String link;

  factory _$UserEvent([void Function(UserEventBuilder)? updates]) =>
      (new UserEventBuilder()..update(updates))._build();

  _$UserEvent._(
      {required this.id,
      this.patientToken,
      required this.patient,
      required this.healer,
      this.room,
      this.office,
      required this.isUrgent,
      required this.isHealerPresent,
      required this.isPatientPresent,
      required this.isCancelled,
      required this.type,
      required this.createdAt,
      required this.start,
      required this.end,
      required this.name,
      this.description,
      this.cancelledDescription,
      required this.link})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'UserEvent', 'id');
    BuiltValueNullFieldError.checkNotNull(patient, r'UserEvent', 'patient');
    BuiltValueNullFieldError.checkNotNull(healer, r'UserEvent', 'healer');
    BuiltValueNullFieldError.checkNotNull(isUrgent, r'UserEvent', 'isUrgent');
    BuiltValueNullFieldError.checkNotNull(
        isHealerPresent, r'UserEvent', 'isHealerPresent');
    BuiltValueNullFieldError.checkNotNull(
        isPatientPresent, r'UserEvent', 'isPatientPresent');
    BuiltValueNullFieldError.checkNotNull(
        isCancelled, r'UserEvent', 'isCancelled');
    BuiltValueNullFieldError.checkNotNull(type, r'UserEvent', 'type');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'UserEvent', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(start, r'UserEvent', 'start');
    BuiltValueNullFieldError.checkNotNull(end, r'UserEvent', 'end');
    BuiltValueNullFieldError.checkNotNull(name, r'UserEvent', 'name');
    BuiltValueNullFieldError.checkNotNull(link, r'UserEvent', 'link');
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
        patientToken == other.patientToken &&
        patient == other.patient &&
        healer == other.healer &&
        room == other.room &&
        office == other.office &&
        isUrgent == other.isUrgent &&
        isHealerPresent == other.isHealerPresent &&
        isPatientPresent == other.isPatientPresent &&
        isCancelled == other.isCancelled &&
        type == other.type &&
        createdAt == other.createdAt &&
        start == other.start &&
        end == other.end &&
        name == other.name &&
        description == other.description &&
        cancelledDescription == other.cancelledDescription &&
        link == other.link;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            0,
                                                                            id
                                                                                .hashCode),
                                                                        patientToken
                                                                            .hashCode),
                                                                    patient
                                                                        .hashCode),
                                                                healer
                                                                    .hashCode),
                                                            room.hashCode),
                                                        office.hashCode),
                                                    isUrgent.hashCode),
                                                isHealerPresent.hashCode),
                                            isPatientPresent.hashCode),
                                        isCancelled.hashCode),
                                    type.hashCode),
                                createdAt.hashCode),
                            start.hashCode),
                        end.hashCode),
                    name.hashCode),
                description.hashCode),
            cancelledDescription.hashCode),
        link.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserEvent')
          ..add('id', id)
          ..add('patientToken', patientToken)
          ..add('patient', patient)
          ..add('healer', healer)
          ..add('room', room)
          ..add('office', office)
          ..add('isUrgent', isUrgent)
          ..add('isHealerPresent', isHealerPresent)
          ..add('isPatientPresent', isPatientPresent)
          ..add('isCancelled', isCancelled)
          ..add('type', type)
          ..add('createdAt', createdAt)
          ..add('start', start)
          ..add('end', end)
          ..add('name', name)
          ..add('description', description)
          ..add('cancelledDescription', cancelledDescription)
          ..add('link', link))
        .toString();
  }
}

class UserEventBuilder implements Builder<UserEvent, UserEventBuilder> {
  _$UserEvent? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _patientToken;
  String? get patientToken => _$this._patientToken;
  set patientToken(String? patientToken) => _$this._patientToken = patientToken;

  MinimalUserBuilder? _patient;
  MinimalUserBuilder get patient =>
      _$this._patient ??= new MinimalUserBuilder();
  set patient(MinimalUserBuilder? patient) => _$this._patient = patient;

  HealerBuilder? _healer;
  HealerBuilder get healer => _$this._healer ??= new HealerBuilder();
  set healer(HealerBuilder? healer) => _$this._healer = healer;

  OfficeRoomBuilder? _room;
  OfficeRoomBuilder get room => _$this._room ??= new OfficeRoomBuilder();
  set room(OfficeRoomBuilder? room) => _$this._room = room;

  OfficeBuilder? _office;
  OfficeBuilder get office => _$this._office ??= new OfficeBuilder();
  set office(OfficeBuilder? office) => _$this._office = office;

  bool? _isUrgent;
  bool? get isUrgent => _$this._isUrgent;
  set isUrgent(bool? isUrgent) => _$this._isUrgent = isUrgent;

  bool? _isHealerPresent;
  bool? get isHealerPresent => _$this._isHealerPresent;
  set isHealerPresent(bool? isHealerPresent) =>
      _$this._isHealerPresent = isHealerPresent;

  bool? _isPatientPresent;
  bool? get isPatientPresent => _$this._isPatientPresent;
  set isPatientPresent(bool? isPatientPresent) =>
      _$this._isPatientPresent = isPatientPresent;

  bool? _isCancelled;
  bool? get isCancelled => _$this._isCancelled;
  set isCancelled(bool? isCancelled) => _$this._isCancelled = isCancelled;

  HealerEventType? _type;
  HealerEventType? get type => _$this._type;
  set type(HealerEventType? type) => _$this._type = type;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

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

  String? _cancelledDescription;
  String? get cancelledDescription => _$this._cancelledDescription;
  set cancelledDescription(String? cancelledDescription) =>
      _$this._cancelledDescription = cancelledDescription;

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
      _patientToken = $v.patientToken;
      _patient = $v.patient.toBuilder();
      _healer = $v.healer.toBuilder();
      _room = $v.room?.toBuilder();
      _office = $v.office?.toBuilder();
      _isUrgent = $v.isUrgent;
      _isHealerPresent = $v.isHealerPresent;
      _isPatientPresent = $v.isPatientPresent;
      _isCancelled = $v.isCancelled;
      _type = $v.type;
      _createdAt = $v.createdAt;
      _start = $v.start;
      _end = $v.end;
      _name = $v.name;
      _description = $v.description;
      _cancelledDescription = $v.cancelledDescription;
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
  UserEvent build() => _build();

  _$UserEvent _build() {
    _$UserEvent _$result;
    try {
      _$result = _$v ??
          new _$UserEvent._(
              id: BuiltValueNullFieldError.checkNotNull(id, r'UserEvent', 'id'),
              patientToken: patientToken,
              patient: patient.build(),
              healer: healer.build(),
              room: _room?.build(),
              office: _office?.build(),
              isUrgent: BuiltValueNullFieldError.checkNotNull(
                  isUrgent, r'UserEvent', 'isUrgent'),
              isHealerPresent: BuiltValueNullFieldError.checkNotNull(
                  isHealerPresent, r'UserEvent', 'isHealerPresent'),
              isPatientPresent: BuiltValueNullFieldError.checkNotNull(
                  isPatientPresent, r'UserEvent', 'isPatientPresent'),
              isCancelled: BuiltValueNullFieldError.checkNotNull(
                  isCancelled, r'UserEvent', 'isCancelled'),
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'UserEvent', 'type'),
              createdAt: BuiltValueNullFieldError.checkNotNull(
                  createdAt, r'UserEvent', 'createdAt'),
              start: BuiltValueNullFieldError.checkNotNull(
                  start, r'UserEvent', 'start'),
              end: BuiltValueNullFieldError.checkNotNull(
                  end, r'UserEvent', 'end'),
              name:
                  BuiltValueNullFieldError.checkNotNull(name, r'UserEvent', 'name'),
              description: description,
              cancelledDescription: cancelledDescription,
              link: BuiltValueNullFieldError.checkNotNull(link, r'UserEvent', 'link'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'patient';
        patient.build();
        _$failedField = 'healer';
        healer.build();
        _$failedField = 'room';
        _room?.build();
        _$failedField = 'office';
        _office?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'UserEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
