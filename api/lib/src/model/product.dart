//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product.g.dart';

/// Product
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [currency] 
/// * [isRecurrent] 
/// * [price] 
abstract class Product implements Built<Product, ProductBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'name')
    String get name;

    @BuiltValueField(wireName: r'currency')
    String get currency;

    @BuiltValueField(wireName: r'isRecurrent')
    bool get isRecurrent;

    @BuiltValueField(wireName: r'price')
    int get price;

    Product._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(ProductBuilder b) => b;

    factory Product([void updates(ProductBuilder b)]) = _$Product;

    @BuiltValueSerializer(custom: true)
    static Serializer<Product> get serializer => _$ProductSerializer();
}

class _$ProductSerializer implements StructuredSerializer<Product> {
    @override
    final Iterable<Type> types = const [Product, _$Product];

    @override
    final String wireName = r'Product';

    @override
    Iterable<Object?> serialize(Serializers serializers, Product object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(String)));
        result
            ..add(r'name')
            ..add(serializers.serialize(object.name,
                specifiedType: const FullType(String)));
        result
            ..add(r'currency')
            ..add(serializers.serialize(object.currency,
                specifiedType: const FullType(String)));
        result
            ..add(r'isRecurrent')
            ..add(serializers.serialize(object.isRecurrent,
                specifiedType: const FullType(bool)));
        result
            ..add(r'price')
            ..add(serializers.serialize(object.price,
                specifiedType: const FullType(int)));
        return result;
    }

    @override
    Product deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = ProductBuilder();

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
                case r'name':
                    result.name = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'currency':
                    result.currency = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'isRecurrent':
                    result.isRecurrent = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'price':
                    result.price = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
            }
        }
        return result.build();
    }
}

