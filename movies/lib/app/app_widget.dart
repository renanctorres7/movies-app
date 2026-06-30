import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/app/core/routes/app_pages.dart';
import 'package:movies/app/core/routes/app_routes.dart';
import 'package:movies/app/core/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      theme: AppTheme.appTheme,
      initialRoute: AppRoutes.search,
      getPages: AppPages.pages,
      defaultTransition: Transition.fade,
    );
  }
}
