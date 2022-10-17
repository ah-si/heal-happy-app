//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:heal_happy_sdk/src/model/office_room.dart';
import 'package:heal_happy_sdk/src/model/user.dart';

part 'office.g.dart';

/// Office
///
/// Properties:
/// * [rooms] 
/// * [managers] 
/// * [id] 
/// * [name] 
/// * [street] 
/// * [street2] 
/// * [city] 
/// * [zipCode] 
abstract class Office implements Built<Office, OfficeBuilder> {
    @BuiltValueField(wireName: r'rooms')
    BuiltList<OfficeRoom> get rooms;

    @BuiltValueField(wireName: r'managers')
    BuiltList<User> get managers;

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

    Office._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(OfficeBuilder b) => b;

    factory Office([void updates(OfficeBuilder b)]) = _$Office;

    @BuiltValueSerializer(custom: true)
    static Serializer<Office> get serializer => _$OfficeSerializer();
}

class _$OfficeSerializer implements StructuredSerializer<Office> {
    @override
    final Iterable<Type> types = const [Office, _$Office];

    @override
    final String wireName = r'Office';

    @override
    Iterable<Object?> serialize(Serializers serializers, Office object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'rooms')
            ..add(serializers.serialize(object.rooms,
                specifiedType: const FullType(BuiltList, [FullType(OfficeRoom)])));
        result
            ..add(r'managers')
            ..add(serializers.serialize(object.managers,
                specifiedType: const FullType(BuiltList, [FullType(User)])));
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
    Office deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = OfficeBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'rooms':
                    result.rooms.replace(serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(OfficeRoom)])) as BuiltList<OfficeRoom>);
                    break;
                case r'managers':
                    result.managers.replace(serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(User)])) as BuiltList<User>);
                    break;
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

