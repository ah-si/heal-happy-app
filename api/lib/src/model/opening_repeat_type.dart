//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'opening_repeat_type.g.dart';

class OpeningRepeatType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'daily')
  static const OpeningRepeatType daily = _$daily;
  @BuiltValueEnumConst(wireName: r'weekly')
  static const OpeningRepeatType weekly = _$weekly;
  @BuiltValueEnumConst(wireName: r'monthly')
  static const OpeningRepeatType monthly = _$monthly;

  static Serializer<OpeningRepeatType> get serializer => _$openingRepeatTypeSerializer;

  const OpeningRepeatType._(String name): super(name);

  static BuiltSet<OpeningRepeatType> get values => _$values;
  static OpeningRepeatType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class OpeningRepeatTypeMixin = Object with _$OpeningRepeatTypeMixin;

