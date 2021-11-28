part of 'home_screen.dart';

class _Users extends HookConsumerWidget {
  const _Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(adminUsersStoreProvider);
    late Widget child;
    if (store.isLoading) {
      child = const Loading();
    } else if (store.searchResults == null) {
      child = const SizedBox();
    } else if (store.searchResults!.error != null) {
      child = Center(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Text(
            store.searchResults!.error!.cause.twoLiner(context),
            style: TextStyle(color: context.theme.errorColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else if (store.searchResults!.users.isEmpty) {
      child = Center(
        child: Text(
          context.l10n.emptyUsers,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      child = Padding(
        padding: const EdgeInsets.all(kNormalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final user = store.searchResults!.users[index];
                  return _UserItem(
                    user: user,
                    onDeletePressed: () async {
                      final success = await showConfirm(context, context.l10n.delete(user.name), context.l10n.deleteHealerConfirm);
                      if (success) {
                        final store = ref.read(adminUsersStoreProvider);
                        showLoadingDialog(context, (_) => Text(context.l10n.deleting), () => store.deleteUser(user));
                      }
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 1);
                },
                itemCount: store.searchResults!.users.length,
              ),
            ),
            Pagination(
              total: store.searchResults!.totalPages,
              current: store.searchResults!.currentPage,
              onPageSelected: (int selectedPage) {
                store.search(selectedPage);
              },
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _UsersSearch(),
        Expanded(child: child),
      ],
    );
  }
}

class _UsersSearch extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerSearch = useTextEditingController();
    final controllerSpe = useTextEditingController();
    final activatedState = useState<bool?>(null);
    final verifiedState = useState<bool?>(null);
    final jobState = useState<String?>(null);
    final typeState = useState<UserTypeEnum?>(null);
    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        runAlignment: WrapAlignment.spaceEvenly,
        alignment: WrapAlignment.spaceEvenly,
        runSpacing: kNormalPadding,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: TextField(
              controller: controllerSearch,
              decoration: InputDecoration(label: Text(context.l10n.searchQueryField)),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: DropdownButtonFormField<UserTypeEnum>(
              decoration: InputDecoration(label: Text(context.l10n.userTypeField)),
              onChanged: (value) {
                typeState.value = value;
              },
              value: typeState.value,
              items: const [
                DropdownMenuItem(child: Text('Tous'), value: null),
                DropdownMenuItem(child: Text('Patients'), value: UserTypeEnum.patient),
                DropdownMenuItem(child: Text('Soignants'), value: UserTypeEnum.healer),
                DropdownMenuItem(child: Text('Admins'), value: UserTypeEnum.admin),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: JobSearchFormField(
              decoration: InputDecoration(label: Text(context.l10n.speField2)),
              controller: controllerSpe,
              onItemSelected: (MapEntry<String, String> selected) {
                jobState.value = selected.key;
              },
              loadData: () {
                return ref.read(userStoreProvider).getSpecialities();
              },
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140),
            child: CheckboxListTile(
              value: activatedState.value,
              onChanged: (value) {
                activatedState.value = value;
              },
              tristate: true,
              title: Text(context.l10n.isActivatedField),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140),
            child: CheckboxListTile(
              value: verifiedState.value,
              onChanged: (value) {
                verifiedState.value = value;
              },
              tristate: true,
              title: Text(context.l10n.isVerifiedField),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final store = ref.read(adminUsersStoreProvider);
              store.search(0,
                  query: SearchQuery(
                    controllerSearch.text.trim(),
                    typeState.value,
                    controllerSpe.text.isNullOrEmpty ? null : jobState.value,
                    activatedState.value,
                    verifiedState.value,
                  ));
            },
            child: Text(context.l10n.searchButton),
          ),
          ElevatedButton(
            onPressed: () {
              String url = '${Config().baseUrl}/api/v1/admin/users?';

              if (!controllerSearch.text.isNullOrEmpty) url += 'query=${controllerSearch.text.trim()}&';
              if (typeState.value != null) {
                final serialized = serializers.serialize(
                  typeState.value as Object,
                  specifiedType: const FullType(UserTypeEnum),
                );
                url += 'type=$serialized&';
              }
              if (!controllerSpe.text.isNullOrEmpty) url += 'job=${jobState.value}&';
              if (activatedState.value != null) {
                final serialized = serializers.serialize(
                  activatedState.value as Object,
                  specifiedType: const FullType(bool),
                );
                url += 'isActivated=$serialized&';
              }
              final token = BackendApiProvider().getToken();
              url += 'token=$token&';
              launch(url);
            },
            child: Text(context.l10n.exportButton),
          ),
        ],
      ),
    );
  }
}


class _UserItem extends HookConsumerWidget {
  final User user;
  final VoidCallback onDeletePressed;

  const _UserItem({Key? key, required this.onDeletePressed, required this.user}) : super(key: key);

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
              if (user.type == UserTypeEnum.healer && user.diplomaFile != null)
                TextButton(
                  onPressed: () {
                    final token = BackendApiProvider().getToken();
                    launch('${Config().baseUrl}/api/v1/admin/files/download?file=${user.diplomaFile}&token=$token');
                  },
                  child: Text(context.l10n.downloadDiploma),
                ),
              if (user.type == UserTypeEnum.healer && user.healerTermsFile != null)
                TextButton(
                  onPressed: () {
                    final token = BackendApiProvider().getToken();
                    launch('${Config().baseUrl}/api/v1/admin/files/download?file=${user.healerTermsFile}&token=$token');
                  },
                  child: Text(context.l10n.downloadHealerTerms),
                ),
              TextButton(
                onPressed: onDeletePressed,
                child: Text(context.l10n.deleteButton),
              ),
              if (user.type == UserTypeEnum.healer && !user.isVerified)
                TextButton(
                  onPressed: () async {
                    final success = await showConfirm(context, context.l10n.accept(user.name), context.l10n.acceptConfirm);
                    if (success) {
                      final store = ref.read(adminUsersStoreProvider);
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
