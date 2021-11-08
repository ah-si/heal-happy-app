import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/auth/models/user_info.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/presentation/menu_item.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/healer/stores/healer_store.dart';
import 'package:heal_happy/profile/step_calendar_info.dart';
import 'package:heal_happy/profile/step_personal_info.dart';
import 'package:heal_happy/profile/step_pro_info.dart';
import 'package:heal_happy/profile/step_social_info.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HealerHomeScreen extends HookConsumerWidget {
  static const name = 'healer_home';

  const HealerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStore = ref.watch(userStoreProvider);
    final store = ref.watch(healerStoreProvider);

    return BgContainer(
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
                    const Spacer(),
                    MenuItem(
                      label: context.l10n.disconnect,
                      onTap: () async {
                        final success = await showConfirm(context, context.l10n.disconnect, context.l10n.disconnectConfirm);
                        if (success) {
                          final store = ref.read(userStoreProvider);
                          store.logout();
                        }
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
                      child: Text(
                        context.l10n.accountNotVerified,
                        style: const TextStyle(color: Colors.white),
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
                      ),
                    ),
                  ),
                Expanded(
                  child: ColoredBox(
                    color: Colors.white.withOpacity(0.8),
                    child: store.selectedTab == HomeTabs.home ? const _HealerEvents() : _HealerProfile(),
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

class _HealerEvents extends HookConsumerWidget {
  const _HealerEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(healerStoreProvider);

    useEffect(() {
      store.loadEvents();
    }, const []);

    if (store.eventsResults == null || store.isLoading) {
      return const Loading();
    }

    if (store.eventsResults?.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Text(
            store.eventsResults!.error!.cause.twoLiner(context),
            style: TextStyle(color: context.theme.errorColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (store.eventsResults!.events.isEmpty) {
      return Center(
        child: Text(
          context.l10n.noEvents,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.l10n.plannedConsultations, style: context.textTheme.subtitle1),
          Wrap(
            children: store.eventsResults!.events.map((e) => _HealerEventDetails(event: e)).toList(growable: false),
          ),
        ],
      ),
    );
  }
}

class _HealerEventDetails extends HookConsumerWidget {
  final UserEvent event;
  static final DateFormat _dateFormat = DateFormat('EEE dd MMM à HH:mm');

  const _HealerEventDetails({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320, maxHeight: 280),
      child: Card(
        margin: const EdgeInsets.all(kSmallPadding),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(kNormalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(_dateFormat.format(event.start), style: context.textTheme.headline6),
                      const SizedBox(height: kSmallPadding),
                      Text(context.l10n.yourPatient, style: context.textTheme.subtitle2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(event.patient.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
                            child: InkWell(
                              onTap: () {
                                launch('mailto:${event.patient.email}');
                              },
                              onLongPress: () {
                                Clipboard.setData(ClipboardData(text: event.patient.email));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Email'))));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.email_outlined),
                                  const SizedBox(width: kSmallPadding),
                                  Expanded(child: Text(event.patient.email)),
                                ],
                              ),
                            ),
                          ),
                          if (!event.patient.mobile.isNullOrEmpty)
                            InkWell(
                              onTap: () {
                                launch('tel:${event.patient.mobile}');
                              },
                              onLongPress: () {
                                Clipboard.setData(ClipboardData(text: event.patient.mobile));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Téléphone'))));
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.call_outlined),
                                  const SizedBox(width: kSmallPadding),
                                  Text(event.patient.mobile!),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: kSmallPadding),
                      if (!event.description.isNullOrEmpty) Text(context.l10n.patientMessage, style: context.textTheme.subtitle2),
                      if (!event.description.isNullOrEmpty)
                        Text(
                          event.description! * 30,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () async {
                    final success = await showConfirm(context, context.l10n.cancelConsultation, context.l10n.cancelConsultationConfirm(event.patient.name));
                    if (success) {
                      final cancelled = await showLoadingDialog(context, (_) => Text(context.l10n.canceling), () async {
                        await ref.read(healerStoreProvider).cancelEvent(event.id);
                      });
                      if (cancelled) {
                        showAlert(context, context.l10n.cancelTitle, (_) => Text(context.l10n.consultationCanceled(event.healer.name)));
                      }
                    }
                  },
                  child: Text(context.l10n.cancelButton),
                ),
                TextButton(
                  onPressed: () {
                    launch(event.link);
                  },
                  child: Text(context.l10n.joinVisioButton),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _HealerProfile extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(userInfoProvider);
    final userStore = ref.watch(userStoreProvider);
    useEffect(() {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        store.fromUser(userStore.user!);
      });
    }, const []);
    save() {
      final info = ref.read(userInfoProvider);
      userStore.save(info.toUser(existingUser: userStore.user));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(context.l10n.infoSaved),
      ));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(kNormalPadding),
        child: Column(
          children: [
            ExpansionTile(
              title: Text(context.l10n.calendar),
              children: [
                StepCalendarInfoForm(
                  enableBackButton: false,
                  saveButtonLabel: context.l10n.saveButton,
                  onContinue: save,
                ),
              ],
            ),
            ExpansionTile(
              title: Text(context.l10n.personalInfo),
              children: [
                StepPersonalInfo(
                  headless: true,
                  onContinue: save,
                  saveButtonLabel: context.l10n.saveButton,
                ),
              ],
            ),
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
