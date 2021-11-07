import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/admin/home_screen.dart';
import 'package:heal_happy/auth/change_password.dart';
import 'package:heal_happy/auth/login_screen.dart';
import 'package:heal_happy/auth/register/register_screen.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/healer/home_screen.dart';
import 'package:heal_happy/main.dart';
import 'package:heal_happy/patient/home_screen.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

extension GoRouterExtension on GoRouter {
  goToHome() {
    switch((routerDelegate.refreshListenable as UserStore).requiredUser.type) {
      case UserTypeEnum.admin:
        return goNamed(AdminHomeScreen.name);
      case UserTypeEnum.healer:
        return goNamed(HealerHomeScreen.name);
      case UserTypeEnum.patient:
        return goNamed(PatientHomeScreen.name);
    }
  }
}

GoRouter createRouter(UserStore userStore) => GoRouter(
      refreshListenable: userStore,
      // redirect to the login page if the user is not logged in
      redirect: (state) {
        if (userStore.loginPending) {
          //login still ongoing so let's wait
          return null;
        }
        final currentRoute = state.name ?? state.location;
        final loggedIn = userStore.user != null;
        final currentScreenAllowAnonymous = [
          '/',
          RegisterScreen.name,
          LoginScreen.name,
          ChangePasswordScreen.name,
          '/${LoginScreen.name}',
          '/${ChangePasswordScreen.name}',
          '/${RegisterScreen.name}',
          SplashScreen.name,
        ].contains(currentRoute);

        // the user is not logged in and not headed to /login, they need to login
        if (!loggedIn && (!currentScreenAllowAnonymous || currentRoute == '/')) {
          return state.namedLocation(LoginScreen.name);
        }

        if (loggedIn && currentRoute == '/') {
          switch(userStore.requiredUser.type) {
            case UserTypeEnum.admin:
              return state.namedLocation(AdminHomeScreen.name);
            case UserTypeEnum.healer:
              return state.namedLocation(HealerHomeScreen.name);
            case UserTypeEnum.patient:
              return state.namedLocation(PatientHomeScreen.name);
          }
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
          path: '/${AdminHomeScreen.name}',
          name: AdminHomeScreen.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: const AdminHomeScreen(),
          ),
        ),
        GoRoute(
          path: '/${PatientHomeScreen.name}',
          name: PatientHomeScreen.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: const PatientHomeScreen(),
          ),
        ),
        GoRoute(
          path: '/${HealerHomeScreen.name}',
          name: HealerHomeScreen.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: const HealerHomeScreen(),
          ),
        ),
      ],
      errorPageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: const BgContainer(child: Center(child: Text('404 page not found'))),
        );
      },
    );
