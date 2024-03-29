// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$User extends User {
  @override
  final String? id;
  @override
  final bool isVerified;
  @override
  final bool isSuspended;
  @override
  final bool isSubscriptionValid;
  @override
  final DateTime? dateSubscription;
  @override
  final bool isBlocked;
  @override
  final bool isActivated;
  @override
  final bool? canDoFaceToFace;
  @override
  final String? job;
  @override
  final String firstName;
  @override
  final int? consultationDuration;
  @override
  final int? consultationPrice;
  @override
  final bool isAddressPublic;
  @override
  final bool isTermsAccepted;
  @override
  final String? versionTermsAccepted;
  @override
  final String lang;
  @override
  final UserTypeEnum type;
  @override
  final String? experiences;
  @override
  final String? description;
  @override
  final String? diploma;
  @override
  final String? website;
  @override
  final String? social1;
  @override
  final String? social2;
  @override
  final String? social3;
  @override
  final String lastName;
  @override
  final String? street;
  @override
  final String? street2;
  @override
  final String zipCode;
  @override
  final String country;
  @override
  final String city;
  @override
  final String? avatar;
  @override
  final String email;
  @override
  final String? mobile;
  @override
  final String? password;

  factory _$User([void Function(UserBuilder)? updates]) =>
      (new UserBuilder()..update(updates))._build();

  _$User._(
      {this.id,
      required this.isVerified,
      required this.isSuspended,
      required this.isSubscriptionValid,
      this.dateSubscription,
      required this.isBlocked,
      required this.isActivated,
      this.canDoFaceToFace,
      this.job,
      required this.firstName,
      this.consultationDuration,
      this.consultationPrice,
      required this.isAddressPublic,
      required this.isTermsAccepted,
      this.versionTermsAccepted,
      required this.lang,
      required this.type,
      this.experiences,
      this.description,
      this.diploma,
      this.website,
      this.social1,
      this.social2,
      this.social3,
      required this.lastName,
      this.street,
      this.street2,
      required this.zipCode,
      required this.country,
      required this.city,
      this.avatar,
      required this.email,
      this.mobile,
      this.password})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(isVerified, r'User', 'isVerified');
    BuiltValueNullFieldError.checkNotNull(isSuspended, r'User', 'isSuspended');
    BuiltValueNullFieldError.checkNotNull(
        isSubscriptionValid, r'User', 'isSubscriptionValid');
    BuiltValueNullFieldError.checkNotNull(isBlocked, r'User', 'isBlocked');
    BuiltValueNullFieldError.checkNotNull(isActivated, r'User', 'isActivated');
    BuiltValueNullFieldError.checkNotNull(firstName, r'User', 'firstName');
    BuiltValueNullFieldError.checkNotNull(
        isAddressPublic, r'User', 'isAddressPublic');
    BuiltValueNullFieldError.checkNotNull(
        isTermsAccepted, r'User', 'isTermsAccepted');
    BuiltValueNullFieldError.checkNotNull(lang, r'User', 'lang');
    BuiltValueNullFieldError.checkNotNull(type, r'User', 'type');
    BuiltValueNullFieldError.checkNotNull(lastName, r'User', 'lastName');
    BuiltValueNullFieldError.checkNotNull(zipCode, r'User', 'zipCode');
    BuiltValueNullFieldError.checkNotNull(country, r'User', 'country');
    BuiltValueNullFieldError.checkNotNull(city, r'User', 'city');
    BuiltValueNullFieldError.checkNotNull(email, r'User', 'email');
  }

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        isVerified == other.isVerified &&
        isSuspended == other.isSuspended &&
        isSubscriptionValid == other.isSubscriptionValid &&
        dateSubscription == other.dateSubscription &&
        isBlocked == other.isBlocked &&
        isActivated == other.isActivated &&
        canDoFaceToFace == other.canDoFaceToFace &&
        job == other.job &&
        firstName == other.firstName &&
        consultationDuration == other.consultationDuration &&
        consultationPrice == other.consultationPrice &&
        isAddressPublic == other.isAddressPublic &&
        isTermsAccepted == other.isTermsAccepted &&
        versionTermsAccepted == other.versionTermsAccepted &&
        lang == other.lang &&
        type == other.type &&
        experiences == other.experiences &&
        description == other.description &&
        diploma == other.diploma &&
        website == other.website &&
        social1 == other.social1 &&
        social2 == other.social2 &&
        social3 == other.social3 &&
        lastName == other.lastName &&
        street == other.street &&
        street2 == other.street2 &&
        zipCode == other.zipCode &&
        country == other.country &&
        city == other.city &&
        avatar == other.avatar &&
        email == other.email &&
        mobile == other.mobile &&
        password == other.password;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, id.hashCode), isVerified.hashCode), isSuspended.hashCode), isSubscriptionValid.hashCode), dateSubscription.hashCode), isBlocked.hashCode), isActivated.hashCode), canDoFaceToFace.hashCode), job.hashCode), firstName.hashCode), consultationDuration.hashCode), consultationPrice.hashCode), isAddressPublic.hashCode), isTermsAccepted.hashCode), versionTermsAccepted.hashCode),
                                                                                lang.hashCode),
                                                                            type.hashCode),
                                                                        experiences.hashCode),
                                                                    description.hashCode),
                                                                diploma.hashCode),
                                                            website.hashCode),
                                                        social1.hashCode),
                                                    social2.hashCode),
                                                social3.hashCode),
                                            lastName.hashCode),
                                        street.hashCode),
                                    street2.hashCode),
                                zipCode.hashCode),
                            country.hashCode),
                        city.hashCode),
                    avatar.hashCode),
                email.hashCode),
            mobile.hashCode),
        password.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'User')
          ..add('id', id)
          ..add('isVerified', isVerified)
          ..add('isSuspended', isSuspended)
          ..add('isSubscriptionValid', isSubscriptionValid)
          ..add('dateSubscription', dateSubscription)
          ..add('isBlocked', isBlocked)
          ..add('isActivated', isActivated)
          ..add('canDoFaceToFace', canDoFaceToFace)
          ..add('job', job)
          ..add('firstName', firstName)
          ..add('consultationDuration', consultationDuration)
          ..add('consultationPrice', consultationPrice)
          ..add('isAddressPublic', isAddressPublic)
          ..add('isTermsAccepted', isTermsAccepted)
          ..add('versionTermsAccepted', versionTermsAccepted)
          ..add('lang', lang)
          ..add('type', type)
          ..add('experiences', experiences)
          ..add('description', description)
          ..add('diploma', diploma)
          ..add('website', website)
          ..add('social1', social1)
          ..add('social2', social2)
          ..add('social3', social3)
          ..add('lastName', lastName)
          ..add('street', street)
          ..add('street2', street2)
          ..add('zipCode', zipCode)
          ..add('country', country)
          ..add('city', city)
          ..add('avatar', avatar)
          ..add('email', email)
          ..add('mobile', mobile)
          ..add('password', password))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  bool? _isVerified;
  bool? get isVerified => _$this._isVerified;
  set isVerified(bool? isVerified) => _$this._isVerified = isVerified;

  bool? _isSuspended;
  bool? get isSuspended => _$this._isSuspended;
  set isSuspended(bool? isSuspended) => _$this._isSuspended = isSuspended;

  bool? _isSubscriptionValid;
  bool? get isSubscriptionValid => _$this._isSubscriptionValid;
  set isSubscriptionValid(bool? isSubscriptionValid) =>
      _$this._isSubscriptionValid = isSubscriptionValid;

  DateTime? _dateSubscription;
  DateTime? get dateSubscription => _$this._dateSubscription;
  set dateSubscription(DateTime? dateSubscription) =>
      _$this._dateSubscription = dateSubscription;

  bool? _isBlocked;
  bool? get isBlocked => _$this._isBlocked;
  set isBlocked(bool? isBlocked) => _$this._isBlocked = isBlocked;

  bool? _isActivated;
  bool? get isActivated => _$this._isActivated;
  set isActivated(bool? isActivated) => _$this._isActivated = isActivated;

  bool? _canDoFaceToFace;
  bool? get canDoFaceToFace => _$this._canDoFaceToFace;
  set canDoFaceToFace(bool? canDoFaceToFace) =>
      _$this._canDoFaceToFace = canDoFaceToFace;

  String? _job;
  String? get job => _$this._job;
  set job(String? job) => _$this._job = job;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  int? _consultationDuration;
  int? get consultationDuration => _$this._consultationDuration;
  set consultationDuration(int? consultationDuration) =>
      _$this._consultationDuration = consultationDuration;

  int? _consultationPrice;
  int? get consultationPrice => _$this._consultationPrice;
  set consultationPrice(int? consultationPrice) =>
      _$this._consultationPrice = consultationPrice;

  bool? _isAddressPublic;
  bool? get isAddressPublic => _$this._isAddressPublic;
  set isAddressPublic(bool? isAddressPublic) =>
      _$this._isAddressPublic = isAddressPublic;

  bool? _isTermsAccepted;
  bool? get isTermsAccepted => _$this._isTermsAccepted;
  set isTermsAccepted(bool? isTermsAccepted) =>
      _$this._isTermsAccepted = isTermsAccepted;

  String? _versionTermsAccepted;
  String? get versionTermsAccepted => _$this._versionTermsAccepted;
  set versionTermsAccepted(String? versionTermsAccepted) =>
      _$this._versionTermsAccepted = versionTermsAccepted;

  String? _lang;
  String? get lang => _$this._lang;
  set lang(String? lang) => _$this._lang = lang;

  UserTypeEnum? _type;
  UserTypeEnum? get type => _$this._type;
  set type(UserTypeEnum? type) => _$this._type = type;

  String? _experiences;
  String? get experiences => _$this._experiences;
  set experiences(String? experiences) => _$this._experiences = experiences;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _diploma;
  String? get diploma => _$this._diploma;
  set diploma(String? diploma) => _$this._diploma = diploma;

  String? _website;
  String? get website => _$this._website;
  set website(String? website) => _$this._website = website;

  String? _social1;
  String? get social1 => _$this._social1;
  set social1(String? social1) => _$this._social1 = social1;

  String? _social2;
  String? get social2 => _$this._social2;
  set social2(String? social2) => _$this._social2 = social2;

  String? _social3;
  String? get social3 => _$this._social3;
  set social3(String? social3) => _$this._social3 = social3;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _street;
  String? get street => _$this._street;
  set street(String? street) => _$this._street = street;

  String? _street2;
  String? get street2 => _$this._street2;
  set street2(String? street2) => _$this._street2 = street2;

  String? _zipCode;
  String? get zipCode => _$this._zipCode;
  set zipCode(String? zipCode) => _$this._zipCode = zipCode;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _avatar;
  String? get avatar => _$this._avatar;
  set avatar(String? avatar) => _$this._avatar = avatar;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _mobile;
  String? get mobile => _$this._mobile;
  set mobile(String? mobile) => _$this._mobile = mobile;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  UserBuilder() {
    User._defaults(this);
  }

  UserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _isVerified = $v.isVerified;
      _isSuspended = $v.isSuspended;
      _isSubscriptionValid = $v.isSubscriptionValid;
      _dateSubscription = $v.dateSubscription;
      _isBlocked = $v.isBlocked;
      _isActivated = $v.isActivated;
      _canDoFaceToFace = $v.canDoFaceToFace;
      _job = $v.job;
      _firstName = $v.firstName;
      _consultationDuration = $v.consultationDuration;
      _consultationPrice = $v.consultationPrice;
      _isAddressPublic = $v.isAddressPublic;
      _isTermsAccepted = $v.isTermsAccepted;
      _versionTermsAccepted = $v.versionTermsAccepted;
      _lang = $v.lang;
      _type = $v.type;
      _experiences = $v.experiences;
      _description = $v.description;
      _diploma = $v.diploma;
      _website = $v.website;
      _social1 = $v.social1;
      _social2 = $v.social2;
      _social3 = $v.social3;
      _lastName = $v.lastName;
      _street = $v.street;
      _street2 = $v.street2;
      _zipCode = $v.zipCode;
      _country = $v.country;
      _city = $v.city;
      _avatar = $v.avatar;
      _email = $v.email;
      _mobile = $v.mobile;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  User build() => _build();

  _$User _build() {
    final _$result = _$v ??
        new _$User._(
            id: id,
            isVerified: BuiltValueNullFieldError.checkNotNull(
                isVerified, r'User', 'isVerified'),
            isSuspended: BuiltValueNullFieldError.checkNotNull(
                isSuspended, r'User', 'isSuspended'),
            isSubscriptionValid: BuiltValueNullFieldError.checkNotNull(
                isSubscriptionValid, r'User', 'isSubscriptionValid'),
            dateSubscription: dateSubscription,
            isBlocked: BuiltValueNullFieldError.checkNotNull(
                isBlocked, r'User', 'isBlocked'),
            isActivated: BuiltValueNullFieldError.checkNotNull(
                isActivated, r'User', 'isActivated'),
            canDoFaceToFace: canDoFaceToFace,
            job: job,
            firstName: BuiltValueNullFieldError.checkNotNull(
                firstName, r'User', 'firstName'),
            consultationDuration: consultationDuration,
            consultationPrice: consultationPrice,
            isAddressPublic: BuiltValueNullFieldError.checkNotNull(
                isAddressPublic, r'User', 'isAddressPublic'),
            isTermsAccepted: BuiltValueNullFieldError.checkNotNull(
                isTermsAccepted, r'User', 'isTermsAccepted'),
            versionTermsAccepted: versionTermsAccepted,
            lang: BuiltValueNullFieldError.checkNotNull(lang, r'User', 'lang'),
            type: BuiltValueNullFieldError.checkNotNull(type, r'User', 'type'),
            experiences: experiences,
            description: description,
            diploma: diploma,
            website: website,
            social1: social1,
            social2: social2,
            social3: social3,
            lastName: BuiltValueNullFieldError.checkNotNull(
                lastName, r'User', 'lastName'),
            street: street,
            street2: street2,
            zipCode: BuiltValueNullFieldError.checkNotNull(zipCode, r'User', 'zipCode'),
            country: BuiltValueNullFieldError.checkNotNull(country, r'User', 'country'),
            city: BuiltValueNullFieldError.checkNotNull(city, r'User', 'city'),
            avatar: avatar,
            email: BuiltValueNullFieldError.checkNotNull(email, r'User', 'email'),
            mobile: mobile,
            password: password);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
