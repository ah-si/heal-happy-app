import 'package:dart_countries/dart_countries.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/admin/home_screen.dart';
import 'package:heal_happy/common/config.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/job_search_field.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/presentation/menu_item.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy/donations/donate.dart';
import 'package:heal_happy/healer/home_screen.dart';
import 'package:heal_happy/patient/healer_availability.dart';
import 'package:heal_happy/patient/healer_profile_screen.dart';
import 'package:heal_happy/patient/stores/patient_store.dart';
import 'package:heal_happy/user/user_profile.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_widgets/infinite_widgets.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:url_launcher/url_launcher_string.dart';

void _disconnect(BuildContext context, WidgetRef ref) async {
  final success = await showConfirm(context, context.l10n.disconnect, context.l10n.disconnectConfirm);
  if (success) {
    final store = ref.read(userStoreProvider);
    store.logout();
  }
}

class MobilePatientHome extends HookConsumerWidget {
  const MobilePatientHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.read(patientStoreProvider);
    final userStore = ref.read(userStoreProvider);
    final controller = useTabController(initialLength: userStore.user?.type == UserTypeEnum.patient ? 4 : 3, initialIndex: store.selectedTab.index);

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
          if (userStore.user?.type == UserTypeEnum.admin)
            IconButton(
              onPressed: () {
                context.pushNamed(AdminHomeScreen.name);
              },
              tooltip: context.l10n.adminMode,
              icon: const Icon(Icons.admin_panel_settings_outlined),
            ),
          if (userStore.user?.type == UserTypeEnum.healer)
            IconButton(
              onPressed: () {
                context.pushNamed(HealerHomeScreen.name);
              },
              tooltip: context.l10n.healerMode,
              icon: const Icon(Icons.masks_outlined),
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
              text: context.l10n.search,
            ),
            if (userStore.user?.type == UserTypeEnum.patient)
              Tab(
                text: context.l10n.profile,
              ),
            Tab(
              text: context.l10n.eventsHistory,
            ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kNormalPadding),
        child: ColoredBox(
          color: Colors.white.withOpacity(0.8),
          child: TabBarView(
            controller: controller,
            children: [
              Column(
                children: [
                  if (!(userStore.user?.isActivated ?? true))
                    _ActivatedBanner(userStore: userStore),
                  const Expanded(
                    child: _PlannedConsultations(
                      key: Key('consultations'),
                    ),
                  ),
                  const DonateBanner(),
                ],
              ),
              const _SearchTab(),
              if (userStore.user?.type == UserTypeEnum.patient) const UserProfile(),
              const Scrollbar(child: Center(child: _PlannedConsultations(showHistory: true))),
            ],
          ),
        ),
      ),
    );
  }
}

class DesktopPatientHome extends HookConsumerWidget {
  const DesktopPatientHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStore = ref.watch(userStoreProvider);
    final store = ref.watch(patientStoreProvider);

    late Widget child;
    switch (store.selectedTab) {
      case HomeTabs.home:
        child = SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(kNormalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(context.l10n.eventsDescription),
                const Expanded(
                  child: _PlannedConsultations(
                    key: Key('consultations'),
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case HomeTabs.profile:
        child = const SizedBox(height: double.infinity, child: UserProfile());
        break;
      case HomeTabs.search:
        child = const _SearchTab();
        break;
      case HomeTabs.history:
        child = SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(kNormalPadding),
                child: Text(context.l10n.eventHistoryIntro),
              ),
              const Expanded(child: _PlannedConsultations(showHistory: true)),
            ],
          ),
        );
        break;
    }
    return BgContainer(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.all(kNormalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const _SearchBar(),
                const SizedBox(height: kNormalPadding),
                const _MenuBar(),
                if (!(userStore.user?.isActivated ?? true))
                  _ActivatedBanner(userStore: userStore),
                Expanded(
                  child: ColoredBox(
                    color: Colors.white.withOpacity(0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            child: child,
                          ),
                        ),
                        if (MediaQuery.of(context).size.width > 650)
                          Padding(
                            padding: const EdgeInsets.all(kNormalPadding),
                            child: Text(
                              context.l10n.mentionLegal,
                              style: TextStyle(color: context.primaryColor),
                            ),
                          ),
                        const DonateBanner(),
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

class _ActivatedBanner extends StatelessWidget {
  const _ActivatedBanner({
    Key? key,
    required this.userStore,
  }) : super(key: key);

  final UserStore userStore;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.theme.colorScheme.error.withOpacity(0.8),
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
    );
  }
}

class _SearchTab extends HookConsumerWidget {
  const _SearchTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        if (context.isMobile) const _SearchBar(),
        const Expanded(child: _HealerList()),
      ],
    );
  }
}

