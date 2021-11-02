import 'package:flutter/material.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminHomeScreen extends HookConsumerWidget {
  static const name = 'admin_home';

  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(userStoreProvider);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
