import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/admin/stores/dashboard_store.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
