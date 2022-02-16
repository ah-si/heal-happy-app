// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'healer_event_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HealerEventType _$visio = const HealerEventType._('visio');
const HealerEventType _$faceToFace = const HealerEventType._('faceToFace');

HealerEventType _$valueOf(String name) {
  switch (name) {
    case 'visio':
      return _$visio;
    case 'faceToFace':
      return _$faceToFace;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<HealerEventType> _$values =
    new BuiltSet<HealerEventType>(const <HealerEventType>[
  _$visio,
  _$faceToFace,
]);

class _$HealerEventTypeMeta {
  const _$HealerEventTypeMeta();
  HealerEventType get visio => _$visio;
  HealerEventType get faceToFace => _$faceToFace;
  HealerEventType valueOf(String name) => _$valueOf(name);
  BuiltSet<HealerEventType> get values => _$values;
}

abstract class _$HealerEventTypeMixin {
  // ignore: non_constant_identifier_names
  _$HealerEventTypeMeta get HealerEventType => const _$HealerEventTypeMeta();
}

Serializer<HealerEventType> _$healerEventTypeSerializer =
    new _$HealerEventTypeSerializer();

class _$HealerEventTypeSerializer
    implements PrimitiveSerializer<HealerEventType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'visio': 'visio',
    'faceToFace': 'faceToFace',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'visio': 'visio',
    'faceToFace': 'faceToFace',
  };

  @override
  final Iterable<Type> types = const <Type>[HealerEventType];
  @override
  final String wireName = 'HealerEventType';

  @override
  Object serialize(Serializers serializers, HealerEventType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  HealerEventType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      HealerEventType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
