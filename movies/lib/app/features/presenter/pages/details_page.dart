import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/core/utils/dependency_creator.dart';
import 'package:movies/app/features/infra/contracts/image_url_builder.dart';
import 'package:movies/app/features/presenter/models/movie_details_args.dart';
import 'package:movies/app/features/presenter/widgets/genres_details_page_widget.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as MovieDetailsArgs;
    final imageUrlBuilder = getIt<ImageUrlBuilder>();
    final movie = args.movie;
    final imageUrl = imageUrlBuilder.buildPosterUrl(movie.backdropPath ?? '');
    final year = movie.releaseDate != null && movie.releaseDate!.length >= 4
        ? movie.releaseDate!.substring(0, 4)
        : '';
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.colorGray08,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: ListView(
          children: [
            _backButtonWidget(),
            Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 100.h),
                    child: Container(
                      color: Colors.white,
                      width: size.width,
                      height: size.height,
                    ),
                  ),
                  _detailsContent(
                    context: context,
                    imageUrl: imageUrl,
                    title: movie.title ?? '',
                    originalTitle: movie.originalTitle ?? '',
                    popularity: movie.voteAverage?.toDouble() ?? 0,
                    year: year,
                    genreNames: args.genreNames,
                    overview: movie.overview ?? '',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _backButtonWidget() {
  return Padding(
    padding: EdgeInsets.only(top: 48.h, left: 20.w, bottom: 56.h),
    child: Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: Get.back,
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

Widget _detailsContent({
  required BuildContext context,
  required String imageUrl,
  required String title,
  required String originalTitle,
  required double popularity,
  required String year,
  required List<String> genreNames,
  required String overview,
}) {
  final size = MediaQuery.of(context).size;

  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 2.r,
              blurRadius: 10.r,
              offset: const Offset(2, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  height: 318.h,
                  width: 216.w,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
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
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const SizedBox(),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 32.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '${popularity.toStringAsFixed(1)} ',
              style: GoogleFonts.montserrat(
                fontSize: 24.sp,
                color: AppColors.colorHighlight,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              ' /10',
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: AppColors.colorGray03,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 32.h),
        child: Text(
          title.toUpperCase(),
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            color: AppColors.colorGray01,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 12.h),
        child: Text(
          'Título original: $originalTitle',
          style: GoogleFonts.montserrat(
            fontSize: 10.sp,
            color: AppColors.colorGray02,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 40.h),
        child: Container(
          alignment: Alignment.center,
          width: 100.w,
          height: 35.h,
          decoration: BoxDecoration(
            color: AppColors.colorGray08,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Ano: ',
                style: GoogleFonts.montserrat(
                  fontSize: 12.sp,
                  color: AppColors.colorGray03,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                year,
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: AppColors.colorGray01,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 12.h),
        child: GenresDetailsPageWidget(genreNames: genreNames),
      ),
      Padding(
        padding: EdgeInsets.only(top: 56.h, left: 20.w),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Descrição',
            textAlign: TextAlign.left,
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              color: AppColors.colorGray02,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 8.h, left: 20.w, right: 20.w, bottom: 32.h),
        child: Text(
          overview,
          textAlign: TextAlign.left,
          style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            color: AppColors.colorGray01,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}
