import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';

class MessageSliver extends StatelessWidget {
  const MessageSliver({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Text(
          message,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.colorGray01,
          ),
        ),
      ),
    );
  }
}
