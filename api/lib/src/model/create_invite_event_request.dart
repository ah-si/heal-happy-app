//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:heal_happy_sdk/src/model/healer_event_type.dart';

part 'create_invite_event_request.g.dart';

/// CreateInviteEventRequest
///
/// Properties:
/// * [slot]
/// * [roomId]
/// * [email]
/// * [mobile]
/// * [firstName]
/// * [lastName]
/// * [type]
/// * [message]
abstract class CreateInviteEventRequest implements Built<CreateInviteEventRequest, CreateInviteEventRequestBuilder> {
    @BuiltValueField(wireName: r'slot')
    DateTime? get slot;

    @BuiltValueField(wireName: r'roomId')
    String? get roomId;

    @BuiltValueField(wireName: r'email')
    String get email;

    @BuiltValueField(wireName: r'mobile')
    String? get mobile;

    @BuiltValueField(wireName: r'firstName')
    String? get firstName;

    @BuiltValueField(wireName: r'lastName')
    String? get lastName;

    @BuiltValueField(wireName: r'type')
    HealerEventType get type;
    // enum typeEnum {  visio,  faceToFace,  };

    @BuiltValueField(wireName: r'message')
    String? get message;

    CreateInviteEventRequest._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(CreateInviteEventRequestBuilder b) => b;

    factory CreateInviteEventRequest([void updates(CreateInviteEventRequestBuilder b)]) = _$CreateInviteEventRequest;

    @BuiltValueSerializer(custom: true)
    static Serializer<CreateInviteEventRequest> get serializer => _$CreateInviteEventRequestSerializer();
}

class _$CreateInviteEventRequestSerializer implements StructuredSerializer<CreateInviteEventRequest> {
    @override
    final Iterable<Type> types = const [CreateInviteEventRequest, _$CreateInviteEventRequest];

    @override
    final String wireName = r'CreateInviteEventRequest';

    @override
    Iterable<Object?> serialize(Serializers serializers, CreateInviteEventRequest object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.slot != null) {
            result
                ..add(r'slot')
                ..add(serializers.serialize(object.slot,
                    specifiedType: const FullType(DateTime)));
        }
        if (object.roomId != null) {
            result
                ..add(r'roomId')
                ..add(serializers.serialize(object.roomId,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'email')
            ..add(serializers.serialize(object.email,
                specifiedType: const FullType(String)));
        if (object.mobile != null) {
            result
                ..add(r'mobile')
                ..add(serializers.serialize(object.mobile,
                    specifiedType: const FullType(String)));
        }
        if (object.firstName != null) {
            result
                ..add(r'firstName')
                ..add(serializers.serialize(object.firstName,
                    specifiedType: const FullType(String)));
        }
        if (object.lastName != null) {
            result
                ..add(r'lastName')
                ..add(serializers.serialize(object.lastName,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'type')
            ..add(serializers.serialize(object.type,
                specifiedType: const FullType(HealerEventType)));
        if (object.message != null) {
            result
                ..add(r'message')
                ..add(serializers.serialize(object.message,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    CreateInviteEventRequest deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = CreateInviteEventRequestBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'slot':
                    result.slot = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    break;
                case r'roomId':
                    result.roomId = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'email':
                    result.email = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'mobile':
                    result.mobile = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'firstName':
                    result.firstName = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'lastName':
                    result.lastName = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'type':
                    result.type = serializers.deserialize(value,
                        specifiedType: const FullType(HealerEventType)) as HealerEventType;
                    break;
                case r'message':
                    result.message = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
            }
        }
        return result.build();
    }
}

