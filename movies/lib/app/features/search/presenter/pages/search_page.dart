import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/routes/app_routes.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/core/utils/loading_status.dart';
import 'package:movies/app/features/search/presenter/stores/search_store.dart';
import 'package:movies/app/features/search/presenter/widgets/big_poster_widget.dart';
import 'package:movies/app/features/search/presenter/widgets/search_header_delegate.dart';

class SearchPage extends GetView<SearchStore> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: SafeArea(
        top: false,
        child: Obx(() {
          final status = controller.loadingStatus.value;

          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: SearchHeaderDelegate(
                  topPadding: MediaQuery.paddingOf(context).top,
                  controller: controller.textEditingController,
                  onSubmitted: (text) {
                    if (text.isNotEmpty) {
                      controller.searchMovies(text);
                    }
                  },
                ),
              ),
              switch (status) {
                LoadingStatus.none => const SliverToBoxAdapter(
                    child: SizedBox.shrink(),
                  ),
                LoadingStatus.loading => SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.colorHighlight,
                        strokeWidth: 6.w,
                      ),
                    ),
                  ),
                LoadingStatus.empty => SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'Nenhum resultado encontrado',
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.colorGray01,
                        ),
                      ),
                    ),
                  ),
                LoadingStatus.error => SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              controller.failureMessage.value,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.colorGray01,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: _retry,
                            child: const Text('Tentar novamente'),
                          ),
                        ],
                      ),
                    ),
                  ),
                LoadingStatus.complete =>
                  _buildResultsSliver(bottomPadding),
              },
            ],
          );
        }),
      ),
    );
  }

  void _retry() {
    final text = controller.textEditingController.text.trim();
    if (text.isNotEmpty) {
      controller.searchMovies(text);
      return;
    }

    controller.loadPopularMovies();
  }

  Widget _buildResultsSliver(double bottomPadding) {
    final results = controller.displayedResults;

    return SliverPadding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 8.h + bottomPadding),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
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
                imageUrl: controller.imageUrlBuilder.buildPosterUrl(
                  movie.backdropPath ?? '',
                ),
                title: movie.title ?? '',
                genre1: genreNames.isNotEmpty ? genreNames.first : '',
                genre2: genreNames.length >= 2 ? genreNames[1] : '',
              ),
            );
          },
          childCount: results.length,
        ),
      ),
    );
  }
}
