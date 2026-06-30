import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.controller,
    required this.onSubmitted,
    this.compact = false,
    this.hintText = 'Pesquise filmes',
    this.height,
  });

  final TextEditingController controller;
  final Function(String) onSubmitted;
  final bool compact;
  final String hintText;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final boxHeight = height ?? (compact ? 36.0 : 47.0);
    final iconSize = compact ? 18.0 : 24.0;
    final hintSize = compact ? 12.0 : 14.0;

    return Container(
      width: double.infinity,
      height: boxHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.colorGray08,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: compact ? 12 : 17),
          child: TextField(
            controller: controller,
            onSubmitted: onSubmitted,
            style: themeData.textTheme.bodyLarge?.copyWith(
              fontSize: compact ? 12 : null,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              isDense: true,
              prefixIconConstraints: BoxConstraints(
                minWidth: compact ? 24 : 30,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.colorGray02,
                size: iconSize,
              ),
              hintText: hintText,
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
