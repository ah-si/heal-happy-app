import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
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
import 'package:heal_happy/patient/healer_availability.dart';
import 'package:heal_happy/patient/healer_profile_screen.dart';
import 'package:heal_happy/patient/stores/patient_store.dart';
import 'package:heal_happy/user/user_profile.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final controller = useTabController(initialLength: 4, initialIndex: store.selectedTab.index);

    useEffect(() {
      controller.addListener(() {
        if (controller.index != controller.previousIndex) {
          store.selectedTab = HomeTabs.values[controller.index];
        }
      });
    }, [controller]);

    return BgContainer(
      appBar: AppBar(
        title: Text(context.l10n.appTitle),
        actions: [
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
            children: const [
              _PlannedConsultations(
                key: Key('consultations'),
              ),
              _SearchTab(),
              UserProfile(),
              Scrollbar(child: Center(child: _PlannedConsultations(showHistory: true))),
            ],
            controller: controller,
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
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    context.l10n.mentionLegal,
                                    style: TextStyle(color: context.primaryColor),
                                  ),
                                ),
                                const SizedBox(width: kNormalPadding),
                                Expanded(
                                  child: Text(
                                    context.l10n.addressLegal,
                                    style: TextStyle(color: context.primaryColor),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
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
        if (store.lastJobSearch == 'med_gene' && userStore.appSettings!.enableUrgencyButton)
          Padding(
            padding: const EdgeInsets.all(kSmallPadding),
            child: TextButton(
              onPressed: () {
                launch('mailto:urgence@ah-si.org');
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
        Expanded(
          child: Scrollbar(
            isAlwaysShown: true,
            controller: controller,
            child: ListView.separated(
              controller: controller,
              itemBuilder: (context, index) {
                return _HealerListItem(healer: store.searchResults!.healers[index]);
              },
              separatorBuilder: (context, index) => const Divider(height: 1),
              primary: false,
              shrinkWrap: true,
              itemCount: store.searchResults?.healers.length ?? 0,
            ),
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
  }
}

class PatientHomeScreen extends StatelessWidget {
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
                  label: context.l10n.eventsHistory,
                  onTap: () {
                    store.selectedTab = HomeTabs.history;
                  },
                  selected: store.selectedTab == HomeTabs.history,
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
    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.healing, size: 50),
          const SizedBox(width: kNormalPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(healer.name, style: context.textTheme.headline6),
                Text(store.specialities[healer.job] ?? '', style: context.textTheme.subtitle2),
                const SizedBox(height: kNormalPadding),
                Text(healer.address),
                if (!healer.description.isNullOrEmpty) const SizedBox(height: kNormalPadding),
                if (!healer.description.isNullOrEmpty)
                  Text(
                    context.l10n.healerDescription,
                    maxLines: 3,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                if (!healer.description.isNullOrEmpty) Text(healer.description!),
                const SizedBox(height: kNormalPadding),
                ElevatedButton(
                  onPressed: () {
                    context.push(HealerProfileScreen.route.replaceAll(':id', healer.id!));
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
              child: Align(alignment: Alignment.centerRight, child: HealerAvailability(id: healer.id!, healerName: healer.name)),
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
      isAlwaysShown: true,
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
    final content = Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(kNormalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(_dateFormat.format(event.start.toLocal()), style: context.textTheme.headline6),
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
                if (event.isCancelled) Text(context.l10n.patientCancelledMessage, style: context.textTheme.subtitle2),
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
        ButtonBar(
          children: [
            if (!event.isCancelled && event.start.isAfter(DateTime.now()))
              TextButton(
                onPressed: () async {
                  final message = await showPrompt(context, context.l10n.cancelConsultation,
                      validator: (value) => isRequired(value, context), description: context.l10n.cancelConsultationConfirm(event.healer.name));
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
            if (!event.isCancelled && event.start.isAfter(DateTime.now().subtract(const Duration(days: 4))))
              TextButton(
                onPressed: () {
                  if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS) {
                    launch(event.link);
                  } else {
                    var options = JitsiMeetingOptions(
                      roomNameOrUrl: event.link,
                      userDisplayName: event.patient.firstName,
                      subject: 'Consultation Soignez Heureux',
                    );
                    JitsiMeetWrapper.joinMeeting(options: options);
                  }
                },
                child: Text(context.l10n.joinVisioButton),
              ),
          ],
        )
      ],
    );
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320, maxHeight: 250),
      child: Card(
        margin: const EdgeInsets.all(kSmallPadding),
        child: event.isUrgent || event.isCancelled
            ? Banner(
                location: BannerLocation.topEnd,
                message: event.isUrgent ? 'Urgent' : 'Annulée',
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
    final jobChoice = useState<MapEntry<String, String>?>(null);
    final controllerJob = useTextEditingController();
    final controllerLocalization = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    submitForm() {
      FocusScope.of(context).requestFocus(FocusNode());
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
                if (false) const Icon(Icons.location_on_outlined),
                if (false) const SizedBox(width: kNormalPadding),
                if (false)
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
