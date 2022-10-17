import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/preferences_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:logging/logging.dart';

const _fileTypesMap = {
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

class HealerRoom {
  final OfficeRoom room;
  final Office office;

  HealerRoom(this.room, this.office);
}

class UserStore extends ChangeNotifier {
  final _logger = Logger('UserStore');
  final BackendApiProvider _apiProvider;
  final PreferencesProvider _preferencesProvider;
  Map<String, String> _specialities = {};
  List<HealerRoom> rooms = [];
  bool isOfficeManager = false;

  bool activationEmailResent = false;

  Map<String, String> get specialities {
    getSpecialities();
    return _specialities;
  }

  bool initPending = true;
  User? user;
  User? currentEditedUser;

  AppSettings? appSettings;

  User get requiredUser => user!;

  UserStore(this._apiProvider, this._preferencesProvider) {
    _apiProvider.onLogout = () {
      user = null;
      notifyListeners();
    };
    init();
  }

  Future<void> loadOffices() async {
    try {
      final officesResult = await _apiProvider.api.getOfficesApi().getOffices();
      final rooms = <HealerRoom>[];
      isOfficeManager = false;
      for (var office in officesResult.data!.offices) {
        final manager = office.managers.firstWhereOrNull((p0) => p0.id == user?.id);
        if (manager != null) {
          isOfficeManager = true;
        }

        for (var room in office.rooms) {
          rooms.add(HealerRoom(room, office));
        }
      }
      this.rooms = rooms;
      notifyListeners();
    } catch (ex, stack) {
      rooms = [];
      notifyListeners();
      _logger.severe('Can\'t retrieve offices, $ex', ex, stack);
    }

  }

  Future<User> getUser(String id) async {
    final user = await _apiProvider.api.getAdminApi().getUser(id: id);
    currentEditedUser = user.data!;
    notifyListeners();
    return currentEditedUser!;
  }

  Future<void> saveUser(String id, User user) async {
    try {
      await _apiProvider.api.getAdminApi().updateUser(id: id, user: user);
    } on DioError catch (error) {
      if (error.response?.statusCode == 400 && error.response!.data.toString().contains('terms_required')) {
        throw ErrorResultException(ErrorResult.adminTermsRequired);
      }
      rethrow;
    }
  }

  Future<Map<String, String>> getSpecialities() async {
    if (_specialities.isEmpty) {
      final spe = await _apiProvider.api.getUserApi().getSpecialities();
      _specialities = spe.data!.toMap();
      notifyListeners();
    }
    return _specialities;
  }

  Future<void> loadSettings({bool force = false}) async {
    //settings already loaded
    if (appSettings != null && !force) {
      return;
    }

    try {
      appSettings = (await _apiProvider.api.getSettingsApi().getSettings()).data!;
    } catch (ex) {
      appSettings = AppSettings((b) => b.enableUrgencyButton = true);
    }
    if (force) {
      notifyListeners();
    }
  }

  Future<void> reloadUser() async {
    final results = await _apiProvider.api.getUserApi().getProfile();
    user = results.data;
    notifyListeners();
  }

  Future<void> init({bool silent = true}) async {
    await loadSettings();
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
      } else if (ex.response?.statusCode == 423) {
        throw ErrorResultException(ErrorResult.accountBlocked);
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
    } on DioError catch (error) {
      if (error.response?.statusCode == 401) {
        throw ErrorResultException(ErrorResult.linkExpired);
      } else {
        rethrow;
      }
    }
  }

  Future<void> askResetPassword(String email) async {
    try {
      await _apiProvider.api.getAuthApi().askResetPassword(
        askResetPassword: AskResetPassword(
          (b) {
            b.email = email;
          },
        ),
      );
    } on DioError catch (error) {
      if (error.response?.statusCode == 404) {
        throw ErrorResultException(ErrorResult.noAccount);
      }
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
      if (ex.response?.statusCode == 400 && ex.response!.data!.toString().contains('duplicate_email')) {
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
              contentType: MediaType.parse(_fileTypesMap[result.files.first.extension!]!),
            ),
          );
    } on DioError catch (ex) {
      if (ex.response?.statusCode == 400 && ex.response!.data.toString().contains('LIMIT_FILE_SIZE')) {
        throw ErrorResultException(ErrorResult.fileTooBig);
      } else if (ex.response?.statusCode == 413) {
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
              contentType: MediaType.parse(_fileTypesMap[result.files.first.extension!]!),
            ),
          );
    } on DioError catch (ex, stack) {
      kDebugLogger.severe('$ex', ex, stack);
      if (ex.response?.statusCode == 400 && ex.response!.data.toString().contains('LIMIT_FILE_SIZE')) {
        throw ErrorResultException(ErrorResult.fileTooBig);
      } else if (ex.response?.statusCode == 413) {
        throw ErrorResultException(ErrorResult.fileTooBig);
      }
      rethrow;
    }
    await init();
  }

  void acceptEvent(String id) {
    _apiProvider.api.getUserApi().acceptEvent(eventId: id);
  }
}
