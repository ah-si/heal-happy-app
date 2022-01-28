part of 'home_screen.dart';

class Dashboard extends HookConsumerWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(adminDashboardStoreProvider);
    final userStore = ref.watch(userStoreProvider);

    useEffect(() {
      scheduleMicrotask(() {
        store.getDashboard();
      });
    }, const []);

    if (store.usersChart == null) {
      return const Loading();
    }

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Wrap(
          children: [
            _DashboardCard(
              child: ClipRect(
                child: SfCircularChart(
                  title: ChartTitle(text: 'Utilisateurs'),
                  series: store.usersChart!,
                  legend: Legend(
                    isVisible: true,
                    isResponsive: true,
                  ),
                ),
              ),
            ),
            _DashboardCard(
              child: ClipRect(
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(minimum: 0, interval: 50),
                  title: ChartTitle(text: 'Consultations'),
                  legend: Legend(
                    isVisible: true,
                    isResponsive: true,
                  ),
                  series: store.eventsChart!,
                ),
              ),
            ),
            _DashboardCard(
              child: CheckboxListTile(
                value: userStore.appSettings?.enableUrgencyButton ?? false,
                title: Text(context.l10n.adminEnableUrgency),
                onChanged: (bool? value) async {
                  final success = await showLoadingDialog(context, (_) => Text(context.l10n.loading), () => store.updateSettings(value!));
                  if (success) {
                    userStore.loadSettings(force: true);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final Widget child;

  const _DashboardCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(kNormalPadding),
      child: Padding(
        padding: const EdgeInsets.all(kNormalPadding),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: child,
        ),
      ),
    );
  }
}
