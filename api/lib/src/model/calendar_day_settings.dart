//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'calendar_day_settings.g.dart';

/// CalendarDaySettings
///
/// Properties:
/// * [startHour] 
/// * [startMinute] 
/// * [endHour] 
/// * [endMinute] 
/// * [start2Hour] 
/// * [start2Minute] 
/// * [end2Hour] 
/// * [end2Minute] 
abstract class CalendarDaySettings implements Built<CalendarDaySettings, CalendarDaySettingsBuilder> {
    @BuiltValueField(wireName: r'startHour')
    int? get startHour;

    @BuiltValueField(wireName: r'startMinute')
    int? get startMinute;

    @BuiltValueField(wireName: r'endHour')
    int? get endHour;

    @BuiltValueField(wireName: r'endMinute')
    int? get endMinute;

    @BuiltValueField(wireName: r'start2Hour')
    int? get start2Hour;

    @BuiltValueField(wireName: r'start2Minute')
    int? get start2Minute;

    @BuiltValueField(wireName: r'end2Hour')
    int? get end2Hour;

    @BuiltValueField(wireName: r'end2Minute')
    int? get end2Minute;

    CalendarDaySettings._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(CalendarDaySettingsBuilder b) => b;

    factory CalendarDaySettings([void updates(CalendarDaySettingsBuilder b)]) = _$CalendarDaySettings;

    @BuiltValueSerializer(custom: true)
    static Serializer<CalendarDaySettings> get serializer => _$CalendarDaySettingsSerializer();
}

class _$CalendarDaySettingsSerializer implements StructuredSerializer<CalendarDaySettings> {
    @override
    final Iterable<Type> types = const [CalendarDaySettings, _$CalendarDaySettings];

    @override
    final String wireName = r'CalendarDaySettings';

    @override
    Iterable<Object?> serialize(Serializers serializers, CalendarDaySettings object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.startHour != null) {
            result
                ..add(r'startHour')
                ..add(serializers.serialize(object.startHour,
                    specifiedType: const FullType(int)));
        }
        if (object.startMinute != null) {
            result
                ..add(r'startMinute')
                ..add(serializers.serialize(object.startMinute,
                    specifiedType: const FullType(int)));
        }
        if (object.endHour != null) {
            result
                ..add(r'endHour')
                ..add(serializers.serialize(object.endHour,
                    specifiedType: const FullType(int)));
        }
        if (object.endMinute != null) {
            result
                ..add(r'endMinute')
                ..add(serializers.serialize(object.endMinute,
                    specifiedType: const FullType(int)));
        }
        if (object.start2Hour != null) {
            result
                ..add(r'start2Hour')
                ..add(serializers.serialize(object.start2Hour,
                    specifiedType: const FullType(int)));
        }
        if (object.start2Minute != null) {
            result
                ..add(r'start2Minute')
                ..add(serializers.serialize(object.start2Minute,
                    specifiedType: const FullType(int)));
        }
        if (object.end2Hour != null) {
            result
                ..add(r'end2Hour')
                ..add(serializers.serialize(object.end2Hour,
                    specifiedType: const FullType(int)));
        }
        if (object.end2Minute != null) {
            result
                ..add(r'end2Minute')
                ..add(serializers.serialize(object.end2Minute,
                    specifiedType: const FullType(int)));
        }
        return result;
    }

    @override
    CalendarDaySettings deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = CalendarDaySettingsBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'startHour':
                    result.startHour = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'startMinute':
                    result.startMinute = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'endHour':
                    result.endHour = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'endMinute':
                    result.endMinute = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'start2Hour':
                    result.start2Hour = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'start2Minute':
                    result.start2Minute = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'end2Hour':
                    result.end2Hour = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'end2Minute':
                    result.end2Minute = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
            }
        }
        return result.build();
    }
}

