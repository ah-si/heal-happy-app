import 'dart:async';
import 'dart:io';

import 'package:heal_happy/auth/login_screen.dart';
import 'package:heal_happy/common/l10n/common_localizations.dart';
import 'package:heal_happy/common/l10n/error_localizations.dart';
import 'package:heal_happy/common/router.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/logging.dart';
import 'package:heal_happy/common/utils/preferences_provider.dart';
import 'package:heal_happy/home/home_screen.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

MaterialColor createMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initLogger();
  await PreferencesProvider().setup();
  if (kIsWeb) {
    GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(builder: (context, ref, child) {
        final userStore = ref.read(userStoreProvider);
        return HookBuilder(
          builder: (context) {
            final router = useMemoized(() => createRouter(userStore));
            return MaterialApp.router(
              title: 'Soignez Heureux',
              theme: ThemeData(
                primarySwatch: createMaterialColor(kPrimaryColor),
              ),
              locale: const Locale('fr', 'FR'),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                CommonLocalizationsDelegate(),
                ErrorLocalizationsDelegate(),
              ],
              supportedLocales: kSupportedLanguages,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
            );
          },
        );
      }),
    );
  }
}

class SplashScreen extends HookConsumerWidget {
  static const name = 'splashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStore = ref.read(userStoreProvider); //read and not watch to avoid loop

    return Scaffold(
      body: FutureBuilder(
        future: userStore.init(silent: false),
        builder: (context, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          scheduleMicrotask(() {
            if (data.hasError) {
              context.goNamed(LoginScreen.name);
            } else {
              context.goNamed(HomeScreen.name);
            }
          });
          return const SizedBox();
        },
      ),
    );
  }
}
