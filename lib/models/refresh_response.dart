class RefreshResponse {
  final bool success;
  final String? accessToken;

  RefreshResponse({required this.success, this.accessToken});

  factory RefreshResponse.fromJson(Map<String, dynamic> json) {
    return RefreshResponse(
      success: json["success"],
      accessToken: json["data"]?["accessToken"],
    );
  }
}
