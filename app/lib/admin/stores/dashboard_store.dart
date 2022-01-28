import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final adminDashboardStoreProvider = ChangeNotifierProvider((_) => AdminDashboardStore());

enum DashboardDataEnum {
  admin,
  healerVerified,
  healerToVerify,
  patientActivated,
  patientNonActivated,
}

class UsersChartData {
  final DashboardDataEnum type;
  final int total;

  UsersChartData(this.type, this.total);
}

class EventsChartData {
  final int month;
  final int year;
  final int total;

  EventsChartData(this.month, this.year, this.total);
}

class AdminDashboardStore extends ChangeNotifier {
  final AdminApi _adminApi;
  final SettingsApi _settingsApi;
  List<CircularSeries<UsersChartData, String>>? usersChart;
  List<ColumnSeries<EventsChartData, String>>? eventsChart;
  bool isLoading = false;

  AdminDashboardStore({AdminApi? adminApi, SettingsApi? settingsApi}) :
        _adminApi = adminApi ?? BackendApiProvider().api.getAdminApi(),
        _settingsApi = settingsApi ?? BackendApiProvider().api.getSettingsApi();

  Future<void> updateSettings(bool enableUrgency) async {
    await _settingsApi.updateSettings(appSettings: AppSettings((b) => b.enableUrgencyButton = enableUrgency));
  }

  void _manageEventsChart(Dashboard dashboard) async {
    final eventsData = dashboard.events.where((p0) => !p0.isCancelled && !p0.isUrgent).toList();
    final canceledEventsData = dashboard.events.where((p0) => p0.isCancelled).toList();
    final urgentEventsData = dashboard.events.where((p0) => !p0.isCancelled && p0.isUrgent).toList();
    final _uiFormat = DateFormat('MMM');
    final year = Date.now().year;
    String? getCallback(EventsChartData row, _) {
      final _date = DateTime(year, row.month, 1);
      return _uiFormat.format(_date);
    }

    String? getCallbackLabel(EventsChartData row, _) {
      return row.total.toString();
    }

    eventsChart = [
      ColumnSeries(
        legendItemText: 'Normales',
        dataSource: eventsData.reversed.map((p0) => EventsChartData(p0.month, p0.year, p0.total)).toList(),
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        enableTooltip: true,
        xValueMapper: getCallback,
        yValueMapper: (EventsChartData data, _) => data.total,
        // Set a label accessor to control the text of the bar label.
        dataLabelMapper: getCallbackLabel,
      ),
      ColumnSeries(
        legendItemText: 'Annulées',
        dataSource: canceledEventsData.reversed.map((p0) => EventsChartData(p0.month, p0.year, p0.total)).toList(),
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        enableTooltip: true,
        xValueMapper: getCallback,
        yValueMapper: (EventsChartData data, _) => data.total,
        // Set a label accessor to control the text of the bar label.
        dataLabelMapper: getCallbackLabel,
      ),
      ColumnSeries(
        legendItemText: 'Urgentes',
        dataSource: urgentEventsData.reversed.map((p0) => EventsChartData(p0.month, p0.year, p0.total)).toList(),
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        enableTooltip: true,
        xValueMapper: getCallback,
        yValueMapper: (EventsChartData data, _) => data.total,
        // Set a label accessor to control the text of the bar label.
        dataLabelMapper: getCallbackLabel,
      ),
    ];
  }

  void _manageUsersChart(Dashboard dashboard) async {
    final admins = dashboard.users.where((p0) => p0.type == UserTypeEnum.admin);
    final data = <UsersChartData>[];
    int total = 0;
    for (final admin in admins) {
      total += admin.total;
    }
    data.add(UsersChartData(DashboardDataEnum.admin, total));

    final patients = dashboard.users.where((p0) => p0.type == UserTypeEnum.patient);

    int totalActivated = 0;
    int totalNonActivated = 0;
    for (final patient in patients) {
      if (patient.isActivated) {
        totalActivated += patient.total;
      } else {
        totalNonActivated += patient.total;
      }
    }
    data.add(UsersChartData(DashboardDataEnum.patientActivated, totalActivated));
    data.add(UsersChartData(DashboardDataEnum.patientNonActivated, totalNonActivated));

    final healers = dashboard.users.where((p0) => p0.type == UserTypeEnum.healer);

    int totalVerified = 0;
    int totalToVerify = 0;
    for (final healer in healers) {
      if (healer.isVerified) {
        totalVerified += healer.total;
      } else {
        totalToVerify += healer.total;
      }
    }
    data.add(UsersChartData(DashboardDataEnum.healerVerified, totalVerified));
    data.add(UsersChartData(DashboardDataEnum.healerToVerify, totalToVerify));

    String? getCallback(UsersChartData row, _) {
      switch (row.type) {
        case DashboardDataEnum.admin:
          return '${row.total} Admin';
        case DashboardDataEnum.healerVerified:
          return '${row.total} Soignants vérifiés';
        case DashboardDataEnum.healerToVerify:
          return '${row.total} Soignants à vérifier';
        case DashboardDataEnum.patientActivated:
          return '${row.total} Patients actif';
        case DashboardDataEnum.patientNonActivated:
          return '${row.total} Patients inactif';
      }
    }

    usersChart = [
      PieSeries(
        dataSource: data,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        enableTooltip: true,
        explode: true,
        explodeIndex: 4,
        explodeOffset: '10%',
        xValueMapper: getCallback,
        yValueMapper: (UsersChartData data, _) => data.total,
        // Set a label accessor to control the text of the arc label.
        dataLabelMapper: getCallback,
      )
    ];
  }

  Future<void> getDashboard() async {
    isLoading = true;
    notifyListeners();
    try {
      final results = await _adminApi.getDashboard();
      _manageUsersChart(results.data!);
      _manageEventsChart(results.data!);
      isLoading = false;
      notifyListeners();
    } catch (error) {
      isLoading = false;
      notifyListeners();
    }
  }
}
