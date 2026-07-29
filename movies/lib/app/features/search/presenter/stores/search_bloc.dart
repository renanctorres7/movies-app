import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app/core/core.dart';
import 'package:movies/app/features/search/presenter/models/movie_details_args.dart';

import '../../../../core/utils/loading_status.dart';
import '../../../genres/domain/usecases/usecases.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../../infra/contracts/image_url_builder.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchByTextUsecase searchByTextUsecase;
  final GetPopularMoviesUsecase getPopularMoviesUsecase;
  final GetGenresListUsecase getGenresListUsecase;
  final ResolveGenreNamesUsecase resolveGenreNamesUsecase;
  final FilterSearchResultsByGenreUsecase filterByGenreUsecase;
  final CollectUniqueGenreNamesUsecase collectUniqueGenreNamesUsecase;
  final ImageUrlBuilder imageUrlBuilder;

  SearchBloc({
    required this.searchByTextUsecase,
    required this.getPopularMoviesUsecase,
    required this.getGenresListUsecase,
    required this.resolveGenreNamesUsecase,
    required this.filterByGenreUsecase,
    required this.collectUniqueGenreNamesUsecase,
    required this.imageUrlBuilder,
  }) : super(SearchState()) {
    on<SearchStarted>(_onSearchStarted);
    on<SearchPopularMoviesRequested>(_onSearchPopularMoviesRequested);
    on<SearchGenresListRequested>(_onSearchGenresListRequested);
    on<SearchByTextRequested>(_onSearchByTextRequested);
    on<SearchGenreFilterToggled>(_onSearchGenreFilterToggled);
  }

  final textEditingController = TextEditingController();

  void _onSearchStarted(SearchStarted event, Emitter<SearchState> emit) {
    add(SearchPopularMoviesRequested());
    add(SearchGenresListRequested());
  }

  Future<void> _onSearchPopularMoviesRequested(
      SearchPopularMoviesRequested event, Emitter<SearchState> emit) async {
    emit(state.copyWith(
      loadingStatus: LoadingStatus.loading,
      failureMessage: '',
      results: const [],
      filteredResults: const [],
      genreFilterActive: false,
      genreNames: const [],
    ));

    final result = await getPopularMoviesUsecase();

    result.fold(
      (failure) {
        emit(state.copyWith(
            loadingStatus: LoadingStatus.error,
            failureMessage: _messageForFailure(failure)));
      },
      (value) {
        emit(state.copyWith(
          results: value,
          genreNames: collectUniqueGenreNamesUsecase(
            results: value,
            genres: state.genres,
          ),
          loadingStatus:
              value.isEmpty ? LoadingStatus.empty : LoadingStatus.complete,
        ));
      },
    );
  }

  Future<void> _onSearchGenresListRequested(
    SearchGenresListRequested event,
    Emitter<SearchState> emit,
  ) async {
    final result = await getGenresListUsecase();
    result.fold(
      (_) {},
      (value) {
        if (value.isEmpty) return;
        emit(state.copyWith(
          genres: value,
          genreNames: state.results.isNotEmpty
              ? collectUniqueGenreNamesUsecase(
                  results: state.results,
                  genres: value,
                )
              : state.genreNames,
        ));
      },
    );
  }

  Future<void> _onSearchByTextRequested(
    SearchByTextRequested event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(
      loadingStatus: LoadingStatus.loading,
      failureMessage: '',
      results: const [],
      filteredResults: const [],
      genreFilterActive: false,
      genreNames: const [],
    ));
    final result = await searchByTextUsecase(event.text);
    result.fold(
      (failure) {
        emit(state.copyWith(
          loadingStatus: LoadingStatus.error,
          failureMessage: _messageForFailure(failure),
        ));
      },
      (value) {
        emit(state.copyWith(
          results: value,
          genreNames: collectUniqueGenreNamesUsecase(
            results: value,
            genres: state.genres,
          ),
          loadingStatus:
              value.isEmpty ? LoadingStatus.empty : LoadingStatus.complete,
        ));
      },
    );
  }

  void _onSearchGenreFilterToggled(
    SearchGenreFilterToggled event,
    Emitter<SearchState> emit,
  ) {
    final genreFilterActive = !state.genreFilterActive;
    final filteredResults = state.results.isNotEmpty && genreFilterActive
        ? filterByGenreUsecase(
            results: state.results,
            genreName: event.name,
            genres: state.genres,
          )
        : <SearchResultsEntity>[];
    emit(state.copyWith(
      filteredResults: filteredResults,
      genreSelectedIndex: event.index,
      genreFilterActive: genreFilterActive,
      loadingStatus: LoadingStatus.complete,
    ));
  }

  List<String> genreNamesFor(SearchResultsEntity movie) {
    return resolveGenreNamesUsecase(
      genreIds: movie.genreIds ?? [],
      genres: state.genres,
    );
  }

  MovieDetailsArgs buildDetailsArgs(SearchResultsEntity movie) {
    return MovieDetailsArgs(
      movie: movie,
      genreNames: genreNamesFor(movie),
      imageUrl: imageUrlBuilder.buildPosterUrl(movie.backdropPath ?? ''),
    );
  }

  String _messageForFailure(FailureError failure) {
    if (failure is InvalidSearchText) {
      return 'Digite um termo de busca válido.';
    }
    if (failure is NullError) {
      return 'Nenhum resultado encontrado.';
    }
    if (failure is ApiError) {
      if (failure.statusCode == 401) {
        return 'Sessão inválida. Verifique a API key.';
      } else if (failure.statusCode >= 500) {
        return 'Serviço indisponível. Tente mais tarde.';
      } else {
        return 'Não foi possível carregar os dados. Tente novamente.';
      }
    } else {
      return 'Não foi possível carregar os filmes. Tente novamente.';
    }
  }

  @override
  Future<void> close() {
    textEditingController.dispose();
    return super.close();
  }
}

