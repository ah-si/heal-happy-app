import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heal_happy/admin/stores/admin_store.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/presentation/menu_item.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminHomeScreen extends HookConsumerWidget {
  static const name = 'admin_home';

  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(adminStoreProvider);

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
                Expanded(
                  child: ColoredBox(
                    color: Colors.white.withOpacity(0.8),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: store.selectedTab == HomeTabs.home ? const _HealerToVerify() : null,
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

class _HealerToVerify extends HookConsumerWidget {
  const _HealerToVerify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(adminStoreProvider);

    if (store.isLoading || store.searchResults == null) {
      return const Loading();
    }

    if (store.searchResults!.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Text(
            store.searchResults!.error!.cause.twoLiner(context),
            style: TextStyle(color: context.theme.errorColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (store.searchResults!.healers.isEmpty) {
      return Center(
        child: Text(
          context.l10n.emptyHealer,
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
          Text(
            context.l10n.pendingHealer,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return _HealerItem(healer: store.searchResults!.healers[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(height: 1);
              },
              itemCount: store.searchResults!.healers.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _HealerItem extends HookConsumerWidget {
  final User healer;

  const _HealerItem({Key? key, required this.healer}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: kNormalPadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kNormalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(healer.name, style: context.textTheme.subtitle1),
                Text(
                  specialities[healer.job] ?? healer.job!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: kSmallPadding),
                Text(healer.adminAddress),
                InkWell(
                  onTap: () {
                    launch('mailto:${healer.email}');
                  },
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: healer.email));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Email'))));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.email_outlined),
                      const SizedBox(width: kSmallPadding),
                      Expanded(child: Text(healer.email)),
                    ],
                  ),
                ),
                if (!healer.mobile.isNullOrEmpty)
                  InkWell(
                    onTap: () {
                      launch('tel:${healer.mobile}');
                    },
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: healer.mobile));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.phoneCopied)));
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.call_outlined),
                        const SizedBox(width: kSmallPadding),
                        Text(healer.mobile!),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          ButtonBar(
            children: [
              TextButton(
                onPressed: () async {
                  final success = await showConfirm(context, context.l10n.delete(healer.name), context.l10n.deleteHealerConfirm);
                  if (success) {
                    final store = ref.read(adminStoreProvider);
                    showLoadingDialog(context, (_) => Text(context.l10n.deleting), () => store.deleteHealer(healer));
                  }
                },
                child: Text(context.l10n.deleteButton),
              ),
              TextButton(
                onPressed: () async {
                  final success = await showConfirm(context, context.l10n.accept(healer.name),
                      context.l10n.acceptConfirm);
                  if (success) {
                    final store = ref.read(adminStoreProvider);
                    showLoadingDialog(context, (_) => Text(context.l10n.accepting), () => store.validateHealer(healer));
                  }
                },
                child: Text(context.l10n.acceptButton),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
