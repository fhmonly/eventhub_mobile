import 'dart:convert';
import 'package:event_hub/models/event_model.dart';
import 'package:event_hub/models/base_response.dart';
import 'package:event_hub/services/api_client.dart';

class ApiService {
  /// GET /events
  static Future<List<EventModel>> getEvents() async {
    final res = await ApiClient.fetchWithAuth("/events");

    if (res.statusCode != 200) {
      throw Exception("Failed: ${res.statusCode}");
    }

    final json = jsonDecode(res.body);

    final parsed = BaseResponse<List<EventModel>>.fromJson(
      json,
      (data) => (data as List).map((e) => EventModel.fromJson(e)).toList(),
    );

    if (!parsed.success || parsed.data == null) {
      throw Exception(parsed.message ?? "Unknown error");
    }

    return parsed.data!;
  }

  /// GET /events/:id
  static Future<EventModel> getEventById(int id) async {
    final res = await ApiClient.fetchWithAuth("/events/$id");

    if (res.statusCode != 200) {
      throw Exception("Failed: ${res.statusCode}");
    }

    final json = jsonDecode(res.body);

    final parsed = BaseResponse<EventModel>.fromJson(
      json,
      (data) => EventModel.fromJson(data),
    );

    if (!parsed.success || parsed.data == null) {
      throw Exception(parsed.message ?? "Unknown error");
    }

    return parsed.data!;
  }
}
