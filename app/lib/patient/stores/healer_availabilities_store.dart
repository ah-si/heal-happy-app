import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:intl/intl.dart';

final availabilitiesStoreProvider = ChangeNotifierProvider.family<AvailabilitiesStore, StoreInfo>((_, info) => AvailabilitiesStore(info.id, mobileFormat: info.mobileFormat));

class StoreInfo {
  final String id;
  final bool mobileFormat;

  StoreInfo(this.id, this.mobileFormat);
}

class SlotInfo {
  final String label;
  final DateTime dateTime;

  SlotInfo(this.label, this.dateTime);
}

class DaySlots {
  final String date;
  final List<SlotInfo> slots;

  DaySlots(this.date, this.slots);
}

class AvailabilitiesResults {
  final List<DaySlots> slots;
  final ErrorResultException? error;

  AvailabilitiesResults(this.slots, {this.error});
}

class AvailabilitiesStore extends ChangeNotifier {
  final UserApi _userApi;
  static final _hourFormat = DateFormat('HH:mm');
  static final _uiFormat = DateFormat('EEEE\ndd MMM');
  static final _mobileUiFormat = DateFormat('EEE\ndd MMM');
  AvailabilitiesResults? availabilities;
  bool isLoading = false;
  DateTime? _from;
  final String healerId;
  final bool mobileFormat;

  AvailabilitiesStore(this.healerId, {UserApi? userApi, this.mobileFormat=false}) : _userApi = BackendApiProvider().api.getUserApi() {
    getAvailabilitiesHealers();
  }

  Future<void> createEvent(String patientId, DateTime slot, String message, bool isUrgent) async {
    try {
      await _userApi.createEvent(id: healerId, createEventRequest: CreateEventRequest((b) {
        b.patientId = patientId;
        b.slot = slot.toUtc();
        b.isUrgent = isUrgent;
        b.message = message;
      }));
    } on DioError catch(ex) {
      if (ex.response?.statusCode == 403 && ex.response!.data!.toString().contains('meeting_exist_already')) {
        throw ErrorResultException(ErrorResult.meetingAlreadyExist);
      } else if (ex.response?.statusCode == 403 && ex.response!.data!.toString().contains('account_not_activated')) {
        throw ErrorResultException(ErrorResult.accountNotActivated);
      } else if (ex.response?.statusCode == 403 && ex.response!.data!.toString().contains('no_past_event')) {
        throw ErrorResultException(ErrorResult.noPastEvent);
      } else if (ex.response?.statusCode == 400 && ex.response!.data!.toString().contains('slot_taken')) {
        throw ErrorResultException(ErrorResult.meetingAlreadyBooked);
      }
      rethrow;
    }
    getAvailabilitiesHealers();
  }

  //TODO manage to navigate between date from
  Future<void> getAvailabilitiesHealers() async {
    isLoading = true;
    notifyListeners();

    if (_from == null) {
      _from = DateTime.now();
    } else {
      _from!.add(const Duration(days: -7));
    }
    try {
      final results = await _userApi.getHealerAvailabilities(id: healerId, from: _from!.toUtc());
      final slots = results.data!.slots;
      final Map<String, List<SlotInfo>> dates = {};
      // hide all available slots that are before now + 1 hour
      final now = DateTime.now().add(const Duration(hours: 1));
      for (var i = 0; i<7; i++) {
        final date = DateTime.fromMillisecondsSinceEpoch(_from!.millisecondsSinceEpoch).add(Duration(days: i));
        final dateStr = (mobileFormat ? _mobileUiFormat : _uiFormat).format(date);
        dates[dateStr] = [];
      }
      for (var slot in slots) {
        if (now.isAfter(slot.toLocal())) {
          continue;
        }
        final date = (mobileFormat ? _mobileUiFormat : _uiFormat).format(slot.toLocal());
        dates[date]!.add(SlotInfo(_hourFormat.format(slot.toLocal()), slot.toLocal()));
      }
      availabilities = AvailabilitiesResults(dates.keys.map((e) => DaySlots(e, dates[e] ?? [])).toList(growable: false));
      isLoading = false;
      notifyListeners();
    } catch (error, stackTrace) {
      availabilities = AvailabilitiesResults([], error: handleError(error, stackTrace));
      isLoading = false;
      notifyListeners();
    }
  }
}
