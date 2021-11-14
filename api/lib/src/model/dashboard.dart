//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:heal_happy_sdk/src/model/dashboard_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard.g.dart';

/// Dashboard
///
/// Properties:
/// * [users] 
abstract class Dashboard implements Built<Dashboard, DashboardBuilder> {
    @BuiltValueField(wireName: r'users')
    BuiltList<DashboardUser> get users;

    Dashboard._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(DashboardBuilder b) => b;

    factory Dashboard([void updates(DashboardBuilder b)]) = _$Dashboard;

    @BuiltValueSerializer(custom: true)
    static Serializer<Dashboard> get serializer => _$DashboardSerializer();
}

class _$DashboardSerializer implements StructuredSerializer<Dashboard> {
    @override
    final Iterable<Type> types = const [Dashboard, _$Dashboard];

    @override
    final String wireName = r'Dashboard';

    @override
    Iterable<Object?> serialize(Serializers serializers, Dashboard object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'users')
            ..add(serializers.serialize(object.users,
                specifiedType: const FullType(BuiltList, [FullType(DashboardUser)])));
        return result;
    }

    @override
    Dashboard deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = DashboardBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'users':
                    result.users.replace(serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(DashboardUser)])) as BuiltList<DashboardUser>);
                    break;
            }
        }
        return result.build();
    }
}

