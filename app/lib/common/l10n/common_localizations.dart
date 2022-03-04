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

  String get healerDescription => Intl.message('Description:', name: 'healerDescription');

  String get healerDiploma => Intl.message('Diplomes:', name: 'healerDiploma');

  String get healerExperiences => Intl.message('Expériences:', name: 'healerExperiences');

  String get adminUsersMenu => Intl.message('Utilisateurs', name: 'adminUsersMenu');

  String get adminEventsMenu => Intl.message('Consultations', name: 'adminEventsMenu');

  String get adminOfficesMenu => Intl.message('Cabinets', name: 'adminOfficesMenu');

  String get adminHealerStatsMenu => Intl.message('Compta', name: 'adminHealerStatsMenu');

  String get openingPopupTitle => Intl.message('Disponibilité', name: 'openingPopupTitle');

  String get startDate => Intl.message('Date de début', name: 'startDate');

  String get endDate => Intl.message('Date de fin', name: 'endDate');

  String nbEvents(int events) => Intl.plural(events, args: [events], one: '$events consultation', name: 'nbEvents', other: '$events consultations');

  String nbDuration(int duration) => Intl.message('$duration minutes', args: [duration], name: 'nbEvents');

  String get disconnect => Intl.message('Déconnexion', name: 'disconnect');

  String get disconnectConfirm => Intl.message('Voulez-vous vous déconnecter?', name: 'disconnectConfirm');

  String get emptyHealer => Intl.message('Vous n\'avez aucun soignant à valider pour le moment.', name: 'emptyHealer');

  String get emptyUsers => Intl.message('Aucun utilisateur ne correspond à votre recherche.', name: 'emptyUsers');

  String get emptyEvents => Intl.message('Aucune consultation ne correspond à votre recherche.', name: 'emptyEvents');

  String get addOffice => Intl.message('Ajout d\'un cabinet médicale', name: 'addOffice');

  String get addRoom => Intl.message('Ajout d\'une salle de soin', name: 'addRoom');

  String get renameRoom => Intl.message('Renommer la salle de soin', name: 'renameRoom');

  String get deleteRoom => Intl.message('Supprimer la salle de soin', name: 'deleteRoom');

  String get deleteRoomConfirm => Intl.message('Êtes vous sur de vouloir supprimer cette salle de soins? Assurez vous qu\'il n\'y ait plus de consultation prévu dans cette salle avant suppression.', name: 'deleteRoomConfirm');

  String get emptyOffices => Intl.message('Aucun cabinet ne correspond à votre recherche.', name: 'emptyOffices');

  String get pendingHealer => Intl.message('Voici la liste des soignants en attente de validation:', name: 'pendingHealer');

  String itemCopied(String name) => Intl.message('$name copié dans le presse-papiers', args: [name], name: 'itemCopied');

  String get phoneCopied => Intl.message('Téléphone copié dans le presse-papiers', name: 'phoneCopied');

  String get deleting => Intl.message('Suppression en cours...', name: 'deleting');

  String get deleteButton => Intl.message('Supprimer', name: 'deleteButton');

  String get downloadDiploma => Intl.message('Télécharger le diplôme', name: 'downloadDiploma');

  String get userActivated => Intl.message('L\'utilisateur a validé son email', name: 'userActivated');

  String get userUnActivated =>
      Intl.message('L\'utilisateur n\'a pas validé son email, si il est soignant, il n\'est pas visible pour les patients', name: 'userUnActivated');

  String get userVerified => Intl.message('L\'utilisateur est vérifié', name: 'userVerified');

  String get userUnVerified => Intl.message('L\'utilisateur n\'a pas été vérifié et donc n\'est pas visible pour les patients', name: 'userUnVerified');

  String get userRgpdKo => Intl.message(
      'L\'utilisateur n\'a pas accepté la politique de confidentialité RGPD, il doit aller sur son profil, partie "informations personnelles", cocher la case de confidentialité et cliquer "enregistrer"',
      name: 'userRgpdKo');

  String get downloadTerms => Intl.message('Télécharger la charte', name: 'downloadTerms');

  String get downloadTuto => Intl.message('Télécharger notre tutoriel', name: 'downloadTuto');

  String get helpTuto => Intl.message('Si vous avez besoin d\'aide pour la gestion de votre compte, vous pouvez consulter notre tutoriel:', name: 'helpTuto');

  String delete(String name) => Intl.message('Supprimer $name?', args: [name], name: 'delete');

  String get deleteOfficePermission => Intl.message('Enlever les accès?', name: 'deleteOfficePermission');

  String get deleteHealerConfirm =>
      Intl.message('Êtes-vous sûr de vouloir supprimer ce soignant?\nCette action ne peut être annulée et le soignant devra se réinscrire.',
          name: 'deleteHealerConfirm');

  String get deleteManagerConfirm =>
      Intl.message('Êtes-vous sûr de vouloir supprimer cette secrétaire médicale?\nCette personne ne pourra plus gérer ce cabinet.',
          name: 'deleteManagerConfirm');

  String get deleteOfficeHealerConfirm => Intl.message(
      'Êtes-vous sûr de vouloir supprimer ce soignant de cette salle de soins?\nCette personne ne pourra plus faire de présentiel dans cette salle.',
      name: 'deleteOfficeHealerConfirm');

  String get acceptButton => Intl.message('Accepter', name: 'acceptButton');

  String get allowFaceToFace => Intl.message('Activer le présentiel', name: 'allowFaceToFace');

  String get allowFaceToFaceConfirm => Intl.message('Etes vous sur de vouloir autoriser se soignant à faire du présentiel?', name: 'allowFaceToFaceConfirm');

  String get disallowFaceToFace => Intl.message('Désactiver le présentiel', name: 'disallowFaceToFace');

  String get disallowFaceToFaceConfirm =>
      Intl.message('Etes vous sur de vouloir supprimer l\'autoriser de se soignant à faire du présentiel?', name: 'disallowFaceToFaceConfirm');

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

  String get acceptTerms => Intl.message(
      'Les informations recueillies sur ce formulaire sont enregistrées dans un fichier informatisé par l\'Alliance Humaine Santé Internationale pour nous permettre de traiter votre demande. Elles sont conservées pendant toute la durée de notre relation. En soumettant ce formulaire, j’accepte que mes informations soient utilisées exclusivement dans le cadre de ma demande et de la relation personnalisée qui pourrait en découler si je le souhaite.',
      name: 'acceptTerms');

  String get goToTerms =>
      Intl.message('Pour connaître et exercer mes droits, notamment pour annuler mon consentement, je consulte la politique de vie privée en cliquant ici.',
          name: 'goToTerms');

  String get passwordChanged => Intl.message('Votre mot de passe a été mis à jour.', name: 'passwordChanged');

  String get passwordMismatch => Intl.message('Les mots de passe ne correspondent pas', name: 'passwordMismatch');

  String get emailField => Intl.message('Email*:', name: 'emailField');

  String get captchaField => Intl.message('Recopier le texte de l\'image*:', name: 'captchaField');

  String get patientEmailField => Intl.message('Email du patient*:', name: 'patientEmailField');

  String get patientPhoneField => Intl.message('Téléphone du patient*:', name: 'patientPhoneField');

  String get patientNameField => Intl.message('Nom du patient*:', name: 'patientNameField');

  String get patientFirstNameField => Intl.message('Prénom du patient*:', name: 'patientFirstNameField');

  String get consultationType => Intl.message('Type de consultation*:', name: 'consultationType');

  String get consultationAddress => Intl.message('Adresse du cabinet*:', name: 'consultationAddress');

  String get consultationVisio => Intl.message('Téléconsultation', name: 'consultationVisio');

  String get consultationFaceToFace => Intl.message('Présentiel', name: 'consultationFaceToFace');

  String get legendMessage => Intl.message('Voici le code couleur pour vous retrouver rapidement dans votre calendrier.', name: 'legendMessage');

  String get legendUrgency => Intl.message('Urgences', name: 'legendUrgency');

  String get legendVisio => Intl.message('Téléconsultations', name: 'legendVisio');

  String get legendConsultation => Intl.message('Consultations présentielles', name: 'legendConsultation');

  String get legendPending => Intl.message('Consultations en attente de confirmation par le patient', name: 'legendPending');

  String get legendCancelled => Intl.message('Consultations annulées', name: 'legendCancelled');

  String consultationLabel(HealerEventType type) {
    switch (type) {
      case HealerEventType.visio:
        return consultationVisio;
      case HealerEventType.faceToFace:
        return consultationFaceToFace;
    }
    return '';
  }

  String openingLabel(OpeningType type) {
    switch (type) {
      //case OpeningType.available:
      //  return openingAvailable;
      case OpeningType.faceToFace:
        return openingFaceToFace;
      //case OpeningType.unavailable:
      //  return openingUnavailable;
      case OpeningType.visio:
        return openingVisio;
    }
    return '';
  }

  String openingRepeatLabel(OpeningRepeatType? repeat) {
    switch (repeat) {
      case OpeningRepeatType.daily:
        return openingRepeatDaily;
      case OpeningRepeatType.monthly:
        return openingRepeatMonthly;
      case OpeningRepeatType.weekly:
        return openingRepeatWeekly;
    }
    return openingRepeatNever;
  }

  String get openingRepeat => Intl.message('Répétition:', name: 'openingRepeat');

  String get openingType => Intl.message('Type de disponibilité:', name: 'openingType');

  String get openingAvailable => Intl.message('Disponible', name: 'openingAvailable');

  String get openingVisio => Intl.message('Téléconsultation', name: 'openingVisio');

  String get openingFaceToFace => Intl.message('Présentielle', name: 'openingFaceToFace');

  String get openingUnavailable => Intl.message('Indisponible', name: 'openingUnavailable');

  String get openingRepeatNever => Intl.message('Jamais', name: 'openingRepeatNever');

  String get openingRepeatDaily => Intl.message('Journalier', name: 'openingRepeatDaily');

  String get openingRepeatWeekly => Intl.message('Hebdomadaire', name: 'openingRepeatWeekly');

  String get openingRepeatMonthly => Intl.message('Mensuel', name: 'openingRepeatMonthly');

  String get patientEmailHelp => Intl.message('La patient doit être inscrit sur Soignez Heureux avec cette email', name: 'patientEmailHelp');

  String get downloadHealerTerms => Intl.message('Télécharger la charte', name: 'downloadTerms');

  String get sendHealerProof => Intl.message(
      'Afin de valider votre compte soignant, merci de nous fournir votre carte d\'identité, la charte Soignez Heureux signé ainsi une preuve de votre spécialité (diplôme, attestation de formation...) par email à contact@ah-si.org.',
      name: 'sendHealerProof');

  String get noAvailabilities => Intl.message('Aucune disponibilité pour le moment', name: 'noAvailabilities');

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

  String get eventPendingWarning => Intl.message(
      'Le patient n\'a pas validé cette consultation, elle ne sera donc pas comptabilisé à la fin du mois. La patient doit cliquer sur le lien qu\'il a reçu par email.',
      name: 'eventPendingWarning');

  String get patientMessage => Intl.message('Motif du rendez-vous:', name: 'patientMessage');

  String get messageForPatient => Intl.message('Message pour le patient:', name: 'messageForPatient');

  String get patientCancelledMessage => Intl.message('Motif de l\'annulation:', name: 'patientCancelledMessage');

  String get cancelButton => Intl.message('Annuler', name: 'cancelButton');

  String get showQrCode => Intl.message('Affiche le QR Code', name: 'showQrCode');

  String get qrCodeTitle => Intl.message('QR Code', name: 'qrCodeTitle');

  String get joinVisioButton => Intl.message('Rejoindre la visio', name: 'joinVisioButton');

  String get seeAddress => Intl.message('Voir l\'adresse', name: 'seeAddress');

  String get addressTitle => Intl.message('Adresse du rendez-vous', name: 'addressTitle');

  String get updateEvent => Intl.message('Modifier', name: 'updateEvent');

  String get updateEventMessage => Intl.message('Message pour le patient', name: 'updateEventMessage');

  String get infoSaved => Intl.message('Information enregistrée avec succès', name: 'infoSaved');

  String get saveButton => Intl.message('Enregistrer', name: 'saveButton');

  String get deleteOpening => Intl.message('Supprimer la disponibilité?', name: 'deletingOpening');

  String get deleteOpeningMessage => Intl.message('Voulez vous vraiment supprimer cette disponibilité?', name: 'deleteOpeningMessage');

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

  String get searchQueryPlaceholder => Intl.message('Nom, prénom, email...', name: 'searchQueryPlaceholder');

  String get editUser => Intl.message('Modifier l\'utilisateur', name: 'editUser');

  String get descriptionField => Intl.message('Description*:', name: 'descriptionField');

  String get expField => Intl.message('Experiences:', name: 'expField');

  String get diplomaField => Intl.message('Diplomes:', name: 'diplomaField');

  String get nameField => Intl.message('Nom*:', name: 'nameField');

  String get firstNameField => Intl.message('Prénom*:', name: 'firstNameField');

  String get phoneField => Intl.message('Mobile*:', name: 'phoneField');

  String get cityField => Intl.message('Ville*:', name: 'cityField');

  String get zipField => Intl.message('Code postal*:', name: 'zipField');

  String get generalNameField => Intl.message('Nom*:', name: 'generalNameField');

  String get streetField => Intl.message('Numéro et rue:', name: 'streetField');

  String get street2Field => Intl.message('Complément:', name: 'street2Field');

  String get socialIntro => Intl.message('Si vous le souhaitez, vous pouvez renseigner vos liens sociaux:', name: 'socialIntro');

  String get personalInfoIntro => Intl.message('Merci de remplir vos informations personnelles:', name: 'personalInfoIntro');

  String get proInfoIntro => Intl.message('Merci de remplir vos informations professionnelles:', name: 'proInfoIntro');

  String get eraseButton => Intl.message('Effacer', name: 'eraseButton');

  String get calendarLegend => Intl.message('M. = Matin, AM. = Après midi', name: 'calendarLegend');

  String get calendarEventsLegend => Intl.message('Légende du calendrier', name: 'calendarEventsLegend');

  String get dayHourError => Intl.message('L\'heure de début ne peut être avant l\'heure de fin', name: 'dayHourError');

  String get calendarIntro => Intl.message('Merci de remplir vos disponibilités:', name: 'calendarIntro');

  String get calendarShowExternalOpenings => Intl.message('Disponibilités cabinets médicaux', name: 'calendarIntro');

  String get calendarShowExternalOpeningsDesc => Intl.message('Afficher les disponibilités de tout les soignants de mes cabinets médicaux', name: 'calendarIntro');

  String get consultationDurationField => Intl.message('Durée d\'une consultation*:', name: 'consultationDurationField');

  String get consultationDurationHint => Intl.message('A spécifier en minutes', name: 'consultationDurationHint');

  String calendarDayError(String day) => Intl.message('Les horaires pour $day sont incorrects, merci de corriger.', args: [day], name: 'calendarDayError');

  String get cancelConsultation => Intl.message('Annuler la consultation?', name: 'cancelConsultation');

  String cancelConsultationConfirm(String name) =>
      Intl.message('Êtes-vous sûr de vouloir annuler la consultation avec $name?', args: [name], name: 'cancelConsultationConfirm');

  String consultationCanceled(String name) =>
      Intl.message('Votre consultation avec $name a été annulée, un email lui a été envoyé pour l\'avertir.', args: [name], name: 'cancelConsultationConfirm');

  String get noEvents => Intl.message('Vous n\'avez aucune consultation planifiée pour le moment.', name: 'noEvents');

  String get eventHistoryIntro =>
      Intl.message('Voici l\'historique de vos consultations, seul l\'historique à 30 jours est affiché ici.', name: 'eventHistoryIntro');

  String get noEventHistory => Intl.message('Vous n\'avez aucune consultation dans votre historique.', name: 'noEventHistory');

  String get loading => Intl.message('Chargement en cours...', name: 'loading');

  String get profile => Intl.message('Profil', name: 'profile');

  String get countryField => Intl.message('Pays', name: 'countryField');

  String get help => Intl.message('Aide', name: 'help');

  String get patientMode => Intl.message('Mode patient', name: 'patientMode');

  String get healerMode => Intl.message('Mode soignant', name: 'healerMode');

  String get adminMode => Intl.message('Mode admin', name: 'adminMode');

  String get helpIntro => Intl.message(
      'Si vous avez besoin d\'aide, rejoignez d\'autres soignants sur le réseau Telegram dédié de Soignez Heureux en cliquant sur le lien suivant:',
      name: 'helpIntro');

  String get helpOrdo => Intl.message('Pour vos prescriptions, vous pouvez utiliser l\'ordonnance de l\'ONG:', name: 'helpOrdo');

  String get helpDownloadOrdo => Intl.message('Télécharger l\'ordonnance', name: 'helpDownloadOrdo');

  String get healerUrl => Intl.message(
      'Vous pouvez partager le lien de votre compte soignant afin que des patients prenne rendez-vous directement avec vous. Votre lien soignant est:',
      name: 'healerUrl');

  String get manageOfficeRooms => Intl.message('Gestion des salles de soin', name: 'manageOfficeRooms');

  String get officeManagers => Intl.message('Gestion des secrétaires médical', name: 'officeManagers');

  String get officeHealers => Intl.message('Gestion des soignants', name: 'officeHealers');

  String get addManager => Intl.message('Ajouter une secrétaire médical', name: 'addManager');

  String get addOfficeHealer => Intl.message('Ajouter un soignant', name: 'addOfficeHealer');

  String get helpYoutube => Intl.message('Une série de tutoriels sont disponibles sur notre chaine Youtube officiel:', name: 'helpYoutube');

  String get helpCall =>
      Intl.message('Pour appeler les patients de manière anonyme (numéro masqué), vous pouvez rajouter #31# avant le numéro du patient.', name: 'helpCall');

  String get eventsHistory => Intl.message('Historique', name: 'eventsHistory');

  String get resendActivationLink => Intl.message('Renvoyer le lien', name: 'resendActivationLink');

  String get eventsDescription =>
      Intl.message('Vos consultations à venir sont affichées ici, pour voir vos anciennes consultations, consultez votre historique.',
          name: 'eventsDescription');

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

  String get mentionLegal => Intl.message(
      'Aucune donnée médicale n\'est demandée ni diffusée. Les données personnelles sont protégées. Les praticiens médicaux et para médicaux de « soignez heureux » se sont engagés à respecter le secret médical.',
      name: 'mentionLegal');

  String get addressLegal =>
      Intl.message('Alliance Humaine Santé Internationale - AHSI\nHuman Alliance International Health – HAIH\nCH-1202 Genève – Suisse', name: 'addressLegal');

  String get donateIntro => Intl.message('Voici les informations pour faire vos dons par virement bancaire: ', name: 'donateIntro');

  String get urgencyContact => Intl.message(
      'En cas d\'urgence, et si vous ne trouvez pas de médecin disponible, merci de nous contacter à urgence@ah-si.org en précisant votre problème et vos informations de contact.',
      name: 'urgencyContact');

  String eventCreatedAt(String date) => Intl.message('Consultation prise le $date', args: [date], name: 'eventCreatedAt');

  String get donateInstructions =>
      Intl.message('Si vous faites un don, merci de préciser votre destination de don dans le champ information :', name: 'donateInstructions');

  String get takeRdv => Intl.message('Prendre rendez-vous', name: 'takeRdv');

  String get createRdv => Intl.message('Créer un rendez-vous', name: 'createRdv');

  String get rdvCreated => Intl.message('Rendez-vous validé!', name: 'rdvCreated');

  String get openingCreated => Intl.message('Disponibilité créée!', name: 'openingCreated');

  String get eventIsUrgency => Intl.message('Signaler au soignant que c\'est une urgence', name: 'eventIsUrgency');

  String get adminEventIsUrgency => Intl.message('Urgent', name: 'adminEventIsUrgency');

  String get adminEnableUrgency => Intl.message('Afficher le bouton urgence', name: 'adminEnableUrgency');

  String get adminEventIsCancelled => Intl.message('Annulée', name: 'adminEventIsCancelled');

  String get inviteEventAccepted => Intl.message('Merci d\'avoir validé la consultation.\nSoyez Heureux!', name: 'inviteEventAccepted');

  String get accountActivated =>
      Intl.message('Merci d\'avoir activé votre compte, vous pouvez maintenant utiliser Soignez Heureux.\nSoyez Heureux!', name: 'accountActivated');

  String get eventUrgencyTitle => Intl.message('Rendez-vous urgent', name: 'eventUrgencyTitle');

  String get eventUrgencyDesc => Intl.message(
      'Si votre cas est grave et que vous avez besoin d\'une consultation urgente, ceci alertera le soignant. Si il peut vous prendre plus tôt il vous contactera directement par téléphone.\n\nVérifiez que vos informations de contact soient correctes dans votre profil.\n\nMerci d\'utiliser ceci uniquement en cas d\'urgence.',
      name: 'eventUrgencyDesc');

  String get hideCancelled => Intl.message('Cacher les annulations', name: 'hideCancelled');

  String get showCalendarLegend => Intl.message('Voir la légende', name: 'showCalendarLegend');

  String get seeOnlyUrgencies => Intl.message('Voir uniquement les consultations urgentes', name: 'seeOnlyUrgencies');

  String get rdvCreatedDescription => Intl.message('Vous allez recevoir un email de confirmation.', name: 'rdvCreatedDescription');

  String get openingCreatedDescription =>
      Intl.message('Les patients pourront maintenant prendre (ou non si vous avez créé une indisponibilité) rendez-vous avec vous sur ce créneau.',
          name: 'openingCreatedDescription');

  String get messageForHealer => Intl.message('Motif du rendez-vous:', name: 'messageForHealer');

  String get creatingRdv => Intl.message('Création du rendez-vous', name: 'creatingRdv');

  String get wrongConsultationDuration => Intl.message('entre 30 et 120 minutes uniquement', name: 'wrongConsultationDuration');

  String get hintReasonConsultation =>
      Intl.message('Merci de préciser aussi votre age et vos pathologies dans le motif de votre consultation.', name: 'hintReasonConsultation');

  String takeRdvConfirm(String name, String when) => Intl.message('Voulez-vous prendre rendez-vous avec $name à $when?', name: 'takeRdvConfirm');

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
