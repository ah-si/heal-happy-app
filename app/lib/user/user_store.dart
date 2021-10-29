import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy/common/utils/preferences_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final userStoreProvider = ChangeNotifierProvider<UserStore>((ref) {
  final api = ref.watch(apiProvider);
  final prefs = ref.watch(preferenceProvider);
  return UserStore(api, prefs);
});

class UserStore extends ChangeNotifier {
  final BackendApiProvider _apiProvider;
  final PreferencesProvider _preferencesProvider;
  User? user;

  UserStore(this._apiProvider, this._preferencesProvider);

  Future<void> init({bool silent = true}) async {
    try {
      final token = _preferencesProvider.prefs.getString(PreferencesProvider.keyToken);
      if (token == null) {
        throw ErrorResultException(ErrorResult.notLogged);
      }

      _apiProvider.setToken(token);
      final results = await _apiProvider.api.getUserApi().getProfile();
      user = results.data;
      notifyListeners();
    } catch (ex, stack) {
      if (!silent) {
        rethrow;
      }
      // something went wrong, maybe not connected yet
    }
  }

  Future<void> logout() async {
    user = null;
    await _preferencesProvider.prefs.remove(PreferencesProvider.keyToken);
    await _preferencesProvider.prefs.remove(PreferencesProvider.keyRefreshToken);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final results = await _apiProvider.api.getAuthApi().login(
      loginRequest: LoginRequest(
        (b) {
          b.password = password;
          b.email = email;
        },
      ),
    );
    final token = results.data!.token;
    final refreshToken = results.data!.refreshToken;
    await _preferencesProvider.prefs.setString(PreferencesProvider.keyToken, token);
    await init();
  }

  Future<void> register(UserUpdate user) async {
    final results = await _apiProvider.api.getAuthApi().register(userUpdate: user);
    final token = results.data!.token;
    final refreshToken = results.data!.refreshToken;
    await _preferencesProvider.prefs.setString(PreferencesProvider.keyToken, token);
    await init();
  }
}
