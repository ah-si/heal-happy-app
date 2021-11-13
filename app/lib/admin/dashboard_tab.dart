part of 'home_screen.dart';


class Dashboard extends HookConsumerWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(adminDashboardStoreProvider);

    useEffect(() {
      scheduleMicrotask(() {
        store.getDashboard();
      });
    }, const []);

    if (store.dashboard == null) {
      return const Loading();
    }

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Wrap(
          children: [
            Card(
              margin: const EdgeInsets.all(kNormalPadding),
              child: Padding(
                padding: const EdgeInsets.all(kNormalPadding),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: ClipRect(
                    child: SfCircularChart(
                      title: ChartTitle(text: 'Utilisateurs'),
                      series: store.dashboard!,
                      legend: Legend(
                        isVisible: true,
                        isResponsive: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
