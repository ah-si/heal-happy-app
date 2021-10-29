import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/auth/login_screen.dart';
import 'package:heal_happy/auth/register_screen.dart';
import 'package:heal_happy/home/home_screen.dart';
import 'package:heal_happy/main.dart';

GoRouter createRouter(userStore) => GoRouter(
      refreshListenable: userStore,
      // redirect to the login page if the user is not logged in
      redirect: (state) {
        final loggedIn = userStore.user != null;
        final currentScreenAllowAnonymous = [
          '/',
          RegisterScreen.name,
          LoginScreen.name,
          '/${LoginScreen.name}',
          '/${RegisterScreen.name}',
          SplashScreen.name,
        ].contains(state.name ?? state.location);

        print('redirect ${state.location} $loggedIn $currentScreenAllowAnonymous');

        // the user is not logged in and not headed to /login, they need to login
        if (!loggedIn && !currentScreenAllowAnonymous) {
          print('GO LOGIN');
          return state.namedLocation(LoginScreen.name);
        }

        // the user is logged in and headed to /login, no need to login again
        if (loggedIn && state.name == LoginScreen.name) {
          print('GO HOME');
          return state.namedLocation(HomeScreen.name);
        }

        // no need to redirect at all
        return null;
      },

      routes: [
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
        print('ERROR ${state.name} ${state.location}');
        return CustomTransitionPage<void>(
          key: state.pageKey,
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Text('404 page not found'),
        );
      },
    );
