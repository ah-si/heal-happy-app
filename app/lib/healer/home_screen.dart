import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/auth/models/user_info.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/loading.dart';
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
                    InkWell(
                      splashColor: context.primaryColor,
                      child: ColoredBox(
                        color: Colors.white.withOpacity(store.selectedTab == HomeTabs.home ? 0.8 : 0.6),
                        child: Padding(
                          padding: const EdgeInsets.all(kSmallPadding),
                          child: Text(
                            'Accueil',
                            style: TextStyle(
                              color: store.selectedTab == HomeTabs.home ? context.primaryColor : Colors.black,
                              fontWeight: store.selectedTab == HomeTabs.home ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        store.selectedTab = HomeTabs.home;
                      },
                    ),
                    const SizedBox(width: 2),
                    InkWell(
                      splashColor: context.primaryColor,
                      child: ColoredBox(
                        color: Colors.white.withOpacity(store.selectedTab == HomeTabs.profile ? 0.8 : 0.6),
                        child: Padding(
                          padding: const EdgeInsets.all(kSmallPadding),
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              color: store.selectedTab == HomeTabs.profile ? context.primaryColor : Colors.black,
                              fontWeight: store.selectedTab == HomeTabs.profile ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        store.selectedTab = HomeTabs.profile;
                      },
                    ),
                    const Spacer(),
                    InkWell(
                      splashColor: context.primaryColor,
                      child: ColoredBox(
                        color: Colors.white.withOpacity(0.8),
                        child: const Padding(
                          padding: EdgeInsets.all(kSmallPadding),
                          child: Text('Déconnexion'),
                        ),
                      ),
                      onTap: () async {
                        final success = await showConfirm(context, 'Déconnexion', 'Voulez-vous vous déconnecter?');
                        if (success) {
                          final store = ref.read(userStoreProvider);
                          store.logout();
                        }
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: ColoredBox(
                    color: Colors.white.withOpacity(0.8),
                    child: store.selectedTab == HomeTabs.home ? _HealerEvents() : _HealerProfile(),
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
        child: const Text(
          'Vous n\'avez aucune consultation planifié pour le moment.',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Vos consultations planifiées:', style: context.textTheme.subtitle1),
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
                      Text('Votre patient:', style: context.textTheme.subtitle2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(event.patient.name, style: TextStyle(fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
                            child: InkWell(
                              onTap: () {
                                launch('mailto:${event.patient.email}');
                              },
                              onLongPress: () {
                                Clipboard.setData(ClipboardData(text: event.patient.email));
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email copié dans le presse-papiers')));
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
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Téléphone copié dans le presse-papiers')));
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
                      if (!event.description.isNullOrEmpty) Text('Message du patient:', style: context.textTheme.subtitle2),
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
                    final success =
                        await showConfirm(context, 'Annuler la consultation?', 'Êtes vous sur de vouloir annuler la consulation avec ${event.patient.name}?');
                    if (success) {
                      final cancelled = await showLoadingDialog(context, (_) => Text('Annulation en cours'), () async {
                        await ref.read(healerStoreProvider).cancelEvent(event.id);
                      });
                      if (cancelled) {
                        showAlert(context, 'Annulation',
                            (_) => Text('Votre consultation avec ${event.patient.name} a été annulée, un email lui a été envoyé pour l\'avertir.'));
                      }
                    }
                  },
                  child: Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    launch(event.link);
                  },
                  child: Text('Rejoindre la visio'),
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
        content: Text('Information enregistré avec succès'),
      ));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(kNormalPadding),
        child: Column(
          children: [
            ExpansionTile(
              title: Text('Calendrier'),
              children: [
                StepCalendarInfoForm(
                  enableBackButton: false,
                  saveButtonLabel: 'Enregistrer',
                  onContinue: save,
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Information personnelles'),
              children: [
                StepPersonalInfo(
                  headless: true,
                  onContinue: save,
                  saveButtonLabel: 'Enregistrer',
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Information professionelles'),
              children: [
                StepInfoPro(
                  headless: true,
                  onContinue: save,
                  saveButtonLabel: 'Enregistrer',
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Addresse'),
              children: [
                StepAddress(
                  headless: true,
                  onContinue: save,
                  saveButtonLabel: 'Enregistrer',
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Information social'),
              children: [
                StepSocial(
                  headless: true,
                  onContinue: save,
                  saveButtonLabel: 'Enregistrer',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
