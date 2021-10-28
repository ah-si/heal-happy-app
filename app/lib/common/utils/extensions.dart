import 'package:app/common/utils/constants.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  Color get primaryColor => kPrimaryColor;

  Color get accentColor => kAccentColor;
}

extension NullStringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension StringCasingExtension on String {
  String get capitalized => length > 0 ?'${this[0].toUpperCase()}${substring(1)}':'';
  String get titleCase => replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.capitalized).join(" ");
}
