// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minimal_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MinimalUser extends MinimalUser {
  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String mobile;
  @override
  final String email;

  factory _$MinimalUser([void Function(MinimalUserBuilder)? updates]) =>
      (new MinimalUserBuilder()..update(updates)).build();

  _$MinimalUser._(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.mobile,
      required this.email})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'MinimalUser', 'id');
    BuiltValueNullFieldError.checkNotNull(
        firstName, 'MinimalUser', 'firstName');
    BuiltValueNullFieldError.checkNotNull(lastName, 'MinimalUser', 'lastName');
    BuiltValueNullFieldError.checkNotNull(mobile, 'MinimalUser', 'mobile');
    BuiltValueNullFieldError.checkNotNull(email, 'MinimalUser', 'email');
  }

  @override
  MinimalUser rebuild(void Function(MinimalUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MinimalUserBuilder toBuilder() => new MinimalUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MinimalUser &&
        id == other.id &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        mobile == other.mobile &&
        email == other.email;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, id.hashCode), firstName.hashCode),
                lastName.hashCode),
            mobile.hashCode),
        email.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MinimalUser')
          ..add('id', id)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('mobile', mobile)
          ..add('email', email))
        .toString();
  }
}

class MinimalUserBuilder implements Builder<MinimalUser, MinimalUserBuilder> {
  _$MinimalUser? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _mobile;
  String? get mobile => _$this._mobile;
  set mobile(String? mobile) => _$this._mobile = mobile;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  MinimalUserBuilder() {
    MinimalUser._defaults(this);
  }

  MinimalUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _mobile = $v.mobile;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MinimalUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MinimalUser;
  }

  @override
  void update(void Function(MinimalUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MinimalUser build() {
    final _$result = _$v ??
        new _$MinimalUser._(
            id: BuiltValueNullFieldError.checkNotNull(id, 'MinimalUser', 'id'),
            firstName: BuiltValueNullFieldError.checkNotNull(
                firstName, 'MinimalUser', 'firstName'),
            lastName: BuiltValueNullFieldError.checkNotNull(
                lastName, 'MinimalUser', 'lastName'),
            mobile: BuiltValueNullFieldError.checkNotNull(
                mobile, 'MinimalUser', 'mobile'),
            email: BuiltValueNullFieldError.checkNotNull(
                email, 'MinimalUser', 'email'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
