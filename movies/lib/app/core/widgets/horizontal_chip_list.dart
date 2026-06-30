import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';

class HorizontalChipList extends StatelessWidget {
  const HorizontalChipList({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 30.h,
      child: items.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      border: Border.all(color: AppColors.colorGray08, width: 1),
                      borderRadius: BorderRadius.circular(26.r),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      child: Text(
                        items[index],
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: AppColors.colorGray02,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : const SizedBox(),
    );
  }
}
