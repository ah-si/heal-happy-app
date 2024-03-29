import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:intl/intl.dart';

final availabilitiesStoreProvider =
    ChangeNotifierProvider.family<AvailabilitiesStore, StoreInfo>((_, info) => AvailabilitiesStore(info.id, eventType: info.eventType, mobileFormat: info.mobileFormat));

class StoreInfo {
  final String id;
  final HealerEventType eventType;
  final bool mobileFormat;

  StoreInfo(this.id, this.eventType, this.mobileFormat);
}

class SlotInfo {
  final String label;
  final String? roomId;
  final DateTime dateTime;

  SlotInfo(this.label, this.dateTime, this.roomId);
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
  static final _uiFormat = DateFormat('EEEE\ndd MMM');
  static final _mobileUiFormat = DateFormat('EEE\ndd MMM');
  AvailabilitiesResults? availabilities;
  bool isLoading = false;
  DateTime? _from;
  int currentPage = 0;
  final String healerId;
  final HealerEventType eventType;
  final bool mobileFormat;

  AvailabilitiesStore(this.healerId, {required this.eventType, UserApi? userApi, this.mobileFormat = false}) : _userApi = BackendApiProvider().api.getUserApi() {
    getAvailabilitiesHealers();
  }

  Future<void> createEvent(String patientId, String? roomId, HealerEventType type, DateTime slot, String message, bool isUrgent) async {
    try {
      await _userApi.createEvent(
          id: healerId,
          createEventRequest: CreateEventRequest((b) {
            b.patientId = patientId;
            b.slot = slot.toUtc();
            b.roomId = roomId;
            b.type = type;
            b.isUrgent = isUrgent;
            b.message = message;
          }));
    } on DioError catch(err) {
      if (err.response?.statusCode == 403 && err.response!.data!.toString().contains('patient_blocked')) {
        throw ErrorResultException(ErrorResult.accountBlocked);
      }
      rethrow;
    }
    getAvailabilitiesHealers();
  }

  Future<void> nextAvailabilitiesHealers() async {
    if (currentPage < 1) {
      currentPage++;
      await getAvailabilitiesHealers();
    }
  }

  Future<void> previousAvailabilitiesHealers() async {
    if (currentPage > 0) {
      currentPage--;
      await getAvailabilitiesHealers();
    }
  }

  Future<void> getAvailabilitiesHealers() async {
    isLoading = true;
    notifyListeners();

    final date = DateTime.now();
    _from = DateTime(date.year, date.month, date.day).add(Duration(days: currentPage * 7));

    try {
      final results = await _userApi.getHealerAvailabilities(id: healerId, type: eventType, from: _from!.toUtc());
      final slots = results.data!.slots;
      final Map<String, List<SlotInfo>> dates = {};
      // hide all available slots that are before now + 1 hour
      final now = DateTime.now().add(const Duration(hours: 1));
      for (var i = 0; i < 7; i++) {
        final date = DateTime.fromMillisecondsSinceEpoch(_from!.millisecondsSinceEpoch).add(Duration(days: i));
        final dateStr = (mobileFormat ? _mobileUiFormat : _uiFormat).format(date);
        dates[dateStr] = [];
      }
      for (var info in slots) {
        for (var slot in info.slots) {
          final localDate = slot.toLocal();
          if (now.isAfter(localDate)) {
            continue;
          }
          final date = (mobileFormat ? _mobileUiFormat : _uiFormat).format(localDate);
          dates[date]?.add(SlotInfo(kHourFormat.format(localDate), localDate, info.roomId));
        }
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
