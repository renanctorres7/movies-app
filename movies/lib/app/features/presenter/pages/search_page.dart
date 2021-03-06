import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/routes/app_routes.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/core/utils/loading_status.dart';
import 'package:movies/app/features/presenter/stores/search_store.dart';
import 'package:movies/app/features/presenter/widgets/big_poster_widget.dart';
import 'package:movies/app/features/presenter/widgets/search_app_bar.dart';

class SearchPage extends GetView<SearchStore> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              width: size.width,
              height: size.height,
              color: AppColors.colorWhite,
              padding: EdgeInsets.only(top: 130.h, left: 20.w, right: 20.w),
              child: Obx(() {
                switch (controller.loadingStatus.value) {
                  case LoadingStatus.empty:
                    return Center(
                      child: Text(
                        "Nenhum resultado encontrado",
                        style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.colorGray01),
                      ),
                    );
                  case LoadingStatus.loading:
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.colorHighlight,
                        strokeWidth: 6,
                      ),
                    );
                  case LoadingStatus.complete:
                    return ListView.builder(
                      itemCount: controller.genreFilterActive.value == false
                          ? controller.listResults.length
                          : controller.listResultsFilter.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            controller.setDataToDetailsPage(index);
                            Get.toNamed(AppRoutes.details);
                          },
                          child: controller.genreFilterActive.value == false
                              ? BigPosterWidget(
                                  imageUrl: controller.listResults[index].backdropPath ??
                                      "",
                                  title:
                                      controller.listResults[index].title ?? "",
                                  genre1:
                                      controller.getSpecificGenreName(index, 0),
                                  genre2: controller.listResults[index].genreIds!.length >= 2
                                      ? controller.getSpecificGenreName(
                                          index, 1)
                                      : "")
                              : BigPosterWidget(
                                  imageUrl: controller
                                      .listResultsFilter[index].backdropPath??"",
                                  title:
                                      controller.listResultsFilter[index].title??"",
                                  genre1:
                                      controller.getSpecificGenreName(index, 0),
                                  genre2: controller.listResultsFilter[index]
                                              .genreIds!.length >=
                                          2
                                      ? controller.getSpecificGenreName(index, 1)
                                      : ""),
                        );
                      },
                    );
                  case LoadingStatus.none:
                  default:
                    return const SizedBox();
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
