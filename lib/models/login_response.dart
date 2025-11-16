class LoginResponse {
  final bool success;
  final String? accessToken;
  final String? role;

  LoginResponse({required this.success, this.accessToken, this.role});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      accessToken: json['data']?['accessToken'],
      role: json['data']?['role'],
    );
  }
}
