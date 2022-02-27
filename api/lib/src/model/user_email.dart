//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_email.g.dart';

/// UserEmail
///
/// Properties:
/// * [email] 
abstract class UserEmail implements Built<UserEmail, UserEmailBuilder> {
    @BuiltValueField(wireName: r'email')
    String get email;

    UserEmail._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(UserEmailBuilder b) => b;

    factory UserEmail([void updates(UserEmailBuilder b)]) = _$UserEmail;

    @BuiltValueSerializer(custom: true)
    static Serializer<UserEmail> get serializer => _$UserEmailSerializer();
}

class _$UserEmailSerializer implements StructuredSerializer<UserEmail> {
    @override
    final Iterable<Type> types = const [UserEmail, _$UserEmail];

    @override
    final String wireName = r'UserEmail';

    @override
    Iterable<Object?> serialize(Serializers serializers, UserEmail object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'email')
            ..add(serializers.serialize(object.email,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    UserEmail deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = UserEmailBuilder();

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

