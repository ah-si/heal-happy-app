import 'dart:async';

import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/admin/stores/admin_store.dart';
import 'package:heal_happy/admin/stores/dashboard_store.dart';
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
import 'package:heal_happy/user/user_profile.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart' hide Dashboard;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

part 'dashboard_tab.dart';
part 'healer_reports_tab.dart';
part 'users_tab.dart';

class AdminHomeScreen extends HookConsumerWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

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
      case HomeTabs.healerStats:
        child = const HealerReports();
        break;
      case HomeTabs.profile:
        child = const SizedBox(height: double.infinity, child: SingleChildScrollView(child: UserProfile()));
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
                          ],
                        ),
                      ),
                    ),
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
