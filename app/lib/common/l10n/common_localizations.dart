import 'dart:async';

import 'package:app/common/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'messages/messages_all.dart';

class CommonLocalizations {
  final Locale locale;

  CommonLocalizations(this.locale);

  static Future<CommonLocalizations> load(Locale locale) {
    final name = locale.countryCode == null || locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) async {
      Intl.defaultLocale = localeName;
      await initializeDateFormatting(Intl.defaultLocale);
      return CommonLocalizations(locale);
    });
  }

  static CommonLocalizations of(BuildContext context) => Localizations.of<CommonLocalizations>(context, CommonLocalizations)!;

  String get appTitle => Intl.message('Soignez Heureux', name: 'appTitle', desc: 'Action bar title on main screen.');


}

class CommonLocalizationsDelegate extends LocalizationsDelegate<CommonLocalizations> {
  Locale? locale;

  CommonLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => kSupportedLanguages.contains(locale);

  @override
  Future<CommonLocalizations> load(Locale locale) {
    this.locale = locale;
    return CommonLocalizations.load(locale);
  }

  @override
  bool shouldReload(CommonLocalizationsDelegate old) => old.locale != locale;
}
