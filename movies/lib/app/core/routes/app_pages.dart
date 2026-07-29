import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app/core/routes/app_routes.dart';
import 'package:movies/app/core/utils/dependency_creator.dart';
import 'package:movies/app/features/search/presenter/pages/details_page.dart';
import 'package:movies/app/features/search/presenter/pages/search_page.dart';

import '../../features/search/presenter/models/movie_details_args.dart';
import '../../features/search/presenter/stores/search_bloc.dart';
import '../../features/search/presenter/stores/search_event.dart';

class AppPages {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.search:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) => SearchBloc(
                      searchByTextUsecase: getIt(),
                      getPopularMoviesUsecase: getIt(),
                      getGenresListUsecase: getIt(),
                      resolveGenreNamesUsecase: getIt(),
                      filterByGenreUsecase: getIt(),
                      collectUniqueGenreNamesUsecase: getIt(),
                      imageUrlBuilder: getIt(),
                    )..add(SearchStarted()),
                child: const SearchPage()));
      case AppRoutes.details:
        final args = settings.arguments as MovieDetailsArgs;
        return MaterialPageRoute(
            builder: (_) => DetailsPage(
                  args: args,
                ));
      default:
        return null;
    }
  }
}