// class SearchStore extends GetxController {
//   final SearchByTextUsecase searchByTextUsecase;
//   final GetPopularMoviesUsecase getPopularMoviesUsecase;
//   final GetGenresListUsecase getGenresListUsecase;
//   final ResolveGenreNamesUsecase resolveGenreNamesUsecase;
//   final FilterSearchResultsByGenreUsecase filterByGenreUsecase;
//   final CollectUniqueGenreNamesUsecase collectUniqueGenreNamesUsecase;
//   final ImageUrlBuilder imageUrlBuilder;

//   SearchStore({
//     required this.searchByTextUsecase,
//     required this.getPopularMoviesUsecase,
//     required this.getGenresListUsecase,
//     required this.resolveGenreNamesUsecase,
//     required this.filterByGenreUsecase,
//     required this.collectUniqueGenreNamesUsecase,
//     required this.imageUrlBuilder,
//   });

//   final textEditingController = TextEditingController();

//   final listResults = <SearchResultsEntity>[].obs;
//   final listResultsFilter = <SearchResultsEntity>[].obs;
//   final genresList = <GenresEntity>[].obs;
//   final listGenresByName = <String>[].obs;
//   final loadingStatus = LoadingStatus.none.obs;
//   final failureMessage = ''.obs;
//   final genreSelectedIndex = 0.obs;
//   final genreFilterActive = false.obs;

//   List<SearchResultsEntity> get displayedResults =>
//       genreFilterActive.value ? listResultsFilter : listResults;

//   @override
//   void onInit() {
//     super.onInit();
//     loadGenres();
//     loadPopularMovies();
//   }

//   @override
//   void onClose() {
//     textEditingController.dispose();
//     super.onClose();
//   }

//   Future<void> loadPopularMovies() async {
//     loadingStatus.value = LoadingStatus.loading;
//     failureMessage.value = '';
//     listResults.clear();
//     listResultsFilter.clear();
//     genreFilterActive.value = false;
//     listGenresByName.clear();

//     final result = await getPopularMoviesUsecase();
//     result.fold(
//       (failure) {
//         failureMessage.value = _messageForFailure(failure);
//         loadingStatus.value = LoadingStatus.error;
//       },
//       (value) {
//         if (value.isEmpty) {
//           loadingStatus.value = LoadingStatus.empty;
//           return;
//         }

//         listResults.value = value;
//         listGenresByName.value = collectUniqueGenreNamesUsecase(
//           results: value,
//           genres: genresList,
//         );
//         loadingStatus.value = LoadingStatus.complete;
//       },
//     );
//   }

//   Future<void> searchMovies(String text) async {
//     loadingStatus.value = LoadingStatus.loading;
//     failureMessage.value = '';
//     listResults.clear();
//     listResultsFilter.clear();
//     genreFilterActive.value = false;
//     listGenresByName.clear();

//     final result = await searchByTextUsecase(text);
//     result.fold(
//       (failure) {
//         failureMessage.value = _messageForFailure(failure);
//         loadingStatus.value = LoadingStatus.error;
//       },
//       (value) {
//         if (value.isEmpty) {
//           loadingStatus.value = LoadingStatus.empty;
//           return;
//         }

//         listResults.value = value;
//         listGenresByName.value = collectUniqueGenreNamesUsecase(
//           results: value,
//           genres: genresList,
//         );
//         loadingStatus.value = LoadingStatus.complete;
//       },
//     );
//   }

//   Future<void> loadGenres() async {
//     final result = await getGenresListUsecase();
//     result.fold(
//       (_) => null,
//       (value) {
//         if (value.isNotEmpty) {
//           genresList.assignAll(value);
//           if (listResults.isNotEmpty) {
//             listGenresByName.value = collectUniqueGenreNamesUsecase(
//               results: listResults,
//               genres: genresList,
//             );
//           }
//         }
//       },
//     );
//   }

//   List<String> genreNamesFor(SearchResultsEntity movie) {
//     return resolveGenreNamesUsecase(
//       genreIds: movie.genreIds ?? [],
//       genres: genresList,
//     );
//   }

//   MovieDetailsArgs buildDetailsArgs(SearchResultsEntity movie) {
//     return MovieDetailsArgs(
//       movie: movie,
//       genreNames: genreNamesFor(movie),
//       imageUrl: imageUrlBuilder.buildPosterUrl(movie.backdropPath ?? ''),
//     );
//   }

//   void setGenreFilter(int index, String genreName) {
//     listResultsFilter.clear();
//     loadingStatus.value = LoadingStatus.loading;
//     genreSelectedIndex.value = index;
//     genreFilterActive.value = !genreFilterActive.value;

//     if (listResults.isNotEmpty && genreFilterActive.value) {
//       listResultsFilter.value = filterByGenreUsecase(
//         results: listResults,
//         genreName: genreName,
//         genres: genresList,
//       );
//     }

//     loadingStatus.value = LoadingStatus.complete;
//   }

//   String _messageForFailure(FailureError failure) {
//     if (failure is InvalidSearchText) {
//       return 'Digite um termo de busca válido.';
//     }
//     if (failure is NullError) {
//       return 'Nenhum resultado encontrado.';
//     }
//     return 'Não foi possível carregar os filmes. Tente novamente.';
//   }
// }
