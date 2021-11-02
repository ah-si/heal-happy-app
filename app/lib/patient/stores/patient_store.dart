
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final patientStoreProvider = ChangeNotifierProvider((_) => PatientStore());

class SearchResults {
  final List<Healer> healers;
  final ErrorResultException? error;

  SearchResults(this.healers, {this.error});
}

class PatientStore extends ChangeNotifier {
  final UserApi _userApi;
  SearchResults? searchResults;
  bool isLoading = false;

  PatientStore({UserApi? userApi}): _userApi = BackendApiProvider().api.getUserApi();

  Future<void> searchHealers(String job, String localization) async {
    isLoading = true;
    notifyListeners();
    try {
      final results = await _userApi.searchHealers(job: job, localization: localization);
      searchResults = SearchResults(results.data?.toList() ?? []);
      isLoading = false;
      notifyListeners();
    } catch(error, stackTrace) {
      searchResults = SearchResults([], error: handleError(error, stackTrace));
      isLoading = false;
      notifyListeners();
    }
  }
}
