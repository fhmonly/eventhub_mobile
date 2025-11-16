import 'package:event_hub/layouts/app_shell.dart';
import 'package:event_hub/routes/app.dart';
import 'package:event_hub/routes/guards.dart';
import 'package:event_hub/screens/dev_page.dart';
import 'package:event_hub/services/dev_config_service.dart';
import 'package:event_hub/services/local_storage.dart';
import 'package:provider/provider.dart';
import 'package:event_hub/screens/protected/event_detail_page.dart';
import 'package:event_hub/screens/protected/event_list_page.dart';
import 'package:event_hub/screens/auth/login.dart';
import 'package:event_hub/screens/splash.dart';
import 'package:event_hub/services/api_service.dart';
import 'package:event_hub/services/favorites_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  await DevConfigService.init();
  runApp(MyApp());
}

// ---------------------------
// ROOT APP
// ---------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final favService = FavoritesService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoritesService>.value(value: favService),
      ],
      child: MaterialApp.router(
        title: 'EventHub',
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
