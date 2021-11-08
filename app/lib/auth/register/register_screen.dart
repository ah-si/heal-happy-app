import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/admin/home_screen.dart';
import 'package:heal_happy/auth/login_screen.dart';
import 'package:heal_happy/auth/models/user_info.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/healer/home_screen.dart';
import 'package:heal_happy/patient/home_screen.dart';
import 'package:heal_happy/profile/step_calendar_info.dart';
import 'package:heal_happy/profile/step_personal_info.dart';
import 'package:heal_happy/profile/step_pro_info.dart';
import 'package:heal_happy/profile/step_social_info.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final infoPersoStepValidationProvider = Provider((ref) {
  final info = ref.watch(userInfoProvider);
  return !info.firstName.isNullOrEmpty && !info.lastName.isNullOrEmpty && !info.email.isNullOrEmpty && !info.password.isNullOrEmpty;
});

class RegisterScreen extends HookConsumerWidget {
  static const name = 'register';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);
    final controller = usePageController();
    return WillPopScope(
      onWillPop: () async {
        if ((controller.page ?? 0) > .0) {
          controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          return false;
        }
        return true;
      },
      child: BgContainer(
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
                      height: 160,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 160),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 550),
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
                            borderRadius: const BorderRadius.all(Radius.circular(kSmallPadding))),
                        child: PageView.builder(
                          controller: controller,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            next() => controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                            register() async {
                              final store = ref.read(userStoreProvider);
                              final userInfo = ref.read(userInfoProvider);
                              final success = await showLoadingDialog(context, (_) => const Text('Inscription en cours...'), () async {
                                await store.register(userInfo.toUser());
                              });
                              if (success) {
                                switch (store.requiredUser.type) {
                                  case UserTypeEnum.admin:
                                    context.goNamed(AdminHomeScreen.name);
                                    break;
                                  case UserTypeEnum.healer:
                                    context.goNamed(HealerHomeScreen.name);
                                    break;
                                  case UserTypeEnum.patient:
                                    context.goNamed(PatientHomeScreen.name);
                                    break;
                                }
                              }
                            }

                            switch (index) {
                              case 1:
                                return StepPersonalInfo(onContinue: () {
                                  if (userInfo.type == UserTypeEnum.patient) {
                                    register();
                                  } else {
                                    next();
                                  }
                                });
                              case 2:
                                return StepInfoPro(onContinue: next);
                              case 3:
                                return SingleChildScrollView(child: StepCalendarInfo(onContinue: next));
                              case 4:
                                return StepAddress(onContinue: next);
                              case 5:
                                return StepSocial(onContinue: register);
                            }
                            return _StepType(
                              onContinue: next,
                            );
                          },
                          itemCount: userInfo.type == UserTypeEnum.patient ? 2 : 6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StepTypeAvatar extends HookConsumerWidget {
  final VoidCallback onContinue;
  final IconData icon;
  final Color color;
  final String label;

  const _StepTypeAvatar({
    Key? key,
    required this.onContinue,
    required this.label,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: color,
          child: Stack(
            children: [
              Center(
                child: Icon(
                  icon,
                  size: 40,
                  semanticLabel: label,
                ),
              ),
              Material(
                type: MaterialType.circle,
                clipBehavior: Clip.antiAlias,
                color: Colors.transparent,
                child: InkWell(
                  onTap: onContinue,
                ),
              ),
            ],
          ),
        ),
        Text(label),
      ],
    );
  }
}

class _StepType extends HookConsumerWidget {
  final VoidCallback onContinue;

  const _StepType({Key? key, required this.onContinue}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(kNormalPadding),
            child: Text(
              context.l10n.youAre,
              style: context.textTheme.headline5,
            ),
          ),
        ),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _StepTypeAvatar(
              onContinue: () {
                userInfo.type = UserTypeEnum.patient;
                onContinue();
              },
              label: context.l10n.patient,
              icon: Icons.person,
              color: userInfo.type == UserTypeEnum.patient ? context.primaryColor : Colors.grey.withOpacity(0.5),
            ),
            _StepTypeAvatar(
              onContinue: () {
                userInfo.type = UserTypeEnum.healer;
                onContinue();
              },
              label: context.l10n.healer,
              color: userInfo.type == UserTypeEnum.healer ? context.primaryColor : Colors.grey.withOpacity(0.5),
              icon: Icons.healing,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(kBigPadding),
          child: TextButton(
            onPressed: () {
              context.goNamed(LoginScreen.name);
            },
            child: Text(context.l10n.alreadyHaveAccount),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
