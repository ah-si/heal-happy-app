import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/common/config.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/calendar_legend.dart';
import 'package:heal_happy/common/presentation/datetime_button.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/presentation/menu_item.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy/healer/stores/healer_store.dart';
import 'package:heal_happy/patient/healer_profile_screen.dart';
import 'package:heal_happy/patient/home_screen.dart';
import 'package:heal_happy/user/user_profile.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:url_launcher/url_launcher.dart';

part 'healer_calendar.dart';

void _disconnect(BuildContext context, WidgetRef ref) async {
  final success = await showConfirm(context, context.l10n.disconnect, context.l10n.disconnectConfirm);
  if (success) {
    final store = ref.read(userStoreProvider);
    store.logout();
  }
}

class MobileHealerHome extends HookConsumerWidget {
  const MobileHealerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(healerStoreProvider);
    final controller = useTabController(initialLength: 3, initialIndex: store.selectedTab.index);
    useEffect(() {
      controller.addListener(() {
        if (controller.index != controller.previousIndex) {
          store.selectedTab = HomeTabs.values[controller.index];
        }
      });
      return null;
    }, [controller]);

    return BgContainer(
      appBar: AppBar(
        title: Text(context.l10n.appTitle),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(PatientHomeScreen.name);
            },
            tooltip: context.l10n.patientMode,
            icon: const Icon(Icons.local_hospital_outlined),
          ),
          IconButton(
            onPressed: () {
              _disconnect(context, ref);
            },
            tooltip: context.l10n.disconnect,
            icon: const Icon(Icons.logout),
          ),
        ],
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(
              text: context.l10n.home,
            ),
            Tab(
              text: context.l10n.profile,
            ),
            Tab(
              text: context.l10n.help,
            ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kNormalPadding),
        child: ColoredBox(
          color: Colors.white.withOpacity(0.8),
          child: TabBarView(
            children: const [
              _HealerHomePage(),
              UserProfile(),
              SingleChildScrollView(child: _Help()),
            ],
            controller: controller,
          ),
        ),
      ),
    );
  }
}

class HealerHomeScreen extends StatelessWidget {
  static const name = 'healer';

  const HealerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.isMobile ? const MobileHealerHome() : const DesktopHealerHome();
  }
}

class DesktopHealerHome extends HookConsumerWidget {
  const DesktopHealerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStore = ref.watch(userStoreProvider);
    final store = ref.watch(healerStoreProvider);

    late Widget child;

    switch (store.selectedTab) {
      case HomeTabs.home:
        child = const _HealerHomePage();
        break;
      case HomeTabs.profile:
        child = const UserProfile();
        break;
      case HomeTabs.help:
        child = const SingleChildScrollView(child: _Help());
        break;
    }

