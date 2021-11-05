// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_event_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateEventRequest extends CreateEventRequest {
  @override
  final DateTime slot;
  @override
  final String patientId;
  @override
  final String? message;

  factory _$CreateEventRequest(
          [void Function(CreateEventRequestBuilder)? updates]) =>
      (new CreateEventRequestBuilder()..update(updates)).build();

  _$CreateEventRequest._(
      {required this.slot, required this.patientId, this.message})
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
        patientId == other.patientId &&
        message == other.message;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, slot.hashCode), patientId.hashCode), message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CreateEventRequest')
          ..add('slot', slot)
          ..add('patientId', patientId)
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

  String? _patientId;
  String? get patientId => _$this._patientId;
  set patientId(String? patientId) => _$this._patientId = patientId;

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
      _patientId = $v.patientId;
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
            patientId: BuiltValueNullFieldError.checkNotNull(
                patientId, 'CreateEventRequest', 'patientId'),
            message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
