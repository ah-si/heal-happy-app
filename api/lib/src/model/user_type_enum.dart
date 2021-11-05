//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_type_enum.g.dart';

class UserTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'admin')
  static const UserTypeEnum admin = _$admin;
  @BuiltValueEnumConst(wireName: r'patient')
  static const UserTypeEnum patient = _$patient;
  @BuiltValueEnumConst(wireName: r'healer')
  static const UserTypeEnum healer = _$healer;

  static Serializer<UserTypeEnum> get serializer => _$userTypeEnumSerializer;

  const UserTypeEnum._(String name): super(name);

  static BuiltSet<UserTypeEnum> get values => _$values;
  static UserTypeEnum valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class UserTypeEnumMixin = Object with _$UserTypeEnumMixin;

