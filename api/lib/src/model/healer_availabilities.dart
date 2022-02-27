//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:heal_happy_sdk/src/model/slot.dart';

part 'healer_availabilities.g.dart';

/// HealerAvailabilities
///
/// Properties:
/// * [slots]
/// * [until]
abstract class HealerAvailabilities implements Built<HealerAvailabilities, HealerAvailabilitiesBuilder> {
    @BuiltValueField(wireName: r'slots')
    BuiltList<Slot> get slots;

    @BuiltValueField(wireName: r'until')
    String get until;

    HealerAvailabilities._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(HealerAvailabilitiesBuilder b) => b;

    factory HealerAvailabilities([void updates(HealerAvailabilitiesBuilder b)]) = _$HealerAvailabilities;

    @BuiltValueSerializer(custom: true)
    static Serializer<HealerAvailabilities> get serializer => _$HealerAvailabilitiesSerializer();
}

class _$HealerAvailabilitiesSerializer implements StructuredSerializer<HealerAvailabilities> {
    @override
    final Iterable<Type> types = const [HealerAvailabilities, _$HealerAvailabilities];

    @override
    final String wireName = r'HealerAvailabilities';

    @override
    Iterable<Object?> serialize(Serializers serializers, HealerAvailabilities object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'slots')
            ..add(serializers.serialize(object.slots,
                specifiedType: const FullType(BuiltList, [FullType(Slot)])));
        result
            ..add(r'until')
            ..add(serializers.serialize(object.until,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    HealerAvailabilities deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = HealerAvailabilitiesBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'slots':
                    result.slots.replace(serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(Slot)])) as BuiltList<Slot>);
                    break;
                case r'until':
                    result.until = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
            }
        }
        return result.build();
    }
}

