import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:intl/intl.dart';

class ErrorLocalizations {
  final Locale locale;

  ErrorLocalizations(this.locale);

  static Future<ErrorLocalizations> load(Locale locale) async {
    final name = locale.countryCode == null || locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return ErrorLocalizations(locale);
  }

  static ErrorLocalizations of(BuildContext context) => Localizations.of<ErrorLocalizations>(context, ErrorLocalizations)!;

  String get dialogErrorTitle => Intl.message('Oops!', name: 'dialogErrorTitle', desc: 'The title of a dialog where something went wrong');

  String get wrongEmailMessage => Intl.message('Email incorrect', name: 'wrongEmailMessage');

  String get internalMessage => Intl.message('Erreur inconnue', name: 'internalMessage');
  String get internalHint => Intl.message('Une erreur est survenue, nous nous excusons pour la gêne occasionnée et allons régler le problème au plus vite.', name: 'internalHint');

  String get noNetworkMessage => Intl.message('Pas de réseau', name: 'noNetworkMessage');
  String get noNetworkHint => Intl.message('Merci de retenter quand vous aurez du réseau internet.', name: 'noNetworkHint');

  String get noAppForTheAction => Intl.message('No application available for this action',
      name: 'noAppForTheAction', desc: 'Displayed when no app can handle the wanted action (send sms, email, open web page...)');
  String get noAppForTheActionHint => Intl.message('Try to install an application who handle this kind of action',
      name: 'noAppForTheActionHint', desc: 'Displayed when no app can handle the wanted action (send sms, email, open web page...)');

  String get fieldRequired => Intl.message('Ce champ est requis', name: 'fieldRequired', desc: 'When a field is required on a form');
  String get fieldRequiredHint => Intl.message('Merci de remplir ce champ', name: 'fieldRequiredHint', desc: 'When a field is required on a form');

  String get notLogged => Intl.message('Vous n\êtes pas connecté', name: 'notLogged', desc: 'When a 401 occurred');
  String get notLoggedHint => Intl.message('Merci de vous connecter pour réaliser cette action', name: 'notLoggedHint', desc: 'When a 401 occurred');

  String get forbidden => Intl.message('Cette action est interdite', name: 'forbidden', desc: 'When a 403 occurred');
  String get forbiddenHint => Intl.message('Vous n\'avez pas la permission de réaliser cette action', name: 'forbiddenHint', desc: 'When a 403 occurred');

  String get wrongCredentials => Intl.message('Erreur de connexion', name: 'wrongCredentials', desc: 'When login credentials are wrong');
  String get wrongCredentialsHint => Intl.message('Merci de vérifier votre email et mot de passe avec de retenter', name: 'wrongCredentialsHint', desc: 'When login credentials are wrong');

  String get meetingAlreadyExist => Intl.message('Reservation impossible', name: 'meetingAlreadyExist');
  String get meetingAlreadyExistHint => Intl.message('Vous avez déjà une consultation planifiée avec ce soignant, vous pourrez reprendre rendez-vous une fois la consulation passé.', name: 'meetingAlreadyExistHint');

  String get emailAlreadyUsed => Intl.message('Email déjà enregistré', name: 'emailAlreadyUsed');
  String get emailAlreadyUsedHint => Intl.message('Cet email est déjà enregistré, merci de vous connecter avec vos informations ou renseigner un autre email', name: 'emailAlreadyUsedHint');
}

class ErrorLocalizationsDelegate extends LocalizationsDelegate<ErrorLocalizations> {
  late Locale locale;
  ErrorLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => kSupportedLanguages.contains(locale);

  @override
  Future<ErrorLocalizations> load(Locale locale) {
    this.locale = locale;
    return ErrorLocalizations.load(locale);
  }

  @override
  bool shouldReload(ErrorLocalizationsDelegate old) => old.locale != locale;
}
