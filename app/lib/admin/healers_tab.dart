part of 'home_screen.dart';

class _HealerToVerify extends HookConsumerWidget {
  const _HealerToVerify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(adminStoreProvider);

    useEffect(() {
      scheduleMicrotask(() {
        store.searchHealers(0);
      });
    }, const []);

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
                return _UserItem(user: store.searchResults!.healers[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(height: 1);
              },
              itemCount: store.searchResults!.healers.length,
            ),
          ),
          Pagination(
            total: store.searchResults!.totalPages,
            current: store.searchResults!.currentPage,
            onPageSelected: (int selectedPage) {
              store.searchHealers(selectedPage);
            },
          ),
        ],
      ),
    );
  }
}

class _UserItem extends HookConsumerWidget {
  final User user;
  final bool showAcceptButton;

  const _UserItem({Key? key, this.showAcceptButton = true, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(userStoreProvider);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: kNormalPadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kNormalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(user.name, style: context.textTheme.subtitle1),
                if (user.type == UserTypeEnum.admin)
                  Text(
                    context.l10n.userType(UserTypeEnum.admin),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                if (user.type == UserTypeEnum.patient)
                  Text(
                    context.l10n.userType(UserTypeEnum.patient),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                if (user.type == UserTypeEnum.healer)
                  Text(
                    store.specialities[user.job] ?? user.job!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: kSmallPadding),
                Text(user.adminAddress),
                InkWell(
                  onTap: () {
                    launch('mailto:${user.email}');
                  },
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: user.email));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Email'))));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.email_outlined),
                      const SizedBox(width: kSmallPadding),
                      Expanded(child: Text(user.email)),
                    ],
                  ),
                ),
                if (!user.mobile.isNullOrEmpty)
                  InkWell(
                    onTap: () {
                      launch('tel:${user.mobile}');
                    },
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: user.mobile));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.phoneCopied)));
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.call_outlined),
                        const SizedBox(width: kSmallPadding),
                        Text(user.mobile!),
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
                  final success = await showConfirm(context, context.l10n.delete(user.name), context.l10n.deleteHealerConfirm);
                  if (success) {
                    final store = ref.read(adminStoreProvider);
                    showLoadingDialog(context, (_) => Text(context.l10n.deleting), () => store.deleteHealer(user));
                  }
                },
                child: Text(context.l10n.deleteButton),
              ),
              if (showAcceptButton)
                TextButton(
                  onPressed: () async {
                    final success = await showConfirm(context, context.l10n.accept(user.name), context.l10n.acceptConfirm);
                    if (success) {
                      final store = ref.read(adminStoreProvider);
                      showLoadingDialog(context, (_) => Text(context.l10n.accepting), () => store.validateHealer(user));
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
