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
      (new AdminUserEventBuilder()..update(updates)).build();

  _$AdminUserEvent._(
      {required this.id,
      required this.patient,
      required this.healer,
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
    BuiltValueNullFieldError.checkNotNull(id, 'AdminUserEvent', 'id');
    BuiltValueNullFieldError.checkNotNull(patient, 'AdminUserEvent', 'patient');
    BuiltValueNullFieldError.checkNotNull(healer, 'AdminUserEvent', 'healer');
    BuiltValueNullFieldError.checkNotNull(
        isUrgent, 'AdminUserEvent', 'isUrgent');
    BuiltValueNullFieldError.checkNotNull(
        isCancelled, 'AdminUserEvent', 'isCancelled');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'AdminUserEvent', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(start, 'AdminUserEvent', 'start');
    BuiltValueNullFieldError.checkNotNull(end, 'AdminUserEvent', 'end');
    BuiltValueNullFieldError.checkNotNull(name, 'AdminUserEvent', 'name');
    BuiltValueNullFieldError.checkNotNull(link, 'AdminUserEvent', 'link');
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
                                            $jc($jc(0, id.hashCode),
                                                patient.hashCode),
                                            healer.hashCode),
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
    return (newBuiltValueToStringHelper('AdminUserEvent')
          ..add('id', id)
          ..add('patient', patient)
          ..add('healer', healer)
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
  _$AdminUserEvent build() {
    _$AdminUserEvent _$result;
    try {
      _$result = _$v ??
          new _$AdminUserEvent._(
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'AdminUserEvent', 'id'),
              patient: patient.build(),
              healer: healer.build(),
              isUrgent: BuiltValueNullFieldError.checkNotNull(
                  isUrgent, 'AdminUserEvent', 'isUrgent'),
              isCancelled: BuiltValueNullFieldError.checkNotNull(
                  isCancelled, 'AdminUserEvent', 'isCancelled'),
              createdAt: BuiltValueNullFieldError.checkNotNull(
                  createdAt, 'AdminUserEvent', 'createdAt'),
              start: BuiltValueNullFieldError.checkNotNull(
                  start, 'AdminUserEvent', 'start'),
              end: BuiltValueNullFieldError.checkNotNull(
                  end, 'AdminUserEvent', 'end'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, 'AdminUserEvent', 'name'),
              description: description,
              cancelledDescription: cancelledDescription,
              link: BuiltValueNullFieldError.checkNotNull(
                  link, 'AdminUserEvent', 'link'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'patient';
        patient.build();
        _$failedField = 'healer';
        healer.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AdminUserEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
