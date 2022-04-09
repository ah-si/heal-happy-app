//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'donations_month_data.g.dart';

/// DonationsMonthData
///
/// Properties:
/// * [total] 
/// * [currency] 
/// * [donations] 
abstract class DonationsMonthData implements Built<DonationsMonthData, DonationsMonthDataBuilder> {
    @BuiltValueField(wireName: r'total')
    int get total;

    @BuiltValueField(wireName: r'currency')
    String get currency;

    @BuiltValueField(wireName: r'donations')
    BuiltMap<String, int> get donations;

    DonationsMonthData._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(DonationsMonthDataBuilder b) => b;

    factory DonationsMonthData([void updates(DonationsMonthDataBuilder b)]) = _$DonationsMonthData;

    @BuiltValueSerializer(custom: true)
    static Serializer<DonationsMonthData> get serializer => _$DonationsMonthDataSerializer();
}

class _$DonationsMonthDataSerializer implements StructuredSerializer<DonationsMonthData> {
    @override
    final Iterable<Type> types = const [DonationsMonthData, _$DonationsMonthData];

    @override
    final String wireName = r'DonationsMonthData';

    @override
    Iterable<Object?> serialize(Serializers serializers, DonationsMonthData object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'total')
            ..add(serializers.serialize(object.total,
                specifiedType: const FullType(int)));
        result
            ..add(r'currency')
            ..add(serializers.serialize(object.currency,
                specifiedType: const FullType(String)));
        result
            ..add(r'donations')
            ..add(serializers.serialize(object.donations,
                specifiedType: const FullType(BuiltMap, [FullType(String), FullType(int)])));
        return result;
    }

    @override
    DonationsMonthData deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = DonationsMonthDataBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'total':
                    result.total = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'currency':
                    result.currency = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'donations':
                    result.donations.replace(serializers.deserialize(value,
                        specifiedType: const FullType(BuiltMap, [FullType(String), FullType(int)])) as BuiltMap<String, int>);
                    break;
            }
        }
        return result.build();
    }
}

