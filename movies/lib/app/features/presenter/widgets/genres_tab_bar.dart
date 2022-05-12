import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';

class GenresTabBar extends StatelessWidget {
  const GenresTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 30.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.colorHighlight,
                  border: Border.all(color: AppColors.colorGray08, width: 1),
                  borderRadius: BorderRadius.circular(26.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Text(
                  'Ação',
                  style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: AppColors.colorWhite,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.colorGray08, width: 1),
                  borderRadius: BorderRadius.circular(26.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Text(
                  'Aventura',
                  style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: AppColors.colorHighlight,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.colorGray08, width: 1),
                  borderRadius: BorderRadius.circular(26.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Text(
                  'Fantasia',
                  style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: AppColors.colorHighlight,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.colorGray08, width: 1),
                borderRadius: BorderRadius.circular(26.r)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Text(
                'Comédia',
                style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    color: AppColors.colorHighlight,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
