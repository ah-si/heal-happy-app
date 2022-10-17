// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ask_reset_password.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AskResetPassword extends AskResetPassword {
  @override
  final String email;

  factory _$AskResetPassword(
          [void Function(AskResetPasswordBuilder)? updates]) =>
      (new AskResetPasswordBuilder()..update(updates))._build();

  _$AskResetPassword._({required this.email}) : super._() {
    BuiltValueNullFieldError.checkNotNull(email, r'AskResetPassword', 'email');
  }

  @override
  AskResetPassword rebuild(void Function(AskResetPasswordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AskResetPasswordBuilder toBuilder() =>
      new AskResetPasswordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AskResetPassword && email == other.email;
  }

  @override
  int get hashCode {
    return $jf($jc(0, email.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AskResetPassword')
          ..add('email', email))
        .toString();
  }
}

class AskResetPasswordBuilder
    implements Builder<AskResetPassword, AskResetPasswordBuilder> {
  _$AskResetPassword? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  AskResetPasswordBuilder() {
    AskResetPassword._defaults(this);
  }

  AskResetPasswordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AskResetPassword other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AskResetPassword;
  }

  @override
  void update(void Function(AskResetPasswordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AskResetPassword build() => _build();

  _$AskResetPassword _build() {
    final _$result = _$v ??
        new _$AskResetPassword._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'AskResetPassword', 'email'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
