import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final userInfoProvider = ChangeNotifierProvider((ref) {
  return UserInfo();
});

class UserInfo extends ChangeNotifier {
  UserTypeEnum? _type;

  UserTypeEnum? get type => _type;

  set type(value) {
    _type = value;
    notifyListeners();
  }

  toUser({User? existingUser}) {
    builder(UserBuilder b) {
      b.isVerified = existingUser?.isVerified ?? false;
      b.isActivated = existingUser?.isActivated ?? false;
      b.canDoFaceToFace = existingUser?.canDoFaceToFace ?? false;
      b.isTermsAccepted = _isTermsAccepted;

      b.type = type;
      b.type = type;
      b.lang = 'fr_FR';
      b.consultationDuration = consultationDuration ?? 30;

      b.job = job;
      b.description = description ?? '';
      b.experiences = experiences;
      b.diploma = diploma;

      b.website = website;
      b.social1 = social1;
      b.social2 = social2;
      b.social3 = social3;

      b.email = email;
      b.firstName = firstName;
      b.lastName = lastName;
      if (!password.isNullOrEmpty) {
        b.password = password;
      }
      b.mobile = mobile;

      b.street = street;
      b.street2 = street2;
      b.zipCode = zipCode ?? '';
      b.city = city ?? '';
      b.country = country;
      b.isAddressPublic = isAddressVisible;
    }

    return existingUser?.rebuild(builder) ?? User(builder);
  }

  fromUser(User user) {
    _type = user.type;
    _isAddressVisible = user.isAddressPublic;
    _firstName = user.firstName;
    _lastName = user.lastName;
    _email = user.email;
    _mobile = user.mobile;
    _consultationTime = user.consultationDuration;
    _website = user.website;
    _social1 = user.social1;
    _social2 = user.social2;
    _social3 = user.social3;
    _description = user.description;
    _experiences = user.experiences;
    _diploma = user.diploma;
    _isTermsAccepted = user.isTermsAccepted;
    _street = user.street;
    _street2 = user.street2;
    _zipCode = user.zipCode;
    _city = user.city;
    _job = user.job;
    _country = user.country;
    _password = null;
    notifyListeners();
  }

  bool? _isAddressVisible = false;

  bool? get isAddressVisible => _isAddressVisible;

  set isAddressVisible(value) {
    _isAddressVisible = value;
    notifyListeners();
  }

  bool _isTermsAccepted = false;

  bool get isTermsAccepted => _isTermsAccepted;

  set isTermsAccepted(bool value) {
    _isTermsAccepted = value;
    notifyListeners();
  }

  int? _consultationTime;

  int? get consultationDuration => _consultationTime;

  set consultationDuration(int? value) {
    _consultationTime = value;
    notifyListeners();
  }

  String? _firstName;

  String? get firstName => _firstName;

  set firstName(value) {
    _firstName = value;
    notifyListeners();
  }

  String? _lastName;

  String? get lastName => _lastName;

  set lastName(value) {
    _lastName = value;
    notifyListeners();
  }

  String? _email;

  String? get email => _email;

  set email(value) {
    _email = value;
    notifyListeners();
  }

  String? _captcha;

  String? get captcha => _captcha;

  set captcha(value) {
    _captcha = value;
    notifyListeners();
  }

  String? _mobile;

  String? get mobile => _mobile;

  set mobile(value) {
    _mobile = value;
    notifyListeners();
  }

  String? _description;

  String? get description => _description;

  set description(value) {
    _description = value;
    notifyListeners();
  }

  String? _job;

  String? get job => _job;

  set job(value) {
    _job = value;
    notifyListeners();
  }

  String? _experiences;

  String? get experiences => _experiences;

  set experiences(value) {
    _experiences = value;
    notifyListeners();
  }

  String? _diploma;

  String? get diploma => _diploma;

  set diploma(value) {
    _diploma = value;
    notifyListeners();
  }

  String? _website;

  String? get website => _website;

  set website(value) {
    _website = value;
    notifyListeners();
  }

  String? _social1;

  String? get social1 => _social1;

  set social1(value) {
    _social1 = value;
    notifyListeners();
  }

  String? _social2;

  String? get social2 => _social2;

  set social2(value) {
    _social2 = value;
    notifyListeners();
  }

  String? _social3;

  String? get social3 => _social3;

  set social3(value) {
    _social3 = value;
    notifyListeners();
  }

  String? _password;

  String? get password => _password;

  set password(value) {
    _password = value;
    notifyListeners();
  }

  String? _street;

  String? get street => _street;

  set street(value) {
    _street = value;
    notifyListeners();
  }

  String? _street2;

  String? get street2 => _street2;

  set street2(value) {
    _street2 = value;
    notifyListeners();
  }

  String? _city;

  String? get city => _city;

  set city(value) {
    _city = value;
    notifyListeners();
  }

  String? _zipCode;

  String? get zipCode => _zipCode;

  set zipCode(value) {
    _zipCode = value;
    notifyListeners();
  }

  String? _country;

  String get country => _country ?? 'FR';

  set country(value) {
    _country = value;
    notifyListeners();
  }
}
