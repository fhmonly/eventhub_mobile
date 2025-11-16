class LoginResponse {
  final bool success;
  final String? accessToken;
  final String? refreshToken;
  final String? role;

  LoginResponse({
    required this.success,
    this.accessToken,
    this.refreshToken,
    this.role,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      accessToken: json['data']?['accessToken'],
      refreshToken: json['data']?['refreshToken'],
      role: json['data']?['role'],
    );
  }
}
