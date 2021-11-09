import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final adminDashboardStoreProvider = ChangeNotifierProvider((_) => AdminDashboardStore());

enum DashboardDataEnum {
  admin,
  healerVerified,
  healerToVerify,
  patientActivated,
  patientNonActivated,
}

class DashboardData {
  final DashboardDataEnum type;
  final int total;

  DashboardData(this.type, this.total);
}

class AdminDashboardStore extends ChangeNotifier {
  final AdminApi _adminApi;
  List<CircularSeries<DashboardData, String>>? dashboard;
  bool isLoading = false;

  AdminDashboardStore({AdminApi? adminApi}) : _adminApi = BackendApiProvider().api.getAdminApi();

  Future<void> getDashboard() async {
    isLoading = true;
    notifyListeners();
    try {
      final results = await _adminApi.getDashboard();
      final admins = results.data!.users.where((p0) => p0.type == UserTypeEnum.admin);
      final data = <DashboardData>[];
      int total = 0;
      for (final admin in admins) {
        total += admin.total;
      }
      data.add(DashboardData(DashboardDataEnum.admin, total));

      final patients = results.data!.users.where((p0) => p0.type == UserTypeEnum.patient);

      int totalActivated = 0;
      int totalNonActivated = 0;
      for (final patient in patients) {
        if (patient.isActivated) {
          totalActivated += patient.total;
        } else {
          totalNonActivated += patient.total;
        }
      }
      data.add(DashboardData(DashboardDataEnum.patientActivated, totalActivated));
      data.add(DashboardData(DashboardDataEnum.patientNonActivated, totalNonActivated));

      final healers = results.data!.users.where((p0) => p0.type == UserTypeEnum.healer);

      int totalVerified = 0;
      int totalToVerify = 0;
      for (final healer in healers) {
        if (healer.isVerified) {
          totalVerified += healer.total;
        } else {
          totalToVerify += healer.total;
        }
      }
      data.add(DashboardData(DashboardDataEnum.healerVerified, totalVerified));
      data.add(DashboardData(DashboardDataEnum.healerToVerify, totalToVerify));
      dashboard = [
        PieSeries(
          dataSource: data,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          enableTooltip: true,
          explode: true,
          explodeIndex: 4,
          explodeOffset: '10%',
          xValueMapper: getCallback,
          yValueMapper: (DashboardData data, _) => data.total,
          // Set a label accessor to control the text of the arc label.
          dataLabelMapper: getCallback,
        )
      ];
      isLoading = false;
      notifyListeners();
    } catch (error) {
      isLoading = false;
      notifyListeners();
    }
  }

  String? getCallback(DashboardData row, _) {
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
}
