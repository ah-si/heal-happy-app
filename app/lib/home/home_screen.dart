
import 'package:app/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  static const name = 'home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(child: ElevatedButton(onPressed: (){
        final store = ref.read(userStoreProvider);
        store.logout();
      },child: Text('logout')),),
    );
  }

}
