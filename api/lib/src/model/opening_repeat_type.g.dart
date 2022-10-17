// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_repeat_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OpeningRepeatType _$daily = const OpeningRepeatType._('daily');
const OpeningRepeatType _$weekly = const OpeningRepeatType._('weekly');
const OpeningRepeatType _$monthly = const OpeningRepeatType._('monthly');

OpeningRepeatType _$valueOf(String name) {
  switch (name) {
    case 'daily':
      return _$daily;
    case 'weekly':
      return _$weekly;
    case 'monthly':
      return _$monthly;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<OpeningRepeatType> _$values =
    new BuiltSet<OpeningRepeatType>(const <OpeningRepeatType>[
  _$daily,
  _$weekly,
  _$monthly,
]);

class _$OpeningRepeatTypeMeta {
  const _$OpeningRepeatTypeMeta();
  OpeningRepeatType get daily => _$daily;
  OpeningRepeatType get weekly => _$weekly;
  OpeningRepeatType get monthly => _$monthly;
  OpeningRepeatType valueOf(String name) => _$valueOf(name);
  BuiltSet<OpeningRepeatType> get values => _$values;
}

abstract class _$OpeningRepeatTypeMixin {
  // ignore: non_constant_identifier_names
  _$OpeningRepeatTypeMeta get OpeningRepeatType =>
      const _$OpeningRepeatTypeMeta();
}

Serializer<OpeningRepeatType> _$openingRepeatTypeSerializer =
    new _$OpeningRepeatTypeSerializer();

class _$OpeningRepeatTypeSerializer
    implements PrimitiveSerializer<OpeningRepeatType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'daily': 'daily',
    'weekly': 'weekly',
    'monthly': 'monthly',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'daily': 'daily',
    'weekly': 'weekly',
    'monthly': 'monthly',
  };

  @override
  final Iterable<Type> types = const <Type>[OpeningRepeatType];
  @override
  final String wireName = 'OpeningRepeatType';

  @override
  Object serialize(Serializers serializers, OpeningRepeatType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OpeningRepeatType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OpeningRepeatType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
