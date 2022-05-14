import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/utils/utils.dart';

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
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        bottom: 16.h,
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            imageUrl.isNotEmpty
                ? ClipRRect(
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
                      child: imageUrl.isNotEmpty
                          ? Image.network(
                              Utils.trimUrlImage(imageUrl),
                              height: 430.h,
                              width: 300.w,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return SizedBox(
                                  width: size.width,
                                  height: size.height,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: SizedBox(
                                      width: 200.w,
                                      child: LinearProgressIndicator(
                                        color: AppColors.colorGray03,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : const SizedBox(),
                    ))
                : Container(
                    width: 300.w,
                    height: 250.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AppColors.colorGray03)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.w, top: 12.h),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Icons.movie,
                          size: 24.sp,
                          color: AppColors.colorGray03,
                        ),
                      ),
                    ),
                  ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(left: 24.w, bottom: 32.h, right: 24.w),
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
                              color: imageUrl.isNotEmpty
                                  ? AppColors.colorWhite
                                  : AppColors.colorGray01),
                        ),
                      ),
                      Text(
                        genre1 + '- $genre2',
                        style: GoogleFonts.montserrat(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: imageUrl.isNotEmpty
                                ? AppColors.colorWhite
                                : AppColors.colorGray01),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
