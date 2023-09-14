import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const String _darkMode = 'darkMode';

  final SharedPreferences _sharedPreferences;

  SettingsRepository(this._sharedPreferences);

  bool isDarkMode() {
    return _sharedPreferences.getBool(_darkMode) ?? false;
  }

  Future<void> setDarkMode(bool value) async {
    await _sharedPreferences.setBool(_darkMode, value);
  }
}
