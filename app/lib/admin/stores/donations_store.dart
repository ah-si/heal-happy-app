import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final adminDonationsStoreProvider = ChangeNotifierProvider((_) => AdminDonationsStore());

enum DashboardDataEnum {
  admin,
  healerVerified,
  healerToVerify,
  patientActivated,
  patientNonActivated,
}

class DonationsChartData {
  final String amount;
  final int total;

  DonationsChartData(this.amount, this.total);
}

class AmountChartData {
  final int month;
  final int year;
  final int total;

  AmountChartData(this.month, this.year, this.total);
}

class AdminDonationsStore extends ChangeNotifier {
  final AdminApi _adminApi;
  static final DateFormat _monthFormat = DateFormat('MMMM');
  late String currentMonth;
  late String previousMonth;
  List<CircularSeries<DonationsChartData, String>>? currentChart;
  List<CircularSeries<DonationsChartData, String>>? previousChart;
  List<ColumnSeries<AmountChartData, String>>? donationsChart;
  bool isLoading = false;

  AdminDonationsStore({AdminApi? adminApi}) : _adminApi = adminApi ?? BackendApiProvider().api.getAdminApi() {
    currentMonth = _monthFormat.format(DateTime.now());
    previousMonth = _monthFormat.format(DateTime.now().subtract(const Duration(days: 31)));
  }

  void _manageAmountsChart(DonationsData donations) async {
    final data = <AmountChartData>[];
    final now = DateTime.now();
    final previous = DateTime.now().subtract(const Duration(days: 31));
    data.add(AmountChartData(previous.month, previous.year, donations.previous.total));
    data.add(AmountChartData(now.month, now.year, donations.current.total));

    final _uiFormat = DateFormat('MMMM');
    final year = Date.now().year;
    String? getCallback(AmountChartData row, _) {
      final _date = DateTime(year, row.month, 1);
      return _uiFormat.format(_date);
    }

    String? getCallbackLabel(AmountChartData row, _) {
      return row.total.toString() + donations.current.currency;
    }

    donationsChart = [
      ColumnSeries(
        dataSource: data,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        enableTooltip: true,
        xValueMapper: getCallback,
        yValueMapper: (AmountChartData data, _) => data.total,
        // Set a label accessor to control the text of the bar label.
        dataLabelMapper: getCallbackLabel,
      ),
    ];
  }

  List<CircularSeries<DonationsChartData, String>> _manageDonationsChart(DonationsMonthData donationsData) {
    final data = <DonationsChartData>[];

    for (final don in donationsData.donations.keys) {
      data.add(DonationsChartData(don + donationsData.currency, donationsData.donations[don]!));
    }

    String? getCallbackLabel(DonationsChartData row, _) {
      return row.amount;
    }

    String? getCallback(DonationsChartData row, _) {
      return '${row.amount} (${row.total} dons)';
    }

    return <PieSeries<DonationsChartData, String>>[
      PieSeries(
        dataSource: data,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        enableTooltip: true,
        explode: true,
        explodeIndex: 4,
        explodeOffset: '10%',
        xValueMapper: getCallback,
        yValueMapper: (DonationsChartData data, _) => data.total,
        // Set a label accessor to control the text of the arc label.
        dataLabelMapper: getCallbackLabel,
      )
    ];
  }

  Future<void> getDonations() async {
    isLoading = true;
    notifyListeners();
    try {
      final results = await _adminApi.getDonations();
      currentChart = _manageDonationsChart(results.data!.current);
      previousChart = _manageDonationsChart(results.data!.previous);
      _manageAmountsChart(results.data!);
      isLoading = false;
      notifyListeners();
    } catch (error) {
      isLoading = false;
      notifyListeners();
    }
  }
}
