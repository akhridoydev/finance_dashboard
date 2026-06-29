import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/constants/app_constants.dart';

void main() {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set URL strategy for web (removes # from URL)
  setUrlStrategy(PathUrlStrategy());

  runApp(const NTechProfitApp());
}

class NTechProfitApp extends StatelessWidget {
  const NTechProfitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
    );
  }
}