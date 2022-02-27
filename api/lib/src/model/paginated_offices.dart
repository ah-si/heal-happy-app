//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:heal_happy_sdk/src/model/office.dart';

part 'paginated_offices.g.dart';

/// PaginatedOffices
///
/// Properties:
/// * [totalPages]
/// * [offices]
abstract class PaginatedOffices implements Built<PaginatedOffices, PaginatedOfficesBuilder> {
    @BuiltValueField(wireName: r'totalPages')
    int get totalPages;

    @BuiltValueField(wireName: r'offices')
    BuiltList<Office> get offices;

    PaginatedOffices._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(PaginatedOfficesBuilder b) => b;

    factory PaginatedOffices([void updates(PaginatedOfficesBuilder b)]) = _$PaginatedOffices;

    @BuiltValueSerializer(custom: true)
    static Serializer<PaginatedOffices> get serializer => _$PaginatedOfficesSerializer();
}

class _$PaginatedOfficesSerializer implements StructuredSerializer<PaginatedOffices> {
    @override
    final Iterable<Type> types = const [PaginatedOffices, _$PaginatedOffices];

    @override
    final String wireName = r'PaginatedOffices';

    @override
    Iterable<Object?> serialize(Serializers serializers, PaginatedOffices object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'totalPages')
            ..add(serializers.serialize(object.totalPages,
                specifiedType: const FullType(int)));
        result
            ..add(r'offices')
            ..add(serializers.serialize(object.offices,
                specifiedType: const FullType(BuiltList, [FullType(Office)])));
        return result;
    }

    @override
    PaginatedOffices deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = PaginatedOfficesBuilder();

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
                case r'offices':
                    result.offices.replace(serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(Office)])) as BuiltList<Office>);
                    break;
            }
        }
        return result.build();
    }
}

