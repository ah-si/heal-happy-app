//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:heal_happy_sdk/src/model/user_type_enum.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'healer.g.dart';

/// Healer
///
/// Properties:
/// * [id] 
/// * [isVerified] 
/// * [isActivated] 
/// * [canDoFaceToFace] 
/// * [job] 
/// * [firstName] 
/// * [consultationDuration] 
/// * [isAddressPublic] 
/// * [isTermsAccepted] 
/// * [versionTermsAccepted] 
/// * [lang] 
/// * [type] 
/// * [experiences] 
/// * [description] 
/// * [diploma] 
/// * [website] 
/// * [social1] 
/// * [social2] 
/// * [social3] 
/// * [lastName] 
/// * [street] 
/// * [street2] 
/// * [zipCode] 
/// * [country] 
/// * [city] 
/// * [avatar] 
abstract class Healer implements Built<Healer, HealerBuilder> {
    @BuiltValueField(wireName: r'id')
    String? get id;

    @BuiltValueField(wireName: r'isVerified')
    bool get isVerified;

    @BuiltValueField(wireName: r'isActivated')
    bool get isActivated;

    @BuiltValueField(wireName: r'canDoFaceToFace')
    bool? get canDoFaceToFace;

    @BuiltValueField(wireName: r'job')
    String? get job;

    @BuiltValueField(wireName: r'firstName')
    String get firstName;

    @BuiltValueField(wireName: r'consultationDuration')
    int? get consultationDuration;

    @BuiltValueField(wireName: r'isAddressPublic')
    bool get isAddressPublic;

    @BuiltValueField(wireName: r'isTermsAccepted')
    bool get isTermsAccepted;

    @BuiltValueField(wireName: r'versionTermsAccepted')
    String? get versionTermsAccepted;

    @BuiltValueField(wireName: r'lang')
    String get lang;

    @BuiltValueField(wireName: r'type')
    UserTypeEnum get type;
    // enum typeEnum {  admin,  patient,  healer,  };

    @BuiltValueField(wireName: r'experiences')
    String? get experiences;

    @BuiltValueField(wireName: r'description')
    String? get description;

    @BuiltValueField(wireName: r'diploma')
    String? get diploma;

    @BuiltValueField(wireName: r'website')
    String? get website;

    @BuiltValueField(wireName: r'social1')
    String? get social1;

    @BuiltValueField(wireName: r'social2')
    String? get social2;

    @BuiltValueField(wireName: r'social3')
    String? get social3;

    @BuiltValueField(wireName: r'lastName')
    String get lastName;

    @BuiltValueField(wireName: r'street')
    String? get street;

    @BuiltValueField(wireName: r'street2')
    String? get street2;

    @BuiltValueField(wireName: r'zipCode')
    String get zipCode;

    @BuiltValueField(wireName: r'country')
    String get country;

    @BuiltValueField(wireName: r'city')
    String get city;

    @BuiltValueField(wireName: r'avatar')
    String? get avatar;

    Healer._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(HealerBuilder b) => b
        ..isAddressPublic = false;

    factory Healer([void updates(HealerBuilder b)]) = _$Healer;

    @BuiltValueSerializer(custom: true)
    static Serializer<Healer> get serializer => _$HealerSerializer();
}

class _$HealerSerializer implements StructuredSerializer<Healer> {
    @override
    final Iterable<Type> types = const [Healer, _$Healer];

    @override
    final String wireName = r'Healer';

