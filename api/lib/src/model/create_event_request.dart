//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_event_request.g.dart';

/// CreateEventRequest
///
/// Properties:
/// * [slot] 
/// * [isUrgent] 
/// * [patientId] 
/// * [message] 
abstract class CreateEventRequest implements Built<CreateEventRequest, CreateEventRequestBuilder> {
    @BuiltValueField(wireName: r'slot')
    DateTime get slot;

    @BuiltValueField(wireName: r'isUrgent')
    bool? get isUrgent;

    @BuiltValueField(wireName: r'patientId')
    String get patientId;

    @BuiltValueField(wireName: r'message')
    String? get message;

    CreateEventRequest._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(CreateEventRequestBuilder b) => b;

    factory CreateEventRequest([void updates(CreateEventRequestBuilder b)]) = _$CreateEventRequest;

    @BuiltValueSerializer(custom: true)
    static Serializer<CreateEventRequest> get serializer => _$CreateEventRequestSerializer();
}

class _$CreateEventRequestSerializer implements StructuredSerializer<CreateEventRequest> {
    @override
    final Iterable<Type> types = const [CreateEventRequest, _$CreateEventRequest];

    @override
    final String wireName = r'CreateEventRequest';

    @override
    Iterable<Object?> serialize(Serializers serializers, CreateEventRequest object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'slot')
            ..add(serializers.serialize(object.slot,
                specifiedType: const FullType(DateTime)));
        if (object.isUrgent != null) {
            result
                ..add(r'isUrgent')
                ..add(serializers.serialize(object.isUrgent,
                    specifiedType: const FullType(bool)));
        }
        result
            ..add(r'patientId')
            ..add(serializers.serialize(object.patientId,
                specifiedType: const FullType(String)));
        if (object.message != null) {
            result
                ..add(r'message')
                ..add(serializers.serialize(object.message,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    CreateEventRequest deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = CreateEventRequestBuilder();

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
                case r'isUrgent':
                    result.isUrgent = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'patientId':
                    result.patientId = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
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

