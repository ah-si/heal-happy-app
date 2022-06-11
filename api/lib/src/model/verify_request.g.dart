// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VerifyRequest extends VerifyRequest {
  @override
  final bool isVerified;

  factory _$VerifyRequest([void Function(VerifyRequestBuilder)? updates]) =>
      (new VerifyRequestBuilder()..update(updates)).build();

  _$VerifyRequest._({required this.isVerified}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        isVerified, 'VerifyRequest', 'isVerified');
  }

  @override
  VerifyRequest rebuild(void Function(VerifyRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerifyRequestBuilder toBuilder() => new VerifyRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyRequest && isVerified == other.isVerified;
  }

  @override
  int get hashCode {
    return $jf($jc(0, isVerified.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('VerifyRequest')
          ..add('isVerified', isVerified))
        .toString();
  }
}

class VerifyRequestBuilder
    implements Builder<VerifyRequest, VerifyRequestBuilder> {
  _$VerifyRequest? _$v;

  bool? _isVerified;
  bool? get isVerified => _$this._isVerified;
  set isVerified(bool? isVerified) => _$this._isVerified = isVerified;

  VerifyRequestBuilder() {
    VerifyRequest._defaults(this);
  }

  VerifyRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isVerified = $v.isVerified;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerifyRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VerifyRequest;
  }

  @override
  void update(void Function(VerifyRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$VerifyRequest build() {
    final _$result = _$v ??
        new _$VerifyRequest._(
            isVerified: BuiltValueNullFieldError.checkNotNull(
                isVerified, 'VerifyRequest', 'isVerified'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
