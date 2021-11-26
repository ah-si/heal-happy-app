import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/preferences_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:http_parser/http_parser.dart';

const _FILE_TYPE_MAP = {
  // mime type
  "png": "image/png",
  "jpeg": "image/jpeg",
  "jpg": "image/jpg",
  "pdf": "application/pdf",
};

final userStoreProvider = ChangeNotifierProvider<UserStore>((ref) {
  final api = ref.watch(apiProvider);
  final prefs = ref.watch(preferenceProvider);
  return UserStore(api, prefs);
});

class UserStore extends ChangeNotifier {
  final BackendApiProvider _apiProvider;
  final PreferencesProvider _preferencesProvider;
  Map<String, String> _specialities = {};

  bool activationEmailResent = false;

  Map<String, String> get specialities {
    getSpecialities();
    return _specialities;
  }

  bool initPending = true;
  User? user;

  User get requiredUser => user!;

  UserStore(this._apiProvider, this._preferencesProvider) {
    _apiProvider.onLogout = () {
      user = null;
      notifyListeners();
    };
  }

  Future<Map<String, String>> getSpecialities() async {
    if (_specialities.isEmpty) {
      final spe = await _apiProvider.api.getUserApi().getSpecialities();
      _specialities = spe.data!.toMap();
      notifyListeners();
    }
    return _specialities;
  }

  Future<void> init({bool silent = true}) async {
    try {
      final token = _preferencesProvider.prefs.getString(PreferencesProvider.keyToken);
      if (token.isNullOrEmpty) {
        throw ErrorResultException(ErrorResult.notLogged);
      }

      _apiProvider.setToken(token!);
      final results = await _apiProvider.api.getUserApi().getProfile();
      user = results.data;
      initPending = false;
      notifyListeners();
    } catch (ex) {
      initPending = false;
      notifyListeners();
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
    } on DioError catch (ex) {
      if (ex.response?.statusCode == 401) {
        throw ErrorResultException(ErrorResult.wrongCredentials);
      }
      rethrow;
    }
  }

  Future<void> changePassword(String password, String token) async {
    try {
      await _apiProvider.api.getAuthApi().resetPassword(
        resetPassword: ResetPassword(
          (b) {
            b.password = password;
            b.token = token;
          },
        ),
      );
    } on DioError catch (error, stack) {
      if (error.response?.statusCode == 401) {
        throw ErrorResultException(ErrorResult.linkExpired);
      } else {
        rethrow;
      }
    }
  }

  Future<void> askResetPassword(String email) async {
    await _apiProvider.api.getAuthApi().askResetPassword(
      askResetPassword: AskResetPassword(
        (b) {
          b.email = email;
        },
      ),
    );
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
      if (ex.response?.statusCode == 400 && ex.response!.data!.toString().contains('email must be unique')) {
        throw ErrorResultException(ErrorResult.emailAlreadyUsed);
      }
      rethrow;
    }
    await init(silent: false);
  }

  Future<void> save(User user) async {
    final results = await _apiProvider.api.getUserApi().saveProfile(user: user);
    this.user = results.data!;
    notifyListeners();
  }

  Future<void> resendActivationLink() async {
    await _apiProvider.api.getUserApi().resendActivationLink();
    activationEmailResent = true;
    notifyListeners();
  }

  Future<void> uploadTerms(FilePickerResult result) async {
    try {
      var data = result.files.first.bytes;
      data ??= File(result.files.first.path!).readAsBytesSync();

      await _apiProvider.api.getUserApi().putTerms(
            terms: MultipartFile.fromBytes(
              data,
              filename: result.files.first.name,
              contentType: MediaType.parse(_FILE_TYPE_MAP[result.files.first.extension!]!),
            ),
          );
    } on DioError catch (ex) {
      if (ex.response?.statusCode == 400 && ex.response!.data.toString().contains('LIMIT_FILE_SIZE')) {
        throw ErrorResultException(ErrorResult.fileTooBig);
      }
      rethrow;
    }
    await init();
  }

  Future<void> uploadDiploma(FilePickerResult result) async {
    try {
      var data = result.files.first.bytes;
      data ??= File(result.files.first.path!).readAsBytesSync();
      await _apiProvider.api.getUserApi().putDiploma(
            diploma: MultipartFile.fromBytes(
              data,
              filename: result.files.first.name,
              contentType: MediaType.parse(_FILE_TYPE_MAP[result.files.first.extension!]!),
            ),
          );
    } on DioError catch (ex) {
      if (ex.response?.statusCode == 400 && ex.response!.data.toString().contains('LIMIT_FILE_SIZE')) {
        throw ErrorResultException(ErrorResult.fileTooBig);
      }
      rethrow;
    }
    await init();
  }
}
