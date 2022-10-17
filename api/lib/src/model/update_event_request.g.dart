// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_event_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateEventRequest extends UpdateEventRequest {
  @override
  final DateTime start;
  @override
  final String? message;

  factory _$UpdateEventRequest(
          [void Function(UpdateEventRequestBuilder)? updates]) =>
      (new UpdateEventRequestBuilder()..update(updates))._build();

  _$UpdateEventRequest._({required this.start, this.message}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        start, r'UpdateEventRequest', 'start');
  }

  @override
  UpdateEventRequest rebuild(
          void Function(UpdateEventRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateEventRequestBuilder toBuilder() =>
      new UpdateEventRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateEventRequest &&
        start == other.start &&
        message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, start.hashCode), message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateEventRequest')
          ..add('start', start)
          ..add('message', message))
        .toString();
  }
}

class UpdateEventRequestBuilder
    implements Builder<UpdateEventRequest, UpdateEventRequestBuilder> {
  _$UpdateEventRequest? _$v;

  DateTime? _start;
  DateTime? get start => _$this._start;
  set start(DateTime? start) => _$this._start = start;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  UpdateEventRequestBuilder() {
    UpdateEventRequest._defaults(this);
  }

  UpdateEventRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _start = $v.start;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateEventRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UpdateEventRequest;
  }

  @override
  void update(void Function(UpdateEventRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateEventRequest build() => _build();

  _$UpdateEventRequest _build() {
    final _$result = _$v ??
        new _$UpdateEventRequest._(
            start: BuiltValueNullFieldError.checkNotNull(
                start, r'UpdateEventRequest', 'start'),
            message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
