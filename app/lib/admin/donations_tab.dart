part of 'home_screen.dart';

class Donations extends HookConsumerWidget {
  const Donations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(adminDonationsStoreProvider);

    useEffect(() {
      scheduleMicrotask(() {
        store.getDonations();
      });
      return null;
    }, const []);

    if (store.currentChart == null) {
      return const Loading();
    }

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Wrap(
          children: [
            _DonationsCard(
              child: ClipRect(
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(minimum: 0, interval: 100),
                  title: ChartTitle(text: 'Dons'),
                  series: store.donationsChart!,
                ),
              ),
            ),
            _DonationsCard(
              child: ClipRect(
                child: SfCircularChart(
                  title: ChartTitle(text: 'Montants pour ' + store.currentMonth),
                  series: store.currentChart!,
                  legend: Legend(
                    isVisible: true,
                    isResponsive: true,
                  ),
                ),
              ),
            ),
            _DonationsCard(
              child: ClipRect(
                child: SfCircularChart(
                  title: ChartTitle(text: 'Montants pour ' + store.previousMonth),
                  series: store.previousChart!,
                  legend: Legend(
                    isVisible: true,
                    isResponsive: true,
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

class _DonationsCard extends StatelessWidget {
  final Widget child;

  const _DonationsCard({Key? key, required this.child}) : super(key: key);

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
