import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final openingStoreProvider = ChangeNotifierProvider((_) => OpeningStore());

class OpeningResults {
  final List<HealerOpening> slots;
  final ErrorResultException? error;

  OpeningResults(this.slots, {this.error});
}

class OpeningStore extends ChangeNotifier {
  final UserApi _userApi;
  OpeningResults? results;

  OpeningStore({UserApi? userApi}) : _userApi = BackendApiProvider().api.getUserApi();

  Future<void> loadOpenings() async {
    try {
      final openings = await _userApi.getOpenings();
      results = OpeningResults(openings.data!.toList());
    } catch (error, stackTrace) {
      results = OpeningResults([], error: handleError(error, stackTrace));
    }
    notifyListeners();
  }

  Future<void> createOpening(
    String userId,
    OpeningType type,
    OpeningRepeatType? repeat,
    DateTime start,
    DateTime end,
  ) async {
    await _userApi.createOpening(healerOpening: HealerOpening((b) {
      b.repeat = repeat;
      b.userId = userId;
      b.start = start.toUtc();
      b.type = type;
      b.end = end.toUtc();
    }));
    await loadOpenings();
  }

  Future<void> updateOpening(HealerOpening opening) async {
    await _userApi.updateOpening(healerOpening: opening, openingId: opening.id!);
    await loadOpenings();
  }

  Future<void> deleteOpening(String openingId) async {
    await _userApi.deleteOpening(openingId: openingId);
    await loadOpenings();
  }
}
