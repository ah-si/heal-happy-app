import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/common/router.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

extension UserExtension on User {
  String get name => '$firstName $lastName';
}

extension HealerExtension on Healer {
  String get address {
    String address = '';
    if (isAddressPublic) {
      address = street ?? '';
      if (street2 != null && street2!.isNotEmpty) {
        address += street2!;
      }
    }
    address += '$zipCode $city';
    return address;
  }

  String get name => '$firstName $lastName.';
}

extension ContextExtension on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  Color get primaryColor => kPrimaryColor;

  Color get accentColor => kAccentColor;

  void goToHome() => GoRouter.of(this).goToHome();

  bool isRelevant() {
    try {
      navigator;
      return true;
    } catch(_) {
      return false;
    }
  }
}

extension NullStringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension StringCasingExtension on String {
  String get capitalized => length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get titleCase => replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.capitalized).join(" ");
}

extension TimeOfDayExtension on TimeOfDay {
  bool isAfter(TimeOfDay? other) {
    if (other == null) return false;
    if (hour < other.hour) {
      return false;
    }
    return minute > other.minute;
  }

  bool isBefore(TimeOfDay? other) {
    if (other == null) return false;
    if (hour < other.hour) {
      return true;
    }
    return minute < other.minute;
  }
}
