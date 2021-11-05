//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ask_reset_password.g.dart';

/// AskResetPassword
///
/// Properties:
/// * [email] 
abstract class AskResetPassword implements Built<AskResetPassword, AskResetPasswordBuilder> {
    @BuiltValueField(wireName: r'email')
    String get email;

    AskResetPassword._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(AskResetPasswordBuilder b) => b;

    factory AskResetPassword([void updates(AskResetPasswordBuilder b)]) = _$AskResetPassword;

    @BuiltValueSerializer(custom: true)
    static Serializer<AskResetPassword> get serializer => _$AskResetPasswordSerializer();
}

class _$AskResetPasswordSerializer implements StructuredSerializer<AskResetPassword> {
    @override
    final Iterable<Type> types = const [AskResetPassword, _$AskResetPassword];

    @override
    final String wireName = r'AskResetPassword';

    @override
    Iterable<Object?> serialize(Serializers serializers, AskResetPassword object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'email')
            ..add(serializers.serialize(object.email,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    AskResetPassword deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = AskResetPasswordBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'email':
                    result.email = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
            }
        }
        return result.build();
    }
}

