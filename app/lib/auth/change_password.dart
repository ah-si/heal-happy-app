import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/auth/login_screen.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangePasswordScreen extends HookConsumerWidget {
  static const String name = 'resetPassword';
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
          (context) => Text(context.l10n.sending),
          () => store.changePassword(controllerPass.text, token),
        );
        if (success) {
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(content: Text(context.l10n.passwordChanged)));
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
                IntroDialog(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(context.l10n.resetPasswordIntro, style: context.textTheme.subtitle1),
                        TextFormField(
                          controller: controllerPass,
                          obscureText: true,
                          validator: (value) => isPasswordValid(value, true, context),
                          keyboardType: TextInputType.text,
                          autofillHints: const [AutofillHints.newPassword],
                          onFieldSubmitted: (_) => submitForm(),
                          decoration: InputDecoration(label: Text(context.l10n.passwordField)),
                        ),
                        TextFormField(
                          controller: controllerConfirm,
                          obscureText: true,
                          validator: (value) {
                            final result = isRequired(value, context);
                            if (result == null && controllerConfirm.text != controllerPass.text) {
                              return context.l10n.passwordMismatch;
                            }
                            return result;
                          },
                          keyboardType: TextInputType.text,
                          autofillHints: const [AutofillHints.password],
                          onFieldSubmitted: (_) => submitForm(),
                          decoration: InputDecoration(label: Text(context.l10n.confirmPasswordField)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kNormalPadding),
                          child: ElevatedButton(
                            onPressed: submitForm,
                            child: Text(context.l10n.sendButton),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.goNamed(LoginScreen.name);
                          },
                          child: Text(context.l10n.backToLogin),
                        ),
                      ],
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