    @override
    Iterable<Object?> serialize(Serializers serializers, Healer object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.id != null) {
            result
                ..add(r'id')
                ..add(serializers.serialize(object.id,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'isVerified')
            ..add(serializers.serialize(object.isVerified,
                specifiedType: const FullType(bool)));
        result
            ..add(r'isActivated')
            ..add(serializers.serialize(object.isActivated,
                specifiedType: const FullType(bool)));
        if (object.canDoFaceToFace != null) {
            result
                ..add(r'canDoFaceToFace')
                ..add(serializers.serialize(object.canDoFaceToFace,
                    specifiedType: const FullType(bool)));
        }
        if (object.job != null) {
            result
                ..add(r'job')
                ..add(serializers.serialize(object.job,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'firstName')
            ..add(serializers.serialize(object.firstName,
                specifiedType: const FullType(String)));
        result
            ..add(r'consultationDuration')
            ..add(object.consultationDuration == null ? null : serializers.serialize(object.consultationDuration,
                specifiedType: const FullType(int)));
        result
            ..add(r'isAddressPublic')
            ..add(serializers.serialize(object.isAddressPublic,
                specifiedType: const FullType(bool)));
        result
            ..add(r'isTermsAccepted')
            ..add(serializers.serialize(object.isTermsAccepted,
                specifiedType: const FullType(bool)));
        if (object.versionTermsAccepted != null) {
            result
                ..add(r'versionTermsAccepted')
                ..add(serializers.serialize(object.versionTermsAccepted,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'lang')
            ..add(serializers.serialize(object.lang,
                specifiedType: const FullType(String)));
        result
            ..add(r'type')
            ..add(serializers.serialize(object.type,
                specifiedType: const FullType(UserTypeEnum)));
        if (object.experiences != null) {
            result
                ..add(r'experiences')
                ..add(serializers.serialize(object.experiences,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'description')
            ..add(object.description == null ? null : serializers.serialize(object.description,
                specifiedType: const FullType(String)));
        if (object.diploma != null) {
            result
                ..add(r'diploma')
                ..add(serializers.serialize(object.diploma,
                    specifiedType: const FullType(String)));
        }
        if (object.website != null) {
            result
                ..add(r'website')
                ..add(serializers.serialize(object.website,
                    specifiedType: const FullType(String)));
        }
        if (object.social1 != null) {
            result
                ..add(r'social1')
                ..add(serializers.serialize(object.social1,
                    specifiedType: const FullType(String)));
        }
        if (object.social2 != null) {
            result
                ..add(r'social2')
                ..add(serializers.serialize(object.social2,
                    specifiedType: const FullType(String)));
        }
        if (object.social3 != null) {
            result
                ..add(r'social3')
                ..add(serializers.serialize(object.social3,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'lastName')
            ..add(serializers.serialize(object.lastName,
                specifiedType: const FullType(String)));
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
            ..add(r'zipCode')
            ..add(serializers.serialize(object.zipCode,
                specifiedType: const FullType(String)));
        result
            ..add(r'country')
            ..add(serializers.serialize(object.country,
                specifiedType: const FullType(String)));
        result
            ..add(r'city')
            ..add(serializers.serialize(object.city,
                specifiedType: const FullType(String)));
        if (object.avatar != null) {
            result
                ..add(r'avatar')
                ..add(serializers.serialize(object.avatar,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    Healer deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = HealerBuilder();

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
                case r'isVerified':
                    result.isVerified = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'isActivated':
                    result.isActivated = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'canDoFaceToFace':
                    result.canDoFaceToFace = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'job':
                    result.job = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'firstName':
                    result.firstName = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'consultationDuration':
                    result.consultationDuration = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'isAddressPublic':
                    result.isAddressPublic = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'isTermsAccepted':
                    result.isTermsAccepted = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    break;
                case r'versionTermsAccepted':
                    result.versionTermsAccepted = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'lang':
                    result.lang = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'type':
                    result.type = serializers.deserialize(value,
                        specifiedType: const FullType(UserTypeEnum)) as UserTypeEnum;
                    break;
                case r'experiences':
                    result.experiences = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'description':
                    result.description = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'diploma':
                    result.diploma = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'website':
                    result.website = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'social1':
                    result.social1 = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'social2':
                    result.social2 = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'social3':
                    result.social3 = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'lastName':
                    result.lastName = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'street':
                    result.street = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'street2':
                    result.street2 = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'zipCode':
                    result.zipCode = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'country':
                    result.country = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'city':
                    result.city = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'avatar':
                    result.avatar = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
            }
        }
        return result.build();
    }
}

