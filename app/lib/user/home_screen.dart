import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/admin/home_screen.dart' deferred as admin;
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/healer/home_screen.dart' deferred as healer;
import 'package:heal_happy/patient/home_screen.dart' deferred as patient;
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  static const name = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStore = ref.watch(userStoreProvider);

    if (userStore.initPending) {
      return const BgContainer(child: Loading());
    }

    return const BgContainer(
      child: _HomeContent(),
    );
  }
}

class _HomeContent extends HookConsumerWidget {

  const _HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStore = ref.watch(userStoreProvider);

    Future future = useMemoized(() {
      switch (userStore.user?.type) {
        case UserTypeEnum.admin:
          return admin.loadLibrary();
        case UserTypeEnum.healer:
          return healer.loadLibrary();
        case UserTypeEnum.patient:
          return patient.loadLibrary();
        default:
          return patient.loadLibrary();
      }
    });
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }
        if (snapshot.hasError) {
          return Text(ErrorResult.internal.twoLiner(context), style: TextStyle(color: context.theme.errorColor));
        }

        switch (userStore.user?.type) {
          case UserTypeEnum.admin:
          // ignore: prefer_const_constructors
            return admin.AdminHomeScreen();
          case UserTypeEnum.healer:
          // ignore: prefer_const_constructors
            return healer.HealerHomeScreen();
          case UserTypeEnum.patient:
          // ignore: prefer_const_constructors
            return patient.PatientHomeScreen();
          default:
          // ignore: prefer_const_constructors
            return patient.PatientHomeScreen();
        }
      },
      future: future,
    );
  }
}
