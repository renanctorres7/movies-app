import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movies/app/core/routes/app_pages.dart';
import 'package:movies/app/core/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movies',
            theme: AppTheme.appTheme,
            getPages: AppPages.pages,
            defaultTransition: Transition.fade,
          );
        }); //added by extension
  }
}
