import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final adminHealerStatsStoreProvider = ChangeNotifierProvider((_) => AdminHealerStatsStore());

class StatsResults {
  final List<HealerStats> stats;
  final ErrorResultException? error;

  StatsResults(this.stats, {this.error});
}

class AdminHealerStatsStore extends ChangeNotifier {
  final AdminApi _adminApi;
  StatsResults? results;
  bool isLoading = false;

  AdminHealerStatsStore({AdminApi? adminApi}) : _adminApi = BackendApiProvider().api.getAdminApi();

  Future<void> getStats(DateTime start, DateTime end) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _adminApi.getHealerStats(start: start.toDate(), end: end.toDate());
      results = StatsResults(response.data!.toList()..sort((a, b) => a.totalDuration.compareTo(b.totalDuration)));
      isLoading = false;
      notifyListeners();
    } catch (error, stackTrace) {
      results = StatsResults([], error: handleError(error, stackTrace));
      isLoading = false;
      notifyListeners();
    }
  }

}
