//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:heal_happy_sdk/src/model/user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_user_event.g.dart';

/// AdminUserEvent
///
/// Properties:
/// * [id] 
/// * [patient] 
/// * [healer] 
/// * [isUrgent] 
/// * [isCancelled] 
/// * [createdAt] 
/// * [start] 
/// * [end] 
/// * [name] 
/// * [description] 
/// * [cancelledDescription] 
/// * [link] 
abstract class AdminUserEvent implements Built<AdminUserEvent, AdminUserEventBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'patient')
    User get patient;

    @BuiltValueField(wireName: r'healer')
    User get healer;

    @BuiltValueField(wireName: r'isUrgent')
    bool get isUrgent;

    @BuiltValueField(wireName: r'isCancelled')
    bool get isCancelled;

    @BuiltValueField(wireName: r'createdAt')
    DateTime get createdAt;

    @BuiltValueField(wireName: r'start')
    DateTime get start;

    @BuiltValueField(wireName: r'end')
    DateTime get end;

    @BuiltValueField(wireName: r'name')
    String get name;

    @BuiltValueField(wireName: r'description')
    String? get description;

    @BuiltValueField(wireName: r'cancelledDescription')
    String? get cancelledDescription;

    @BuiltValueField(wireName: r'link')
    String get link;

    AdminUserEvent._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(AdminUserEventBuilder b) => b;

    factory AdminUserEvent([void updates(AdminUserEventBuilder b)]) = _$AdminUserEvent;

    @BuiltValueSerializer(custom: true)
    static Serializer<AdminUserEvent> get serializer => _$AdminUserEventSerializer();
}

class _$AdminUserEventSerializer implements StructuredSerializer<AdminUserEvent> {
    @override
    final Iterable<Type> types = const [AdminUserEvent, _$AdminUserEvent];

    @override
    final String wireName = r'AdminUserEvent';

    @override
    Iterable<Object?> serialize(Serializers serializers, AdminUserEvent object,
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
                specifiedType: const FullType(User)));
        result
            ..add(r'isUrgent')
            ..add(serializers.serialize(object.isUrgent,
                specifiedType: const FullType(bool)));
        result
            ..add(r'isCancelled')
            ..add(serializers.serialize(object.isCancelled,
                specifiedType: const FullType(bool)));
        result
            ..add(r'createdAt')
            ..add(serializers.serialize(object.createdAt,
                specifiedType: const FullType(DateTime)));
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
        if (object.cancelledDescription != null) {
            result
                ..add(r'cancelledDescription')
                ..add(serializers.serialize(object.cancelledDescription,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'link')
            ..add(serializers.serialize(object.link,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    AdminUserEvent deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = AdminUserEventBuilder();

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
                        specifiedType: const FullType(User)) as User);
                    break;
                case r'isUrgent':
                    result.isUrgent = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'isCancelled':
                    result.isCancelled = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'createdAt':
                    result.createdAt = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
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
                case r'cancelledDescription':
                    result.cancelledDescription = serializers.deserialize(value,
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

