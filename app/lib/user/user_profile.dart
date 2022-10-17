import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/auth/models/user_info.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/profile/step_calendar_info.dart';
import 'package:heal_happy/profile/step_personal_info.dart';
import 'package:heal_happy/profile/step_pro_info.dart';
import 'package:heal_happy/profile/step_social_info.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfile extends HookConsumerWidget {
  final String? id;
  final bool showTerms;

  const UserProfile({this.showTerms = true, this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(userInfoProvider);
    final userStore = ref.watch(userStoreProvider);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (userStore.user != null && id == null) {
          store.fromUser(userStore.user!);
        }
      });
      return null;
    }, [userStore.user]);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (id != null) {
          userStore.getUser(id!).then(store.fromUser);
        }
      });
      return null;
    }, [id]);

    if (id != null && userStore.currentEditedUser == null || store.email == null) {
      return const Loading();
    }

    save() async {
      final info = ref.read(userInfoProvider);
      try {
        if (id == null) {
          await userStore.save(info.toUser(existingUser: userStore.user));
        } else {
          await userStore.saveUser(id!, info.toUser(existingUser: userStore.currentEditedUser));
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(context.l10n.infoSaved),
        ));
      } catch(ex, stack) {
        showErrorDialog(context, ex, stack);
      }
    }

    final isHealer = store.type == UserTypeEnum.healer;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(kNormalPadding),
        child: Column(
          children: [
            if (isHealer && userStore.user?.dateSubscription != null) Padding(
              padding: const EdgeInsets.only(bottom: kNormalPadding),
              child: Text(context.l10n.subscriptionValid(kDateFormat.format(userStore.user!.dateSubscription!))),
            ),
            if (isHealer)
              ExpansionTile(
                title: Text(context.l10n.calendar),
                initiallyExpanded: true,
                children: [
                  StepCalendarInfo(onSave: save, userId: id),
                ],
              ),
            ExpansionTile(
              title: Text(context.l10n.personalInfo),
              initiallyExpanded: !isHealer,
              children: [
                StepPersonalInfo(
                  headless: true,
                  showTerms: showTerms,
                  onContinue: save,
                  saveButtonLabel: context.l10n.saveButton,
                ),
              ],
            ),
            if (isHealer)
              ExpansionTile(
                title: Text(context.l10n.proInfo),
                children: [
                  StepInfoPro(
                    headless: true,
                    onContinue: save,
                    saveButtonLabel: context.l10n.saveButton,
                  ),
                ],
              ),
            if (isHealer)
              ExpansionTile(
                title: Text(context.l10n.address),
                children: [
                  StepAddress(
                    headless: true,
                    onContinue: save,
                    saveButtonLabel: context.l10n.saveButton,
                  ),
                ],
              ),
            if (isHealer)
              ExpansionTile(
                title: Text(context.l10n.socialInfo),
                children: [
                  StepSocial(
                    headless: true,
                    onContinue: save,
                    saveButtonLabel: context.l10n.saveButton,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
