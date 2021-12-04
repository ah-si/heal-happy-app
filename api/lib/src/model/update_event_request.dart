//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_event_request.g.dart';

/// UpdateEventRequest
///
/// Properties:
/// * [start] 
/// * [message] 
abstract class UpdateEventRequest implements Built<UpdateEventRequest, UpdateEventRequestBuilder> {
    @BuiltValueField(wireName: r'start')
    DateTime get start;

    @BuiltValueField(wireName: r'message')
    String? get message;

    UpdateEventRequest._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(UpdateEventRequestBuilder b) => b;

    factory UpdateEventRequest([void updates(UpdateEventRequestBuilder b)]) = _$UpdateEventRequest;

    @BuiltValueSerializer(custom: true)
    static Serializer<UpdateEventRequest> get serializer => _$UpdateEventRequestSerializer();
}

class _$UpdateEventRequestSerializer implements StructuredSerializer<UpdateEventRequest> {
    @override
    final Iterable<Type> types = const [UpdateEventRequest, _$UpdateEventRequest];

    @override
    final String wireName = r'UpdateEventRequest';

    @override
    Iterable<Object?> serialize(Serializers serializers, UpdateEventRequest object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'start')
            ..add(serializers.serialize(object.start,
                specifiedType: const FullType(DateTime)));
        if (object.message != null) {
            result
                ..add(r'message')
                ..add(serializers.serialize(object.message,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    UpdateEventRequest deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = UpdateEventRequestBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'start':
                    result.start = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
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

