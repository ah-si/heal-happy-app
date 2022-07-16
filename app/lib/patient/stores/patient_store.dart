import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final patientStoreProvider = ChangeNotifierProvider((_) => PatientStore());

class SearchResults {
  final List<Healer> healers;
  final int totalPages;
  final int currentPage;
  final ErrorResultException? error;

  SearchResults(this.healers, this.currentPage, this.totalPages, {this.error});
}

class PatientEventResults {
  final List<UserEvent> events;
  final ErrorResultException? error;

  PatientEventResults(this.events, {this.error});
}

enum HomeTabs { home, search, profile, history }

class PatientStore extends ChangeNotifier {
  final UserApi _userApi;
  SearchResults? searchResults;
  PatientEventResults? eventsResults;
  Map<String, String> specialities = {};
  Map<String, String> localities = {};
  bool isLoading = false;
  String? _lastJobSearch;
  String? _lastLocalizationSearch;
  HealerEventType lastTypeSearch = HealerEventType.visio;
  HomeTabs _selectedTab = HomeTabs.home;

  PatientStore({UserApi? userApi}) : _userApi = BackendApiProvider().api.getUserApi();

  String get lastJobSearch => _lastJobSearch ?? '';

  HomeTabs get selectedTab => _selectedTab;

  set selectedTab(HomeTabs value) {
    if (_selectedTab != value) {
      _selectedTab = value;
      notifyListeners();
    }
  }

  Future<Map<String, String>> getSpecialities() async {
    if (specialities.isEmpty) {
      final spe = await _userApi.getSpecialities(onlyExisting: true);
      specialities = spe.data!.toMap();
    }
    return specialities;
  }

  Future<void> loadHealersPage(int page) async {
    return searchHealers(_lastJobSearch!, lastTypeSearch, _lastLocalizationSearch, page);
  }

  bool _isNewSearch(String job, HealerEventType type, String? localization) {
    return searchResults?.healers == null || job != _lastJobSearch || lastTypeSearch != type || _lastLocalizationSearch != localization;
  }

  Future<void> searchHealers(String job, HealerEventType type, String? localization, int page) async {
    final isNewSearch = _isNewSearch(job, type, localization) || page == 0;
    isLoading = isNewSearch;
    _selectedTab = HomeTabs.search;
    notifyListeners();
    try {
      final pageToLoad = page;
      final results = await _userApi.searchHealers(job: job, localization: localization, page: pageToLoad, type: type);
      if (isNewSearch) {
        searchResults = SearchResults(results.data?.healers.toList() ?? [], pageToLoad, results.data?.totalPages ?? 0);
      } else {
        searchResults = SearchResults(List.from(searchResults!.healers)..addAll(results.data?.healers.toList() ?? []), pageToLoad, results.data?.totalPages ?? 0);
      }
      isLoading = false;
      _lastJobSearch = job;
      lastTypeSearch = type;
      _lastLocalizationSearch = localization;
      notifyListeners();
    } catch (error, stackTrace) {
      if (isNewSearch) {
        searchResults = SearchResults([], 0, 0, error: handleError(error, stackTrace));
      } else {
        searchResults = SearchResults(searchResults!.healers, 0, 0, error: handleError(error, stackTrace));
      }
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cancelEvent(String eventId, String message) async {
    await _userApi.deleteEvent(eventId: eventId, deleteEventRequest: DeleteEventRequest((b) => b.message = message));
    loadEvents(false);
  }

  Future<void> loadEvents(bool showHistory) async {
    isLoading = true;
    try {
      final events = await _userApi.getEvents(includePastEvents: showHistory, modeHealer: false);
      eventsResults = PatientEventResults(events.data!.toList());
      isLoading = false;
      notifyListeners();
    } catch (error, stackTrace) {
      eventsResults = PatientEventResults([], error: handleError(error, stackTrace));
      isLoading = false;
      notifyListeners();
    }
  }

  void searchLocalities(String spe) async {
    final loc = await _userApi.getLocalities(job: spe);
    localities = loc.data!.toMap();
    notifyListeners();
  }
}
