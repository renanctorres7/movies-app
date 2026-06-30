import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';

class SelectableChipTabBar extends StatelessWidget {
  const SelectableChipTabBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.isActive,
    required this.onTap,
  });

  final List<String> items;
  final int selectedIndex;
  final bool isActive;
  final void Function(int index, String label) onTap;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: 30.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final isSelected = isActive && selectedIndex == index;
          final backgroundColor =
              isActive ? (isSelected ? AppColors.colorHighlight : AppColors.colorWhite) : AppColors.colorWhite;
          final textColor = isActive
              ? (isSelected ? AppColors.colorWhite : AppColors.colorHighlight)
              : AppColors.colorHighlight;

          return GestureDetector(
            onTap: () => onTap(index, items[index]),
            child: Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  border: Border.all(color: AppColors.colorGray08, width: 1),
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Text(
                    items[index],
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: textColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
