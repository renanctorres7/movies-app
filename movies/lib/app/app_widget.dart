import 'package:flutter/material.dart';
import 'package:movies/app/core/routes/app_pages.dart';
import 'package:movies/app/core/routes/app_routes.dart';
import 'package:movies/app/core/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      theme: AppTheme.appTheme,
      initialRoute: AppRoutes.search,
      onGenerateRoute: AppPages.onGenerateRoute,
    );
  }
}
