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
import 'package:url_launcher/url_launcher_string.dart';

class LoginScreen extends HookConsumerWidget {
  static const name = 'login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: PreferencesProvider().prefs.getString(PreferencesProvider.keyEmail) ?? '');
    final controllerPass = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    submitForm() async {
      if (formKey.currentState!.validate()) {
        //TextInput.finishAutofillContext(shouldSave: true);
        final store = ref.read(userStoreProvider);
        final success = await showLoadingDialog(
          context,
          (context) => Text(context.l10n.login),
          () => store.login(controller.text.trim(), controllerPass.text.trim()),
        );
        if (success) {
          context.goNamed(HomeScreen.name);
        }
      }
    }

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
                  child: AutofillGroup(
                    onDisposeAction: AutofillContextAction.commit,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: controller,
                            validator: (value) => isEmailValid(value, context),
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email, AutofillHints.username],
                            decoration: InputDecoration(label: Text(context.l10n.emailField)),
                          ),
                          TextFormField(
                            controller: controllerPass,
                            obscureText: true,
                            validator: (value) => isRequired(value, context),
                            keyboardType: TextInputType.text,
                            autofillHints: const [AutofillHints.password],
                            onFieldSubmitted: (_) => submitForm(),
                            decoration: InputDecoration(label: Text(context.l10n.passwordField)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(kNormalPadding),
                            child: ElevatedButton(
                              onPressed: submitForm,
                              child: Text(context.l10n.loginButton),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.goNamed(RegisterScreen.name);
                            },
                            child: Text(context.l10n.noAccount, textAlign: TextAlign.center),
                          ),
                          TextButton(
                            onPressed: () async {
                              final email = await showPrompt(
                                context,
                                context.l10n.passwordForgotten,
                                description: context.l10n.needEmail,
                                initialValue: controller.text,
                                validator: (value) => isEmailValid(value, context),
                              );
                              if (!email.isNullOrEmpty) {
                                final store = ref.read(userStoreProvider);
                                final success = await showLoadingDialog(context, (_) => Text(context.l10n.sending), () => store.askResetPassword(email!));
                                if (success) {
                                  showAlert(context, context.l10n.passwordForgotten, (_) => Text(context.l10n.passwordForgottenEmailSent));
                                }
                              }
                            },
                            child: Text(context.l10n.passwordForgottenButton, textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (kIsWeb)
                  Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            launchUrlString(kUrlPlayStore);
                          },
                          child: Image.asset(
                            'assets/images/play_badge.png',
                            width: 250,
                            fit: BoxFit.contain,
                          ),
                        ),
                        if (false)
                          InkWell(
                            onTap: () {
                              launchUrlString(kUrlAppStore);
                            },
                            child: Image.asset(
                              'assets/images/apple_badge.png',
                              width: 220,
                              fit: BoxFit.contain,
                            ),
                          ),
                        if (false)
                          InkWell(
                            onTap: () {
                              launchUrlString(kUrlAppMacStore);
                            },
                            child: Image.asset(
                              'assets/images/mac_badge.png',
                              width: 250,
                              fit: BoxFit.contain,
                            ),
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
