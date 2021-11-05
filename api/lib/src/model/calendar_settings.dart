//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:heal_happy_sdk/src/model/calendar_day_settings.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'calendar_settings.g.dart';

/// CalendarSettings
///
/// Properties:
/// * [monday] 
/// * [tuesday] 
/// * [wednesday] 
/// * [thursday] 
/// * [friday] 
/// * [saturday] 
/// * [sunday] 
abstract class CalendarSettings implements Built<CalendarSettings, CalendarSettingsBuilder> {
    @BuiltValueField(wireName: r'monday')
    CalendarDaySettings? get monday;

    @BuiltValueField(wireName: r'tuesday')
    CalendarDaySettings? get tuesday;

    @BuiltValueField(wireName: r'wednesday')
    CalendarDaySettings? get wednesday;

    @BuiltValueField(wireName: r'thursday')
    CalendarDaySettings? get thursday;

    @BuiltValueField(wireName: r'friday')
    CalendarDaySettings? get friday;

    @BuiltValueField(wireName: r'saturday')
    CalendarDaySettings? get saturday;

    @BuiltValueField(wireName: r'sunday')
    CalendarDaySettings? get sunday;

    CalendarSettings._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(CalendarSettingsBuilder b) => b;

    factory CalendarSettings([void updates(CalendarSettingsBuilder b)]) = _$CalendarSettings;

    @BuiltValueSerializer(custom: true)
    static Serializer<CalendarSettings> get serializer => _$CalendarSettingsSerializer();
}

class _$CalendarSettingsSerializer implements StructuredSerializer<CalendarSettings> {
    @override
    final Iterable<Type> types = const [CalendarSettings, _$CalendarSettings];

    @override
    final String wireName = r'CalendarSettings';

    @override
    Iterable<Object?> serialize(Serializers serializers, CalendarSettings object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.monday != null) {
            result
                ..add(r'monday')
                ..add(serializers.serialize(object.monday,
                    specifiedType: const FullType(CalendarDaySettings)));
        }
        if (object.tuesday != null) {
            result
                ..add(r'tuesday')
                ..add(serializers.serialize(object.tuesday,
                    specifiedType: const FullType(CalendarDaySettings)));
        }
        if (object.wednesday != null) {
            result
                ..add(r'wednesday')
                ..add(serializers.serialize(object.wednesday,
                    specifiedType: const FullType(CalendarDaySettings)));
        }
        if (object.thursday != null) {
            result
                ..add(r'thursday')
                ..add(serializers.serialize(object.thursday,
                    specifiedType: const FullType(CalendarDaySettings)));
        }
        if (object.friday != null) {
            result
                ..add(r'friday')
                ..add(serializers.serialize(object.friday,
                    specifiedType: const FullType(CalendarDaySettings)));
        }
        if (object.saturday != null) {
            result
                ..add(r'saturday')
                ..add(serializers.serialize(object.saturday,
                    specifiedType: const FullType(CalendarDaySettings)));
        }
        if (object.sunday != null) {
            result
                ..add(r'sunday')
                ..add(serializers.serialize(object.sunday,
                    specifiedType: const FullType(CalendarDaySettings)));
        }
        return result;
    }

    @override
    CalendarSettings deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = CalendarSettingsBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'monday':
                    result.monday.replace(serializers.deserialize(value,
                        specifiedType: const FullType(CalendarDaySettings)) as CalendarDaySettings);
                    break;
                case r'tuesday':
                    result.tuesday.replace(serializers.deserialize(value,
                        specifiedType: const FullType(CalendarDaySettings)) as CalendarDaySettings);
                    break;
                case r'wednesday':
                    result.wednesday.replace(serializers.deserialize(value,
                        specifiedType: const FullType(CalendarDaySettings)) as CalendarDaySettings);
                    break;
                case r'thursday':
                    result.thursday.replace(serializers.deserialize(value,
                        specifiedType: const FullType(CalendarDaySettings)) as CalendarDaySettings);
                    break;
                case r'friday':
                    result.friday.replace(serializers.deserialize(value,
                        specifiedType: const FullType(CalendarDaySettings)) as CalendarDaySettings);
                    break;
                case r'saturday':
                    result.saturday.replace(serializers.deserialize(value,
                        specifiedType: const FullType(CalendarDaySettings)) as CalendarDaySettings);
                    break;
                case r'sunday':
                    result.sunday.replace(serializers.deserialize(value,
                        specifiedType: const FullType(CalendarDaySettings)) as CalendarDaySettings);
                    break;
            }
        }
        return result.build();
    }
}

