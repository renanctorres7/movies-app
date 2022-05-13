import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/features/presenter/stores/search_store.dart';
import 'package:movies/app/features/presenter/widgets/big_poster_widget.dart';
import 'package:movies/app/features/presenter/widgets/search_app_bar.dart';

class SearchPage extends GetView<SearchStore> {
  const SearchPage({Key? key}) : super(key: key);

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
              children: [],
            ),
          ),
          SearchAppBar(
            controller: controller.textEditingController,
            onSubmitted: (String? text) {
              if (text != null && text.isNotEmpty) {}
            },
          ),
        ],
      ),
    );
  }
}
