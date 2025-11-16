import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../services/token_storage.dart';
import '../../utils/dialogs.dart';

class LoginController {
  Future<void> handleLogin(
    BuildContext context,
    String email,
    String password,
  ) async {
    final res = await AuthService().login(email, password);

    if (!res.success) {
      showErrorDialog(context, "Login gagal.");
      return;
    }

    if (res.role == "admin") {
      showErrorDialog(context, "Access Denied.\nAkun admin tidak boleh login.");
      return;
    }

    if (res.role == "user" && res.accessToken != null) {
      await TokenStorage.saveToken(res.accessToken!);
    }
  }
}
