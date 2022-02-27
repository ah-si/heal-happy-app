//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'slot.g.dart';

/// Slot
///
/// Properties:
/// * [roomId] 
/// * [slots] 
abstract class Slot implements Built<Slot, SlotBuilder> {
    @BuiltValueField(wireName: r'roomId')
    String? get roomId;

    @BuiltValueField(wireName: r'slots')
    BuiltList<DateTime> get slots;

    Slot._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SlotBuilder b) => b;

    factory Slot([void updates(SlotBuilder b)]) = _$Slot;

    @BuiltValueSerializer(custom: true)
    static Serializer<Slot> get serializer => _$SlotSerializer();
}

class _$SlotSerializer implements StructuredSerializer<Slot> {
    @override
    final Iterable<Type> types = const [Slot, _$Slot];

    @override
    final String wireName = r'Slot';

    @override
    Iterable<Object?> serialize(Serializers serializers, Slot object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.roomId != null) {
            result
                ..add(r'roomId')
                ..add(serializers.serialize(object.roomId,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'slots')
            ..add(serializers.serialize(object.slots,
                specifiedType: const FullType(BuiltList, [FullType(DateTime)])));
        return result;
    }

    @override
    Slot deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SlotBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'roomId':
                    result.roomId = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'slots':
                    result.slots.replace(serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(DateTime)])) as BuiltList<DateTime>);
                    break;
            }
        }
        return result.build();
    }
}

