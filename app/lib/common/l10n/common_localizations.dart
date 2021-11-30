import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
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

  String get adminUsersMenu => Intl.message('Utilisateurs', name: 'adminUsersMenu');

  String get adminHealerStatsMenu => Intl.message('Compta', name: 'adminHealerStatsMenu');

  String get startDate => Intl.message('Date de début', name: 'startDate');

  String get endDate => Intl.message('Date de fin', name: 'endDate');

  String nbEvents(int events) => Intl.plural(events, args: [events], one: '$events consultation', name: 'nbEvents', other: '$events consultations');

  String nbDuration(int duration) => Intl.message('$duration minutes', args: [duration], name: 'nbEvents');

  String get disconnect => Intl.message('Déconnexion', name: 'disconnect');

  String get disconnectConfirm => Intl.message('Voulez-vous vous déconnecter?', name: 'disconnectConfirm');

  String get emptyHealer => Intl.message('Vous n\'avez aucun soignant à valider pour le moment.', name: 'emptyHealer');

  String get emptyUsers => Intl.message('Aucun utilisateur ne correspond à votre recherche.', name: 'emptyUsers');

  String get pendingHealer => Intl.message('Voici la liste des soignants en attente de validation:', name: 'pendingHealer');

  String itemCopied(String name) => Intl.message('$name copié dans le presse-papiers', args: [name], name: 'itemCopied');

  String get phoneCopied => Intl.message('Téléphone copié dans le presse-papiers', name: 'phoneCopied');

  String get deleting => Intl.message('Suppression en cours...', name: 'deleting');

  String get deleteButton => Intl.message('Supprimer', name: 'deleteButton');

  String get downloadDiploma => Intl.message('Télécharger le diplôme', name: 'downloadDiploma');

  String get downloadTerms => Intl.message('Télécharger la charte', name: 'downloadTerms');

  String delete(String name) => Intl.message('Supprimer $name?', args: [name], name: 'delete');

  String get deleteHealerConfirm =>
      Intl.message('Êtes-vous sûr de vouloir supprimer ce soignant?\nCette action ne peut être annulée et le soignant devra se réinscrire.',
          name: 'deleteHealerConfirm');

  String get acceptButton => Intl.message('Accepter', name: 'acceptButton');

  String get editButton => Intl.message('Modifier', name: 'editButton');

  String get acceptConfirm => Intl.message(
      'En acceptant le soignant, il sera visible dans la recherche et les patients pourront prendre rendez-vous avec lui.\nVoulez- vous continuer?',
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

  String get resetPasswordIntro => Intl.message('Changement de votre mot de passe', name: 'resetPasswordIntro');

  String get confirmPasswordField => Intl.message('Confirmation du mot de passe*:', name: 'confirmPasswordField');

  String get acceptTerms => Intl.message('Les informations recueillies sur ce formulaire sont enregistrées dans un fichier informatisé par l\'Alliance Humaine Santé Internationale pour nous permettre de traiter votre demande. Elles sont conservées pendant tout la durée de notre relation. En soumettant ce formulaire, j’accepte que mes informations soient utilisées exclusivement dans le cadre de ma demande et de la relation personnalisée qui pourrait en découler si je le souhaite.', name: 'acceptTerms');

  String get goToTerms => Intl.message('Pour connaître et exercer mes droits, notamment pour annuler mon consentement, je consulte la politique de vie privée en cliquant ici.', name: 'goToTerms');

  String get passwordChanged => Intl.message('Votre mot de passe a été mis à jour.', name: 'passwordChanged');

  String get passwordMismatch => Intl.message('Les mots de passe ne correspondent pas', name: 'passwordMismatch');

  String get emailField => Intl.message('Email*:', name: 'emailField');

  String get uploading => Intl.message('Uploading...', name: 'uploading');

  String get downloadHealerTerms => Intl.message('Télécharger la charte', name: 'downloadTerms');

  String get diplomaUpload => Intl.message('Afin de valider votre compte soignant, merci de nous fournir une preuve de votre spécialité (diplôme, attestation de formation...).', name: 'diplomaUpload');

  String get noAvailabilities => Intl.message('Aucune disponibilité pour le moment', name: 'noAvailabilities');

  String get diplomaDialogTitle => Intl.message('Choisir mon diplôme', name: 'diplomaDialogTitle');

  String get termsDialogTitle => Intl.message('Choisir la charte signé', name: 'termsDialogTitle');

  String get termsUpload => Intl.message('Merci de télécharger la charte d\'utilisation de Soignez Heureux, la signer et nous la fournir.', name: 'termsUpload');

  String get uploadButton => Intl.message('Envoyer', name: 'uploadButton');

  String get backToLogin => Intl.message('Retour au login', name: 'backToLogin');

  String get backButton => Intl.message('Retour', name: 'backButton');

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

  String get speField2 => Intl.message('Spécialité:', name: 'speField2');

  String get userTypeField => Intl.message('Type:', name: 'userTypeField');

  String get isActivatedField => Intl.message('Activé:', name: 'isActivatedField');

  String get isVerifiedField => Intl.message('Vérifié:', name: 'isVerifiedField');

  String get searchQueryField => Intl.message('Recherche:', name: 'searchQueryField');

  String get descriptionField => Intl.message('Description*:', name: 'descriptionField');

  String get expField => Intl.message('Experiences:', name: 'expField');

  String get diplomaField => Intl.message('Diplomes:', name: 'diplomaField');

  String get nameField => Intl.message('Nom*:', name: 'nameField');

  String get firstNameField => Intl.message('Prénom*:', name: 'firstNameField');

  String get phoneField => Intl.message('Mobile*:', name: 'phoneField');

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

  String get resendActivationLink => Intl.message('Renvoyer le lien', name: 'resendActivationLink');

  String get resendActivationLinkTitle => Intl.message('Activation du compte', name: 'resendActivationLinkTitle');

  String get resendActivationLinkSuccess => Intl.message('Le lien d\'activation vous à été renvoyé par email.', name: 'resendActivationLinkSuccess');

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

  String get exportButton => Intl.message('Exporter', name: 'exportButton');

  String get donateDescription => Intl.message('Nous fonctionnons uniquement grâce aux dons, cliquez ici pour nous soutenir.', name: 'donateDescription');

  String get mentionLegal => Intl.message('Aucune donnée médicale n\'est demandée ni diffusée. Les données personnelles sont protégées. Les praticiens médicaux et para médicaux de « soignez heureux » se sont engagés à respecter le secret médical.', name: 'mentionLegal');

  String get addressLegal => Intl.message('Alliance Humaine Santé Internationale - AHSI\nHuman Alliance International Health – HAIH\nCH-1202 Genève – Suisse', name: 'addressLegal');

  String get donateIntro => Intl.message('Voici les informations pour faire vos dons par virement bancaire: ', name: 'donateIntro');

  String get donateInstructions =>
      Intl.message('Si vous faites un don, merci de préciser votre destination de don dans le champ information :', name: 'donateInstructions');

  String get takeRdv => Intl.message('Prendre rendez-vous', name: 'takeRdv');

  String get rdvCreated => Intl.message('Rendez-vous validé!', name: 'rdvCreated');

  String get rdvCreatedDescription => Intl.message('Vous allez recevoir un email de confirmation.', name: 'rdvCreatedDescription');

  String get messageForHealer => Intl.message('Message pour le soignant:', name: 'messageForHealer');

  String get creatingRdv => Intl.message('Création du rendez-vous', name: 'creatingRdv');

  String takeRdvConfirm(String name, String when) => Intl.message('Voulez prendre rendez-vous avec $name à $when?', name: 'takeRdvConfirm');

  String userType(UserTypeEnum? type) {
    switch (type) {
      case UserTypeEnum.admin:
        return Intl.message('Admin', name: 'typeAdmin');
      case UserTypeEnum.healer:
        return Intl.message('Soignant', name: 'typeHealer');
      case UserTypeEnum.patient:
        return Intl.message('Patient', name: 'typePatient');
    }
    return Intl.message('Tous', name: 'typeUnknown');
  }
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
