// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_type_enum.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserTypeEnum _$admin = const UserTypeEnum._('admin');
const UserTypeEnum _$patient = const UserTypeEnum._('patient');
const UserTypeEnum _$healer = const UserTypeEnum._('healer');

UserTypeEnum _$valueOf(String name) {
  switch (name) {
    case 'admin':
      return _$admin;
    case 'patient':
      return _$patient;
    case 'healer':
      return _$healer;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<UserTypeEnum> _$values =
    new BuiltSet<UserTypeEnum>(const <UserTypeEnum>[
  _$admin,
  _$patient,
  _$healer,
]);

class _$UserTypeEnumMeta {
  const _$UserTypeEnumMeta();
  UserTypeEnum get admin => _$admin;
  UserTypeEnum get patient => _$patient;
  UserTypeEnum get healer => _$healer;
  UserTypeEnum valueOf(String name) => _$valueOf(name);
  BuiltSet<UserTypeEnum> get values => _$values;
}

abstract class _$UserTypeEnumMixin {
  // ignore: non_constant_identifier_names
  _$UserTypeEnumMeta get UserTypeEnum => const _$UserTypeEnumMeta();
}

Serializer<UserTypeEnum> _$userTypeEnumSerializer =
    new _$UserTypeEnumSerializer();

class _$UserTypeEnumSerializer implements PrimitiveSerializer<UserTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'admin': 'admin',
    'patient': 'patient',
    'healer': 'healer',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'admin': 'admin',
    'patient': 'patient',
    'healer': 'healer',
  };

  @override
  final Iterable<Type> types = const <Type>[UserTypeEnum];
  @override
  final String wireName = 'UserTypeEnum';

  @override
  Object serialize(Serializers serializers, UserTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UserTypeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
