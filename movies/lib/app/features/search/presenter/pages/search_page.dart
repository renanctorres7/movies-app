import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movies/app/core/routes/app_routes.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/core/utils/loading_status.dart';
import 'package:movies/app/core/widgets/widgets.dart';
import 'package:movies/app/features/search/presenter/components/components.dart';
import 'package:movies/app/features/search/presenter/stores/search_store.dart';

class SearchPage extends GetView<SearchStore> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Container(
        color: AppColors.colorWhite,
        child: SafeArea(
          child: Scaffold(
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
                        topPadding: 0,
                        controller: controller.textEditingController,
                        onSubmitted: (text) {
                          if (text.isNotEmpty) {
                            controller.searchMovies(text);
                          }
                        },
                        genresSection: Obx(
                          () => SelectableChipTabBar(
                            items: controller.listGenresByName,
                            selectedIndex: controller.genreSelectedIndex.value,
                            isActive: controller.genreFilterActive.value,
                            onTap: controller.setGenreFilter,
                          ),
                        ),
                      ),
                    ),
                    switch (status) {
                      LoadingStatus.none => const SliverToBoxAdapter(
                          child: SizedBox.shrink(),
                        ),
                      LoadingStatus.loading => const LoadingSliver(),
                      LoadingStatus.empty => const MessageSliver(
                          message: 'Nenhum resultado encontrado',
                        ),
                      LoadingStatus.error => ErrorRetrySliver(
                          message: controller.failureMessage.value,
                          onRetry: _retry,
                        ),
                      LoadingStatus.complete => SearchResultsSliver(
                          results: controller.displayedResults,
                          bottomPadding: bottomPadding,
                          onMovieTap: (movie) {
                            Get.toNamed(
                              AppRoutes.details,
                              arguments: controller.buildDetailsArgs(movie),
                            );
                          },
                          genreNamesFor: controller.genreNamesFor,
                          imageUrlFor: (movie) => controller.imageUrlBuilder
                              .buildPosterUrl(movie.backdropPath ?? ''),
                        ),
                    },
                  ],
                );
              }),
            ),
          ),
        ),
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
}
