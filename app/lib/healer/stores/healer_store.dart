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

enum HomeTabs { home, profile, history, help }

class HealerStore extends ChangeNotifier {
  final UserApi _userApi;
  PatientEventResults? eventsResults;
  bool isLoading = false;
  bool _seeOnlyUrgency = false;
  int eventUrgent = 0;
  HomeTabs _selectedTab = HomeTabs.home;

  HealerStore({UserApi? userApi}) : _userApi = BackendApiProvider().api.getUserApi();

  bool get seeOnlyUrgency => _seeOnlyUrgency;

  set seeOnlyUrgency(bool value) {
    _seeOnlyUrgency = value;
    notifyListeners();
  }

  HomeTabs get selectedTab => _selectedTab;

  set selectedTab(HomeTabs value) {
    if (_selectedTab != value) {
      _selectedTab = value;
      notifyListeners();
    }
  }

  Future<void> cancelEvent(String eventId, String message) async {
    await _userApi.deleteEvent(eventId: eventId, deleteEventRequest: DeleteEventRequest((b) => b.message = message));
    await loadEvents(false);
  }

  Future<void> loadEvents(bool showHistory) async {
    isLoading = true;
    try {
      final events = await _userApi.getEvents(includePastEvents: showHistory);
      eventUrgent = events.data!.where((p0) => p0.isUrgent).length;
      eventsResults = PatientEventResults(events.data!.toList());
      isLoading = false;
      notifyListeners();
    } catch (error, stackTrace) {
      eventUrgent = 0;
      eventsResults = PatientEventResults([], error: handleError(error, stackTrace));
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateEvent(UserEvent event, DateTime date, String? message) async {
    final updatedEvent = await _userApi.updateEvent(eventId: event.id, updateEventRequest: UpdateEventRequest((b) {
      b.start = date.toUtc();
      b.message = message;
    }));
    final index = eventsResults!.events.indexOf(event);
    if (date.isBefore(DateTime.now())) {
      eventsResults = PatientEventResults(List.from(eventsResults!.events)
        ..removeAt(index));
    } else {
      eventsResults = PatientEventResults(List.from(eventsResults!.events)
        ..replaceRange(index, index + 1, [updatedEvent.data!]));
    }
    notifyListeners();
  }
}
