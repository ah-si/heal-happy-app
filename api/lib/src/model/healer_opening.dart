//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:heal_happy_sdk/src/model/opening_type.dart';
import 'package:heal_happy_sdk/src/model/healer.dart';
import 'package:heal_happy_sdk/src/model/opening_repeat_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'healer_opening.g.dart';

/// HealerOpening
///
/// Properties:
/// * [id] 
/// * [userId] 
/// * [roomId] 
/// * [type] 
/// * [user] 
/// * [repeat] 
/// * [start] 
/// * [end] 
abstract class HealerOpening implements Built<HealerOpening, HealerOpeningBuilder> {
    @BuiltValueField(wireName: r'id')
    String? get id;

    @BuiltValueField(wireName: r'userId')
    String get userId;

    @BuiltValueField(wireName: r'roomId')
    String? get roomId;

    @BuiltValueField(wireName: r'type')
    OpeningType get type;
    // enum typeEnum {  visio,  faceToFace,  unavailable,  };

    @BuiltValueField(wireName: r'user')
    Healer? get user;

    @BuiltValueField(wireName: r'repeat')
    OpeningRepeatType? get repeat;
    // enum repeatEnum {  daily,  weekly,  monthly,  };

    @BuiltValueField(wireName: r'start')
    DateTime get start;

    @BuiltValueField(wireName: r'end')
    DateTime get end;

    HealerOpening._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(HealerOpeningBuilder b) => b;

    factory HealerOpening([void updates(HealerOpeningBuilder b)]) = _$HealerOpening;

    @BuiltValueSerializer(custom: true)
    static Serializer<HealerOpening> get serializer => _$HealerOpeningSerializer();
}

class _$HealerOpeningSerializer implements StructuredSerializer<HealerOpening> {
    @override
    final Iterable<Type> types = const [HealerOpening, _$HealerOpening];

    @override
    final String wireName = r'HealerOpening';

    @override
    Iterable<Object?> serialize(Serializers serializers, HealerOpening object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.id != null) {
            result
                ..add(r'id')
                ..add(serializers.serialize(object.id,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'userId')
            ..add(serializers.serialize(object.userId,
                specifiedType: const FullType(String)));
        if (object.roomId != null) {
            result
                ..add(r'roomId')
                ..add(serializers.serialize(object.roomId,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'type')
            ..add(serializers.serialize(object.type,
                specifiedType: const FullType(OpeningType)));
        if (object.user != null) {
            result
                ..add(r'user')
                ..add(serializers.serialize(object.user,
                    specifiedType: const FullType(Healer)));
        }
        if (object.repeat != null) {
            result
                ..add(r'repeat')
                ..add(serializers.serialize(object.repeat,
                    specifiedType: const FullType(OpeningRepeatType)));
        }
        result
            ..add(r'start')
            ..add(serializers.serialize(object.start,
                specifiedType: const FullType(DateTime)));
        result
            ..add(r'end')
            ..add(serializers.serialize(object.end,
                specifiedType: const FullType(DateTime)));
        return result;
    }

    @override
    HealerOpening deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = HealerOpeningBuilder();

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
                case r'userId':
                    result.userId = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'roomId':
                    result.roomId = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'type':
                    result.type = serializers.deserialize(value,
                        specifiedType: const FullType(OpeningType)) as OpeningType;
                    break;
                case r'user':
                    result.user.replace(serializers.deserialize(value,
                        specifiedType: const FullType(Healer)) as Healer);
                    break;
                case r'repeat':
                    result.repeat = serializers.deserialize(value,
                        specifiedType: const FullType(OpeningRepeatType)) as OpeningRepeatType;
                    break;
                case r'start':
                    result.start = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    break;
                case r'end':
                    result.end = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    break;
            }
        }
        return result.build();
    }
}

