//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'healer_stats.g.dart';

/// HealerStats
///
/// Properties:
/// * [id] 
/// * [totalEvents] 
/// * [totalDuration] 
/// * [street] 
/// * [street2] 
/// * [city] 
/// * [zipCode] 
/// * [firstName] 
/// * [lastName] 
/// * [email] 
/// * [mobile] 
/// * [job] 
abstract class HealerStats implements Built<HealerStats, HealerStatsBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'totalEvents')
    int get totalEvents;

    @BuiltValueField(wireName: r'totalDuration')
    int get totalDuration;

    @BuiltValueField(wireName: r'street')
    String? get street;

    @BuiltValueField(wireName: r'street2')
    String? get street2;

    @BuiltValueField(wireName: r'city')
    String get city;

    @BuiltValueField(wireName: r'zipCode')
    String get zipCode;

    @BuiltValueField(wireName: r'firstName')
    String get firstName;

    @BuiltValueField(wireName: r'lastName')
    String get lastName;

    @BuiltValueField(wireName: r'email')
    String get email;

    @BuiltValueField(wireName: r'mobile')
    String? get mobile;

    @BuiltValueField(wireName: r'job')
    String get job;

    HealerStats._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(HealerStatsBuilder b) => b;

    factory HealerStats([void updates(HealerStatsBuilder b)]) = _$HealerStats;

    @BuiltValueSerializer(custom: true)
    static Serializer<HealerStats> get serializer => _$HealerStatsSerializer();
}

class _$HealerStatsSerializer implements StructuredSerializer<HealerStats> {
    @override
    final Iterable<Type> types = const [HealerStats, _$HealerStats];

    @override
    final String wireName = r'HealerStats';

    @override
    Iterable<Object?> serialize(Serializers serializers, HealerStats object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(String)));
        result
            ..add(r'totalEvents')
            ..add(serializers.serialize(object.totalEvents,
                specifiedType: const FullType(int)));
        result
            ..add(r'totalDuration')
            ..add(serializers.serialize(object.totalDuration,
                specifiedType: const FullType(int)));
        if (object.street != null) {
            result
                ..add(r'street')
                ..add(serializers.serialize(object.street,
                    specifiedType: const FullType(String)));
        }
        if (object.street2 != null) {
            result
                ..add(r'street2')
                ..add(serializers.serialize(object.street2,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'city')
            ..add(serializers.serialize(object.city,
                specifiedType: const FullType(String)));
        result
            ..add(r'zipCode')
            ..add(serializers.serialize(object.zipCode,
                specifiedType: const FullType(String)));
        result
            ..add(r'firstName')
            ..add(serializers.serialize(object.firstName,
                specifiedType: const FullType(String)));
        result
            ..add(r'lastName')
            ..add(serializers.serialize(object.lastName,
                specifiedType: const FullType(String)));
        result
            ..add(r'email')
            ..add(serializers.serialize(object.email,
                specifiedType: const FullType(String)));
        if (object.mobile != null) {
            result
                ..add(r'mobile')
                ..add(serializers.serialize(object.mobile,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'job')
            ..add(serializers.serialize(object.job,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    HealerStats deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = HealerStatsBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'id':
                    result.id = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'totalEvents':
                    result.totalEvents = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'totalDuration':
                    result.totalDuration = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'street':
                    result.street = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'street2':
                    result.street2 = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'city':
                    result.city = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'zipCode':
                    result.zipCode = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'firstName':
                    result.firstName = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'lastName':
                    result.lastName = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'email':
                    result.email = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'mobile':
                    result.mobile = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'job':
                    result.job = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
            }
        }
        return result.build();
    }
}

