import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/auth/register/register_screen.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy/common/utils/preferences_provider.dart';
import 'package:heal_happy/main.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountActivatedScreen extends HookConsumerWidget {
  static const name = 'accountActivated';

  const AccountActivatedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return BgContainer(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kNormalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 180,
                  ),
                ),
                const SizedBox(height: 30),
                IntroDialog(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    children: [
                      Text(context.l10n.accountActivated, textAlign: TextAlign.center),
                      const SizedBox(height: kNormalPadding),
                      TextButton(
                        onPressed: () {
                          context.go('/');
                        },
                        child: Text(context.l10n.backToLogin),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
