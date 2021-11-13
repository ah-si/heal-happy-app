
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/donate.dart';
import 'package:heal_happy/common/presentation/job_search_field.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/presentation/menu_item.dart';
import 'package:heal_happy/common/presentation/pagination.dart';
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
  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStore = ref.watch(userStoreProvider);
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
                const _MenuBar(),
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
                Expanded(
                  child: ColoredBox(
                    color: Colors.white.withOpacity(0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
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
                                        return Center(
                                          child: Text(
                                            context.l10n.noSearchResults,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      }

                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: ListView.separated(
                                              itemBuilder: (context, index) {
                                                return _HealerListItem(healer: store.searchResults!.healers[index]);
                                              },
                                              separatorBuilder: (context, index) => const Divider(height: 1),
                                              primary: false,
                                              shrinkWrap: true,
                                              itemCount: store.searchResults?.healers.length ?? 0,
                                            ),
                                          ),
                                          Pagination(
                                            total: store.searchResults!.totalPages,
                                            current: store.searchResults!.currentPage,
                                            onPageSelected: (int selectedPage) {
                                              store.loadHealersPage(selectedPage);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                          ),
                        ),
                        ColoredBox(
                          color: context.primaryColor,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if (kIsWeb) {
                                  launch('https://www.ah-si.org/dons-soignez-heureux');
                                } else {
                                  showAlert(
                                    context,
                                    context.l10n.donate,
                                    (_) => const Donate(),
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: kNormalPadding, vertical: kSmallPadding),
                                child: Text(
                                  context.l10n.donateDescription,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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

class _MenuBar extends HookConsumerWidget {
  const _MenuBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(patientStoreProvider);
    return Row(
      children: [
        MenuItem(
          label: context.l10n.home,
          onTap: () {
            store.selectedTab = HomeTabs.home;
          },
          selected: store.selectedTab == HomeTabs.home,
        ),
        const SizedBox(width: 2),
        if (store.searchResults != null)
          MenuItem(
            label: context.l10n.search,
            onTap: () {
              store.selectedTab = HomeTabs.search;
            },
            selected: store.selectedTab == HomeTabs.search,
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
    );
  }
}

class _HealerListItem extends HookConsumerWidget {
  final Healer healer;

  const _HealerListItem({Key? key, required this.healer}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.read(userStoreProvider);
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
              Text(store.specialities[healer.job] ?? '', style: context.textTheme.subtitle2),
              const SizedBox(height: kNormalPadding),
              Text(healer.address),
              const SizedBox(height: kNormalPadding),
              if (false)
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('En savoir plus'),
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
              child: HookBuilder(builder: (context) {
                final controller = useScrollController();
                return Scrollbar(
                  controller: controller,
                  child: SingleChildScrollView(
                    controller: controller,
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
                                                    (_) => Text(context.l10n.takeRdv),
                                                    (context) => Column(
                                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                                          children: [
                                                            Text(context.l10n.takeRdvConfirm(healer.name, slot.label)),
                                                            TextField(
                                                              controller: controller,
                                                              maxLines: 3,
                                                              decoration: InputDecoration(
                                                                label: Text(context.l10n.messageForHealer),
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
                                                          final success = await showLoadingDialog(context, (_) => Text(context.l10n.creatingRdv), () async {
                                                            await store.createEvent(userStore.user!.id!, slot.dateTime, controller.text);
                                                          });
                                                          if (success) {
                                                            Navigator.of(context).pop();
                                                            showAlert(context, context.l10n.rdvCreated, (_) => Text(context.l10n.rdvCreatedDescription));
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
                );
              }),
            ),
          ],
        ),
      );
    }

    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey, offset: Offset(2, 2), spreadRadius: .5, blurRadius: 8),
      ]),
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
      return Text(
        context.l10n.noConsultation,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.l10n.plannedConsultation, style: context.textTheme.subtitle1),
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
                    Text(context.l10n.yourHealer),
                    Row(
                      children: [
                        const Icon(Icons.healing, size: 50),
                        const SizedBox(width: kNormalPadding),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(event.healer.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(event.healer.address, style: const TextStyle(fontWeight: FontWeight.bold)),
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
                    final success = await showConfirm(context, context.l10n.cancelConsultation, context.l10n.cancelConsultationConfirm(event.healer.name));
                    if (success) {
                      final cancelled = await showLoadingDialog(context, (_) => Text(context.l10n.canceling), () async {
                        await ref.read(patientStoreProvider).cancelEvent(event.id);
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

class _SearchBar extends HookConsumerWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobChoice = useState<MapEntry<String, String>?>(null);
    final controllerJob = useTextEditingController();
    final controllerLocalization = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    submitForm() {
      if (formKey.currentState!.validate()) {
        ref.read(patientStoreProvider).searchHealers(jobChoice.value!.key, controllerLocalization.text, 0);
      }
    }

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
                        hintText: context.l10n.specialityField,
                        border: InputBorder.none,
                      ),
                      nbVisibleResults: 10,
                      controller: controllerJob,
                      validator: (value) {
                        final result = isRequired(value, context);
                        if (result == null && jobChoice.value == null) {
                          return isRequired(null, context); //force required message
                        }
                        return result;
                      },
                      onItemSelected: (MapEntry<String, String> selected) {
                        jobChoice.value = selected;
                      },
                      loadData: () {
                        return ref.read(patientStoreProvider).getSpecialities();
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
                        hintText: context.l10n.localizationField,
                        border: InputBorder.none,
                      ),
                      controller: controllerLocalization,
                      onFieldSubmitted: (_) => submitForm(),
                    ),
                  ),
                ),
                ColoredBox(
                  color: context.primaryColor,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: submitForm,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(kNormalPadding),
                          child: Text(
                            context.l10n.searchButton,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
