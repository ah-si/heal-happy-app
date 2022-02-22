import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final adminOfficeStoreProvider = ChangeNotifierProvider((_) => AdminOfficeStore());

class OfficeResults {
  final List<Office> offices;
  final int totalPages;
  final int currentPage;
  final ErrorResultException? error;

  OfficeResults(this.offices, this.currentPage, this.totalPages, {this.error});
}

class AdminOfficeStore extends ChangeNotifier {
  final OfficesApi _officesApi;
  final UserApi _userApi;
  OfficeResults? results;
  bool isLoading = false;

  AdminOfficeStore({OfficesApi? officesApi, UserApi? userApi})
      : _officesApi = officesApi ?? BackendApiProvider().api.getOfficesApi(),
        _userApi = userApi ?? BackendApiProvider().api.getUserApi();

  void loadOfficesPage(int selectedPage) {}

  void loadOffices(int page) async {
    try {
      final resultsRequest = await _officesApi.getOffices();
      results = OfficeResults(resultsRequest.data!.offices.toList(growable: false), page, resultsRequest.data!.totalPages);
    } catch (error, stackTrace) {
      results = OfficeResults([], page, 0, error: handleError(error, stackTrace));
      isLoading = false;
    }
    notifyListeners();
  }
}
