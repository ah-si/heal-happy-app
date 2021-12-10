//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_event_request.g.dart';

/// DeleteEventRequest
///
/// Properties:
/// * [message] 
abstract class DeleteEventRequest implements Built<DeleteEventRequest, DeleteEventRequestBuilder> {
    @BuiltValueField(wireName: r'message')
    String get message;

    DeleteEventRequest._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(DeleteEventRequestBuilder b) => b;

    factory DeleteEventRequest([void updates(DeleteEventRequestBuilder b)]) = _$DeleteEventRequest;

    @BuiltValueSerializer(custom: true)
    static Serializer<DeleteEventRequest> get serializer => _$DeleteEventRequestSerializer();
}

class _$DeleteEventRequestSerializer implements StructuredSerializer<DeleteEventRequest> {
    @override
    final Iterable<Type> types = const [DeleteEventRequest, _$DeleteEventRequest];

    @override
    final String wireName = r'DeleteEventRequest';

    @override
    Iterable<Object?> serialize(Serializers serializers, DeleteEventRequest object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'message')
            ..add(serializers.serialize(object.message,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    DeleteEventRequest deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = DeleteEventRequestBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'message':
                    result.message = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
            }
        }
        return result.build();
    }
}

