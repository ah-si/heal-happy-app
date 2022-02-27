//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'office_info.g.dart';

/// OfficeInfo
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [street] 
/// * [street2] 
/// * [city] 
/// * [zipCode] 
abstract class OfficeInfo implements Built<OfficeInfo, OfficeInfoBuilder> {
    @BuiltValueField(wireName: r'id')
    String? get id;

    @BuiltValueField(wireName: r'name')
    String get name;

    @BuiltValueField(wireName: r'street')
    String get street;

    @BuiltValueField(wireName: r'street2')
    String get street2;

    @BuiltValueField(wireName: r'city')
    String get city;

    @BuiltValueField(wireName: r'zipCode')
    String get zipCode;

    OfficeInfo._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(OfficeInfoBuilder b) => b;

    factory OfficeInfo([void updates(OfficeInfoBuilder b)]) = _$OfficeInfo;

    @BuiltValueSerializer(custom: true)
    static Serializer<OfficeInfo> get serializer => _$OfficeInfoSerializer();
}

class _$OfficeInfoSerializer implements StructuredSerializer<OfficeInfo> {
    @override
    final Iterable<Type> types = const [OfficeInfo, _$OfficeInfo];

    @override
    final String wireName = r'OfficeInfo';

    @override
    Iterable<Object?> serialize(Serializers serializers, OfficeInfo object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.id != null) {
            result
                ..add(r'id')
                ..add(serializers.serialize(object.id,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'name')
            ..add(serializers.serialize(object.name,
                specifiedType: const FullType(String)));
        result
            ..add(r'street')
            ..add(serializers.serialize(object.street,
                specifiedType: const FullType(String)));
        result
            ..add(r'street2')
            ..add(serializers.serialize(object.street2,
                specifiedType: const FullType(String)));
        result
            ..add(r'city')
            ..add(serializers.serialize(object.city,
                specifiedType: const FullType(String)));
        result
            ..add(r'zipCode')
            ..add(serializers.serialize(object.zipCode,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    OfficeInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = OfficeInfoBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'id':
                    result.id = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'name':
                    result.name = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'street':
                    result.street = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'street2':
                    result.street2 = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'city':
                    result.city = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'zipCode':
                    result.zipCode = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
            }
        }
        return result.build();
    }
}

