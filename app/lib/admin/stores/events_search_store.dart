import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final adminEventsSearchStoreProvider = ChangeNotifierProvider((_) => AdminEventsSearchStore());

class SearchResults {
  final List<AdminUserEvent> events;
  final int totalPages;
  final int currentPage;
  final ErrorResultException? error;

  SearchResults(this.events, this.currentPage, this.totalPages, {this.error});
}

class AdminEventsSearchStore extends ChangeNotifier {
  final AdminApi _adminApi;
  final UserApi _userApi;
  SearchResults? searchResults;
  bool isLoading = false;
  late DateTime _start;
  late DateTime _end;
  bool? _isUrgent;
  bool? _isCancelled;

  AdminEventsSearchStore({AdminApi? adminApi, UserApi? userApi})
      : _adminApi = adminApi ?? BackendApiProvider().api.getAdminApi(),
        _userApi = userApi ?? BackendApiProvider().api.getUserApi();

  Future<void> loadEventsPage(int page) async {
    return getEvents(page, _start, _end, _isUrgent, _isCancelled);
  }

  Future<void> getEvents(int page, DateTime start, DateTime end, bool? isUrgent, bool? isCancelled) async {
    isLoading = true;
    _start = start;
    _end = end;
    _isUrgent = isUrgent;
    _isCancelled = isCancelled;
    notifyListeners();
    try {
      final results = await _adminApi.searchEvents(
        start: start.toDate(),
        end: end.toDate(),
        isCancelled: isCancelled,
        isUrgent: isUrgent,
      );
      searchResults = SearchResults(results.data!.events.toList(), page, results.data!.totalPages);
      isLoading = false;
      notifyListeners();
    } catch (error, stackTrace) {
      searchResults = SearchResults([], page, 0, error: handleError(error, stackTrace));
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cancelEvent(String eventId, String message) async {
    await _userApi.deleteEvent(eventId: eventId, deleteEventRequest: DeleteEventRequest((b) => b.message = message));
  }

  Future<void> updateEvent(AdminUserEvent event, DateTime date, String? message) async {
    await _userApi.updateEvent(
        eventId: event.id,
        updateEventRequest: UpdateEventRequest((b) {
          b.start = date.toUtc();
          b.message = message;
        }));
    loadEventsPage(searchResults!.currentPage);
  }
}
