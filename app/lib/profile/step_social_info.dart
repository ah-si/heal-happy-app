import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/auth/models/user_info.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StepSocial extends HookConsumerWidget {
  final VoidCallback? onContinue;
  final String? saveButtonLabel;
  final bool headless;

  const StepSocial({this.saveButtonLabel, this.headless = false, this.onContinue, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);
    final controllerWebsite = useTextEditingController(text: userInfo.website);
    final controllerSocial1 = useTextEditingController(text: userInfo.social1);
    final controllerSocial2 = useTextEditingController(text: userInfo.social2);
    final controllerSocial3 = useTextEditingController(text: userInfo.social3);
    submitForm() {
      userInfo.website = controllerWebsite.text;
      userInfo.social1 = controllerSocial1.text;
      userInfo.social2 = controllerSocial2.text;
      userInfo.social3 = controllerSocial3.text;
      onContinue?.call();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!headless)
          Text(
            context.l10n.socialIntro,
            style: context.textTheme.headline5,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controllerWebsite,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(label: Text(context.l10n.websiteField)),
            ),
            TextFormField(
              controller: controllerSocial1,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(label: Text(context.l10n.social1Field)),
            ),
            TextFormField(
              controller: controllerSocial2,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(label: Text(context.l10n.social2Field)),
            ),
            TextFormField(
              controller: controllerSocial3,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(label: Text(context.l10n.social3Field)),
              onFieldSubmitted: (_) {
                submitForm();
              },
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
                child: Text(saveButtonLabel ?? context.l10n.sendButton),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
