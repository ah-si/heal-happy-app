import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/job_search_field.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy/patient/stores/healer_availabilities_store.dart';
import 'package:heal_happy/patient/stores/patient_store.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientHomeScreen extends HookConsumerWidget {
  static const name = 'patient_home';

  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(patientStoreProvider);
    return BgContainer(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.all(kNormalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _SearchBar(),
                const SizedBox(height: kNormalPadding),
                Row(
                  children: [
                    InkWell(
                      splashColor: context.primaryColor,
                      child: ColoredBox(
                        color: Colors.white.withOpacity(store.selectedTab == HomeTabs.home ?0.8:0.6),
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
                    if (store.searchResults != null)
                      InkWell(
                        splashColor: context.primaryColor,
                        child: ColoredBox(
                          color: Colors.white.withOpacity(store.selectedTab == HomeTabs.search ? 0.8:0.6),
                          child: Padding(
                            padding: const EdgeInsets.all(kSmallPadding),
                            child: Text(
                              'Recherche',
                              style: TextStyle(
                                color: store.selectedTab == HomeTabs.search ? context.primaryColor : Colors.black,
                                fontWeight: store.selectedTab == HomeTabs.search ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          store.selectedTab = HomeTabs.search;
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
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: store.selectedTab == HomeTabs.home
                          ? const _PlannedConsultations()
                          : HookConsumer(
                              builder: (context, ref, child) {
                                final store = ref.watch(patientStoreProvider);

                                if (store.searchResults == null || store.isLoading) {
                                  return const Loading();
                                }

                                if (store.searchResults?.error != null) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(kNormalPadding),
                                      child: Text(
                                        store.searchResults!.error!.cause.twoLiner(context),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: context.theme.errorColor),
                                      ),
                                    ),
                                  );
                                }

                                if (store.searchResults!.healers.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      'Il n\'y a aucun résultat pour votre recherche',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }

                                return ListView.separated(
                                  itemBuilder: (context, index) {
                                    return _HealerListItem(healer: store.searchResults!.healers[index]);
                                  },
                                  separatorBuilder: (context, index) => const Divider(height: 1),
                                  itemCount: store.searchResults?.healers.length ?? 0,
                                );
                              },
                            ),
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

class _HealerListItem extends StatelessWidget {
  final Healer healer;

  const _HealerListItem({Key? key, required this.healer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.healing, size: 50),
          const SizedBox(width: kNormalPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(healer.name, style: context.textTheme.headline6),
              Text(specialities[healer.job] ?? '', style: context.textTheme.subtitle2),
              const SizedBox(height: kNormalPadding),
              Text(healer.address),
              const SizedBox(height: kNormalPadding),
              if (false)
                ElevatedButton(
                  onPressed: () {},
                  child: Text('En savoir plus'),
                ),
            ],
          ),
          const SizedBox(width: kNormalPadding),
          Expanded(
            child: _HealerAvailability(healer: healer),
          ),
        ],
      ),
    );
  }
}

class _HealerAvailability extends HookConsumerWidget {
  final Healer healer;

  const _HealerAvailability({Key? key, required this.healer}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(availabilitiesStoreProvider(healer.id!));
    late Widget child;
    if (store.isLoading) {
      child = const Loading();
    } else if (store.availabilities?.error != null) {
      child = Center(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Text(
            store.availabilities!.error!.cause.twoLiner(context),
            style: TextStyle(color: context.theme.errorColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      child = ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 220),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: store.availabilities!.slots
                    .map(
                      (e) => Expanded(
                        child: Text(e.date, textAlign: TextAlign.center),
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: store.availabilities!.slots
                        .map(
                          (e) => Expanded(
                            child: Column(
                              children: [
                                ...e.slots
                                    .map((slot) => Padding(
                                          padding: const EdgeInsets.all(kSmallPadding),
                                          child: ActionChip(
                                            label: Text(slot.label),
                                            labelStyle: const TextStyle(color: Colors.white),
                                            backgroundColor: context.primaryColor,
                                            onPressed: () {
                                              final controller = TextEditingController();
                                              showAppDialog(
                                                  context,
                                                  (_) => Text('Prendre rendez vous'),
                                                  (context) => Column(
                                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        children: [
                                                          Text('Voulez prendre rendez vous avec ${healer.name} à ${slot.label}?'),
                                                          TextField(
                                                            controller: controller,
                                                            maxLines: 3,
                                                            decoration: InputDecoration(
                                                              label: Text('Message pour le soignant:'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                  actions: [
                                                    DialogAction(
                                                      text: MaterialLocalizations.of(context).cancelButtonLabel,
                                                      callback: (BuildContext context) {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    DialogAction(
                                                      text: MaterialLocalizations.of(context).okButtonLabel,
                                                      callback: (BuildContext context) async {
                                                        final userStore = ref.read(userStoreProvider);
                                                        final success = await showLoadingDialog(context, (_) => Text('Création du rendez-vous'), () async {
                                                          await store.createEvent(userStore.user!.id!, slot.dateTime, controller.text);
                                                        });
                                                        if (success) {
                                                          Navigator.of(context).pop();
                                                          showAlert(
                                                              context, 'Rendez-vous validé!', (_) => Text('Vous allez recevoir un email de confirmation.'));
                                                        }
                                                      },
                                                    ),
                                                  ]);
                                            },
                                          ),
                                        ))
                                    .toList(growable: false),
                              ],
                            ),
                          ),
                        )
                        .toList(growable: false),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(2, 2), spreadRadius: .5, blurRadius: 8)]),
      child: child,
    );
  }
}

class _PlannedConsultations extends HookConsumerWidget {
  const _PlannedConsultations({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(patientStoreProvider);
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
      return const Text(
        'Vous n\'avez aucune consultation planifié pour le moment.',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Vos consultations planifiées:', style: context.textTheme.subtitle1),
          Wrap(
            children: store.eventsResults!.events.map((e) => _PatientEventDetails(event: e)).toList(growable: false),
          ),
        ],
      ),
    );
  }
}

class _PatientEventDetails extends HookConsumerWidget {
  final UserEvent event;
  static final DateFormat _dateFormat = DateFormat('EEE dd MMM à HH:mm');

  const _PatientEventDetails({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 200),
      child: Card(
        margin: const EdgeInsets.all(kSmallPadding),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(kNormalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(_dateFormat.format(event.start), style: context.textTheme.headline6),
                    const SizedBox(height: kSmallPadding),
                    const Text('Votre soignant:'),
                    Row(
                      children: [
                        const Icon(Icons.healing, size: 50),
                        const SizedBox(width: kNormalPadding),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(event.healer.name, style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(event.healer.address, style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () async {
                    final success =
                        await showConfirm(context, 'Annuler la consultation?', 'Êtes vous sur de vouloir annuler la consulation avec ${event.healer.name}?');
                    if (success) {
                      final cancelled = await showLoadingDialog(context, (_) => Text('Annulation en cours'), () async {
                        await ref.read(patientStoreProvider).cancelEvent(event.id);
                      });
                      if (cancelled) {
                        showAlert(context, 'Annulation', (_) => Text('Votre consultation avec ${event.healer.name} a été annulée.'));
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

class _SearchBar extends HookConsumerWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobChoice = useState<MapEntry<String, String>?>(null);
    final controllerJob = useTextEditingController();
    final controllerLocalization = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return ColoredBox(
      color: Colors.white.withOpacity(.85),
      child: Padding(
        padding: const EdgeInsets.only(left: kSmallPadding),
        child: Form(
          key: formKey,
          child: SizedBox(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(Icons.search),
                const SizedBox(width: kNormalPadding),
                Expanded(
                  child: Center(
                    child: JobSearchFormField(
                      decoration: InputDecoration(
                        hintText: 'Recherche de spécialité*:',
                        border: InputBorder.none,
                      ),
                      nbVisibleResults: 10,
                      controller: controllerJob,
                      validator: (value) {
                        final result = isRequired(value);
                        if (result == null && jobChoice.value == null) {
                          return isRequired(null); //force required message
                        }
                        return result;
                      },
                      onItemSelected: (MapEntry<String, String> selected) {
                        jobChoice.value = selected;
                      },
                    ),
                  ),
                  flex: 5,
                ),
                const Icon(Icons.location_on_outlined),
                const SizedBox(width: kNormalPadding),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Localisation*:',
                        border: InputBorder.none,
                      ),
                      controller: controllerLocalization,
                      validator: isRequired,
                    ),
                  ),
                ),
                ColoredBox(
                  color: context.primaryColor,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          ref.read(patientStoreProvider).searchHealers(jobChoice.value!.key, controllerLocalization.text);
                        }
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(kNormalPadding),
                          child: Text(
                            'Rechercher',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
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
