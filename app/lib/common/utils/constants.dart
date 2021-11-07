import 'dart:ui';

import 'package:logging/logging.dart';

const bool kIsProductionMode = bool.fromEnvironment('dart.vm.product');

final kDebugLogger = Logger('HealHappy');

final kSupportedLanguages = [
  const Locale('fr', 'FR'), // French
];

const kPrimaryColor = Color(0xFF2a3a5e);
const kAccentColor = Color(0xFF4f8e41);

const double kSmallPadding = 8.0;
const double kMediumPadding = 12.0;
const double kNormalPadding = 15.0;
const double kBigPadding = 32.0;
const double kHugePadding = 54.0;

const kGradient1Color = Color(0xFF101f34);
const kGradient2Color = Color(0xFF4d8c3f);
const kGradient3Color = Color(0xFF6aa842);

const specialities = {
  'allergologue': 'Allergologue',
  'anatomo_cyto_pathologiste': 'Anatomo-cyto-pathologiste',
  'andrologue': 'Andrologue',
  'anesthesiste-rea': 'Anesthésiste-réanimateur',
  'angiologue': 'Angiologue',
  'aromatherapeute': 'Aromathérapeute',
  'audioprothesiste': 'Audioprothésiste',
  'cancerologue': 'Cancérologue',
  'cancerologue_med': 'Cancérologue médical',
  'cancerologue_radio': 'Cancérologue radiothérapeute',
  'cardiologue': 'Cardiologue',
  'chiropracteur': 'Chiropracteur',
  'chir': 'Chirurgien',
  'chir_cancer': 'Chirurgien cancérologue',
  'chir_dentiste': 'Chirurgien-dentiste',
  'chir_face_cou': 'Chirurgien de la face et du cou',
  'chir_main': 'Chirurgien de la main',
  'chir_inf': 'Chirurgien infantile',
  'chir_maxillo_facial': 'Chirurgien maxillo-facial',
  'chir_maxillo_facial_stoma': 'Chirurgien maxillo-facial et stomatologue',
  'chir_ortho': 'Chirurgien orthopédiste',
  'chir_thoracique_cardio': 'Chirurgien thoracique et cardio-vasculaire',
  'chir_plasticien_esthetique': 'Chirurgien plasticien et esthétique',
  'chir_uro': 'Chirurgien urologue',
  'chir_vasculaire': 'Chirurgien vasculaire',
  'chir_visceral_digestif': 'Chirurgien viscéral et digestif',
  'dermatologue': 'Dermatologue',
  'dieteticien': 'Diététicien',
  'endocrinologue': 'Endocrinologue',
  'energeticien': 'Énergéticien',
  'ergotherapeute': 'Ergothérapeute',
  'gastro_hepato': 'Gastro-entérologue et hépatologue',
  'geneticien': 'Généticien',
  'geriatre': 'Gériatre',
  'gyneco_med': 'Gynécologue médical',
  'gyneco_med_obstretrique': 'Gynécologue médical et obstétrique',
  'gyneco_obstretricien': 'Gynécologue obstétricien',
  'hematologue': 'Hématologue',
  'hypno': 'Hypnothérapeute',
  'infectiologue': 'Infectiologue',
  'infirmier': 'Infirmier',
  'kinesiologue': 'Kinésiologue',
  'magnetiseur': 'Magnétiseur',
  'masseur_kine': 'Masseur-kinésithérapeute',
  'masso': 'Massothérapeute',
  'masso_reflexo': 'Massothérapeute-réflexologue',
  'med_acupuncteur': 'Médecin acupuncteur',
  'med_addictologue': 'Médecin addictologue',
  'med_biologiste': 'Médecin biologiste',
  'med_bucco_dentaire': 'Médecin bucco-dentaire',
  'med_sport': 'Médecin du sport',
  'med_travail': 'Médecin du travail',
  'med_gene': 'Médecin généraliste',
  'med_homeo': 'Médecin homéopathe',
  'med_morpho_age': 'Médecin morphologue et anti-âge',
  'med_nucleaire': 'Médecin nucléaire',
  'med_nutri': 'Médecin nutritionniste',
  'med_rea': 'Médecin réanimateur',
  'med_spe_sante_publique': 'Médecin spécialiste de santé publique',
  'med_urgentiste': 'Médecin urgentiste',
  'naturopathe': 'Naturopathe',
  'nephrologue': 'Néphrologue',
  'neurochirurgien': 'Neurochirurgien',
  'neurologue': 'Neurologue',
  'nutri': 'Nutritionniste',
  'oculariste': 'Oculariste',
  'ophtalmologue': 'Ophtalmologue',
  'opticien_lunetier': 'Opticien-lunetier',
  'orl': 'ORL',
  'orl_chir': 'ORL - Chirurgien de la face et du cou',
  'orthodontiste': 'Orthodontiste',
  'orthopediste_orthesiste': 'Orthopédiste-orthésiste',
  'orthopediste_orthesiste_podologiste': 'Orthopédiste-orthésiste-podologiste',
  'orthophoniste': 'Orthophoniste',
  'orthoprothesiste': 'Orthoprothésiste',
  'orthoptiste': 'Orthoptiste',
  'osteo': 'Ostéopathe',
  'pediatre': 'Pédiatre',
  'pedicure_podologue': 'Pédicure-podologue',
  'pharmacien': 'Pharmacien',
  'phlebologue': 'Phlébologue',
  'pneumologue': 'Pneumologue',
  'podo_orthesiste': 'Podo-orthésiste',
  'psychanalyste': 'Psychanalyste',
  'psychologue': 'Psychologue',
  'psychiatre': 'Psychiatre',
  'psychiatre_enfant_ado': 'Psychiatre de l\'enfant et de l\'adolescent',
  'psychomotricien': 'Psychomotricien',
  'radiologue': 'Radiologue',
  'radiotherapeute': 'Radiothérapeute',
  'reflexologue': 'Réflexologue',
  'rhumatologue': 'Rhumatologue',
  'sage_femme': 'Sage-femme',
  'sophrologue': 'Sophrologue',
  'spe_hemo_transufsion': 'Spécialiste en hémobiologie-transfusion',
  'spe_med_interne': 'Spécialiste en médecine interne',
  'spe_med_exper': 'Spécialiste en médecine légale et expertises médicales',
  'spe_med_readaptation': 'Spécialiste en médecine physique et de réadaptation',
  'stomatologue': 'Stomatologue',
};
