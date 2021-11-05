// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResetPassword extends ResetPassword {
  @override
  final String password;
  @override
  final String? token;

  factory _$ResetPassword([void Function(ResetPasswordBuilder)? updates]) =>
      (new ResetPasswordBuilder()..update(updates)).build();

  _$ResetPassword._({required this.password, this.token}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        password, 'ResetPassword', 'password');
  }

  @override
  ResetPassword rebuild(void Function(ResetPasswordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResetPasswordBuilder toBuilder() => new ResetPasswordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResetPassword &&
        password == other.password &&
        token == other.token;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, password.hashCode), token.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ResetPassword')
          ..add('password', password)
          ..add('token', token))
        .toString();
  }
}

class ResetPasswordBuilder
    implements Builder<ResetPassword, ResetPasswordBuilder> {
  _$ResetPassword? _$v;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  ResetPasswordBuilder() {
    ResetPassword._defaults(this);
  }

  ResetPasswordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _password = $v.password;
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResetPassword other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ResetPassword;
  }

  @override
  void update(void Function(ResetPasswordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ResetPassword build() {
    final _$result = _$v ??
        new _$ResetPassword._(
            password: BuiltValueNullFieldError.checkNotNull(
                password, 'ResetPassword', 'password'),
            token: token);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
