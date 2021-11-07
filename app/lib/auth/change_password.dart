import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/auth/login_screen.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangePasswordScreen extends HookConsumerWidget {
  static const String name = 'change_password';
  final String token;

  const ChangePasswordScreen(this.token, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerPass = useTextEditingController();
    final controllerConfirm = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    submitForm() async {
      if (formKey.currentState!.validate()) {
        final store = ref.read(userStoreProvider);
        final success = await showLoadingDialog(
          context,
          (context) => const Text('Envoi en cours...'),
          () => store.changePassword(controllerPass.text, token),
        );
        if (success) {
          context.goNamed(LoginScreen.name);
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 180),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      padding: const EdgeInsets.all(kNormalPadding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: kPrimaryColor,
                            blurRadius: 15,
                            offset: Offset(4, 6), // Shadow position
                          ),
                        ],
                        border: Border.all(
                          color: kPrimaryColor,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(kSmallPadding),
                        ),
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: controllerPass,
                              obscureText: true,
                              validator: isRequired,
                              keyboardType: TextInputType.text,
                              autofillHints: const [AutofillHints.newPassword],
                              onFieldSubmitted: (_) => submitForm(),
                              decoration: const InputDecoration(label: Text('Mot de passe*:')),
                            ),
                            TextFormField(
                              controller: controllerConfirm,
                              obscureText: true,
                              validator: isRequired,
                              keyboardType: TextInputType.text,
                              autofillHints: const [AutofillHints.password],
                              onFieldSubmitted: (_) => submitForm(),
                              decoration: const InputDecoration(label: Text('Confirmation mot de passe*:')),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(kNormalPadding),
                              child: ElevatedButton(
                                onPressed: submitForm,
                                child: const Text('Envoyer'),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.goNamed(LoginScreen.name);
                              },
                              child: const Text('Revenir au login'),
                            ),
                          ],
                        ),
                      ),
                    ),
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
