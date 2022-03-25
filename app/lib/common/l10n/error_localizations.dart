import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:intl/intl.dart';

class ErrorLocalizations {
  final Locale locale;

  ErrorLocalizations(this.locale);

  static Future<ErrorLocalizations> load(Locale locale) async {
    return ErrorLocalizations(locale);
  }

  static ErrorLocalizations of(BuildContext context) => Localizations.of<ErrorLocalizations>(context, ErrorLocalizations)!;

  String get dialogErrorTitle => Intl.message('Oops!', name: 'dialogErrorTitle', desc: 'The title of a dialog where something went wrong');

  String get wrongEmailMessage => Intl.message('Email incorrect', name: 'wrongEmailMessage');

  String get wrongPhoneMessage => Intl.message('Mobile incorrect', name: 'wrongPhoneMessage');

  String get wrongPasswordMessage => Intl.message('Le mot de passe doit faire 6 caractères minimum', name: 'wrongPasswordMessage');

  String get internalMessage => Intl.message('Erreur inconnue', name: 'internalMessage');

  String get internalHint =>
      Intl.message('Une erreur est survenue, nous nous excusons pour la gêne occasionnée et allons régler le problème au plus vite.', name: 'internalHint');

  String get noNetworkMessage => Intl.message('Pas de réseau', name: 'noNetworkMessage');

  String get noNetworkHint => Intl.message('Merci de retenter quand vous aurez du réseau internet.', name: 'noNetworkHint');

  String get noAppForTheAction => Intl.message('No application available for this action',
      name: 'noAppForTheAction', desc: 'Displayed when no app can handle the wanted action (send sms, email, open web page...)');

  String get noAppForTheActionHint => Intl.message('Try to install an application who handle this kind of action',
      name: 'noAppForTheActionHint', desc: 'Displayed when no app can handle the wanted action (send sms, email, open web page...)');

  String get fieldRequired => Intl.message('Ce champ est requis', name: 'fieldRequired', desc: 'When a field is required on a form');

  String get fieldRequiredHint => Intl.message('Merci de remplir ce champ', name: 'fieldRequiredHint', desc: 'When a field is required on a form');

  String get notLogged => Intl.message('Vous n’êtes pas connecté', name: 'notLogged', desc: 'When a 401 occurred');

  String get notLoggedHint => Intl.message('Merci de vous connecter pour réaliser cette action', name: 'notLoggedHint', desc: 'When a 401 occurred');

  String get forbidden => Intl.message('Cette action est interdite', name: 'forbidden', desc: 'When a 403 occurred');

  String get forbiddenHint => Intl.message('Vous n\'avez pas la permission de réaliser cette action', name: 'forbiddenHint', desc: 'When a 403 occurred');

  String get wrongCredentials => Intl.message('Erreur de connexion', name: 'wrongCredentials', desc: 'When login credentials are wrong');

  String get wrongCredentialsHint => Intl.message('Merci de vérifier votre email et mot de passe avant nouvelle tentative',
      name: 'wrongCredentialsHint', desc: 'When login credentials are wrong');

  String get meetingAlreadyExist => Intl.message('Réservation impossible', name: 'meetingAlreadyExist');

  String get meetingAlreadyExistHint =>
      Intl.message('Vous avez déjà une consultation planifiée avec ce soignant, vous pourrez reprendre rendez-vous une fois la consultation passée ou annulée.',
          name: 'meetingAlreadyExistHint');

  String get speMeetingAlreadyExist => Intl.message('Réservation impossible', name: 'speMeetingAlreadyExist');

  String get speMeetingAlreadyExistHint =>
      Intl.message('Vous avez déjà une consultation planifiée pour cette spécialité, vous pourrez reprendre rendez-vous une fois la consultation passée ou annulée.',
          name: 'speMeetingAlreadyExistHint');

  String get healerMeetingAlreadyExist => Intl.message('Réservation impossible', name: 'healerMeetingAlreadyExist');

  String get healerMeetingAlreadyExistHint =>
      Intl.message('Vous avez déjà une consultation planifiée avec ce patient, vous pourrez reprendre rendez-vous une fois la consultation passée.',
          name: 'healerMeetingAlreadyExistHint');

  String get emailAlreadyUsed => Intl.message('Email déjà enregistré', name: 'emailAlreadyUsed');

  String get emailAlreadyUsedHint =>
      Intl.message('Cet email est déjà enregistré, merci de vous connecter avec vos informations ou renseigner un autre email', name: 'emailAlreadyUsedHint');

  String get meetingAlreadyBooked => Intl.message('Ce rendez-vous à déjà été réservé', name: 'meetingAlreadyBooked');

  String get meetingAlreadyBookedHint => Intl.message('Merci de choisir un autre horaire pour votre rendez-vous', name: 'meetingAlreadyBookedHint');

  String get noPastEvent => Intl.message('Réservation impossible dans la passé', name: 'noPastEvent');

