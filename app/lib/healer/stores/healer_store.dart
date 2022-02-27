import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:logging/logging.dart';

final healerStoreProvider = ChangeNotifierProvider((_) => HealerStore()..loadOffices());

class PatientEventResults {
  final List<UserEvent> events;
  final ErrorResultException? error;

  PatientEventResults(this.events, {this.error});
}

enum HomeTabs { home, profile, help }

class HealerRoom {
  final OfficeRoom room;
  final Office office;

  HealerRoom(this.room, this.office);
}

class HealerStore extends ChangeNotifier {
  final _logger = Logger('HealerStore');
  final UserApi _userApi;
  final OfficesApi _officeApi;
  PatientEventResults? eventsResults;
  List<HealerRoom> rooms = [];
  bool isLoading = false;
  int eventUrgent = 0;
  int eventCancelled = 0;
  HomeTabs _selectedTab = HomeTabs.home;

  HealerStore({UserApi? userApi, OfficesApi? officeApi})
      : _officeApi = officeApi ?? BackendApiProvider().api.getOfficesApi(),
        _userApi = userApi ?? BackendApiProvider().api.getUserApi();

  HomeTabs get selectedTab => _selectedTab;

  set selectedTab(HomeTabs value) {
    if (_selectedTab != value) {
      _selectedTab = value;
      notifyListeners();
    }
  }

  Future<void> loadOffices() async {
    try {
      final officesResult = await _officeApi.getOffices();
      final rooms = <HealerRoom>[];
      for (var office in officesResult.data!.offices) {
        for (var room in office.rooms) {
          rooms.add(HealerRoom(room, office));
        }
      }
      this.rooms = rooms;
    } catch (ex, stack) {
      rooms = [];
      _logger.severe('Can\'t retrieve offices, $ex', ex, stack);
    }

  }

  Future<void> cancelEvent(String eventId, String message) async {
    await _userApi.deleteEvent(eventId: eventId, deleteEventRequest: DeleteEventRequest((b) => b.message = message));
    await loadEvents();
  }

  Future<void> loadEvents() async {
    isLoading = true;
    if (rooms.isEmpty) {
      await loadOffices();
    }
    try {
      final events = await _userApi.getEvents(includePastEvents: true, modeHealer: true);
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
    String? roomId,
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
            b.roomId = roomId;
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
