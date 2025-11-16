import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _prefs;

  // memastikan prefs hanya di-init sekali
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // SAVE
  static Future<String> setString(String key, String value) async {
    await init();
    await _prefs!.setString(key, value);
    return value;
  }

  static Future<bool> setBool(String key, bool value) async {
    await init();
    await _prefs!.setBool(key, value);
    return value;
  }

  static Future<int> setInt(String key, int value) async {
    await init();
    await _prefs!.setInt(key, value);
    return value;
  }

  // READ
  static Future<String?> getString(String key) async {
    await init();
    return _prefs!.getString(key);
  }

  static Future<bool?> getBool(String key) async {
    await init();
    return _prefs!.getBool(key);
  }

  static Future<int?> getInt(String key) async {
    await init();
    return _prefs!.getInt(key);
  }

  // REMOVE
  static Future<void> remove(String key) async {
    await init();
    await _prefs!.remove(key);
  }

  // CLEAR ALL
  static Future<void> clear() async {
    await init();
    await _prefs!.clear();
  }
}
