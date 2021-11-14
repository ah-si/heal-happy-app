//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:heal_happy_sdk/src/model/healer.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'paginated_healers.g.dart';

/// PaginatedHealers
///
/// Properties:
/// * [totalPages] 
/// * [healers] 
abstract class PaginatedHealers implements Built<PaginatedHealers, PaginatedHealersBuilder> {
    @BuiltValueField(wireName: r'totalPages')
    int get totalPages;

    @BuiltValueField(wireName: r'healers')
    BuiltList<Healer> get healers;

    PaginatedHealers._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(PaginatedHealersBuilder b) => b;

    factory PaginatedHealers([void updates(PaginatedHealersBuilder b)]) = _$PaginatedHealers;

    @BuiltValueSerializer(custom: true)
    static Serializer<PaginatedHealers> get serializer => _$PaginatedHealersSerializer();
}

class _$PaginatedHealersSerializer implements StructuredSerializer<PaginatedHealers> {
    @override
    final Iterable<Type> types = const [PaginatedHealers, _$PaginatedHealers];

    @override
    final String wireName = r'PaginatedHealers';

    @override
    Iterable<Object?> serialize(Serializers serializers, PaginatedHealers object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'totalPages')
            ..add(serializers.serialize(object.totalPages,
                specifiedType: const FullType(int)));
        result
            ..add(r'healers')
            ..add(serializers.serialize(object.healers,
                specifiedType: const FullType(BuiltList, [FullType(Healer)])));
        return result;
    }

    @override
    PaginatedHealers deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = PaginatedHealersBuilder();

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
                case r'healers':
                    result.healers.replace(serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(Healer)])) as BuiltList<Healer>);
                    break;
            }
        }
        return result.build();
    }
}

