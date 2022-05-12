import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key, this.controller}) : super(key: key);

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      width: 320.w,
      height: 47.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: AppColors.colorGray08),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 17.w, right: 17.w),
          child: TextField(
            controller: controller,
            style: themeData.textTheme.bodyText1,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                isDense: true,
                prefixIconConstraints: BoxConstraints(
                  minWidth: 30.w,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.colorGray02,
                  size: 24.sp,
                ),
                hintText: "Pesquise filmes",
                hintStyle: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    color: AppColors.colorGray02,
                    fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }
}
