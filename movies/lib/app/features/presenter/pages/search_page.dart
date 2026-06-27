import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/routes/app_routes.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/core/utils/dependency_creator.dart';
import 'package:movies/app/core/utils/loading_status.dart';
import 'package:movies/app/features/infra/contracts/image_url_builder.dart';
import 'package:movies/app/features/presenter/stores/search_store.dart';
import 'package:movies/app/features/presenter/widgets/big_poster_widget.dart';
import 'package:movies/app/features/presenter/widgets/search_app_bar.dart';

class SearchPage extends GetView<SearchStore> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrlBuilder = getIt<ImageUrlBuilder>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: AppColors.colorWhite,
            padding: EdgeInsets.only(top: 130.h, left: 20.w, right: 20.w),
            child: Obx(() {
              switch (controller.loadingStatus.value) {
                case LoadingStatus.empty:
                  return Center(
                    child: Text(
                      'Nenhum resultado encontrado',
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.colorGray01,
                      ),
                    ),
                  );
                case LoadingStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.colorHighlight,
                      strokeWidth: 6,
                    ),
                  );
                case LoadingStatus.error:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.failureMessage.value,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.colorGray01,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () {
                            final text = controller.textEditingController.text;
                            if (text.isNotEmpty) {
                              controller.searchMovies(text);
                            }
                          },
                          child: const Text('Tentar novamente'),
                        ),
                      ],
                    ),
                  );
                case LoadingStatus.complete:
                  final results = controller.displayedResults;
                  return ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final movie = results[index];
                      final genreNames = controller.genreNamesFor(movie);

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.details,
                            arguments: controller.buildDetailsArgs(movie),
                          );
                        },
                        child: BigPosterWidget(
                          imageUrl: imageUrlBuilder.buildPosterUrl(
                            movie.backdropPath ?? '',
                          ),
                          title: movie.title ?? '',
                          genre1: genreNames.isNotEmpty ? genreNames.first : '',
                          genre2: genreNames.length >= 2 ? genreNames[1] : '',
                        ),
                      );
                    },
                  );
                case LoadingStatus.none:
                  return const SizedBox();
              }
            }),
          ),
          SearchAppBar(
            controller: controller.textEditingController,
            onSubmitted: (text) {
              if (text.isNotEmpty) {
                controller.searchMovies(text);
              }
            },
          ),
        ],
      ),
    );
  }
}