  String get noPastEventHint => Intl.message('Merci de choisir un autre horaire pour votre rendez-vous', name: 'noPastEventHint');

  String get accountNotActivated => Intl.message('Compte inactif', name: 'accountNotActivated');

  String get accountNotActivatedHint => Intl.message('Merci de cliquer sur le lien d\'activation envoyé par email avant de réserver des consultations.', name: 'accountNotActivatedHint');

  String get linkExpired => Intl.message('Lien expiré', name: 'linkExpired');

  String get linkExpiredHint => Intl.message('Votre lien a expiré, merci de recommencer la demande de changement de mot de passe', name: 'linkExpiredHint');

  String get fileTooBig => Intl.message('Fichier trop lourd', name: 'fileTooBig');

  String get fileTooBigHint => Intl.message('Le fichier ne doit pas dépasser 5Mo', name: 'fileTooBigHint');

  String get termsRequired => Intl.message('Problème relatif au traitement des données personnelles', name: 'termsRequired');

  String get termsRequiredHint => Intl.message('Merci d\'aller dans vos informations personnelles et accepté le traitement de vos données.', name: 'termsRequiredHint');

  String get adminTermsRequiredHint => Intl.message('L\'utilisateur n\'a pas accepté le traitement de ses données (RGPD), il est donc impossible de modifier ses données.\nIl doit aller dans ses informations personnelles et accepter le traitement de ses données.', name: 'adminTermsRequiredHint');

  String get noUser => Intl.message('Aucun compte patient avec cet email.', name: 'noUser');

  String get noUserHint => Intl.message('Merci de remplir les informations complètes du patient afin de créer cette consultation.', name: 'noUserHint');

  String get accountNotVerified => Intl.message('Compte non vérifié.', name: 'accountNotVerified');

  String get accountNotVerifiedHint =>
      Intl.message('Une fois votre compte vérifié par un administrateur, vous pourrez pleinement utiliser cette fonctionnalité.', name: 'noUserHint');

  String get noPastOpening => Intl.message('Création impossible dans le passé', name: 'noPastOpening');

  String get noPastOpeningHint => Intl.message('Merci de choisir un autre horaire pour votre disponibilité', name: 'noPastOpeningHint');

  String get noOpeningOverlap => Intl.message('Chevauchement des horaires', name: 'noOpeningOverlap');

  String get noOpeningOverlapHint =>
      Intl.message('Les horaires ne peuvent se chevaucher, merci de choisir un autre horaire pour votre disponibilité', name: 'noOpeningOverlapHint');

  String get dateStartAfterEnd => Intl.message('Date de fin est égale ou après date de début', name: 'dateStartAfterEnd');

  String get dateStartAfterEndHint => Intl.message('La date de fin ne peut être égale ou après la date de début, merci de corriger.', name: 'dateStartAfterEndHint');

  String get faceToFaceNotAllowed => Intl.message('Présentiel pas encore autorisé', name: 'faceToFaceNotAllowed');

  String get faceToFaceNotAllowedHint =>
      Intl.message('Afin de pouvoir réaliser des consultations en présentiel, merci de nous contacter à contact@ah-si.org afin de connaitre les modalitées.',
          name: 'faceToFaceNotAllowedHint');

  String get patientAlreadyBusy => Intl.message('Créneau indisponible', name: 'patientAlreadyBusy');

  String get patientAlreadyBusyHint =>
      Intl.message('Vous avez déjà un rendez vous à cet horaire, merci de choisir un horaire différent.', name: 'patientAlreadyBusyHint');

  String get healerPatientAlreadyBusy => Intl.message('Patient indisponible', name: 'healerPatientAlreadyBusy');

  String get healerPatientAlreadyBusyHint =>
      Intl.message('Votre patient n\'est pas disponible à cet horaire, merci d\'en choisir un autre.', name: 'healerPatientAlreadyBusyHint');

  String get noAccount => Intl.message('Aucun compte avec cet email', name: 'noAccount');

  String get noAccountHint => Intl.message('Cet email n\'est relié à aucun compte Soignez Heureux.', name: 'noAccountHint');

  String get notFound => Intl.message('Resource introuvable', name: 'notFound');

  String get notFoundHint => Intl.message('La resource demandé n\'existe pas ou plus.' , name: 'notFoundHint');

  String get noHealer => Intl.message('Aucun soignant avec cet email', name: 'noHealer');

  String get noHealerHint => Intl.message('Aucun compte soignant avec cet email, il n\'y a pas de compte ou c\'est un compte patient.' , name: 'noHealerHint');

  String get noOpeningRoomOverlap => Intl.message('Chevauchement des horaires', name: 'noOpeningRoomOverlap');

  String get noOpeningRoomOverlapHint => Intl.message('Un autre soignant a déjà pris ce créneau dans cette salle, merci d\'en choisir un autre.' , name: 'noOpeningRoomOverlapHint');
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

