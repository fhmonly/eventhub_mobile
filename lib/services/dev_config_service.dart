import 'package:event_hub/constants/storage_keys.dart';
import 'package:event_hub/services/local_storage.dart';

class DevConfigService {
  static String _baseUrl = "";

  static Future<void> init() async {
    _baseUrl = await LocalStorage.getString(StorageKeys.devBaseUrl) ?? "";
  }

  static String get baseUrl => _baseUrl;

  static Future<void> setBaseUrl(String value) async {
    _baseUrl = await LocalStorage.setString(StorageKeys.devBaseUrl, value);
  }
}
