import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/admin/home_screen.dart' as admin;
import 'package:heal_happy/common/config.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/l10n/common_localizations.dart';
import 'package:heal_happy/common/l10n/error_localizations.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/router.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/logging.dart';
import 'package:heal_happy/common/utils/preferences_provider.dart';
import 'package:heal_happy/healer/home_screen.dart' as healer;
import 'package:heal_happy/patient/home_screen.dart' as patient;
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
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

FutureOr<SentryEvent?> beforeSend(SentryEvent event, {dynamic hint}) async {
  if (event.throwable is ErrorResultException && event.throwable.cause != ErrorResult.internal) {
    return null;
  } else if (event.throwable is DioError && event.throwable.statusCode == 401) {
    return null;
  } else if (event.throwable is DioError && event.throwable.statusCode == 403) {
    return null;
  } else if (event.throwable is DioError && event.throwable.statusCode == 400) {
    return null;
  }

  return event;
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
      options.dsn = kIsProductionMode ? 'https://1827c477584d403dacf3ba82fb437c39@sentry.ah-si.org/2' : '';
      options.beforeSend = beforeSend;
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
              //force time picker and other date widget to use 24h format
              builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!),
              theme: ThemeData(
                primarySwatch: createMaterialColor(kPrimaryColor),
                scrollbarTheme: const ScrollbarThemeData().copyWith(
                  thumbColor: MaterialStateProperty.all(Colors.grey[500]),
                ),
              ),
              locale: kSupportedLanguages.first,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
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

class HomeScreen extends HookConsumerWidget {
  static const name = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStore = ref.watch(userStoreProvider);

    if (userStore.user == null) {
      return const BgContainer(
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    switch (userStore.user?.type) {
      case UserTypeEnum.admin:
        return const admin.AdminHomeScreen();
      case UserTypeEnum.healer:
        return const healer.HealerHomeScreen();
      case UserTypeEnum.patient:
        return const patient.PatientHomeScreen();
      default:
        return const patient.PatientHomeScreen();
    }
  }
}
