import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/auth/models/user_info.dart';
import 'package:heal_happy/common/config.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class StepPersonalInfo extends HookConsumerWidget {
  final VoidCallback? onContinue;
  final String? saveButtonLabel;
  final bool showTerms;
  final bool headless;

  const StepPersonalInfo({this.headless = false, this.showTerms = true, this.saveButtonLabel, this.onContinue, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.read(userInfoProvider);
    final userStore = ref.read(userStoreProvider);
    final controllerMobile = useTextEditingController(text: userInfo.mobile);
    final controllerLastName = useTextEditingController(text: userInfo.lastName);
    final controllerFirstName = useTextEditingController(text: userInfo.firstName);
    final controller = useTextEditingController(text: userInfo.email);
    final controllerPass = useTextEditingController(text: userInfo.password ?? '');
    final controllerConfirm = useTextEditingController();
    final termsState = useState(true);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    submitForm() {
      termsState.value = userInfo.isTermsAccepted;

      if (formKey.currentState!.validate() && (userInfo.isTermsAccepted || !showTerms)) {
        userInfo.firstName = controllerFirstName.text;
        userInfo.lastName = controllerLastName.text;
        userInfo.email = controller.text.trim();
        userInfo.mobile = controllerMobile.text;
        if (controllerPass.text.trim().isNotEmpty) {
          userInfo.password = controllerPass.text.trim();
        }
        onContinue?.call();
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!headless)
            Text(
              context.l10n.personalInfoIntro,
              style: context.textTheme.headline5,
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controllerLastName,
                validator: (value) => isRequired(value, context),
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.familyName],
                onChanged: (value) => userInfo.lastName = value,
                decoration: InputDecoration(label: Text(context.l10n.nameField)),
              ),
              TextFormField(
                controller: controllerFirstName,
                validator: (value) => isRequired(value, context),
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.name, AutofillHints.givenName],
                onChanged: (value) => userInfo.firstName = value,
                decoration: InputDecoration(label: Text(context.l10n.firstNameField)),
              ),
              TextFormField(
                controller: controllerMobile,
                keyboardType: TextInputType.phone,
                validator: (value) => isPhoneValid(value, context),
                autofillHints: const [AutofillHints.telephoneNumber],
                onChanged: (value) => userInfo.mobile = value,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[+0-9]'))],
                maxLength: 12,
                decoration: InputDecoration(label: Text(context.l10n.phoneField), counter: const SizedBox()),
              ),
              TextFormField(
                controller: controller,
                validator: (value) => isEmailValid(value, context),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                onChanged: (value) => userInfo.email = value,
                decoration: InputDecoration(label: Text(context.l10n.emailField)),
              ),
              if (!headless || kIsWeb)
                TextFormField(
                  controller: controllerPass,
                  obscureText: true,
                  validator: (value) => isPasswordValid(value, !headless, context),
                  autofillHints: const [AutofillHints.newPassword],
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) => userInfo.password = value,
                  onFieldSubmitted: (_) {
                    submitForm();
                  },
                  decoration: InputDecoration(label: Text(context.l10n.passwordField)),
                ),
              if (!headless || kIsWeb)
                TextFormField(
                  controller: controllerConfirm,
                  obscureText: true,
                  validator: (value) {
                    if (controllerConfirm.text != controllerPass.text) {
                      return context.l10n.passwordMismatch;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  autofillHints: const [AutofillHints.password],
                  onFieldSubmitted: (_) => submitForm(),
                  decoration: InputDecoration(label: Text(context.l10n.confirmPasswordField)),
                ),
              if ((!headless || !(userStore.user?.isTermsAccepted ?? false)) && showTerms)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
                  child: CheckboxListTile(
                    value: userInfo.isTermsAccepted,
                    onChanged: (value) {
                      userInfo.isTermsAccepted = value!;
                      termsState.value = userInfo.isTermsAccepted;
                    },
                    title: Text(
                      context.l10n.acceptTerms,
                      style: TextStyle(fontSize: 12, color: termsState.value ? Colors.black : Colors.red),
                    ),
                  ),
                ),
            ],
          ),
          Row(
            children: [
              if (!headless)
                Padding(
                  padding: const EdgeInsets.all(kNormalPadding),
                  child: TextButton(
                    onPressed: () async {
                      Navigator.of(context).maybePop();
                    },
                    child: Text(MaterialLocalizations.of(context).backButtonTooltip),
                  ),
                ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(kNormalPadding),
                child: ElevatedButton(
                  onPressed: submitForm,
                  child: Text(saveButtonLabel ?? (userInfo.type == UserTypeEnum.patient ? context.l10n.sendButton : context.l10n.continueButton)),
                ),
              ),
            ],
          ),
          if ((!headless || !(userStore.user?.isTermsAccepted ?? false)) && showTerms)
            TextButton(
              onPressed: () {
                launch('${Config().baseUrl}/terms');
              },
              child: Text(
                context.l10n.goToTerms,
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
