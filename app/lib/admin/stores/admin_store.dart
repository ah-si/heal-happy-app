import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final adminStoreProvider = ChangeNotifierProvider((_) => AdminStore());

class SearchResults {
  final List<User> healers;
  final ErrorResultException? error;

  SearchResults(this.healers, {this.error});
}

enum HomeTabs { home }

class AdminStore extends ChangeNotifier {
  final AdminApi _adminApi;
  SearchResults? searchResults;
  bool isLoading = false;
  HomeTabs _selectedTab = HomeTabs.home;

  AdminStore({AdminApi? adminApi}) : _adminApi = BackendApiProvider().api.getAdminApi() {
    searchHealers();
  }

  HomeTabs get selectedTab => _selectedTab;

  set selectedTab(HomeTabs value) {
    if (_selectedTab != value) {
      _selectedTab = value;
      notifyListeners();
    }
  }

  Future<void> searchHealers() async {
    isLoading = true;
    notifyListeners();
    try {
      final results = await _adminApi.getPendingHealer();
      searchResults = SearchResults(results.data?.toList() ?? []);
      isLoading = false;
      notifyListeners();
    } catch (error, stackTrace) {
      searchResults = SearchResults([], error: handleError(error, stackTrace));
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> validateHealer(User healer) async {
    await _adminApi.verifyUser(id: healer.id!);
    searchResults = SearchResults(searchResults!.healers..remove(healer));
    notifyListeners();
  }

  Future<void> deleteHealer(User healer) async {
    await _adminApi.deleteUser(id: healer.id!);
    searchResults = SearchResults(searchResults!.healers..remove(healer));
    notifyListeners();
  }
}