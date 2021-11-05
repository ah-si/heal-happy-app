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
  final bool isActivated;
  @override
  final String? job;
  @override
  final String firstName;
  @override
  final int? consultationDuration;
  @override
  final bool isAddressPublic;
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
  final CalendarSettings calendarSettings;
  @override
  final String? street;
  @override
  final String? street2;
  @override
  final String zipCode;
  @override
  final String? country;
  @override
  final String city;
  @override
  final Uint8List? avatar;
  @override
  final String email;
  @override
  final String? mobile;
  @override
  final String? password;

  factory _$User([void Function(UserBuilder)? updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._(
      {this.id,
      required this.isVerified,
      required this.isActivated,
      this.job,
      required this.firstName,
      this.consultationDuration,
      required this.isAddressPublic,
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
      required this.calendarSettings,
      this.street,
      this.street2,
      required this.zipCode,
      this.country,
      required this.city,
      this.avatar,
      required this.email,
      this.mobile,
      this.password})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(isVerified, 'User', 'isVerified');
    BuiltValueNullFieldError.checkNotNull(isActivated, 'User', 'isActivated');
    BuiltValueNullFieldError.checkNotNull(firstName, 'User', 'firstName');
    BuiltValueNullFieldError.checkNotNull(
        isAddressPublic, 'User', 'isAddressPublic');
    BuiltValueNullFieldError.checkNotNull(lang, 'User', 'lang');
    BuiltValueNullFieldError.checkNotNull(type, 'User', 'type');
    BuiltValueNullFieldError.checkNotNull(lastName, 'User', 'lastName');
    BuiltValueNullFieldError.checkNotNull(
        calendarSettings, 'User', 'calendarSettings');
    BuiltValueNullFieldError.checkNotNull(zipCode, 'User', 'zipCode');
    BuiltValueNullFieldError.checkNotNull(city, 'User', 'city');
    BuiltValueNullFieldError.checkNotNull(email, 'User', 'email');
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
        isActivated == other.isActivated &&
        job == other.job &&
        firstName == other.firstName &&
        consultationDuration == other.consultationDuration &&
        isAddressPublic == other.isAddressPublic &&
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
        calendarSettings == other.calendarSettings &&
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc(0, id.hashCode), isVerified.hashCode), isActivated.hashCode), job.hashCode), firstName.hashCode), consultationDuration.hashCode), isAddressPublic.hashCode), lang.hashCode),
                                                                                type.hashCode),
                                                                            experiences.hashCode),
                                                                        description.hashCode),
                                                                    diploma.hashCode),
                                                                website.hashCode),
                                                            social1.hashCode),
                                                        social2.hashCode),
                                                    social3.hashCode),
                                                lastName.hashCode),
                                            calendarSettings.hashCode),
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
    return (newBuiltValueToStringHelper('User')
          ..add('id', id)
          ..add('isVerified', isVerified)
          ..add('isActivated', isActivated)
          ..add('job', job)
          ..add('firstName', firstName)
          ..add('consultationDuration', consultationDuration)
          ..add('isAddressPublic', isAddressPublic)
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
          ..add('calendarSettings', calendarSettings)
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

  bool? _isActivated;
  bool? get isActivated => _$this._isActivated;
  set isActivated(bool? isActivated) => _$this._isActivated = isActivated;

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

  bool? _isAddressPublic;
  bool? get isAddressPublic => _$this._isAddressPublic;
  set isAddressPublic(bool? isAddressPublic) =>
      _$this._isAddressPublic = isAddressPublic;

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

  CalendarSettingsBuilder? _calendarSettings;
  CalendarSettingsBuilder get calendarSettings =>
      _$this._calendarSettings ??= new CalendarSettingsBuilder();
  set calendarSettings(CalendarSettingsBuilder? calendarSettings) =>
      _$this._calendarSettings = calendarSettings;

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

  Uint8List? _avatar;
  Uint8List? get avatar => _$this._avatar;
  set avatar(Uint8List? avatar) => _$this._avatar = avatar;

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
      _isActivated = $v.isActivated;
      _job = $v.job;
      _firstName = $v.firstName;
      _consultationDuration = $v.consultationDuration;
      _isAddressPublic = $v.isAddressPublic;
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
      _calendarSettings = $v.calendarSettings.toBuilder();
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
  _$User build() {
    _$User _$result;
    try {
      _$result = _$v ??
          new _$User._(
              id: id,
              isVerified: BuiltValueNullFieldError.checkNotNull(
                  isVerified, 'User', 'isVerified'),
              isActivated: BuiltValueNullFieldError.checkNotNull(
                  isActivated, 'User', 'isActivated'),
              job: job,
              firstName: BuiltValueNullFieldError.checkNotNull(
                  firstName, 'User', 'firstName'),
              consultationDuration: consultationDuration,
              isAddressPublic: BuiltValueNullFieldError.checkNotNull(
                  isAddressPublic, 'User', 'isAddressPublic'),
              lang: BuiltValueNullFieldError.checkNotNull(lang, 'User', 'lang'),
              type: BuiltValueNullFieldError.checkNotNull(type, 'User', 'type'),
              experiences: experiences,
              description: description,
              diploma: diploma,
              website: website,
              social1: social1,
              social2: social2,
              social3: social3,
              lastName: BuiltValueNullFieldError.checkNotNull(
                  lastName, 'User', 'lastName'),
              calendarSettings: calendarSettings.build(),
              street: street,
              street2: street2,
              zipCode: BuiltValueNullFieldError.checkNotNull(
                  zipCode, 'User', 'zipCode'),
              country: country,
              city: BuiltValueNullFieldError.checkNotNull(city, 'User', 'city'),
              avatar: avatar,
              email:
                  BuiltValueNullFieldError.checkNotNull(email, 'User', 'email'),
              mobile: mobile,
              password: password);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'calendarSettings';
        calendarSettings.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'User', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