class _HealerList extends HookConsumerWidget {
  const _HealerList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(patientStoreProvider);
    final userStore = ref.watch(userStoreProvider);
    final controller = useScrollController();

    if (store.searchResults == null) {
      return const SizedBox(height: 0, width: 0);
    }

    if (store.isLoading) {
      return const Loading();
    }

    if (store.searchResults!.healers.isEmpty && store.searchResults?.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Text(
            store.searchResults!.error!.cause.twoLiner(context),
            textAlign: TextAlign.center,
            style: TextStyle(color: context.theme.colorScheme.error),
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

    return Scrollbar(
      thumbVisibility: true,
      controller: controller,
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            if (store.lastJobSearch == 'med_gene' && userStore.appSettings!.enableUrgencyButton)
              Padding(
                padding: const EdgeInsets.all(kSmallPadding),
                child: TextButton(
                  onPressed: () {
                    launchUrlString('mailto:urgence@ah-si.org');
                  },
                  onLongPress: () {
                    Clipboard.setData(const ClipboardData(text: 'urgence@ah-si.org'));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Email'))));
                  },
                  child: Text(
                    context.l10n.urgencyContact,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (!store.searchResults!.isSuspended)
              Padding(
                padding: const EdgeInsets.all(kSmallPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.warning_amber,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: kNormalPadding),
                    Expanded(
                      child: Text(
                        context.l10n.nonSuspendedWarning,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            InfiniteListView.separated(
              itemBuilder: (context, index) {
                return _HealerListItem(healer: store.searchResults!.healers[index]);
              },
              itemCount: store.searchResults?.healers.length ?? 0,
              // Current itemCount you have
              hasNext: store.searchResults!.currentPage < store.searchResults!.totalPages - 1,
              // let the widget know if you have more data to show or not
              nextData: () {
                store.loadHealersPage(store.searchResults!.currentPage + 1);
              },
              primary: false,
              shrinkWrap: true,
              // callback called when end to the list is reach and hasNext is true
              separatorBuilder: (context, index) => const Divider(height: 1),
            ),
          ],
        ),
      ),
    );
  }
}

class PatientHomeScreen extends StatelessWidget {
  static const name = 'patient';

  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.isMobile ? const MobilePatientHome() : const DesktopPatientHome();
  }
}

class _MenuBar extends HookConsumerWidget {
  const _MenuBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(patientStoreProvider);
    final userStore = ref.watch(userStoreProvider);
    return Row(
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
                if (store.searchResults != null) const SizedBox(width: 2),
                if (store.searchResults != null)
                  MenuItem(
                    label: context.l10n.search,
                    onTap: () {
                      store.selectedTab = HomeTabs.search;
                    },
                    selected: store.selectedTab == HomeTabs.search,
                  ),
                if (userStore.user?.type == UserTypeEnum.patient) const SizedBox(width: 2),
                if (userStore.user?.type == UserTypeEnum.patient)
                  MenuItem(
                    label: context.l10n.profile,
                    onTap: () {
                      store.selectedTab = HomeTabs.profile;
                    },
                    selected: store.selectedTab == HomeTabs.profile,
                  ),
                const SizedBox(width: 2),
                MenuItem(
                  label: context.l10n.eventsHistory,
                  onTap: () {
                    store.selectedTab = HomeTabs.history;
                  },
                  selected: store.selectedTab == HomeTabs.history,
                ),
                const SizedBox(width: kNormalPadding),
                if (userStore.user?.type == UserTypeEnum.healer)
                  MenuItem(
                    label: context.l10n.healerMode,
                    onTap: () {
                      context.pushNamed(HealerHomeScreen.name);
                    },
                  ),
                if (userStore.user?.type == UserTypeEnum.admin)
                  MenuItem(
                    label: context.l10n.adminMode,
                    onTap: () {
                      context.pushNamed(AdminHomeScreen.name);
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
    );
  }
}

class _HealerListItem extends HookConsumerWidget {
  final Healer healer;

  const _HealerListItem({Key? key, required this.healer}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.read(userStoreProvider);
    final patientStore = ref.read(patientStoreProvider);
    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      countriesFlag[healer.country]!,
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(width: kSmallPadding),
                    Expanded(child: Text(healer.name, style: context.textTheme.titleLarge)),
                  ],
                ),
                Text(store.specialities[healer.job] ?? '', style: context.textTheme.titleSmall),
                const SizedBox(height: kNormalPadding),
                //if (patientStore.lastTypeSearch == HealerEventType.visio) Text(healer.address),
                if (!healer.description.isNullOrEmpty) const SizedBox(height: kNormalPadding),
                if (!healer.isSuspended)
                  Text(
                    context.l10n.healerPrice,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                if (!healer.isSuspended)
                  Text(
                    healer.consultationPrice == null ? context.l10n.healerPriceUnknown : '${(healer.consultationPrice! / 100).toStringAsFixed(0)}€',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                if (!healer.isSuspended) const SizedBox(height: kNormalPadding),
                if (!healer.description.isNullOrEmpty)
                  Text(
                    context.l10n.healerDescription,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                if (!healer.description.isNullOrEmpty)
                  Text(
                    healer.description!,
                    maxLines: 5,
                  ),
                if (!healer.isSuspended && !healer.website.isNullOrEmpty) const SizedBox(height: kNormalPadding),
                if (!healer.isSuspended && !healer.website.isNullOrEmpty)
                  InkWell(
                    onTap: () {
                      var website = healer.website!;
                      if (!website.startsWith('http')) {
                        website = 'https://${healer.website!}';
                      }
                      launchUrlString(website);
                    },
                    child: Text(
                      healer.website!,
                    ),
                  ),
                const SizedBox(height: kNormalPadding),
                ElevatedButton(
                  onPressed: () {
                    context.push(HealerProfileScreen.route.replaceAll(':id', healer.id!), extra: patientStore.lastTypeSearch);
                  },
                  child: const Text('En savoir plus', textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          if (!context.isMobile) const SizedBox(width: kNormalPadding),
          if (!context.isMobile)
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerRight,
                child: HealerAvailability(
                  id: healer.id!,
                  price: healer.consultationPrice == null ? null : '${healer.consultationPrice! ~/ 100}€',
                  eventType: patientStore.lastTypeSearch,
                  healerName: healer.name,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PlannedConsultations extends HookConsumerWidget {
  final bool showHistory;

  const _PlannedConsultations({
    Key? key,
    this.showHistory = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(patientStoreProvider);
    final controller = useScrollController();

    useEffect(() {
      store.loadEvents(showHistory);
      return null;
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
            style: TextStyle(color: context.theme.colorScheme.error),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (store.eventsResults!.events.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Text(
            showHistory ? context.l10n.noEventHistory : context.l10n.noConsultation,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scrollbar(
      thumbVisibility: true,
      controller: controller,
      child: SingleChildScrollView(
        controller: controller,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: context.isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: store.eventsResults!.events.map((e) => _PatientEventDetails(event: e)).toList(growable: false),
        ),
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
    final patientStore = ref.watch(patientStoreProvider);
    final content = Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(kNormalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(_dateFormat.format(event.start.toLocal()), style: context.textTheme.titleLarge),
                  const SizedBox(height: kSmallPadding),
                  Text(context.l10n.yourHealer),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: kSmallPadding),
                      TextButton(
                        onPressed: () {
                          context.push(HealerProfileScreen.route.replaceAll(':id', event.healer.id!), extra: patientStore.lastTypeSearch);
                        },
                        child: Text(
                          event.healer.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (event.type == HealerEventType.visio)
                        Text(
                          '${event.healer.zipCode} ${event.healer.city}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      const SizedBox(height: kNormalPadding),
                      if (event.type == HealerEventType.visio && !event.isCancelled && event.start.isAfter(DateTime.now().subtract(const Duration(days: 2))))
                        TextButton(
                          onPressed: () async {
                            ref.read(userStoreProvider).acceptEvent(event.id);

                            askToDonate() async {
                              final confirm = await showConfirm(
                                context,
                                context.l10n.askToDonate,
                                context.l10n.askToDonateDesc,
                                okButtonLabel: context.l10n.donate,
                                cancelButtonLabel: context.l10n.donateRefused,
                              );
                              if (confirm) {
                                showAppDialog(
                                    context,
                                    (_) => Text(context.l10n.donate),
                                    (_) => Donate(
                                          onCancelled: () {
                                            context.goNamed(DonateCancelled.name);
                                          },
                                          onSuccess: () {
                                            context.goNamed(DonateSuccess.name);
                                          },
                                        ));
                              }
                            }

                            if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS) {
                              await launchUrlString(event.link);
                              askToDonate();
                            } else {
                              var options = JitsiMeetingOptions(
                                roomNameOrUrl: event.link,
                                userDisplayName: event.patient.firstName,
                                subject: 'Consultation Soignez Heureux',
                              );
                              JitsiMeetWrapper.joinMeeting(
                                options: options,
                                listener: JitsiMeetingListener(
                                  onClosed: askToDonate,
                                ),
                              );
                            }
                          },
                          child: Text(context.l10n.joinVisioButton),
                        ),
                      if (event.type == HealerEventType.faceToFace)
                        TextButton(
                          onPressed: () {
                            launchUrlString(Uri.encodeFull('https://www.google.com/maps/search/?api=1&query=${event.healer.address}'));
                          },
                          child: Text(
                            event.office?.address ?? event.healer.address,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                  if (event.isCancelled) Text(context.l10n.patientCancelledMessage, style: context.textTheme.titleSmall),
                  if (event.isCancelled)
                    Text(
                      event.isCancelled ? event.cancelledDescription ?? 'Aucun' : event.description!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                ],
              ),
            ),
          ),
        ),
        ButtonBar(
          children: [
            if (!event.isCancelled && event.start.isAfter(DateTime.now()))
              TextButton(
                onPressed: () async {
                  final message = await showPrompt(
                    context,
                    context.l10n.cancelConsultation,
                    validator: (value) => isRequired(value, context),
                    description: context.l10n.cancelConsultationConfirm(event.healer.name),
                    label: context.l10n.patientCancelledMessage,
                  );
                  if (!message.isNullOrEmpty) {
                    final cancelled = await showLoadingDialog(context, (_) => Text(context.l10n.canceling), () async {
                      await ref.read(patientStoreProvider).cancelEvent(event.id, message!);
                    });
                    if (cancelled) {
                      showAlert(context, context.l10n.cancelTitle, (_) => Text(context.l10n.consultationCanceled(event.healer.name)));
                    }
                  }
                },
                child: Text(context.l10n.cancelButton),
              ),
            if (event.type == HealerEventType.faceToFace)
              TextButton(
                onPressed: () async {
                  showAppDialog(
                    context,
                    (_) => Text(context.l10n.qrCodeTitle),
                    (_) => SfBarcodeGenerator(
                      value: '${Config.instance!.baseUrl}/acceptInvite/?token=${event.patientToken!}',
                      symbology: QRCode(),
                    ),
                  );
                },
                child: Text(context.l10n.showQrCode),
              ),
          ],
        )
      ],
    );
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320, maxHeight: 300),
      child: Card(
        margin: const EdgeInsets.all(kSmallPadding),
        child: event.isUrgent || event.isCancelled
            ? Banner(
                location: BannerLocation.topEnd,
                message: event.isCancelled ? 'Annulée' : 'Urgent',
                child: content,
              )
            : content,
      ),
    );
  }
}

class _SearchBar extends HookConsumerWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientStore = ref.watch(patientStoreProvider);
    final jobChoice = useState<MapEntry<String, String>?>(null);
    final typeChoice = useState<HealerEventType>(HealerEventType.visio);
    final controllerJob = useTextEditingController();
    final controllerLocalization = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    submitForm() {
      FocusScope.of(context).requestFocus(FocusNode());
      if (formKey.currentState!.validate()) {
        ref.read(patientStoreProvider).searchHealers(jobChoice.value!.key, typeChoice.value, controllerLocalization.text, 0);
      }
    }

    return ColoredBox(
      color: Colors.white.withOpacity(.85),
      child: Padding(
        padding: const EdgeInsets.only(left: kSmallPadding),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(Icons.search),
                    const SizedBox(width: kNormalPadding),
                    Expanded(
                      flex: 2,
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
                    ),
                    const SizedBox(
                      width: kSmallPadding,
                    ),
                    Visibility(
                      visible: false,
                      child: Expanded(
                        child: DropdownButtonFormField<HealerEventType>(
                          items: HealerEventType.values
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      context.l10n.consultationLabel(e),
                                      maxLines: 1,
                                    ),
                                  ))
                              .toList(growable: false),
                          decoration: InputDecoration(
                            labelText: context.l10n.consultationType,
                            border: InputBorder.none,
                          ),
                          value: typeChoice.value,
                          isExpanded: true,
                          onChanged: (value) {
                            typeChoice.value = value!;
                            if (value == HealerEventType.visio) {
                              controllerLocalization.text = '';
                            }
                          },
                        ),
                      ),
                    ),
                    if (typeChoice.value == HealerEventType.visio)
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
              if (typeChoice.value == HealerEventType.faceToFace)
                SizedBox(
                  height: 60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(Icons.location_on_outlined),
                      const SizedBox(width: kNormalPadding),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: HookBuilder(builder: (context) {
                            useEffect(() {
                              patientStore.searchLocalities(controllerJob.text);
                              return null;
                            }, [controllerJob.text]);
                            final localities = patientStore.localities;

                            final items = useMemoized(
                                () => localities.entries
                                    .map((e) => DropdownMenuItem(
                                          key: ValueKey(e.key),
                                          value: e,
                                          child: Text(e.value),
                                        ))
                                    .toList(growable: false),
                                [localities]);

                            return DropdownButtonFormField<MapEntry<String, String>>(
                              onChanged: (entry) {
                                controllerLocalization.text = entry!.key;
                              },
                              validator: (value) => isRequired(value, context),
                              items: items,
                            );
                          }),
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
            ],
          ),
        ),
      ),
    );
  }
}
