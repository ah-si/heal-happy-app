// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_event_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateEventRequest extends CreateEventRequest {
  @override
  final DateTime slot;
  @override
  final String? roomId;
  @override
  final bool? isUrgent;
  @override
  final String patientId;
  @override
  final HealerEventType? type;
  @override
  final String? message;

  factory _$CreateEventRequest(
          [void Function(CreateEventRequestBuilder)? updates]) =>
      (new CreateEventRequestBuilder()..update(updates)).build();

  _$CreateEventRequest._(
      {required this.slot,
      this.roomId,
      this.isUrgent,
      required this.patientId,
      this.type,
      this.message})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(slot, 'CreateEventRequest', 'slot');
    BuiltValueNullFieldError.checkNotNull(
        patientId, 'CreateEventRequest', 'patientId');
  }

  @override
  CreateEventRequest rebuild(
          void Function(CreateEventRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateEventRequestBuilder toBuilder() =>
      new CreateEventRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateEventRequest &&
        slot == other.slot &&
        roomId == other.roomId &&
        isUrgent == other.isUrgent &&
        patientId == other.patientId &&
        type == other.type &&
        message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, slot.hashCode), roomId.hashCode),
                    isUrgent.hashCode),
                patientId.hashCode),
            type.hashCode),
        message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CreateEventRequest')
          ..add('slot', slot)
          ..add('roomId', roomId)
          ..add('isUrgent', isUrgent)
          ..add('patientId', patientId)
          ..add('type', type)
          ..add('message', message))
        .toString();
  }
}

class CreateEventRequestBuilder
    implements Builder<CreateEventRequest, CreateEventRequestBuilder> {
  _$CreateEventRequest? _$v;

  DateTime? _slot;
  DateTime? get slot => _$this._slot;
  set slot(DateTime? slot) => _$this._slot = slot;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  bool? _isUrgent;
  bool? get isUrgent => _$this._isUrgent;
  set isUrgent(bool? isUrgent) => _$this._isUrgent = isUrgent;

  String? _patientId;
  String? get patientId => _$this._patientId;
  set patientId(String? patientId) => _$this._patientId = patientId;

  HealerEventType? _type;
  HealerEventType? get type => _$this._type;
  set type(HealerEventType? type) => _$this._type = type;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  CreateEventRequestBuilder() {
    CreateEventRequest._defaults(this);
  }

  CreateEventRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _slot = $v.slot;
      _roomId = $v.roomId;
      _isUrgent = $v.isUrgent;
      _patientId = $v.patientId;
      _type = $v.type;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateEventRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreateEventRequest;
  }

  @override
  void update(void Function(CreateEventRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CreateEventRequest build() {
    final _$result = _$v ??
        new _$CreateEventRequest._(
            slot: BuiltValueNullFieldError.checkNotNull(
                slot, 'CreateEventRequest', 'slot'),
            roomId: roomId,
            isUrgent: isUrgent,
            patientId: BuiltValueNullFieldError.checkNotNull(
                patientId, 'CreateEventRequest', 'patientId'),
            type: type,
            message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
