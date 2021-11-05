//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reset_password.g.dart';

/// ResetPassword
///
/// Properties:
/// * [password] 
/// * [token] 
abstract class ResetPassword implements Built<ResetPassword, ResetPasswordBuilder> {
    @BuiltValueField(wireName: r'password')
    String get password;

    @BuiltValueField(wireName: r'token')
    String? get token;

    ResetPassword._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(ResetPasswordBuilder b) => b;

    factory ResetPassword([void updates(ResetPasswordBuilder b)]) = _$ResetPassword;

    @BuiltValueSerializer(custom: true)
    static Serializer<ResetPassword> get serializer => _$ResetPasswordSerializer();
}

class _$ResetPasswordSerializer implements StructuredSerializer<ResetPassword> {
    @override
    final Iterable<Type> types = const [ResetPassword, _$ResetPassword];

    @override
    final String wireName = r'ResetPassword';

    @override
    Iterable<Object?> serialize(Serializers serializers, ResetPassword object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'password')
            ..add(serializers.serialize(object.password,
                specifiedType: const FullType(String)));
        if (object.token != null) {
            result
                ..add(r'token')
                ..add(serializers.serialize(object.token,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    ResetPassword deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = ResetPasswordBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'password':
                    result.password = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'token':
                    result.token = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
            }
        }
        return result.build();
    }
}

