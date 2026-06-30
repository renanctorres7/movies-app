import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';

class DetailsBackButton extends StatelessWidget {
  const DetailsBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48, left: 20, bottom: 24),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: onTap ?? Get.back,
          child: Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            width: 75,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(2, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                  color: AppColors.colorGray02,
                ),
                Text(
                  'Voltar',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
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
