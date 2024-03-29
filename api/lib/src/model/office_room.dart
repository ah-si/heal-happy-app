//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:heal_happy_sdk/src/model/user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'office_room.g.dart';

/// OfficeRoom
///
/// Properties:
/// * [id] 
/// * [officeId] 
/// * [name] 
/// * [healers] 
abstract class OfficeRoom implements Built<OfficeRoom, OfficeRoomBuilder> {
    @BuiltValueField(wireName: r'id')
    String? get id;

    @BuiltValueField(wireName: r'officeId')
    String get officeId;

    @BuiltValueField(wireName: r'name')
    String get name;

    @BuiltValueField(wireName: r'healers')
    BuiltList<User> get healers;

    OfficeRoom._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(OfficeRoomBuilder b) => b;

    factory OfficeRoom([void updates(OfficeRoomBuilder b)]) = _$OfficeRoom;

    @BuiltValueSerializer(custom: true)
    static Serializer<OfficeRoom> get serializer => _$OfficeRoomSerializer();
}

class _$OfficeRoomSerializer implements StructuredSerializer<OfficeRoom> {
    @override
    final Iterable<Type> types = const [OfficeRoom, _$OfficeRoom];

    @override
    final String wireName = r'OfficeRoom';

    @override
    Iterable<Object?> serialize(Serializers serializers, OfficeRoom object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.id != null) {
            result
                ..add(r'id')
                ..add(serializers.serialize(object.id,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'officeId')
            ..add(serializers.serialize(object.officeId,
                specifiedType: const FullType(String)));
        result
            ..add(r'name')
            ..add(serializers.serialize(object.name,
                specifiedType: const FullType(String)));
        result
            ..add(r'healers')
            ..add(serializers.serialize(object.healers,
                specifiedType: const FullType(BuiltList, [FullType(User)])));
        return result;
    }

    @override
    OfficeRoom deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = OfficeRoomBuilder();

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
                case r'officeId':
                    result.officeId = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'name':
                    result.name = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'healers':
                    result.healers.replace(serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(User)])) as BuiltList<User>);
                    break;
            }
        }
        return result.build();
    }
}

