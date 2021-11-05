// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_all_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserAllOf extends UserAllOf {
  @override
  final String? id;
  @override
  final String? email;
  @override
  final String? mobile;
  @override
  final String? password;

  factory _$UserAllOf([void Function(UserAllOfBuilder)? updates]) =>
      (new UserAllOfBuilder()..update(updates)).build();

  _$UserAllOf._({this.id, this.email, this.mobile, this.password}) : super._();

  @override
  UserAllOf rebuild(void Function(UserAllOfBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserAllOfBuilder toBuilder() => new UserAllOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserAllOf &&
        id == other.id &&
        email == other.email &&
        mobile == other.mobile &&
        password == other.password;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), email.hashCode), mobile.hashCode),
        password.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserAllOf')
          ..add('id', id)
          ..add('email', email)
          ..add('mobile', mobile)
          ..add('password', password))
        .toString();
  }
}

class UserAllOfBuilder implements Builder<UserAllOf, UserAllOfBuilder> {
  _$UserAllOf? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _mobile;
  String? get mobile => _$this._mobile;
  set mobile(String? mobile) => _$this._mobile = mobile;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  UserAllOfBuilder() {
    UserAllOf._defaults(this);
  }

  UserAllOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _email = $v.email;
      _mobile = $v.mobile;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserAllOf other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserAllOf;
  }

  @override
  void update(void Function(UserAllOfBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserAllOf build() {
    final _$result = _$v ??
        new _$UserAllOf._(
            id: id, email: email, mobile: mobile, password: password);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
