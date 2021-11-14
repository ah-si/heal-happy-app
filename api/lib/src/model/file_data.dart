//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_data.g.dart';

/// FileData
///
/// Properties:
/// * [path] 
abstract class FileData implements Built<FileData, FileDataBuilder> {
    @BuiltValueField(wireName: r'path')
    String get path;

    FileData._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(FileDataBuilder b) => b;

    factory FileData([void updates(FileDataBuilder b)]) = _$FileData;

    @BuiltValueSerializer(custom: true)
    static Serializer<FileData> get serializer => _$FileDataSerializer();
}

class _$FileDataSerializer implements StructuredSerializer<FileData> {
    @override
    final Iterable<Type> types = const [FileData, _$FileData];

    @override
    final String wireName = r'FileData';

    @override
    Iterable<Object?> serialize(Serializers serializers, FileData object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'path')
            ..add(serializers.serialize(object.path,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    FileData deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = FileDataBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'path':
                    result.path = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
            }
        }
        return result.build();
    }
}

