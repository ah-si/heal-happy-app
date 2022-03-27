//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:heal_happy_sdk/src/model/minimal_user.dart';
import 'package:heal_happy_sdk/src/model/office.dart';
import 'package:heal_happy_sdk/src/model/healer.dart';
import 'package:heal_happy_sdk/src/model/healer_event_type.dart';
import 'package:heal_happy_sdk/src/model/office_room.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_event.g.dart';

/// UserEvent
///
/// Properties:
/// * [id] 
/// * [patientToken] 
/// * [patient] 
/// * [healer] 
/// * [room] 
/// * [office] 
/// * [isUrgent] 
/// * [isHealerPresent] 
/// * [isPatientPresent] 
/// * [isCancelled] 
/// * [type] 
/// * [createdAt] 
/// * [start] 
/// * [end] 
/// * [name] 
/// * [description] 
/// * [cancelledDescription] 
/// * [link] 
abstract class UserEvent implements Built<UserEvent, UserEventBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'patientToken')
    String? get patientToken;

    @BuiltValueField(wireName: r'patient')
    MinimalUser get patient;

    @BuiltValueField(wireName: r'healer')
    Healer get healer;

    @BuiltValueField(wireName: r'room')
    OfficeRoom? get room;

    @BuiltValueField(wireName: r'office')
    Office? get office;

    @BuiltValueField(wireName: r'isUrgent')
    bool get isUrgent;

    @BuiltValueField(wireName: r'isHealerPresent')
    bool get isHealerPresent;

    @BuiltValueField(wireName: r'isPatientPresent')
    bool get isPatientPresent;

    @BuiltValueField(wireName: r'isCancelled')
    bool get isCancelled;

    @BuiltValueField(wireName: r'type')
    HealerEventType get type;
    // enum typeEnum {  visio,  faceToFace,  };

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
        if (object.patientToken != null) {
            result
                ..add(r'patientToken')
                ..add(serializers.serialize(object.patientToken,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'patient')
            ..add(serializers.serialize(object.patient,
                specifiedType: const FullType(MinimalUser)));
        result
            ..add(r'healer')
            ..add(serializers.serialize(object.healer,
                specifiedType: const FullType(Healer)));
        if (object.room != null) {
            result
                ..add(r'room')
                ..add(serializers.serialize(object.room,
                    specifiedType: const FullType(OfficeRoom)));
        }
        if (object.office != null) {
            result
                ..add(r'office')
                ..add(serializers.serialize(object.office,
                    specifiedType: const FullType(Office)));
        }
        result
            ..add(r'isUrgent')
            ..add(serializers.serialize(object.isUrgent,
                specifiedType: const FullType(bool)));
        result
            ..add(r'isHealerPresent')
            ..add(serializers.serialize(object.isHealerPresent,
                specifiedType: const FullType(bool)));
        result
            ..add(r'isPatientPresent')
            ..add(serializers.serialize(object.isPatientPresent,
                specifiedType: const FullType(bool)));
        result
            ..add(r'isCancelled')
            ..add(serializers.serialize(object.isCancelled,
                specifiedType: const FullType(bool)));
        result
            ..add(r'type')
            ..add(serializers.serialize(object.type,
                specifiedType: const FullType(HealerEventType)));
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
                case r'patientToken':
                    result.patientToken = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'patient':
                    result.patient.replace(serializers.deserialize(value,
                        specifiedType: const FullType(MinimalUser)) as MinimalUser);
                    break;
                case r'healer':
                    result.healer.replace(serializers.deserialize(value,
                        specifiedType: const FullType(Healer)) as Healer);
                    break;
                case r'room':
                    result.room.replace(serializers.deserialize(value,
                        specifiedType: const FullType(OfficeRoom)) as OfficeRoom);
                    break;
                case r'office':
                    result.office.replace(serializers.deserialize(value,
                        specifiedType: const FullType(Office)) as Office);
                    break;
                case r'isUrgent':
                    result.isUrgent = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'isHealerPresent':
                    result.isHealerPresent = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'isPatientPresent':
                    result.isPatientPresent = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'isCancelled':
                    result.isCancelled = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'type':
                    result.type = serializers.deserialize(value,
                        specifiedType: const FullType(HealerEventType)) as HealerEventType;
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

