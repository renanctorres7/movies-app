import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/features/presenter/stores/search_store.dart';

class GenresTabBar extends GetView<SearchStore> {
  const GenresTabBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        height: 30.h,
        child: Obx(
          () => controller.listGenresByName.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.listGenresByName.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.setGenreFilter(index,
                            controller.listGenresByName[index].toString());
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: Container(
                          decoration: BoxDecoration(
                              color:
                                  controller.genreSelectedIndex.value == index
                                      ? AppColors.colorHighlight
                                      : AppColors.colorWhite,
                              border: Border.all(
                                  color: AppColors.colorGray08, width: 1),
                              borderRadius: BorderRadius.circular(26.r)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            child: Obx(() {
                              return Text(
                                controller.listGenresByName[index].toString(),
                                style: GoogleFonts.montserrat(
                                    fontSize: 12.sp,
                                    color:
                                        controller.genreSelectedIndex.value ==
                                                index
                                            ? AppColors.colorWhite
                                            : AppColors.colorHighlight,
                                    fontWeight: FontWeight.w400),
                              );
                            }),
                          ),
                        ),
                      ),
                    );
                  })
              : const SizedBox(),
        ));
  }
}
