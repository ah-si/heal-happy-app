//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_settings.g.dart';

/// AppSettings
///
/// Properties:
/// * [enableUrgencyButton] 
abstract class AppSettings implements Built<AppSettings, AppSettingsBuilder> {
    @BuiltValueField(wireName: r'enableUrgencyButton')
    bool get enableUrgencyButton;

    AppSettings._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(AppSettingsBuilder b) => b;

    factory AppSettings([void updates(AppSettingsBuilder b)]) = _$AppSettings;

    @BuiltValueSerializer(custom: true)
    static Serializer<AppSettings> get serializer => _$AppSettingsSerializer();
}

class _$AppSettingsSerializer implements StructuredSerializer<AppSettings> {
    @override
    final Iterable<Type> types = const [AppSettings, _$AppSettings];

    @override
    final String wireName = r'AppSettings';

    @override
    Iterable<Object?> serialize(Serializers serializers, AppSettings object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'enableUrgencyButton')
            ..add(serializers.serialize(object.enableUrgencyButton,
                specifiedType: const FullType(bool)));
        return result;
    }

    @override
    AppSettings deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = AppSettingsBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'enableUrgencyButton':
                    result.enableUrgencyButton = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
            }
        }
        return result.build();
    }
}

