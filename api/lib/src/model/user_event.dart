//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:heal_happy_sdk/src/model/healer.dart';
import 'package:heal_happy_sdk/src/model/user.dart';

part 'user_event.g.dart';

/// UserEvent
///
/// Properties:
/// * [id]
/// * [patient]
/// * [healer]
/// * [isUrgent]
/// * [start]
/// * [end]
/// * [name]
/// * [description]
/// * [link]
abstract class UserEvent implements Built<UserEvent, UserEventBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'patient')
    User get patient;

    @BuiltValueField(wireName: r'healer')
    Healer get healer;

    @BuiltValueField(wireName: r'isUrgent')
    bool get isUrgent;

    @BuiltValueField(wireName: r'start')
    DateTime get start;

    @BuiltValueField(wireName: r'end')
    DateTime get end;

    @BuiltValueField(wireName: r'name')
    String get name;

    @BuiltValueField(wireName: r'description')
    String? get description;

    @BuiltValueField(wireName: r'link')
    String get link;

    UserEvent._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(UserEventBuilder b) => b;

    factory UserEvent([void updates(UserEventBuilder b)]) = _$UserEvent;

    @BuiltValueSerializer(custom: true)
    static Serializer<UserEvent> get serializer => _$UserEventSerializer();
}

class _$UserEventSerializer implements StructuredSerializer<UserEvent> {
    @override
    final Iterable<Type> types = const [UserEvent, _$UserEvent];

    @override
    final String wireName = r'UserEvent';

    @override
    Iterable<Object?> serialize(Serializers serializers, UserEvent object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(String)));
        result
            ..add(r'patient')
            ..add(serializers.serialize(object.patient,
                specifiedType: const FullType(User)));
        result
            ..add(r'healer')
            ..add(serializers.serialize(object.healer,
                specifiedType: const FullType(Healer)));
        result
            ..add(r'isUrgent')
            ..add(serializers.serialize(object.isUrgent,
                specifiedType: const FullType(bool)));
        result
            ..add(r'start')
            ..add(serializers.serialize(object.start,
                specifiedType: const FullType(DateTime)));
        result
            ..add(r'end')
            ..add(serializers.serialize(object.end,
                specifiedType: const FullType(DateTime)));
        result
            ..add(r'name')
            ..add(serializers.serialize(object.name,
                specifiedType: const FullType(String)));
        if (object.description != null) {
            result
                ..add(r'description')
                ..add(serializers.serialize(object.description,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'link')
            ..add(serializers.serialize(object.link,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    UserEvent deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = UserEventBuilder();

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
                case r'patient':
                    result.patient.replace(serializers.deserialize(value,
                        specifiedType: const FullType(User)) as User);
                    break;
                case r'healer':
                    result.healer.replace(serializers.deserialize(value,
                        specifiedType: const FullType(Healer)) as Healer);
                    break;
                case r'isUrgent':
                    result.isUrgent = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'start':
                    result.start = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    break;
                case r'end':
                    result.end = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    break;
                case r'name':
                    result.name = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'description':
                    result.description = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'link':
                    result.link = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
            }
        }
        return result.build();
    }
}

