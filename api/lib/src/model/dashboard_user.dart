//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:heal_happy_sdk/src/model/user_type_enum.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_user.g.dart';

/// DashboardUser
///
/// Properties:
/// * [type] 
/// * [isActivated] 
/// * [isVerified] 
/// * [total] 
abstract class DashboardUser implements Built<DashboardUser, DashboardUserBuilder> {
    @BuiltValueField(wireName: r'type')
    UserTypeEnum get type;
    // enum typeEnum {  admin,  patient,  healer,  };

    @BuiltValueField(wireName: r'isActivated')
    bool get isActivated;

    @BuiltValueField(wireName: r'isVerified')
    bool get isVerified;

    @BuiltValueField(wireName: r'total')
    int get total;

    DashboardUser._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(DashboardUserBuilder b) => b;

    factory DashboardUser([void updates(DashboardUserBuilder b)]) = _$DashboardUser;

    @BuiltValueSerializer(custom: true)
    static Serializer<DashboardUser> get serializer => _$DashboardUserSerializer();
}

class _$DashboardUserSerializer implements StructuredSerializer<DashboardUser> {
    @override
    final Iterable<Type> types = const [DashboardUser, _$DashboardUser];

    @override
    final String wireName = r'DashboardUser';

    @override
    Iterable<Object?> serialize(Serializers serializers, DashboardUser object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'type')
            ..add(serializers.serialize(object.type,
                specifiedType: const FullType(UserTypeEnum)));
        result
            ..add(r'isActivated')
            ..add(serializers.serialize(object.isActivated,
                specifiedType: const FullType(bool)));
        result
            ..add(r'isVerified')
            ..add(serializers.serialize(object.isVerified,
                specifiedType: const FullType(bool)));
        result
            ..add(r'total')
            ..add(serializers.serialize(object.total,
                specifiedType: const FullType(int)));
        return result;
    }

    @override
    DashboardUser deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = DashboardUserBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'type':
                    result.type = serializers.deserialize(value,
                        specifiedType: const FullType(UserTypeEnum)) as UserTypeEnum;
                    break;
                case r'isActivated':
                    result.isActivated = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'isVerified':
                    result.isVerified = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'total':
                    result.total = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
            }
        }
        return result.build();
    }
}

