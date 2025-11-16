import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureTokenStorage {
  // Instance secure storage
  static final _storage = FlutterSecureStorage();

  static const _keyAccess = "access_token";
  static const _keyRefresh = "refresh_token";

  // Simpan access token
  static Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _keyAccess, value: token);
  }

  // Ambil access token
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _keyAccess);
  }

  // Hapus access token
  static Future<void> removeAccessToken() async {
    await _storage.delete(key: _keyAccess);
  }

  // Simpan refresh token
  static Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _keyRefresh, value: token);
  }

  // Ambil refresh token
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _keyRefresh);
  }

  // Hapus refresh token
  static Future<void> removeRefreshToken() async {
    await _storage.delete(key: _keyRefresh);
  }

  // Hapus semua token
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
