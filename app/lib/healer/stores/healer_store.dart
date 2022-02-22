import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final healerStoreProvider = ChangeNotifierProvider((_) => HealerStore());

class PatientEventResults {
  final List<UserEvent> events;
  final ErrorResultException? error;

  PatientEventResults(this.events, {this.error});
}

enum HomeTabs { home, profile, help }

class HealerStore extends ChangeNotifier {
  final UserApi _userApi;
  PatientEventResults? eventsResults;
  bool isLoading = false;
  int eventUrgent = 0;
  int eventCancelled = 0;
  HomeTabs _selectedTab = HomeTabs.home;

  HealerStore({UserApi? userApi}) : _userApi = BackendApiProvider().api.getUserApi();

  HomeTabs get selectedTab => _selectedTab;

  set selectedTab(HomeTabs value) {
    if (_selectedTab != value) {
      _selectedTab = value;
      notifyListeners();
    }
  }

  Future<void> cancelEvent(String eventId, String message) async {
    await _userApi.deleteEvent(eventId: eventId, deleteEventRequest: DeleteEventRequest((b) => b.message = message));
    await loadEvents();
  }

  Future<void> loadEvents() async {
    isLoading = true;
    try {
      final events = await _userApi.getEvents(includePastEvents: true);
      eventUrgent = events.data!.where((p0) => p0.isUrgent && !p0.isCancelled).length;
      eventCancelled = events.data!.where((p0) => p0.isCancelled).length;
      eventsResults = PatientEventResults(events.data!.toList());
      isLoading = false;
      notifyListeners();
    } catch (error, stackTrace) {
      eventUrgent = 0;
      eventCancelled = 0;
      eventsResults = PatientEventResults([], error: handleError(error, stackTrace));
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateEvent(UserEvent event, DateTime date, String? message) async {
    try {
      final updatedEvent = await _userApi.updateEvent(
          eventId: event.id,
          updateEventRequest: UpdateEventRequest((b) {
            b.start = date.toUtc();
            b.message = message;
          }));
      final index = eventsResults!.events.indexOf(event);
      if (date.isBefore(DateTime.now())) {
        eventsResults = PatientEventResults(List.from(eventsResults!.events)..removeAt(index));
      } else {
        eventsResults = PatientEventResults(List.from(eventsResults!.events)..replaceRange(index, index + 1, [updatedEvent.data!]));
      }
    } on DioError catch (error) {
      if (error.response?.statusCode == 403 && error.response!.data!.toString().contains('healer_already_booked')) {
        throw ErrorResultException(ErrorResult.meetingAlreadyBooked);
      } else if (error.response?.statusCode == 403 && error.response!.data!.toString().contains('patient_slot_taken')) {
        throw ErrorResultException(ErrorResult.healerPatientAlreadyBusy);
      }
    }
    notifyListeners();
  }

  Future<void> createEvent(
    String userId,
    HealerEventType type,
    DateTime date,
    String email,
    String mobile,
    String firstName,
    String lastName,
    String message,
  ) async {
    try {
      await _userApi.createInviteEvent(
          id: userId,
          createInviteEventRequest: CreateInviteEventRequest((b) {
            b.message = message;
            b.email = email;
            if (!mobile.isNullOrEmpty) {
              b.mobile = mobile;
              b.firstName = firstName;
              b.lastName = lastName;
            }
            b.slot = date.toUtc();
            b.type = type;
          }));
    } on DioError catch (ex) {
      if (ex.response?.statusCode == 404) {
        throw ErrorResultException(ErrorResult.noUser);
      } else if (ex.response?.statusCode == 403 && ex.response!.data!.toString().contains('meeting_exist_already')) {
        throw ErrorResultException(ErrorResult.healerMeetingAlreadyExist);
      } else if (ex.response?.statusCode == 403 && ex.response!.data!.toString().contains('patient_slot_taken')) {
        throw ErrorResultException(ErrorResult.healerPatientAlreadyBusy);
      }
      rethrow;
    }
    await loadEvents();
  }
}
