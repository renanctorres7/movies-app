import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';

class DetailsBackButton extends StatelessWidget {
  const DetailsBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 48.h, left: 20.w, bottom: 56.h),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: onTap ?? Get.back,
          child: Container(
            padding: EdgeInsets.only(right: 10.w, left: 10.w),
            width: 75.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2.r,
                  blurRadius: 5.r,
                  offset: const Offset(2, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 15.sp,
                  color: AppColors.colorGray02,
                ),
                Text(
                  'Voltar',
                  style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    color: AppColors.colorGray02,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
