import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/core/utils/loading_status.dart';
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
      backgroundColor: Colors.white,
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
              child: Obx(() {
                switch (controller.loadingStatus.value) {
                  case LoadingStatus.loading:
                    return const CircularProgressIndicator(
                      color: AppColors.colorGray08,
                      strokeWidth: 4,
                    );
                  case LoadingStatus.complete:
                  default:
                    return ListView.builder(
                      itemCount: controller.listResults.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BigPosterWidget(
                            imageUrl:
                                controller.listResults[index].backdropPath,
                            title: controller.listResults[index].title,
                            genre1: 'teste',
                            genre2: 'teste');
                      },
                    );
                }
              })),
          SearchAppBar(
            controller: controller.textEditingController,
            onSubmitted: (String? text) {
              if (text != null && text.isNotEmpty) {
                controller.addToList(text);
              }
            },
          )
        ],
      ),
    );
  }
}
