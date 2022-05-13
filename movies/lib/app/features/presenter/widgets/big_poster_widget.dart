import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';

class BigPosterWidget extends StatelessWidget {
  const BigPosterWidget(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.genre1,
      required this.genre2})
      : super(key: key);

  final String imageUrl;
  final String title;
  final String genre1;
  final String genre2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 16.h,
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black],
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.darken,
                  child: Image.network(
                    imageUrl,
                    height: 430.h,
                    width: 300.w,
                    fit: BoxFit.cover,
                  ),
                )),
            Container(
                padding: EdgeInsets.only(left: 24.w, bottom: 32.h, right: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 12.h,
                      ),
                      child: Text(
                        title,
                        style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.colorWhite),
                      ),
                    ),
                    Text(
                      '$genre1 - $genre2',
                      style: GoogleFonts.montserrat(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.colorWhite),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
