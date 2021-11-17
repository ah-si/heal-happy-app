import 'package:flutter/material.dart';
import 'package:heal_happy/admin/home_screen.dart' as admin;
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/healer/home_screen.dart' as healer;
import 'package:heal_happy/patient/home_screen.dart' as patient;
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  static const name = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStore = ref.watch(userStoreProvider);

    if (userStore.initPending || userStore.user == null) {
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

    switch (userStore.user?.type) {
      case UserTypeEnum.admin:
        return const admin.AdminHomeScreen();
      case UserTypeEnum.healer:
        return const healer.HealerHomeScreen();
      case UserTypeEnum.patient:
        return const patient.PatientHomeScreen();
      default:
        return const patient.PatientHomeScreen();
    };
  }
}
