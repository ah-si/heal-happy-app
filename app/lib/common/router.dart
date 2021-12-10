import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/admin/user_details_screen.dart';
import 'package:heal_happy/auth/change_password.dart';
import 'package:heal_happy/auth/login_screen.dart';
import 'package:heal_happy/auth/register/register_screen.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/main.dart';
import 'package:heal_happy/patient/healer_profile_screen.dart';
import 'package:heal_happy/user/home_screen.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

late GoRouter _router;

GoRouter createRouter(UserStore userStore) => _router = GoRouter(
      refreshListenable: userStore,
      // redirect to the login page if the user is not logged in
      redirect: (state) {
        if (userStore.initPending) {
          //login still ongoing so let's wait
          return null;
        }
        final currentRoute = state.name ?? state.location;
        final loggedIn = userStore.user != null;
        final currentScreenAllowAnonymous = [
              '/',
              '/404',
              '/500',
              RegisterScreen.name,
              LoginScreen.name,
              ChangePasswordScreen.name,
              '/${LoginScreen.name}',
              '/${ChangePasswordScreen.name}',
              '/${RegisterScreen.name}',
              SplashScreen.name,
            ].firstWhereOrNull(
              (route) {
                if (route == '/') {
                  return route == currentRoute;
                }
                return currentRoute.startsWith(route);
              },
            ) !=
            null;

        if (currentRoute.startsWith('/admin') && userStore.user?.type != UserTypeEnum.admin) {
          return state.namedLocation(HomeScreen.name);
        }

        // the user is not logged in and not headed to /login, they need to login
        if (!loggedIn && (!currentScreenAllowAnonymous || currentRoute == '/')) {
          return state.namedLocation(LoginScreen.name);
        }

        if (loggedIn && currentRoute == '/') {
          return state.namedLocation(HomeScreen.name);
        }

        // no need to redirect at all
        return null;
      },
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/404',
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return child;
            },
            child: const PageStatus(status: 404),
          ),
        ),
        GoRoute(
          path: '/500',
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return child;
            },
            child: const PageStatus(status: 500),
          ),
        ),
        GoRoute(
          path: '/',
          name: SplashScreen.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return child;
            },
            child: const SplashScreen(),
          ),
        ),
        GoRoute(
          path: '/${LoginScreen.name}',
          name: LoginScreen.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: const LoginScreen(),
          ),
        ),
        GoRoute(
          path: '/${ChangePasswordScreen.name}',
          name: ChangePasswordScreen.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: ChangePasswordScreen(state.queryParams['token'] ?? ''),
          ),
        ),
        GoRoute(
          path: UserDetailsScreen.route,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: UserDetailsScreen(
              id: state.params['id']!,
            ),
          ),
        ),
        GoRoute(
          path: HealerProfileScreen.route,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: HealerProfileScreen(
              id: state.params['id']!,
            ),
          ),
        ),
        GoRoute(
          path: '/${RegisterScreen.name}',
          name: RegisterScreen.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: const RegisterScreen(),
          ),
        ),
        GoRoute(
          path: '/${HomeScreen.name}',
          name: HomeScreen.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: const HomeScreen(),
          ),
        ),
      ],
      errorPageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: const PageStatus(status: 404),
        );
      },
    );

class PageStatus extends StatelessWidget {
  static const _message = {
    404: '404 page introuvable',
    500: '500 erreur serveur',
  };

  final int status;

  const PageStatus({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BgContainer(
      child: IntroDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_message[status]!, style: context.textTheme.headline6),
            const SizedBox(height: kSmallPadding),
            TextButton(
              onPressed: () {
                _router.go('/');
              },
              child: const Text('Retourner sur le site'),
            ),
          ],
        ),
      ),
    );
  }
}
