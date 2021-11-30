//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_event.g.dart';

/// DashboardEvent
///
/// Properties:
/// * [year] 
/// * [month] 
/// * [total] 
abstract class DashboardEvent implements Built<DashboardEvent, DashboardEventBuilder> {
    @BuiltValueField(wireName: r'year')
    int get year;

    @BuiltValueField(wireName: r'month')
    int get month;

    @BuiltValueField(wireName: r'total')
    int get total;

    DashboardEvent._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(DashboardEventBuilder b) => b;

    factory DashboardEvent([void updates(DashboardEventBuilder b)]) = _$DashboardEvent;

    @BuiltValueSerializer(custom: true)
    static Serializer<DashboardEvent> get serializer => _$DashboardEventSerializer();
}

class _$DashboardEventSerializer implements StructuredSerializer<DashboardEvent> {
    @override
    final Iterable<Type> types = const [DashboardEvent, _$DashboardEvent];

    @override
    final String wireName = r'DashboardEvent';

    @override
    Iterable<Object?> serialize(Serializers serializers, DashboardEvent object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'year')
            ..add(serializers.serialize(object.year,
                specifiedType: const FullType(int)));
        result
            ..add(r'month')
            ..add(serializers.serialize(object.month,
                specifiedType: const FullType(int)));
        result
            ..add(r'total')
            ..add(serializers.serialize(object.total,
                specifiedType: const FullType(int)));
        return result;
    }

    @override
    DashboardEvent deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = DashboardEventBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'year':
                    result.year = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'month':
                    result.month = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
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

