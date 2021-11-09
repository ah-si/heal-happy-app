import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/common/config.dart';
import 'package:heal_happy/common/l10n/common_localizations.dart';
import 'package:heal_happy/common/l10n/error_localizations.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/router.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/logging.dart';
import 'package:heal_happy/common/utils/preferences_provider.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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

void main() {
  app();
}

void app({Config? config}) async {
  config ??= Config();
  WidgetsFlutterBinding.ensureInitialized();

  initLogger();

  await PreferencesProvider().setup();
  if (kIsWeb) {
    GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  }
  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://55cc8e96b7a7494aa3648c2f16654931@o1060733.ingest.sentry.io/6050521';
    },
    appRunner: () => runApp(const MyApp()),
  );
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
              locale: kSupportedLanguages.first,
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
    useEffect(() {
      scheduleMicrotask(() {
        userStore.init(silent: false);
      });
    }, const []);
    return const BgContainer(
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
