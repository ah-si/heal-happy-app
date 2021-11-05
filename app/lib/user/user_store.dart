import 'dart:async';

import 'package:dio/dio.dart';
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

  User get requiredUser => user!;

  UserStore(this._apiProvider, this._preferencesProvider) {
    _apiProvider.onLogout = () {
      user = null;
      notifyListeners();
    };
  }

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
    } catch (ex) {
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
    try {
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
      if (!kIsWeb) {
        await _preferencesProvider.prefs.setString(PreferencesProvider.keyRefreshToken, refreshToken);
      }
      await _preferencesProvider.prefs.setString(PreferencesProvider.keyEmail, email);
      await init(silent: false);
    } on DioError catch(ex) {
      if (ex.response?.statusCode == 401) {
        throw ErrorResultException(ErrorResult.wrongCredentials);
      }
      rethrow;
    }
  }

  Future<void> register(User user) async {
    try {
      final results = await _apiProvider.api.getAuthApi().register(user: user);
      final token = results.data!.token;
      final refreshToken = results.data!.refreshToken;
      if (!kIsWeb) {
        await _preferencesProvider.prefs.setString(PreferencesProvider.keyRefreshToken, refreshToken);
      }
      await _preferencesProvider.prefs.setString(PreferencesProvider.keyToken, token);
    } on DioError catch (ex) {
      if (ex.response?.statusCode == 400 && ex.response!.data!.toString().contains('users.email must be unique')) {
        throw ErrorResultException(ErrorResult.emailAlreadyUsed);
      }
      rethrow;
    }
    await init(silent: false);
  }

  Future<void> save(User user) async {
    final results = await _apiProvider.api.getUserApi().saveProfile(user: user);
    user = results.data!;
    notifyListeners();
  }
}
