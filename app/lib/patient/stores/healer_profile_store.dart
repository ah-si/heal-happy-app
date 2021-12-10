import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final healerProfileStoreProvider = ChangeNotifierProvider.family<HealerProfileStore, String>((_, id) => HealerProfileStore(id));

class HealerResults {
  final Healer? profile;
  final ErrorResultException? error;

  HealerResults(this.profile, {this.error});
}

class HealerProfileStore extends ChangeNotifier {
  final String _id;
  final UserApi _userApi;
  HealerResults? healerProfile;

  bool isLoading = false;

  HealerProfileStore(this._id, {UserApi? userApi}) : _userApi = BackendApiProvider().api.getUserApi() {
    loadHealerProfile();
  }

  Future<void> loadHealerProfile() async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await _userApi.getHealerProfile(id: _id);
      healerProfile = HealerResults(result.data);
    } catch(error, stackTrace) {
      healerProfile = HealerResults(null, error: handleError(error, stackTrace));
    }
    isLoading = false;
    notifyListeners();
  }


}
