import 'package:flutter/cupertino.dart';
import 'package:heal_happy/common/utils/extensions.dart';

String? isRequired(value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return context.el10n.fieldRequired;
  }
  return null;
}

String? isEmailValid(value, BuildContext context) {
  if (value == null || value.trim().isEmpty) {
    return context.el10n.fieldRequired;
  } else if (!RegExp(
  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
  .hasMatch(value.trim())) {
    return context.el10n.wrongEmailMessage;
  }
  return null;
}

String? isPasswordValid(value, BuildContext context) {
  if (value == null || value.trim().isEmpty) {
    return context.el10n.fieldRequired;
  } else if (value.trim().length < 6) {
    return context.el10n.wrongPasswordMessage;
  }
  return null;
}
