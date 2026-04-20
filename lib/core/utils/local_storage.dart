import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  bool hasSeenOnboarding();
  Future<void> setHasSeenOnboarding(bool value);

  bool isLoggedIn();
  Future<void> setIsLoggedIn(bool value);

  bool isDarkMode();
  Future<void> setIsDarkMode(bool value);

  String? getToken();
  Future<void> setToken(String token);
  Future<void> clearToken();
}

@Injectable(as: LocalStorage)
class LocalStorageImpl implements LocalStorage {
  final SharedPreferences _prefs;

  LocalStorageImpl(this._prefs);

  static const String _keyHasSeenOnboarding = 'has_seen_onboarding';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyIsDarkMode = 'is_dark_mode';
  static const String _keyToken = 'auth_token';

  @override
  bool hasSeenOnboarding() {
    return _prefs.getBool(_keyHasSeenOnboarding) ?? false;
  }

  @override
  Future<void> setHasSeenOnboarding(bool value) async {
    await _prefs.setBool(_keyHasSeenOnboarding, value);
  }

  @override
  bool isLoggedIn() {
    return _prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  @override
  Future<void> setIsLoggedIn(bool value) async {
    await _prefs.setBool(_keyIsLoggedIn, value);
  }

  @override
  bool isDarkMode() {
    return _prefs.getBool(_keyIsDarkMode) ?? false; // default light mode
  }

  @override
  Future<void> setIsDarkMode(bool value) async {
    await _prefs.setBool(_keyIsDarkMode, value);
  }

  @override
  String? getToken() {
    return _prefs.getString(_keyToken);
  }

  @override
  Future<void> setToken(String token) async {
    await _prefs.setString(_keyToken, token);
  }

  @override
  Future<void> clearToken() async {
    await _prefs.remove(_keyToken);
  }
}
