import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app/core/routes/app_routes.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/core/utils/loading_status.dart';
import 'package:movies/app/core/widgets/widgets.dart';
import 'package:movies/app/features/search/presenter/components/components.dart';
import 'package:movies/app/features/search/presenter/stores/search_bloc.dart';

import '../stores/search_event.dart';
import '../stores/search_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final bloc = context.read<SearchBloc>();

    void retry() {
      final text = bloc.textEditingController.text.trim();
      if (text.isNotEmpty) {
        bloc.add(SearchByTextRequested(text));
        return;
      }

      bloc.add(SearchPopularMoviesRequested());
    }

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
              child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: SearchHeaderDelegate(
                        topPadding: 0,
                        controller: bloc.textEditingController,
                        onSubmitted: (text) {
                          if (text.isNotEmpty) {
                            bloc.add(SearchByTextRequested(text));
                          }
                        },
                        genresSection: SelectableChipTabBar(
                          items: state.genreNames,
                          selectedIndex: state.genreSelectedIndex,
                          isActive: state.genreFilterActive,
                          onTap: (index, name) {
                            bloc.add(SearchGenreFilterToggled(index, name));
                          },
                        ),
                      ),
                    ),
                    switch (state.loadingStatus) {
                      LoadingStatus.none => const SliverToBoxAdapter(
                          child: SizedBox.shrink(),
                        ),
                      LoadingStatus.loading => const LoadingSliver(),
                      LoadingStatus.empty => const MessageSliver(
                          message: 'Nenhum resultado encontrado',
                        ),
                      LoadingStatus.error => ErrorRetrySliver(
                          message: state.failureMessage,
                          onRetry: retry,
                        ),
                      LoadingStatus.complete => SearchResultsSliver(
                          results: state.displayedResults,
                          bottomPadding: bottomPadding,
                          onMovieTap: (movie) {
                            Navigator.of(context).pushNamed(
                              AppRoutes.details,
                              arguments: bloc.buildDetailsArgs(movie),
                            );
                          },
                          genreNamesFor: (movie) => bloc.genreNamesFor(movie),
                          imageUrlFor: (movie) => bloc.imageUrlBuilder
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
}
