import 'package:go_router/go_router.dart';
import '../services/token_storage.dart';

class Guards {
  static Future<bool> isLoggedIn() async {
    final token = await TokenStorage.getToken();
    return token != null;
  }

  /// Basic Auth Guard → redirect ke /login kalau belum login
  static Future<String?> authGuard(GoRouterState state) {
    return Future.sync(() async {
      final loggedIn = await isLoggedIn();
      return loggedIn ? null : "/login";
    }).then((v) => v);
  }

  /// Prevent logged-in users from opening login page again
  static Future<String?> authGuest(GoRouterState state) {
    return Future.sync(() async {
      final loggedIn = await isLoggedIn();
      return loggedIn ? "/events" : null;
    }).then((v) => v);
  }

  /// Role-based guard (optional)
  static Future<String?> roleGuard(
    GoRouterState state, {
    required String requiredRole,
    required String userRole,
  }) async {
    if (userRole != requiredRole) {
      return "/access-denied"; // atau snackbar / popup
    }
    return null;
  }
}
