// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_invite_event_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateInviteEventRequest extends CreateInviteEventRequest {
  @override
  final DateTime? slot;
  @override
  final String email;
  @override
  final HealerEventType type;
  @override
  final String? message;

  factory _$CreateInviteEventRequest(
          [void Function(CreateInviteEventRequestBuilder)? updates]) =>
      (new CreateInviteEventRequestBuilder()..update(updates)).build();

  _$CreateInviteEventRequest._(
      {this.slot, required this.email, required this.type, this.message})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        email, 'CreateInviteEventRequest', 'email');
    BuiltValueNullFieldError.checkNotNull(
        type, 'CreateInviteEventRequest', 'type');
  }

  @override
  CreateInviteEventRequest rebuild(
          void Function(CreateInviteEventRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateInviteEventRequestBuilder toBuilder() =>
      new CreateInviteEventRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateInviteEventRequest &&
        slot == other.slot &&
        email == other.email &&
        type == other.type &&
        message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, slot.hashCode), email.hashCode), type.hashCode),
        message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CreateInviteEventRequest')
          ..add('slot', slot)
          ..add('email', email)
          ..add('type', type)
          ..add('message', message))
        .toString();
  }
}

class CreateInviteEventRequestBuilder
    implements
        Builder<CreateInviteEventRequest, CreateInviteEventRequestBuilder> {
  _$CreateInviteEventRequest? _$v;

  DateTime? _slot;
  DateTime? get slot => _$this._slot;
  set slot(DateTime? slot) => _$this._slot = slot;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  HealerEventType? _type;
  HealerEventType? get type => _$this._type;
  set type(HealerEventType? type) => _$this._type = type;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  CreateInviteEventRequestBuilder() {
    CreateInviteEventRequest._defaults(this);
  }

  CreateInviteEventRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _slot = $v.slot;
      _email = $v.email;
      _type = $v.type;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateInviteEventRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreateInviteEventRequest;
  }

  @override
  void update(void Function(CreateInviteEventRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CreateInviteEventRequest build() {
    final _$result = _$v ??
        new _$CreateInviteEventRequest._(
            slot: slot,
            email: BuiltValueNullFieldError.checkNotNull(
                email, 'CreateInviteEventRequest', 'email'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, 'CreateInviteEventRequest', 'type'),
            message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
