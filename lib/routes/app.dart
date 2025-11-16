import 'package:event_hub/layouts/app_shell.dart';
import 'package:event_hub/routes/guards.dart';
import 'package:event_hub/screens/auth/login.dart';
import 'package:event_hub/screens/dev_page.dart';
import 'package:event_hub/screens/protected/event_detail_page.dart';
import 'package:event_hub/screens/protected/event_list_page.dart';
import 'package:event_hub/screens/splash.dart';
import 'package:event_hub/services/api_service.dart';
import 'package:go_router/go_router.dart';

final api = ApiService();

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => AppShell(child: const SplashPage()),
    ),
    GoRoute(path: '/dev-page', builder: (context, state) => DevPage()),
    GoRoute(
      path: '/login',
      builder: (context, state) => AppShell(child: const LoginPage()),
      redirect: (context, state) => Guards.authGuest(state),
    ),
    GoRoute(
      path: '/events',
      builder: (context, state) => (AppShell(child: EventListPage(api: api))),
      redirect: (context, state) => Guards.authGuard(state),
    ),
    GoRoute(
      path: '/events/:id',
      redirect: (context, state) => Guards.authGuard(state),
      builder: (context, state) {
        final idStr = state.pathParameters['id'] ?? '';
        final id = int.tryParse(idStr) ?? 0;
        return AppShell(child: EventDetailPage(id: id));
      },
    ),
  ],
);
