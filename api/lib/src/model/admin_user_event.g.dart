// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminUserEvent extends AdminUserEvent {
  @override
  final String id;
  @override
  final User patient;
  @override
  final User healer;
  @override
  final bool isHealerPresent;
  @override
  final bool isPatientPresent;
  @override
  final bool isUrgent;
  @override
  final bool isCancelled;
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

  factory _$AdminUserEvent([void Function(AdminUserEventBuilder)? updates]) =>
      (new AdminUserEventBuilder()..update(updates))._build();

  _$AdminUserEvent._(
      {required this.id,
      required this.patient,
      required this.healer,
      required this.isHealerPresent,
      required this.isPatientPresent,
      required this.isUrgent,
      required this.isCancelled,
      required this.createdAt,
      required this.start,
      required this.end,
      required this.name,
      this.description,
      this.cancelledDescription,
      required this.link})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'AdminUserEvent', 'id');
    BuiltValueNullFieldError.checkNotNull(
        patient, r'AdminUserEvent', 'patient');
    BuiltValueNullFieldError.checkNotNull(healer, r'AdminUserEvent', 'healer');
    BuiltValueNullFieldError.checkNotNull(
        isHealerPresent, r'AdminUserEvent', 'isHealerPresent');
    BuiltValueNullFieldError.checkNotNull(
        isPatientPresent, r'AdminUserEvent', 'isPatientPresent');
    BuiltValueNullFieldError.checkNotNull(
        isUrgent, r'AdminUserEvent', 'isUrgent');
    BuiltValueNullFieldError.checkNotNull(
        isCancelled, r'AdminUserEvent', 'isCancelled');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'AdminUserEvent', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(start, r'AdminUserEvent', 'start');
    BuiltValueNullFieldError.checkNotNull(end, r'AdminUserEvent', 'end');
    BuiltValueNullFieldError.checkNotNull(name, r'AdminUserEvent', 'name');
    BuiltValueNullFieldError.checkNotNull(link, r'AdminUserEvent', 'link');
  }

  @override
  AdminUserEvent rebuild(void Function(AdminUserEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdminUserEventBuilder toBuilder() =>
      new AdminUserEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminUserEvent &&
        id == other.id &&
        patient == other.patient &&
        healer == other.healer &&
        isHealerPresent == other.isHealerPresent &&
        isPatientPresent == other.isPatientPresent &&
        isUrgent == other.isUrgent &&
        isCancelled == other.isCancelled &&
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
                                                    $jc($jc(0, id.hashCode),
                                                        patient.hashCode),
                                                    healer.hashCode),
                                                isHealerPresent.hashCode),
                                            isPatientPresent.hashCode),
                                        isUrgent.hashCode),
                                    isCancelled.hashCode),
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
    return (newBuiltValueToStringHelper(r'AdminUserEvent')
          ..add('id', id)
          ..add('patient', patient)
          ..add('healer', healer)
          ..add('isHealerPresent', isHealerPresent)
          ..add('isPatientPresent', isPatientPresent)
          ..add('isUrgent', isUrgent)
          ..add('isCancelled', isCancelled)
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

class AdminUserEventBuilder
    implements Builder<AdminUserEvent, AdminUserEventBuilder> {
  _$AdminUserEvent? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  UserBuilder? _patient;
  UserBuilder get patient => _$this._patient ??= new UserBuilder();
  set patient(UserBuilder? patient) => _$this._patient = patient;

  UserBuilder? _healer;
  UserBuilder get healer => _$this._healer ??= new UserBuilder();
  set healer(UserBuilder? healer) => _$this._healer = healer;

  bool? _isHealerPresent;
  bool? get isHealerPresent => _$this._isHealerPresent;
  set isHealerPresent(bool? isHealerPresent) =>
      _$this._isHealerPresent = isHealerPresent;

  bool? _isPatientPresent;
  bool? get isPatientPresent => _$this._isPatientPresent;
  set isPatientPresent(bool? isPatientPresent) =>
      _$this._isPatientPresent = isPatientPresent;

  bool? _isUrgent;
  bool? get isUrgent => _$this._isUrgent;
  set isUrgent(bool? isUrgent) => _$this._isUrgent = isUrgent;

  bool? _isCancelled;
  bool? get isCancelled => _$this._isCancelled;
  set isCancelled(bool? isCancelled) => _$this._isCancelled = isCancelled;

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

  AdminUserEventBuilder() {
    AdminUserEvent._defaults(this);
  }

  AdminUserEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _patient = $v.patient.toBuilder();
      _healer = $v.healer.toBuilder();
      _isHealerPresent = $v.isHealerPresent;
      _isPatientPresent = $v.isPatientPresent;
      _isUrgent = $v.isUrgent;
      _isCancelled = $v.isCancelled;
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
  void replace(AdminUserEvent other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AdminUserEvent;
  }

  @override
  void update(void Function(AdminUserEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminUserEvent build() => _build();

  _$AdminUserEvent _build() {
    _$AdminUserEvent _$result;
    try {
      _$result = _$v ??
          new _$AdminUserEvent._(
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'AdminUserEvent', 'id'),
              patient: patient.build(),
              healer: healer.build(),
              isHealerPresent: BuiltValueNullFieldError.checkNotNull(
                  isHealerPresent, r'AdminUserEvent', 'isHealerPresent'),
              isPatientPresent: BuiltValueNullFieldError.checkNotNull(
                  isPatientPresent, r'AdminUserEvent', 'isPatientPresent'),
              isUrgent: BuiltValueNullFieldError.checkNotNull(
                  isUrgent, r'AdminUserEvent', 'isUrgent'),
              isCancelled: BuiltValueNullFieldError.checkNotNull(
                  isCancelled, r'AdminUserEvent', 'isCancelled'),
              createdAt: BuiltValueNullFieldError.checkNotNull(
                  createdAt, r'AdminUserEvent', 'createdAt'),
              start: BuiltValueNullFieldError.checkNotNull(
                  start, r'AdminUserEvent', 'start'),
              end: BuiltValueNullFieldError.checkNotNull(
                  end, r'AdminUserEvent', 'end'),
              name: BuiltValueNullFieldError.checkNotNull(name, r'AdminUserEvent', 'name'),
              description: description,
              cancelledDescription: cancelledDescription,
              link: BuiltValueNullFieldError.checkNotNull(link, r'AdminUserEvent', 'link'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'patient';
        patient.build();
        _$failedField = 'healer';
        healer.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AdminUserEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
