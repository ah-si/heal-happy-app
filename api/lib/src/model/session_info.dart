//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'session_info.g.dart';

/// SessionInfo
///
/// Properties:
/// * [id] 
/// * [url] 
abstract class SessionInfo implements Built<SessionInfo, SessionInfoBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'url')
    String get url;

    SessionInfo._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SessionInfoBuilder b) => b;

    factory SessionInfo([void updates(SessionInfoBuilder b)]) = _$SessionInfo;

    @BuiltValueSerializer(custom: true)
    static Serializer<SessionInfo> get serializer => _$SessionInfoSerializer();
}

class _$SessionInfoSerializer implements StructuredSerializer<SessionInfo> {
    @override
    final Iterable<Type> types = const [SessionInfo, _$SessionInfo];

    @override
    final String wireName = r'SessionInfo';

    @override
    Iterable<Object?> serialize(Serializers serializers, SessionInfo object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(String)));
        result
            ..add(r'url')
            ..add(serializers.serialize(object.url,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    SessionInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SessionInfoBuilder();

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
                case r'url':
                    result.url = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
            }
        }
        return result.build();
    }
}

