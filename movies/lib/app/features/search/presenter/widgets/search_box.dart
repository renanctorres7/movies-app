import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.controller,
    required this.onSubmitted,
    this.compact = false,
  });

  final TextEditingController controller;
  final Function(String) onSubmitted;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final height = compact ? 36.h : 47.h;
    final iconSize = compact ? 18.sp : 24.sp;
    final hintSize = compact ? 12.sp : 14.sp;

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: AppColors.colorGray08,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: compact ? 12.w : 17.w),
          child: TextField(
            controller: controller,
            onSubmitted: onSubmitted,
            style: themeData.textTheme.bodyLarge?.copyWith(
              fontSize: compact ? 12.sp : null,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              isDense: true,
              prefixIconConstraints: BoxConstraints(
                minWidth: compact ? 24.w : 30.w,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.colorGray02,
                size: iconSize,
              ),
              hintText: 'Pesquise filmes',
              hintStyle: GoogleFonts.montserrat(
                fontSize: hintSize,
                color: AppColors.colorGray02,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
