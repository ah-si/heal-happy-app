// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_event_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeleteEventRequest extends DeleteEventRequest {
  @override
  final String? message;

  factory _$DeleteEventRequest(
          [void Function(DeleteEventRequestBuilder)? updates]) =>
      (new DeleteEventRequestBuilder()..update(updates)).build();

  _$DeleteEventRequest._({this.message}) : super._();

  @override
  DeleteEventRequest rebuild(
          void Function(DeleteEventRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteEventRequestBuilder toBuilder() =>
      new DeleteEventRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteEventRequest && message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc(0, message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DeleteEventRequest')
          ..add('message', message))
        .toString();
  }
}

class DeleteEventRequestBuilder
    implements Builder<DeleteEventRequest, DeleteEventRequestBuilder> {
  _$DeleteEventRequest? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  DeleteEventRequestBuilder() {
    DeleteEventRequest._defaults(this);
  }

  DeleteEventRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteEventRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DeleteEventRequest;
  }

  @override
  void update(void Function(DeleteEventRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DeleteEventRequest build() {
    final _$result = _$v ?? new _$DeleteEventRequest._(message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
