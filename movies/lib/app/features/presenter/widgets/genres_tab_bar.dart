import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';

class GenresTabBar extends StatelessWidget {
  const GenresTabBar({Key? key, required this.list}) : super(key: key);

  final List list;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 30.h,
      child: list.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Container(
                    decoration: BoxDecoration(
                        color: index == 0
                            ? AppColors.colorHighlight
                            : AppColors.colorWhite,
                        border:
                            Border.all(color: AppColors.colorGray08, width: 1),
                        borderRadius: BorderRadius.circular(26.r)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      child: Obx(() {
                        return Text(
                          list[index].toString(),
                          style: GoogleFonts.montserrat(
                              fontSize: 12.sp,
                              color: index == 0
                                  ? AppColors.colorWhite
                                  : AppColors.colorHighlight,
                              fontWeight: FontWeight.w400),
                        );
                      }),
                    ),
                  ),
                );
              })
          : const SizedBox(),
    );
  }
}
