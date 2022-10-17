import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/admin/home_screen.dart';
import 'package:heal_happy/admin/user_details_screen.dart';
import 'package:heal_happy/auth/change_password.dart';
import 'package:heal_happy/auth/login_screen.dart';
import 'package:heal_happy/auth/register/register_screen.dart';
import 'package:heal_happy/common/presentation/account_activated_screen.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/invite_accepted_screen.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/donations/donate.dart';
import 'package:heal_happy/donations/payments.dart';
import 'package:heal_happy/healer/home_screen.dart';
import 'package:heal_happy/main.dart';
import 'package:heal_happy/offices/presentation/office_defails.dart';
import 'package:heal_happy/patient/healer_profile_screen.dart';
import 'package:heal_happy/patient/home_screen.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

late GoRouter router;

GoRouter createRouter(UserStore userStore) => router = GoRouter(

      observers: [SentryNavigatorObserver()],
      refreshListenable: userStore,
      // redirect to the login page if the user is not logged in
      redirect: (context, state) {
        if (userStore.initPending) {
          //login still ongoing so let's wait
          return null;
        }
        final currentRoute = state.name ?? state.location;
        final loggedIn = userStore.user != null;
        final currentScreenAllowAnonymous = [
              HomeScreen.name,
              '/404',
              '/500',
              '/500',
              '/500',
              DonateCancelled.name,
              DonateScreen.name,
              PaymentCancelled.name,
              PaymentSuccess.name,
              DonateSuccess.name,
              RegisterScreen.name,
              InviteAcceptedScreen.name,
              AccountActivatedScreen.name,
              LoginScreen.name,
              ChangePasswordScreen.name,
              '/${DonateScreen.name}',
              '/${DonateCancelled.name}',
              '/${DonateSuccess.name}',
              '/${LoginScreen.name}',
              '/${AccountActivatedScreen.name}',
              '/${InviteAcceptedScreen.name}',
              '/${ChangePasswordScreen.name}',
              '/${RegisterScreen.name}',
            ].firstWhereOrNull(
              (route) {
                if (route == HomeScreen.name) {
                  return route == currentRoute;
                }
                return currentRoute.startsWith(route);
              },
            ) !=
            null;

        if (currentRoute.startsWith('/admin') && userStore.user?.type != UserTypeEnum.admin) {
          return state.namedLocation(HomeScreen.name);
        }

        if (currentRoute == '/healer' && userStore.user?.type == UserTypeEnum.patient) {
          return state.namedLocation(HomeScreen.name);
        }

        // the user is not logged in and not headed to /login, they need to login
        if (!loggedIn && (!currentScreenAllowAnonymous || currentRoute == HomeScreen.name)) {
          return state.namedLocation(LoginScreen.name);
        }

        // no need to redirect at all
        return null;
      },
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
          path: '/${DonateScreen.name}',
          name: DonateScreen.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return child;
            },
            child: const DonateScreen(),
          ),
        ),
        GoRoute(
          path: '/${DonateSuccess.name}',
          name: DonateSuccess.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return child;
            },
            child: const DonateSuccess(),
          ),
        ),
        GoRoute(
          path: '/${DonateCancelled.name}',
          name: DonateCancelled.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return child;
            },
            child: const DonateCancelled(),
          ),
        ),

        GoRoute(
          path: '/${PaymentSuccess.name}',
          name: PaymentSuccess.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return child;
            },
            child: const PaymentSuccess(),
          ),
        ),
        GoRoute(
          path: '/${PaymentCancelled.name}',
          name: PaymentCancelled.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return child;
            },
            child: const PaymentCancelled(),
          ),
        ),
        GoRoute(
          path: '/',
          name: HomeScreen.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return child;
            },
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/${AdminHomeScreen.name}',
          name: AdminHomeScreen.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return child;
            },
            child: const AdminHomeScreen(),
          ),
        ),
        GoRoute(
          path: '/${HealerHomeScreen.name}',
          name: HealerHomeScreen.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return child;
            },
            child: const HealerHomeScreen(),
          ),
        ),
        GoRoute(
          path: '/${PatientHomeScreen.name}',
          name: PatientHomeScreen.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return child;
            },
            child: const PatientHomeScreen(),
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
              eventType: state.extra as HealerEventType? ?? HealerEventType.visio,
            ),
          ),
        ),
        GoRoute(
          path: '${HealerProfileScreen.route}/visio',
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: HealerProfileScreen(
              id: state.params['id']!,
              eventType: HealerEventType.visio,
            ),
          ),
        ),
        GoRoute(
          path: '${HealerProfileScreen.route}/faceToFace',
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: HealerProfileScreen(
              id: state.params['id']!,
              eventType: HealerEventType.faceToFace,
            ),
          ),
        ),
        GoRoute(
          path: OfficeDetailsScreen.route,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: OfficeDetailsScreen(
              id: state.params['id']!,
              office: state.extra as Office?,
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
          path: '/${AccountActivatedScreen.name}',
          name: AccountActivatedScreen.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: const AccountActivatedScreen(),
          ),
        ),
        GoRoute(
          path: '/${InviteAcceptedScreen.name}',
          name: InviteAcceptedScreen.name,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: const InviteAcceptedScreen(),
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
                router.go('/');
              },
              child: const Text('Retourner sur le site'),
            ),
          ],
        ),
      ),
    );
  }
}
