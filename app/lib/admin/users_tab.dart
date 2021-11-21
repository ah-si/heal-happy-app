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
    final jobState = useState<String?>(null);
    final typeState = useState<UserTypeEnum?>(null);
    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
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
          ElevatedButton(
            onPressed: () {
              final store = ref.read(adminUsersStoreProvider);
              store.search(0,
                  query: SearchQuery(controllerSearch.text, typeState.value, controllerSpe.text.isNullOrEmpty ? null : jobState.value, activatedState.value));
            },
            child: Text(context.l10n.searchButton),
          ),
          ElevatedButton(
            onPressed: () {
              String url = '${Config().baseUrl}/api/v1/admin/users?';

              if (!controllerSearch.text.isNullOrEmpty) url += 'query=${controllerSearch.text}&';
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
