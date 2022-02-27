// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_email.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserEmail extends UserEmail {
  @override
  final String email;

  factory _$UserEmail([void Function(UserEmailBuilder)? updates]) =>
      (new UserEmailBuilder()..update(updates)).build();

  _$UserEmail._({required this.email}) : super._() {
    BuiltValueNullFieldError.checkNotNull(email, 'UserEmail', 'email');
  }

  @override
  UserEmail rebuild(void Function(UserEmailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserEmailBuilder toBuilder() => new UserEmailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserEmail && email == other.email;
  }

  @override
  int get hashCode {
    return $jf($jc(0, email.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserEmail')..add('email', email))
        .toString();
  }
}

class UserEmailBuilder implements Builder<UserEmail, UserEmailBuilder> {
  _$UserEmail? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  UserEmailBuilder() {
    UserEmail._defaults(this);
  }

  UserEmailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserEmail other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserEmail;
  }

  @override
  void update(void Function(UserEmailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserEmail build() {
    final _$result = _$v ??
        new _$UserEmail._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, 'UserEmail', 'email'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
