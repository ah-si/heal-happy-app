

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final healerStoreProvider = ChangeNotifierProvider((_) => HealerStore());

class PatientEventResults {
  final List<UserEvent> events;
  final ErrorResultException? error;

  PatientEventResults(this.events, {this.error});
}

enum HomeTabs {
  home, profile, history, help
}

class HealerStore extends ChangeNotifier {
  final UserApi _userApi;
  PatientEventResults? eventsResults;
  bool isLoading = false;
  HomeTabs _selectedTab = HomeTabs.home;

  HealerStore({UserApi? userApi}): _userApi = BackendApiProvider().api.getUserApi();

  HomeTabs get selectedTab => _selectedTab;
  set selectedTab(HomeTabs value) {
    if (_selectedTab != value) {
      _selectedTab = value;
      notifyListeners();
    }
  }

  Future<void> cancelEvent(String eventId) async {
    await _userApi.deleteEvent(eventId:eventId);
    loadEvents(false);
  }

  Future<void> loadEvents(bool showHistory) async {
    isLoading = true;
    try {
      final events = await _userApi.getEvents(includePastEvents: showHistory);
      eventsResults = PatientEventResults(events.data!.toList());
      isLoading = false;
      notifyListeners();
    } catch(error, stackTrace) {
      eventsResults = PatientEventResults([], error: handleError(error, stackTrace));
      isLoading = false;
      notifyListeners();
    }
  }
}
