// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OpeningType _$visio = const OpeningType._('visio');
const OpeningType _$faceToFace = const OpeningType._('faceToFace');
const OpeningType _$unavailable = const OpeningType._('unavailable');

OpeningType _$valueOf(String name) {
  switch (name) {
    case 'visio':
      return _$visio;
    case 'faceToFace':
      return _$faceToFace;
    case 'unavailable':
      return _$unavailable;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<OpeningType> _$values =
    new BuiltSet<OpeningType>(const <OpeningType>[
  _$visio,
  _$faceToFace,
  _$unavailable,
]);

class _$OpeningTypeMeta {
  const _$OpeningTypeMeta();
  OpeningType get visio => _$visio;
  OpeningType get faceToFace => _$faceToFace;
  OpeningType get unavailable => _$unavailable;
  OpeningType valueOf(String name) => _$valueOf(name);
  BuiltSet<OpeningType> get values => _$values;
}

abstract class _$OpeningTypeMixin {
  // ignore: non_constant_identifier_names
  _$OpeningTypeMeta get OpeningType => const _$OpeningTypeMeta();
}

Serializer<OpeningType> _$openingTypeSerializer = new _$OpeningTypeSerializer();

class _$OpeningTypeSerializer implements PrimitiveSerializer<OpeningType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'visio': 'visio',
    'faceToFace': 'faceToFace',
    'unavailable': 'unavailable',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'visio': 'visio',
    'faceToFace': 'faceToFace',
    'unavailable': 'unavailable',
  };

  @override
  final Iterable<Type> types = const <Type>[OpeningType];
  @override
  final String wireName = 'OpeningType';

  @override
  Object serialize(Serializers serializers, OpeningType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OpeningType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OpeningType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