    return SafeArea(
      child: BgContainer(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.all(kNormalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              MenuItem(
                                label: context.l10n.home,
                                onTap: () {
                                  store.selectedTab = HomeTabs.home;
                                },
                                selected: store.selectedTab == HomeTabs.home,
                              ),
                              const SizedBox(width: 2),
                              MenuItem(
                                label: context.l10n.profile,
                                onTap: () {
                                  store.selectedTab = HomeTabs.profile;
                                },
                                selected: store.selectedTab == HomeTabs.profile,
                              ),
                              const SizedBox(width: 2),
                              MenuItem(
                                label: context.l10n.help,
                                onTap: () {
                                  store.selectedTab = HomeTabs.help;
                                },
                                selected: store.selectedTab == HomeTabs.help,
                              ),
                              const SizedBox(width: kNormalPadding),
                              MenuItem(
                                label: context.l10n.patientMode,
                                onTap: () {
                                  context.pushNamed(PatientHomeScreen.name);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      MenuItem(
                        label: context.l10n.disconnect,
                        onTap: () async {
                          _disconnect(context, ref);
                        },
                        selected: true,
                      ),
                    ],
                  ),
                  if (!(userStore.user?.isActivated ?? true))
                    ColoredBox(
                      color: context.theme.errorColor.withOpacity(0.8),
                      child: Padding(
                        padding: const EdgeInsets.all(kSmallPadding),
                        child: Column(
                          children: [
                            Text(
                              context.l10n.accountNotVerified,
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            if (!userStore.activationEmailResent)
                              TextButton(
                                onPressed: () async {
                                  final success = await showLoadingDialog(context, (_) => Text(context.l10n.sending), () => userStore.resendActivationLink());
                                  if (success) {
                                    showAlert(context, context.l10n.resendActivationLinkTitle, (_) => Text(context.l10n.resendActivationLinkSuccess));
                                  }
                                },
                                child: Text(context.l10n.resendActivationLink),
                              ),
                          ],
                        ),
                      ),
                    ),
                  if (!(userStore.user?.isVerified ?? true))
                    ColoredBox(
                      color: context.theme.errorColor.withOpacity(0.8),
                      child: Padding(
                        padding: const EdgeInsets.all(kSmallPadding),
                        child: Text(
                          context.l10n.accountPending,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  Expanded(
                    child: ColoredBox(
                      color: Colors.white.withOpacity(0.8),
                      child: child,
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

class _Help extends HookConsumerWidget {
  const _Help();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStore = ref.watch(userStoreProvider);

    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.l10n.helpCall),
          const SizedBox(height: kNormalPadding),
          Text(context.l10n.helpTuto),
          const SizedBox(height: kNormalPadding),
          TextButton(
            onPressed: () {
              launch('https://www.ah-si.org/wp-content/uploads/Tutoriel-Soignants-soignez-heureux-AH-SI.pdf');
            },
            child: Text(context.l10n.downloadTuto),
          ),
          /*const SizedBox(height: kNormalPadding),
          Text(context.l10n.helpYoutube),
          const SizedBox(height: kNormalPadding),
          TextButton(
            onPressed: () {
              launch(kUrlYoutube);
            },
            onLongPress: () {
              Clipboard.setData(const ClipboardData(text: kUrlYoutube));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Email'))));
            },
            child: const Text('Voir la chaine Youtube'),
          ),*/
          const SizedBox(height: kNormalPadding),
          if (userStore.user?.isVerified ?? false) Text(context.l10n.helpIntro),
          const SizedBox(height: kNormalPadding),
          if (userStore.user?.isVerified ?? false)
            TextButton(
              onPressed: () {
                launch(userStore.user!.telegramUrl);
              },
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: userStore.user!.telegramUrl));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Email'))));
              },
              child: Text(userStore.user!.telegramUrl),
            ),
          const SizedBox(height: kNormalPadding),
          if (userStore.user?.isDoctor ?? false) Text(context.l10n.helpOrdo),
          const SizedBox(height: kNormalPadding),
          if (userStore.user?.isDoctor ?? false)
            TextButton(
              onPressed: () {
                launch('${Config().baseUrl}/assets/assets/files/ordo.doc');
              },
              child: Text(context.l10n.helpDownloadOrdo),
            ),
          const SizedBox(height: kNormalPadding),
          Text(context.l10n.healerUrl),
          const SizedBox(height: kSmallPadding),
          if (userStore.user != null)
            SelectableText(
              Config.instance!.baseUrl + HealerProfileScreen.route.replaceAll(':id', userStore.user!.id!)+'/visio',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}

class _HealerHomePage extends HookConsumerWidget {
  const _HealerHomePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStore = ref.watch(userStoreProvider);

    final needFileUpload = !(userStore.user?.isVerified ?? false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (needFileUpload)
          Padding(
            padding: const EdgeInsets.all(kSmallPadding),
            child: Wrap(
              children: [
                Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(kNormalPadding),
                        child: SelectableText(context.l10n.sendHealerProof),
                      ),
                      ButtonBar(
                        children: [
                          TextButton(
                              onPressed: () {
                                launch('${Config().baseUrl}/assets/assets/files/healerTerms.pdf');
                              },
                              child: Text(context.l10n.downloadHealerTerms))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        const Expanded(child: _HealerEvents()),
      ],
    );
  }
}
