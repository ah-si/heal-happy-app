//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:heal_happy_sdk/src/model/admin_user_event.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'paginated_events.g.dart';

/// PaginatedEvents
///
/// Properties:
/// * [totalPages] 
/// * [events] 
abstract class PaginatedEvents implements Built<PaginatedEvents, PaginatedEventsBuilder> {
    @BuiltValueField(wireName: r'totalPages')
    int get totalPages;

    @BuiltValueField(wireName: r'events')
    BuiltList<AdminUserEvent> get events;

    PaginatedEvents._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(PaginatedEventsBuilder b) => b;

    factory PaginatedEvents([void updates(PaginatedEventsBuilder b)]) = _$PaginatedEvents;

    @BuiltValueSerializer(custom: true)
    static Serializer<PaginatedEvents> get serializer => _$PaginatedEventsSerializer();
}

class _$PaginatedEventsSerializer implements StructuredSerializer<PaginatedEvents> {
    @override
    final Iterable<Type> types = const [PaginatedEvents, _$PaginatedEvents];

    @override
    final String wireName = r'PaginatedEvents';

    @override
    Iterable<Object?> serialize(Serializers serializers, PaginatedEvents object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'totalPages')
            ..add(serializers.serialize(object.totalPages,
                specifiedType: const FullType(int)));
        result
            ..add(r'events')
            ..add(serializers.serialize(object.events,
                specifiedType: const FullType(BuiltList, [FullType(AdminUserEvent)])));
        return result;
    }

    @override
    PaginatedEvents deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = PaginatedEventsBuilder();

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
                case r'events':
                    result.events.replace(serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(AdminUserEvent)])) as BuiltList<AdminUserEvent>);
                    break;
            }
        }
        return result.build();
    }
}

