//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:heal_happy_sdk/src/model/user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'paginated_users.g.dart';

/// PaginatedUsers
///
/// Properties:
/// * [totalPages] 
/// * [users] 
abstract class PaginatedUsers implements Built<PaginatedUsers, PaginatedUsersBuilder> {
    @BuiltValueField(wireName: r'totalPages')
    int get totalPages;

    @BuiltValueField(wireName: r'users')
    BuiltList<User> get users;

    PaginatedUsers._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(PaginatedUsersBuilder b) => b;

    factory PaginatedUsers([void updates(PaginatedUsersBuilder b)]) = _$PaginatedUsers;

    @BuiltValueSerializer(custom: true)
    static Serializer<PaginatedUsers> get serializer => _$PaginatedUsersSerializer();
}

class _$PaginatedUsersSerializer implements StructuredSerializer<PaginatedUsers> {
    @override
    final Iterable<Type> types = const [PaginatedUsers, _$PaginatedUsers];

    @override
    final String wireName = r'PaginatedUsers';

    @override
    Iterable<Object?> serialize(Serializers serializers, PaginatedUsers object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'totalPages')
            ..add(serializers.serialize(object.totalPages,
                specifiedType: const FullType(int)));
        result
            ..add(r'users')
            ..add(serializers.serialize(object.users,
                specifiedType: const FullType(BuiltList, [FullType(User)])));
        return result;
    }

    @override
    PaginatedUsers deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = PaginatedUsersBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'totalPages':
                    result.totalPages = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'users':
                    result.users.replace(serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(User)])) as BuiltList<User>);
                    break;
            }
        }
        return result.build();
    }
}

