import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/features/presenter/widgets/search_app_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Stack(
        children: [
          Container(
            color: AppColors.colorWhite,
            padding: EdgeInsets.only(top: 130.h, left: 20.w, right: 20.w),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Container(
                    height: 470.h,
                    width: 320.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.yellow),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Container(
                    height: 470.h,
                    width: 320.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.red),
                  ),
                )
              ],
            ),
          ),
          const SearchAppBar(),
        ],
      ),
    );
  }
}
