//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'verify_request.g.dart';

/// VerifyRequest
///
/// Properties:
/// * [isVerified] 
abstract class VerifyRequest implements Built<VerifyRequest, VerifyRequestBuilder> {
    @BuiltValueField(wireName: r'isVerified')
    bool get isVerified;

    VerifyRequest._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(VerifyRequestBuilder b) => b;

    factory VerifyRequest([void updates(VerifyRequestBuilder b)]) = _$VerifyRequest;

    @BuiltValueSerializer(custom: true)
    static Serializer<VerifyRequest> get serializer => _$VerifyRequestSerializer();
}

class _$VerifyRequestSerializer implements StructuredSerializer<VerifyRequest> {
    @override
    final Iterable<Type> types = const [VerifyRequest, _$VerifyRequest];

    @override
    final String wireName = r'VerifyRequest';

    @override
    Iterable<Object?> serialize(Serializers serializers, VerifyRequest object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'isVerified')
            ..add(serializers.serialize(object.isVerified,
                specifiedType: const FullType(bool)));
        return result;
    }

    @override
    VerifyRequest deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = VerifyRequestBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'isVerified':
                    result.isVerified = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
            }
        }
        return result.build();
    }
}

