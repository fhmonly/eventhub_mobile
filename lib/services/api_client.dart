import 'dart:convert';
import 'package:event_hub/services/dev_config_service.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import 'token_storage.dart';

class ApiClient {
  static String baseUrl = DevConfigService.baseUrl;

  static Future<http.Response> fetchWithAuth(
    String endpoint, {
    String method = "GET",
    Map<String, String>? headers,
    dynamic body,
  }) async {
    String? token = await TokenStorage.getToken();

    Future<http.Response> send() async {
      final req = http.Request(method, Uri.parse("$baseUrl$endpoint"));

      req.headers.addAll({
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        ...?headers,
      });

      if (body != null) {
        req.body = jsonEncode(body);
      }

      final streamed = await req.send();
      return http.Response.fromStream(streamed);
    }

    var res = await send();

    if (res.statusCode == 401 || res.statusCode == 403) {
      final newToken = await AuthService().refreshToken();

      if (newToken != null) {
        token = newToken;
        res = await send();
      }
    }

    return res;
  }
}
