import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/auth/login_screen.dart';
import 'package:heal_happy/auth/models/user_info.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/profile/step_calendar_info.dart';
import 'package:heal_happy/profile/step_personal_info.dart';
import 'package:heal_happy/profile/step_pro_info.dart';
import 'package:heal_happy/profile/step_social_info.dart';
import 'package:heal_happy/user/home_screen.dart';
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
                  IntroDialog(
                    constraints: const BoxConstraints(maxWidth: 400, maxHeight: 550),
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
                            context.goNamed(HomeScreen.name);
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StepTypeAvatar extends HookWidget {
  final VoidCallback onContinue;
  final String hoverIcon;
  final String icon;
  final Color color;
  final String label;

  const _StepTypeAvatar({
    Key? key,
    required this.onContinue,
    required this.label,
    required this.color,
    required this.hoverIcon,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hover = useState(false);
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: Material(
            type: MaterialType.circle,
            clipBehavior: Clip.antiAlias,
            color: Colors.transparent,
            child: InkResponse(
              splashFactory: NoSplash.splashFactory,
              radius: 0,
              onTap: onContinue,
              onHover: (newHover) {
                hover.value = newHover;
              },
              onTapDown: (_) {
                hover.value = true;
              },
              onTapCancel: () {
                hover.value = false;
              },
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: hover.value ? Image.asset(hoverIcon) : Image.asset(icon),
                ),
              ),
            ),
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _StepTypeAvatar(
                onContinue: () {
                  userInfo.type = UserTypeEnum.patient;
                  onContinue();
                },
                label: context.l10n.patient,
                icon: 'assets/images/patient.png',
                hoverIcon: 'assets/images/patient_on.png',
                color: userInfo.type == UserTypeEnum.patient ? context.primaryColor : Colors.grey.withOpacity(0.5),
              ),
            ),
            Expanded(
              child: _StepTypeAvatar(
                onContinue: () {
                  userInfo.type = UserTypeEnum.healer;
                  onContinue();
                },
                label: context.l10n.healer,
                color: userInfo.type == UserTypeEnum.healer ? context.primaryColor : Colors.grey.withOpacity(0.5),
                icon: 'assets/images/healer.png',
                hoverIcon: 'assets/images/healer_on.png',
              ),
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
      ],
    );
  }
}
