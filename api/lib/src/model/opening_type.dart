//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'opening_type.g.dart';

class OpeningType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'visio')
  static const OpeningType visio = _$visio;
  @BuiltValueEnumConst(wireName: r'faceToFace')
  static const OpeningType faceToFace = _$faceToFace;
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const OpeningType unavailable = _$unavailable;

  static Serializer<OpeningType> get serializer => _$openingTypeSerializer;

  const OpeningType._(String name): super(name);

  static BuiltSet<OpeningType> get values => _$values;
  static OpeningType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class OpeningTypeMixin = Object with _$OpeningTypeMixin;

