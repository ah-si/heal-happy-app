﻿import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CommonLocalizations {
  final Locale locale;

  CommonLocalizations(this.locale);

  static Future<CommonLocalizations> load(Locale locale) async {
    final name = locale.countryCode == null || locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;
    await initializeDateFormatting(Intl.defaultLocale);
    return CommonLocalizations(locale);
  }

  static CommonLocalizations of(BuildContext context) => Localizations.of<CommonLocalizations>(context, CommonLocalizations)!;

  String get appTitle => Intl.message('Soignez Heureux', name: 'appTitle');

  String get home => Intl.message('Accueil', name: 'home');

  String get healerToVerify => Intl.message('Soignants à vérifier', name: 'healerToVerify');

  String get disconnect => Intl.message('Déconnexion', name: 'disconnect');

  String get disconnectConfirm => Intl.message('Voulez-vous vous déconnecter?', name: 'disconnectConfirm');

  String get emptyHealer => Intl.message('Vous n\'avez aucun soignant à valider pour le moment.', name: 'emptyHealer');

  String get pendingHealer => Intl.message('Voici la liste des soignants en attente de validation:', name: 'pendingHealer');

  String itemCopied(String name) => Intl.message('$name copié dans le presse-papiers', args: [name], name: 'itemCopied');

  String get phoneCopied => Intl.message('Téléphone copié dans le presse-papiers', name: 'phoneCopied');

  String get deleting => Intl.message('Suppression en cours...', name: 'deleting');

  String get deleteButton => Intl.message('Supprimer', name: 'deleteButton');

  String delete(String name) => Intl.message('Supprimer $name?', args: [name], name: 'delete');

  String get deleteHealerConfirm =>
      Intl.message('Êtes-vous sûr de vouloir supprimer ce soignant?\nCette action ne peut être annulée et le soignant devra se réinscrire.',
          name: 'deleteHealerConfirm');

  String get acceptButton => Intl.message('Accepter', name: 'acceptButton');

  String get acceptConfirm =>
      Intl.message('En acceptant le soignant, il sera visible dans la recherche et les patients pourront prendre rendez-vous avec lui.\nVoulez- vous continuer?',
          name: 'acceptConfirm');

  String get accepting => Intl.message('Acceptation en cours...', name: 'accepting');

  String accept(String name) => Intl.message('Accepter $name?', args: [name], name: 'accept');

  String get youAre => Intl.message('Vous êtes:', name: 'youAre');

  String get patient => Intl.message('Patient', name: 'patient');

  String get healer => Intl.message('Soignant', name: 'healer');

  String get admin => Intl.message('Administrateur', name: 'admin');

  String get alreadyHaveAccount => Intl.message('J\'ai déjà un compte, me connecter', name: 'alreadyHaveAccount');

  String get sending => Intl.message('Envoi en cours...', name: 'sending');

  String get sendButton => Intl.message('Envoyer', name: 'sendButton');

  String get passwordField => Intl.message('Mot de passe*:', name: 'passwordField');

  String get confirmPasswordField => Intl.message('Confirmation du mot de passe*:', name: 'confirmPasswordField');

  String get passwordMismatch => Intl.message('Les mots de passe ne correspondent pas', name: 'passwordMismatch');

  String get emailField => Intl.message('Email*:', name: 'emailField');

  String get backToLogin => Intl.message('Retour au login', name: 'backToLogin');

  String get login => Intl.message('Connexion en cours...', name: 'login');

  String get loginButton => Intl.message('Connexion', name: 'loginButton');

  String get noAccount => Intl.message('Je n\'ai pas de compte, procéder à mon inscription', name: 'noAccount');

  String get passwordForgotten => Intl.message('Mot de passe oublié', name: 'passwordForgotten');

  String get passwordForgottenEmailSent => Intl.message('Un email vous a été envoyé afin de changer votre mot de passe.', name: 'passwordForgottenEmailSent');

  String get passwordForgottenButton => Intl.message('J\'ai oublié mon mot de passe', name: 'passwordForgottenButton');

  String get needEmail => Intl.message('Renseignez votre email:', name: 'needEmail');

  String get noResults => Intl.message('Aucun résultat', name: 'noResults');

  String get noSearchResults => Intl.message('Il n\'y a aucun résultat pour votre recherche', name: 'noSearchResults');

  String get plannedConsultations => Intl.message('Vos consultations planifiées:', name: 'plannedConsultations');

  String get yourPatient => Intl.message('Votre patient:', name: 'yourPatient');

  String get patientMessage => Intl.message('Message du patient:', name: 'patientMessage');

  String get cancelButton => Intl.message('Annuler', name: 'cancelButton');

  String get joinVisioButton => Intl.message('Rejoindre la visio', name: 'joinVisioButton');

  String get infoSaved => Intl.message('Information enregistrée avec succès', name: 'infoSaved');

  String get saveButton => Intl.message('Enregistrer', name: 'saveButton');

  String get calendar => Intl.message('Calendrier', name: 'calendar');

  String get address => Intl.message('Adresse', name: 'address');

  String get personalInfo => Intl.message('Informations personnelles', name: 'personalInfo');

  String get socialInfo => Intl.message('Information sociale', name: 'socialInfo');

  String get proInfo => Intl.message('Informations professionnelles', name: 'proInfo');

  String get localizationField => Intl.message('Localisation:', name: 'localizationField');

  String get specialityField => Intl.message('Recherche de spécialité*:', name: 'specialityField');

  String get continueButton => Intl.message('Continuer', name: 'continueButton');

  String get cancelTitle => Intl.message('Annulation', name: 'cancelTitle');

  String get canceling => Intl.message('Annulation en cours...', name: 'canceling');

  String get websiteField => Intl.message('Website:', name: 'websiteField');

  String get social1Field => Intl.message('Réseau social 1:', name: 'social1Field');

  String get social2Field => Intl.message('Réseau social 2:', name: 'social2Field');

  String get social3Field => Intl.message('Réseau social 3:', name: 'social3Field');

  String get addressIntro => Intl.message('Merci de remplir votre adresse:', name: 'addressIntro');

  String get addressDescription => Intl.message('Elle sera utilisée afin que les patients proches de vous puissent vous trouver', name: 'addressDescription');

  String get showAddress => Intl.message('Afficher mon adresse publiquement sur mon profil soignant', name: 'showAddress');

  String get speField => Intl.message('Spécialité*:', name: 'speField');

  String get descriptionField => Intl.message('Description*:', name: 'descriptionField');

  String get expField => Intl.message('Experiences:', name: 'expField');

  String get diplomaField => Intl.message('Diplomes:', name: 'diplomaField');

  String get nameField => Intl.message('Nom*:', name: 'nameField');

  String get firstNameField => Intl.message('Prénom*:', name: 'firstNameField');

  String get phoneField => Intl.message('Mobile:', name: 'phoneField');

  String get cityField => Intl.message('Ville*:', name: 'cityField');

  String get zipField => Intl.message('Code postal*:', name: 'zipField');

  String get streetField => Intl.message('Numéro et rue:', name: 'streetField');

  String get street2Field => Intl.message('Complément:', name: 'street2Field');

  String get socialIntro => Intl.message('Si vous le souhaitez, vous pouvez renseigner vos liens sociaux:', name: 'socialIntro');

  String get personalInfoIntro => Intl.message('Merci de remplir vos informations personnelles:', name: 'personalInfoIntro');

  String get proInfoIntro => Intl.message('Merci de remplir vos informations professionnelles:', name: 'proInfoIntro');

  String get eraseButton => Intl.message('Effacer', name: 'eraseButton');

  String get calendarLegend => Intl.message('M. = Matin, AM. = Après midi', name: 'calendarLegend');

  String get dayHourError => Intl.message('L\'heure de début ne peut être avant l\'heure de fin', name: 'dayHourError');

  String get calendarIntro => Intl.message('Merci de remplir vos heures de consultations:', name: 'calendarIntro');

  String get consultationDurationField => Intl.message('Durée d\'une consultation*:', name: 'consultationDurationField');

  String get consultationDurationHint => Intl.message('A spécifier en minutes', name: 'consultationDurationHint');

  String calendarDayError(String day) => Intl.message('Les horaires pour $day sont incorrects, merci de corriger.', args: [day], name: 'calendarDayError');

  String get cancelConsultation => Intl.message('Annuler la consultation?', name: 'cancelConsultation');

  String cancelConsultationConfirm(String name) =>
      Intl.message('Êtes-vous sûr de vouloir annuler la consultation avec $name?', args: [name], name: 'cancelConsultationConfirm');

  String consultationCanceled(String name) =>
      Intl.message('Votre consultation avec $name a été annulée, un email lui a été envoyé pour l\'avertir.', args: [name], name: 'cancelConsultationConfirm');

  String get noEvents => Intl.message('Vous n\'avez aucune consultation planifiée pour le moment.', name: 'noEvents');

  String get loading => Intl.message('Chargement en cours...', name: 'loading');

  String get profile => Intl.message('Profil', name: 'profile');

  String get accountNotVerified =>
      Intl.message('Vous n\'avez pas encore validé votre email, merci de cliquer sur le lien que nous vous avons envoyé.', name: 'accountNotVerified');

  String get accountPending =>
      Intl.message('Votre compte est en attente de validation. Une fois vérifié, les patients pourront prendre rendez-vous.', name: 'accountPending');

  String get donate => Intl.message('Faire un don', name: 'donate');

  String get search => Intl.message('Recherche', name: 'search');

  String get yourHealer => Intl.message('Votre soignant:', name: 'yourHealer');

  String get plannedConsultation => Intl.message('Vos consultations planifiées:', name: 'plannedConsultation');

  String get noConsultation => Intl.message('Vous n\'avez aucune consultation planifiée pour le moment.', name: 'noConsultation');

  String get searchButton => Intl.message('Rechercher', name: 'searchButton');

  String get donateDescription => Intl.message('Nous fonctionnons uniquement grâce aux dons, cliquez ici pour nous soutenir.', name: 'donateDescription');

  String get donateIntro => Intl.message('Voici les informations pour faire vos dons par virement bancaire: ', name: 'donateIntro');

  String get donateInstructions =>
      Intl.message('Si vous faites un don, merci de préciser votre destination de don dans le champ information :', name: 'donateInstructions');

  String get takeRdv => Intl.message('Prendre rendez-vous', name: 'takeRdv');

  String get rdvCreated => Intl.message('Rendez-vous validé!', name: 'rdvCreated');

  String get rdvCreatedDescription => Intl.message('Vous allez recevoir un email de confirmation.', name: 'rdvCreatedDescription');

  String get messageForHealer => Intl.message('Message pour le soignant:', name: 'messageForHealer');

  String get creatingRdv => Intl.message('Création du rendez-vous', name: 'creatingRdv');

  String takeRdvConfirm(String name, String when) => Intl.message('Voulez prendre rendez-vous avec $name à $when?', name: 'takeRdvConfirm');
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

