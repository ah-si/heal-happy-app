import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart' as backend;

final userInfoProvider = ChangeNotifierProvider((ref) {
  return UserInfo();
});

class CalendarTimeOfDaySettings {
  final TimeOfDay? start;
  final TimeOfDay? end;
  final TimeOfDay? start2;
  final TimeOfDay? end2;

  CalendarTimeOfDaySettings({this.start, this.end, this.start2, this.end2});

  factory CalendarTimeOfDaySettings.from(backend.CalendarDaySettings? settings) {
    if (settings == null) {
      return CalendarTimeOfDaySettings();
    } else {
      final start = settings.startHour == null ? null : TimeOfDay(hour: settings.startHour!, minute: settings.startMinute!);
      final end = settings.endHour == null ? null : TimeOfDay(hour: settings.endHour!, minute: settings.endMinute!);
      final start2 = settings.start2Hour == null ? null : TimeOfDay(hour: settings.start2Hour!, minute: settings.start2Minute!);
      final end2 = settings.end2Hour == null ? null : TimeOfDay(hour: settings.end2Hour!, minute: settings.end2Minute!);
      return CalendarTimeOfDaySettings(
        start: start,
        end: end,
        start2: start2,
        end2: end2,
      );
    }
  }

  CalendarDaySettingsBuilder toApiBuilder() {
    CalendarDaySettingsBuilder builder = CalendarDaySettingsBuilder();
    builder.startHour = start?.hour;
    builder.startMinute = start?.minute;
    builder.endHour = end?.hour;
    builder.endMinute = end?.minute;
    builder.start2Hour = start2?.hour;
    builder.start2Minute = start2?.minute;
    builder.end2Hour = end2?.hour;
    builder.end2Minute = end2?.minute;
    return builder;
  }

  bool isValid() {
    if ((start != null && end == null) || (start == null && end != null)) {
      return false;
    }
    if ((start2 != null && end2 == null) || (start2 == null && end2 != null)) {
      return false;
    }
    return true;
  }
}

class CalendarSettings {
  final CalendarTimeOfDaySettings monday;
  final CalendarTimeOfDaySettings tuesday;
  final CalendarTimeOfDaySettings wednesday;
  final CalendarTimeOfDaySettings thursday;
  final CalendarTimeOfDaySettings friday;
  final CalendarTimeOfDaySettings saturday;
  final CalendarTimeOfDaySettings sunday;

  CalendarSettings({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  CalendarSettingsBuilder toApiBuilder() {
    CalendarSettingsBuilder builder = CalendarSettingsBuilder();
    builder.monday = monday.toApiBuilder();
    builder.tuesday = tuesday.toApiBuilder();
    builder.wednesday = wednesday.toApiBuilder();
    builder.thursday = thursday.toApiBuilder();
    builder.friday = friday.toApiBuilder();
    builder.saturday = saturday.toApiBuilder();
    builder.sunday = sunday.toApiBuilder();
    return builder;
  }

  factory CalendarSettings.from(backend.CalendarSettings settings) {
    CalendarSettings calendarSettings = CalendarSettings(
      monday: CalendarTimeOfDaySettings.from(settings.monday),
      tuesday: CalendarTimeOfDaySettings.from(settings.tuesday),
      wednesday: CalendarTimeOfDaySettings.from(settings.wednesday),
      thursday: CalendarTimeOfDaySettings.from(settings.thursday),
      friday: CalendarTimeOfDaySettings.from(settings.friday),
      saturday: CalendarTimeOfDaySettings.from(settings.saturday),
      sunday: CalendarTimeOfDaySettings.from(settings.sunday),
    );
    return calendarSettings;
  }

  bool isValid() {
    return monday.isValid() && tuesday.isValid() && wednesday.isValid() && thursday.isValid() && friday.isValid() && saturday.isValid() && sunday.isValid();
  }

  CalendarSettings copyWith({
    CalendarTimeOfDaySettings? monday,
    CalendarTimeOfDaySettings? tuesday,
    CalendarTimeOfDaySettings? wednesday,
    CalendarTimeOfDaySettings? thursday,
    CalendarTimeOfDaySettings? friday,
    CalendarTimeOfDaySettings? saturday,
    CalendarTimeOfDaySettings? sunday,
  }) {
    return CalendarSettings(
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      sunday: sunday ?? this.sunday,
    );
  }
}

class UserInfo extends ChangeNotifier {
  UserTypeEnum? _type;

  UserTypeEnum? get type => _type;

  set type(value) {
    _type = value;
    notifyListeners();
  }

  toUser({User? existingUser}) {
    builder(UserBuilder b) {
      b.isVerified = false;
      b.isActivated = false;
      b.isTermsAccepted = _isTermsAccepted;

      b.type = type;
      b.type = type;
      b.lang = 'fr_FR';
      b.consultationDuration = consultationDuration ?? 30;
      b.calendarSettings = calendarSettings.toApiBuilder();

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
    _calendarSettings = CalendarSettings.from(user.calendarSettings);
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

  bool? _isAddressVisible;

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

  CalendarSettings _calendarSettings = CalendarSettings(
    monday: CalendarTimeOfDaySettings(),
    tuesday: CalendarTimeOfDaySettings(),
    wednesday: CalendarTimeOfDaySettings(),
    thursday: CalendarTimeOfDaySettings(),
    friday: CalendarTimeOfDaySettings(),
    saturday: CalendarTimeOfDaySettings(),
    sunday: CalendarTimeOfDaySettings(),
  );

  CalendarSettings get calendarSettings => _calendarSettings;

  set calendarSettings(value) {
    _calendarSettings = value;
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
