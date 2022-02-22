part of 'home_screen.dart';

class _Offices extends HookConsumerWidget {
  const _Offices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(adminOfficeStoreProvider);

    useEffect(() {
      store.loadOffices(0);
      return null;
    }, const []);

    late Widget child;
    Widget addButton = FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    );
    if (store.isLoading || store.results == null) {
      child = const Loading();
    } else if (store.results!.error != null) {
      child = Center(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Text(
            store.results!.error!.cause.twoLiner(context),
            style: TextStyle(color: context.theme.errorColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else if (store.results!.offices.isEmpty) {
      child = Scaffold(
        floatingActionButton: addButton,
        body: Center(
          child: Text(
            context.l10n.emptyOffices,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      child = Scaffold(
        floatingActionButton: addButton,
        body: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return _OfficeItem(office: store.results!.offices[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(height: 1);
                  },
                  itemCount: store.results!.offices.length,
                ),
              ),
              Pagination(
                total: store.results!.totalPages,
                current: store.results!.currentPage,
                onPageSelected: (int selectedPage) {
                  store.loadOfficesPage(selectedPage);
                },
              ),
            ],
          ),
        ),
      );
    }

    return child;
  }
}

class _OfficeItem extends StatelessWidget {
  final Office office;

  const _OfficeItem({Key? key, required this.office}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(office.name),
      subtitle: Text(office.address),
      trailing: const Icon(Icons.edit),
      onTap: () {},
    );
  }
}
