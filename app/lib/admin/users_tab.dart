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
            style: TextStyle(color: context.theme.colorScheme.error),
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
        ExpansionTile(
          initiallyExpanded: (store.searchResults?.users.length ?? 0) == 0,
          title: Text(context.l10n.search),
          children: [
            _UsersSearch(),
          ],
        ),
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
    final faceToFaceState = useState<bool?>(null);
    final jobState = useState<String?>(null);
    final typeState = useState<UserTypeEnum?>(null);
    search() {
      final store = ref.read(adminUsersStoreProvider);
      store.search(0,
          query: SearchQuery(
            controllerSearch.text.trim(),
            typeState.value,
            controllerSpe.text.isNullOrEmpty ? null : jobState.value,
            activatedState.value,
            verifiedState.value,
            faceToFaceState.value,
          ));
    }

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
              onSubmitted: (value) {
                search();
              },
              decoration: InputDecoration(label: Text(context.l10n.searchQueryField), hintText: context.l10n.searchQueryPlaceholder),
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
                DropdownMenuItem(value: null, child: Text('Tous')),
                DropdownMenuItem(value: UserTypeEnum.patient, child: Text('Patients')),
                DropdownMenuItem(value: UserTypeEnum.healer, child: Text('Soignants')),
                DropdownMenuItem(value: UserTypeEnum.admin, child: Text('Admins')),
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
              title: Text(context.l10n.isActivatedField, maxLines: 1),
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
              title: Text(context.l10n.isVerifiedField, maxLines: 1),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 160),
            child: CheckboxListTile(
              value: faceToFaceState.value,
              onChanged: (value) {
                faceToFaceState.value = value;
              },
              tristate: true,
              title: Text(context.l10n.canDoFaceToFaceField, maxLines: 1),
            ),
          ),
          ElevatedButton(
            onPressed: search,
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
              if (verifiedState.value != null) {
                final serialized = serializers.serialize(
                  verifiedState.value as Object,
                  specifiedType: const FullType(bool),
                );
                url += 'isVerified=$serialized&';
              }
              if (faceToFaceState.value != null) {
                final serialized = serializers.serialize(
                  faceToFaceState.value as Object,
                  specifiedType: const FullType(bool),
                );
                url += 'canDoFaceToFace=$serialized&';
              }

              final token = BackendApiProvider().getToken();
              url += 'token=$token&';
              launchUrlString(url);
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
                Text(user.name, style: context.textTheme.titleMedium),
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
                Text(user.address),
                InkWell(
                  onTap: () {
                    launchUrlString('mailto:${user.email}');
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
                      launchUrlString('tel:${user.mobile}');
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
                user.isActivated ? Text(context.l10n.userActivated) : Text(context.l10n.userUnActivated),
                if (user.type == UserTypeEnum.healer) user.isVerified ? Text(context.l10n.userVerified) : Text(context.l10n.userUnVerified),
                if (user.type == UserTypeEnum.healer && user.dateSubscription != null) Text(context.l10n.userValid(kDateFormat.format(user.dateSubscription!))),
                if (!user.isTermsAccepted) Text(context.l10n.userRgpdKo),
              ],
            ),
          ),
          ButtonBar(
            children: [
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
                      showLoadingDialog(context, (_) => Text(context.l10n.accepting), () => store.validateHealer(user, true));
                    }
                  },
                  child: Text(context.l10n.acceptButton),
                ),
              if (user.type == UserTypeEnum.patient && !user.isBlocked)
                TextButton(
                  onPressed: () async {
                    final success = await showConfirm(context, context.l10n.disableUser(user.name), context.l10n.disableConfirm);
                    if (success) {
                      final store = ref.read(adminUsersStoreProvider);
                      showLoadingDialog(context, (_) => Text(context.l10n.disabling), () => store.blockUser(user, true));
                    }
                  },
                  child: Text(context.l10n.deactivateUser),
                ),
              if (user.type == UserTypeEnum.patient && user.isBlocked)
                TextButton(
                  onPressed: () async {
                    final success = await showConfirm(context, context.l10n.unlockUser(user.name), context.l10n.unblockConfirm);
                    if (success) {
                      final store = ref.read(adminUsersStoreProvider);
                      showLoadingDialog(context, (_) => Text(context.l10n.unblocking), () => store.blockUser(user, false));
                    }
                  },
                  child: Text(context.l10n.unblockUser),
                ),
              if (user.type == UserTypeEnum.healer && user.isVerified)
                TextButton(
                  onPressed: () async {
                    final success = await showConfirm(context, context.l10n.disableUser(user.name), context.l10n.disableConfirm);
                    if (success) {
                      final store = ref.read(adminUsersStoreProvider);
                      showLoadingDialog(context, (_) => Text(context.l10n.disabling), () => store.validateHealer(user, false));
                    }
                  },
                  child: Text(context.l10n.deactivateUser),
                ),
              if (user.type == UserTypeEnum.healer && user.isVerified)
                TextButton(
                  onPressed: () async {
                    final title = user.canDoFaceToFace! ? context.l10n.disallowFaceToFace : context.l10n.allowFaceToFace;
                    final text = user.canDoFaceToFace! ? context.l10n.disallowFaceToFaceConfirm : context.l10n.allowFaceToFaceConfirm;
                    final success = await showConfirm(context, title, text);
                    if (success) {
                      final store = ref.read(adminUsersStoreProvider);
                      showLoadingDialog(context, (_) => Text(context.l10n.sending),
                          () => store.saveHealer(user.rebuild((p0) => p0.canDoFaceToFace = !user.canDoFaceToFace!)));
                    }
                  },
                  child: Text(user.canDoFaceToFace! ? context.l10n.disallowFaceToFace : context.l10n.allowFaceToFace),
                ),
              TextButton(
                onPressed: () async {
                  context.push(UserDetailsScreen.route.replaceAll(':id', user.id!));
                },
                child: Text(context.l10n.editButton),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
