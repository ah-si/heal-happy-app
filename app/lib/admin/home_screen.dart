import 'dart:async';

import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/admin/stores/admin_store.dart';
import 'package:heal_happy/admin/stores/dashboard_store.dart';
import 'package:heal_happy/admin/stores/donations_store.dart';
import 'package:heal_happy/admin/stores/events_search_store.dart';
import 'package:heal_happy/admin/stores/healer_stats_store.dart';
import 'package:heal_happy/admin/stores/users_search_store.dart';
import 'package:heal_happy/admin/user_details_screen.dart';
import 'package:heal_happy/common/config.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/job_search_field.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/presentation/menu_item.dart';
import 'package:heal_happy/common/presentation/pagination.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy/offices/presentation/offices_tab.dart';
import 'package:heal_happy/patient/home_screen.dart';
import 'package:heal_happy/user/user_profile.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart' hide Dashboard;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

part 'dashboard_tab.dart';
part 'donations_tab.dart';
part 'events_tab.dart';
part 'healer_reports_tab.dart';
part 'users_tab.dart';

void _disconnect(BuildContext context, WidgetRef ref) async {
  final success = await showConfirm(context, context.l10n.disconnect, context.l10n.disconnectConfirm);
  if (success) {
    final store = ref.read(userStoreProvider);
    store.logout();
  }
}

class AdminHomeScreen extends StatelessWidget {
  static const name = 'admin';
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.isMobile ? const MobileAdminHome() : const DesktopAdminHome();
  }
}

class MobileAdminHome extends HookConsumerWidget {
  const MobileAdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.read(adminStoreProvider);
    final controller = useTabController(initialLength: HomeTabs.values.length, initialIndex: store.selectedTab.index);

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
              text: context.l10n.adminUsersMenu,
            ),
            Tab(
              text: context.l10n.adminOfficesMenu,
            ),
            Tab(
              text: context.l10n.adminEventsMenu,
            ),
            Tab(
              text: context.l10n.adminHealerStatsMenu,
            ),
            Tab(
              text: context.l10n.profile,
            ),
            Tab(
              text: context.l10n.donations,
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
              Dashboard(),
              _Users(),
              Offices(),
              _Events(),
              HealerReports(),
              UserProfile(),
              Donations(),
            ],
            controller: controller,
          ),
        ),
      ),
    );
  }

}

class DesktopAdminHome extends HookConsumerWidget {
  const DesktopAdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(adminStoreProvider);

    late Widget child;

    switch (store.selectedTab) {
      case HomeTabs.home:
        child = const Dashboard();
        break;
      case HomeTabs.users:
        child = const _Users();
        break;
      case HomeTabs.events:
        child = const _Events();
        break;
      case HomeTabs.healerStats:
        child = const HealerReports();
        break;
      case HomeTabs.profile:
        child = const SizedBox(height: double.infinity, child: SingleChildScrollView(child: UserProfile()));
        break;
      case HomeTabs.offices:
        child = const Offices();
        break;
      case HomeTabs.donations:
        child = const Donations();
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
                              label: context.l10n.adminUsersMenu,
                              onTap: () {
                                store.selectedTab = HomeTabs.users;
                              },
                              selected: store.selectedTab == HomeTabs.users,
                            ),
                            const SizedBox(width: 2),
                            MenuItem(
                              label: context.l10n.adminOfficesMenu,
                              onTap: () {
                                store.selectedTab = HomeTabs.offices;
                              },
                              selected: store.selectedTab == HomeTabs.offices,
                            ),
                            const SizedBox(width: 2),
                            MenuItem(
                              label: context.l10n.adminEventsMenu,
                              onTap: () {
                                store.selectedTab = HomeTabs.events;
                              },
                              selected: store.selectedTab == HomeTabs.events,
                            ),
                            const SizedBox(width: 2),
                            MenuItem(
                              label: context.l10n.adminHealerStatsMenu,
                              onTap: () {
                                store.selectedTab = HomeTabs.healerStats;
                              },
                              selected: store.selectedTab == HomeTabs.healerStats,
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
                              label: context.l10n.donations,
                              onTap: () {
                                store.selectedTab = HomeTabs.donations;
                              },
                              selected: store.selectedTab == HomeTabs.donations,
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
                    MenuItem(
                      label: context.l10n.disconnect,
                      onTap: () async {
                        _disconnect(context, ref);
                      },
                      selected: true,
                    ),
                  ],
                ),
                Expanded(
                  child: ColoredBox(
                    color: Colors.white.withOpacity(0.8),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: child,
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
