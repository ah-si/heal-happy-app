//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:heal_happy_sdk/src/model/donations_month_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'donations_data.g.dart';

/// DonationsData
///
/// Properties:
/// * [current] 
/// * [previous] 
abstract class DonationsData implements Built<DonationsData, DonationsDataBuilder> {
    @BuiltValueField(wireName: r'current')
    DonationsMonthData get current;

    @BuiltValueField(wireName: r'previous')
    DonationsMonthData get previous;

    DonationsData._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(DonationsDataBuilder b) => b;

    factory DonationsData([void updates(DonationsDataBuilder b)]) = _$DonationsData;

    @BuiltValueSerializer(custom: true)
    static Serializer<DonationsData> get serializer => _$DonationsDataSerializer();
}

class _$DonationsDataSerializer implements StructuredSerializer<DonationsData> {
    @override
    final Iterable<Type> types = const [DonationsData, _$DonationsData];

    @override
    final String wireName = r'DonationsData';

    @override
    Iterable<Object?> serialize(Serializers serializers, DonationsData object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'current')
            ..add(serializers.serialize(object.current,
                specifiedType: const FullType(DonationsMonthData)));
        result
            ..add(r'previous')
            ..add(serializers.serialize(object.previous,
                specifiedType: const FullType(DonationsMonthData)));
        return result;
    }

    @override
    DonationsData deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = DonationsDataBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'current':
                    result.current.replace(serializers.deserialize(value,
                        specifiedType: const FullType(DonationsMonthData)) as DonationsMonthData);
                    break;
                case r'previous':
                    result.previous.replace(serializers.deserialize(value,
                        specifiedType: const FullType(DonationsMonthData)) as DonationsMonthData);
                    break;
            }
        }
        return result.build();
    }
}

