import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preferenceProvider = Provider((ref) => PreferencesProvider());

class PreferencesProvider {
  static const keyLastRoute = 'lastRoute';
  static const keyToken = 'token';
  static const keyEmail = 'email';
  static const keyLastSeen = 'lastSeen';
  static const keyRefreshToken = 'refreshToken';
  static PreferencesProvider? _singleton;

  PreferencesProvider._();

  factory PreferencesProvider() {
    return _singleton ??= PreferencesProvider._();
  }

  late SharedPreferences _prefs;

  SharedPreferences get prefs => _prefs;

  Future<void> setup() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
