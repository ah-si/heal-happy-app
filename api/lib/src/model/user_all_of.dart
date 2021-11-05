//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_all_of.g.dart';

/// UserAllOf
///
/// Properties:
/// * [id] 
/// * [email] 
/// * [mobile] 
/// * [password] 
abstract class UserAllOf implements Built<UserAllOf, UserAllOfBuilder> {
    @BuiltValueField(wireName: r'id')
    String? get id;

    @BuiltValueField(wireName: r'email')
    String? get email;

    @BuiltValueField(wireName: r'mobile')
    String? get mobile;

    @BuiltValueField(wireName: r'password')
    String? get password;

    UserAllOf._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(UserAllOfBuilder b) => b;

    factory UserAllOf([void updates(UserAllOfBuilder b)]) = _$UserAllOf;

    @BuiltValueSerializer(custom: true)
    static Serializer<UserAllOf> get serializer => _$UserAllOfSerializer();
}

class _$UserAllOfSerializer implements StructuredSerializer<UserAllOf> {
    @override
    final Iterable<Type> types = const [UserAllOf, _$UserAllOf];

    @override
    final String wireName = r'UserAllOf';

    @override
    Iterable<Object?> serialize(Serializers serializers, UserAllOf object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.id != null) {
            result
                ..add(r'id')
                ..add(serializers.serialize(object.id,
                    specifiedType: const FullType(String)));
        }
        if (object.email != null) {
            result
                ..add(r'email')
                ..add(serializers.serialize(object.email,
                    specifiedType: const FullType(String)));
        }
        if (object.mobile != null) {
            result
                ..add(r'mobile')
                ..add(serializers.serialize(object.mobile,
                    specifiedType: const FullType(String)));
        }
        if (object.password != null) {
            result
                ..add(r'password')
                ..add(serializers.serialize(object.password,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    UserAllOf deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = UserAllOfBuilder();

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
                case r'email':
                    result.email = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'mobile':
                    result.mobile = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'password':
                    result.password = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
            }
        }
        return result.build();
    }
}

