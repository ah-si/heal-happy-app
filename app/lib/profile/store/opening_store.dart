import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final openingStoreProvider = ChangeNotifierProvider.family<OpeningStore, String?>((_, id) => OpeningStore(userId: id));

class OpeningResults {
  final List<HealerOpening> slots;
  final ErrorResultException? error;

  OpeningResults(this.slots, {this.error});
}

class OpeningStore extends ChangeNotifier {
  final UserApi _userApi;
  final String? _userId;
  bool isInMedicalOffice = false;
  bool _showExternalOpenings = true;
  bool get showExternalOpenings => _showExternalOpenings;
  OpeningResults? _results;
  OpeningResults? results;

  OpeningStore({UserApi? userApi, String? userId})
      : _userId = userId,
        _userApi = BackendApiProvider().api.getUserApi();

  void filterOpenings(bool showExternalOpenings) {
    if (_results != null) {
      _showExternalOpenings = showExternalOpenings;
      if (_results?.error == null && !showExternalOpenings) {
        results = OpeningResults(_results!.slots.where((element) => element.user == null).toList(growable: false));
      } else {
        results = _results;
      }
      notifyListeners();
    }
  }

  Future<void> loadOpenings() async {
    try {
      if (_userId == null) {
        final openings = await _userApi.getOpenings();
        _results = OpeningResults(openings.data!.toList());
      } else {
        final openings = await _userApi.getUserOpenings(userId: _userId!);
        _results = OpeningResults(openings.data!.toList());
      }

      isInMedicalOffice = false;

      for (var element in _results!.slots) {
        if (element.roomId != null) {
          isInMedicalOffice = true;
        }
      }

    } catch (error, stackTrace) {
      _results = OpeningResults([], error: handleError(error, stackTrace));
      isInMedicalOffice = false;
    }
    filterOpenings(_showExternalOpenings);
  }

  Future<void> createOpening(
    String userId,
    OpeningType type,
    String? roomId,
    OpeningRepeatType? repeat,
    DateTime start,
    DateTime end,
  ) async {
    final opening = HealerOpening((b) {
      b.repeat = repeat;
      b.userId = _userId ?? userId;
      b.roomId = roomId;
      b.start = start.toUtc();
      b.type = type;
      b.end = end.toUtc();
    });
    if (_userId == null) {
      await _userApi.createOpening(healerOpening: opening);
    } else {
      await _userApi.createUserOpening(healerOpening: opening, userId: _userId!);
    }
    await loadOpenings();
  }

  Future<void> updateOpening(HealerOpening opening) async {
    if (_userId == null) {
      await _userApi.updateOpening(healerOpening: opening, openingId: opening.id!);
    } else {
      await _userApi.updateUserOpening(healerOpening: opening, openingId: opening.id!, userId: _userId!);
    }
    await loadOpenings();
  }

  Future<void> deleteOpening(String openingId) async {
    if (_userId == null) {
      await _userApi.deleteOpening(openingId: openingId);
    } else {
      await _userApi.deleteUserOpening(openingId: openingId, userId: _userId!);
    }
    await loadOpenings();
  }
}
