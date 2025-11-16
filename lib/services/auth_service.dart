import 'dart:convert';
import 'package:event_hub/routes/app.dart';
import 'package:event_hub/services/dev_config_service.dart';
import 'package:http/http.dart' as http;
import '../models/login_response.dart';
import '../models/refresh_response.dart';
import 'token_storage.dart';

class AuthService {
  static String baseUrl = DevConfigService.baseUrl;

  Future<LoginResponse> login(String email, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/login?withRefresh=true"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    return LoginResponse.fromJson(jsonDecode(res.body));
  }

  Future<String?> refreshToken() async {
    String? refreshToken = await SecureTokenStorage.getRefreshToken();

    final res = await http.post(
      Uri.parse("$baseUrl/auth/refresh"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": refreshToken}),
    );

    if (res.statusCode == 401) {
      await SecureTokenStorage.clearAll();
      router.push('/login');
      return null;
    }

    final data = RefreshResponse.fromJson(jsonDecode(res.body));

    if (data.success && data.accessToken != null) {
      await SecureTokenStorage.saveAccessToken(data.accessToken!);
      return data.accessToken;
    }

    return null;
  }
}
