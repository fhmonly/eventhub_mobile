class BaseResponse<T> {
  final bool success;
  final String? message;
  final Map<String, dynamic>? error;
  final T? data;

  BaseResponse({required this.success, this.message, this.error, this.data});

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) convert,
  ) {
    return BaseResponse(
      success: json["success"] ?? false,
      message: json["message"],
      error: json["error"],
      data: json["data"] != null ? convert(json["data"]) : null,
    );
  }
}
