import 'dart:ui';

import 'package:logging/logging.dart';

const bool kIsProductionMode = bool.fromEnvironment('dart.vm.product');

const String kUrlYoutube = 'https://www.youtube.com/channel/UCPJ5aTSrWqz8AXyxQS-Melw';
const String kUrlPlayStore = 'https://play.google.com/store/apps/details?id=org.ahsi.soignez_heureux';
const String kUrlAppStore = 'org.ahsi.soignez_heureux';
const String kUrlAppMacStore = 'org.ahsi.soignez_heureux';
const String kUrlTelegramHealer = 'https://t.me/+TceR1MPeLAY4ZDI0';
const String kUrlTelegramPara = 'https://t.me/+nIG4tVyJpC01OTc0';

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
