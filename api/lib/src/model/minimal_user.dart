//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'minimal_user.g.dart';

/// MinimalUser
///
/// Properties:
/// * [id] 
/// * [firstName] 
/// * [lastName] 
/// * [mobile] 
/// * [email] 
abstract class MinimalUser implements Built<MinimalUser, MinimalUserBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'firstName')
    String get firstName;

    @BuiltValueField(wireName: r'lastName')
    String get lastName;

    @BuiltValueField(wireName: r'mobile')
    String get mobile;

    @BuiltValueField(wireName: r'email')
    String get email;

    MinimalUser._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(MinimalUserBuilder b) => b;

    factory MinimalUser([void updates(MinimalUserBuilder b)]) = _$MinimalUser;

    @BuiltValueSerializer(custom: true)
    static Serializer<MinimalUser> get serializer => _$MinimalUserSerializer();
}

class _$MinimalUserSerializer implements StructuredSerializer<MinimalUser> {
    @override
    final Iterable<Type> types = const [MinimalUser, _$MinimalUser];

    @override
    final String wireName = r'MinimalUser';

    @override
    Iterable<Object?> serialize(Serializers serializers, MinimalUser object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(String)));
        result
            ..add(r'firstName')
            ..add(serializers.serialize(object.firstName,
                specifiedType: const FullType(String)));
        result
            ..add(r'lastName')
            ..add(serializers.serialize(object.lastName,
                specifiedType: const FullType(String)));
        result
            ..add(r'mobile')
            ..add(serializers.serialize(object.mobile,
                specifiedType: const FullType(String)));
        result
            ..add(r'email')
            ..add(serializers.serialize(object.email,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    MinimalUser deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = MinimalUserBuilder();

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
                case r'firstName':
                    result.firstName = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'lastName':
                    result.lastName = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'mobile':
                    result.mobile = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'email':
                    result.email = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
            }
        }
        return result.build();
    }
}

