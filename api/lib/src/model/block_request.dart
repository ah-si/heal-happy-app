//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'block_request.g.dart';

/// BlockRequest
///
/// Properties:
/// * [isBlocked] 
abstract class BlockRequest implements Built<BlockRequest, BlockRequestBuilder> {
    @BuiltValueField(wireName: r'isBlocked')
    bool get isBlocked;

    BlockRequest._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(BlockRequestBuilder b) => b;

    factory BlockRequest([void updates(BlockRequestBuilder b)]) = _$BlockRequest;

    @BuiltValueSerializer(custom: true)
    static Serializer<BlockRequest> get serializer => _$BlockRequestSerializer();
}

class _$BlockRequestSerializer implements StructuredSerializer<BlockRequest> {
    @override
    final Iterable<Type> types = const [BlockRequest, _$BlockRequest];

    @override
    final String wireName = r'BlockRequest';

    @override
    Iterable<Object?> serialize(Serializers serializers, BlockRequest object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'isBlocked')
            ..add(serializers.serialize(object.isBlocked,
                specifiedType: const FullType(bool)));
        return result;
    }

    @override
    BlockRequest deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = BlockRequestBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'isBlocked':
                    result.isBlocked = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
            }
        }
        return result.build();
    }
}

