import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/auth/models/user_info.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StepPersonalInfo extends HookConsumerWidget {
  final VoidCallback? onContinue;
  final String? saveButtonLabel;
  final bool headless;

  const StepPersonalInfo({this.headless = false, this.saveButtonLabel, this.onContinue, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.read(userInfoProvider);
    final controllerMobile = useTextEditingController(text: userInfo.mobile);
    final controllerLastName = useTextEditingController(text: userInfo.lastName);
    final controllerFirstName = useTextEditingController(text: userInfo.firstName);
    final controller = useTextEditingController(text: userInfo.email);
    final controllerPass = useTextEditingController(text: userInfo.password);
    final formKey = useMemoized(() => GlobalKey<FormState>());
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              if (!headless)
                TextFormField(
                  controller: controllerPass,
                  obscureText: true,
                  validator: (value) => isPasswordValid(value, context),
                  autofillHints: const [AutofillHints.newPassword],
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) => userInfo.password = value,
                  decoration: InputDecoration(label: Text(context.l10n.passwordField)),
                ),
            ],
          ),
          if (!headless) const Spacer(),
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
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      userInfo.firstName = controllerFirstName.text;
                      userInfo.lastName = controllerLastName.text;
                      userInfo.email = controller.text;
                      userInfo.mobile = controllerMobile.text;
                      userInfo.password = controllerPass.text;
                      onContinue?.call();
                    }
                  },
                  child: Text(saveButtonLabel ?? (userInfo.type == UserTypeEnum.patient ? context.l10n.sendButton : context.l10n.continueButton)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
