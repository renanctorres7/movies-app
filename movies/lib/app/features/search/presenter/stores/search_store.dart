import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/app/core/utils/loading_status.dart';
import 'package:movies/app/core/errors/errors.dart';
import 'package:movies/app/features/genres/domain/entities/entities.dart';
import 'package:movies/app/features/genres/domain/usecases/usecases.dart';
import 'package:movies/app/features/search/domain/entities/entities.dart';
import 'package:movies/app/features/search/domain/usecases/usecases.dart';
import 'package:movies/app/features/search/infra/contracts/image_url_builder.dart';
import 'package:movies/app/features/search/presenter/models/movie_details_args.dart';

class SearchStore extends GetxController {
  final SearchByTextUsecase searchByTextUsecase;
  final GetPopularMoviesUsecase getPopularMoviesUsecase;
  final GetGenresListUsecase getGenresListUsecase;
  final ResolveGenreNamesUsecase resolveGenreNamesUsecase;
  final FilterSearchResultsByGenreUsecase filterByGenreUsecase;
  final CollectUniqueGenreNamesUsecase collectUniqueGenreNamesUsecase;
  final ImageUrlBuilder imageUrlBuilder;

  SearchStore({
    required this.searchByTextUsecase,
    required this.getPopularMoviesUsecase,
    required this.getGenresListUsecase,
    required this.resolveGenreNamesUsecase,
    required this.filterByGenreUsecase,
    required this.collectUniqueGenreNamesUsecase,
    required this.imageUrlBuilder,
  });

  final textEditingController = TextEditingController();

  final listResults = <SearchResultsEntity>[].obs;
  final listResultsFilter = <SearchResultsEntity>[].obs;
  final genresList = <GenresEntity>[].obs;
  final listGenresByName = <String>[].obs;
  final loadingStatus = LoadingStatus.none.obs;
  final failureMessage = ''.obs;
  final genreSelectedIndex = 0.obs;
  final genreFilterActive = false.obs;

  List<SearchResultsEntity> get displayedResults =>
      genreFilterActive.value ? listResultsFilter : listResults;

  @override
  void onInit() {
    super.onInit();
    loadGenres();
    loadPopularMovies();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  Future<void> loadPopularMovies() async {
    loadingStatus.value = LoadingStatus.loading;
    failureMessage.value = '';
    listResults.clear();
    listResultsFilter.clear();
    genreFilterActive.value = false;
    listGenresByName.clear();

    final result = await getPopularMoviesUsecase();
    result.fold(
      (failure) {
        failureMessage.value = _messageForFailure(failure);
        loadingStatus.value = LoadingStatus.error;
      },
      (value) {
        if (value.isEmpty) {
          loadingStatus.value = LoadingStatus.empty;
          return;
        }

        listResults.value = value;
        listGenresByName.value = collectUniqueGenreNamesUsecase(
          results: value,
          genres: genresList,
        );
        loadingStatus.value = LoadingStatus.complete;
      },
    );
  }

  Future<void> searchMovies(String text) async {
    loadingStatus.value = LoadingStatus.loading;
    failureMessage.value = '';
    listResults.clear();
    listResultsFilter.clear();
    genreFilterActive.value = false;
    listGenresByName.clear();

    final result = await searchByTextUsecase(text);
    result.fold(
      (failure) {
        failureMessage.value = _messageForFailure(failure);
        loadingStatus.value = LoadingStatus.error;
      },
      (value) {
        if (value.isEmpty) {
          loadingStatus.value = LoadingStatus.empty;
          return;
        }

        listResults.value = value;
        listGenresByName.value = collectUniqueGenreNamesUsecase(
          results: value,
          genres: genresList,
        );
        loadingStatus.value = LoadingStatus.complete;
      },
    );
  }

  Future<void> loadGenres() async {
    final result = await getGenresListUsecase();
    result.fold(
      (_) => null,
      (value) {
        if (value.isNotEmpty) {
          genresList.assignAll(value);
          if (listResults.isNotEmpty) {
            listGenresByName.value = collectUniqueGenreNamesUsecase(
              results: listResults,
              genres: genresList,
            );
          }
        }
      },
    );
  }

  List<String> genreNamesFor(SearchResultsEntity movie) {
    return resolveGenreNamesUsecase(
      genreIds: movie.genreIds ?? [],
      genres: genresList,
    );
  }

  MovieDetailsArgs buildDetailsArgs(SearchResultsEntity movie) {
    return MovieDetailsArgs(
      movie: movie,
      genreNames: genreNamesFor(movie),
      imageUrl: imageUrlBuilder.buildPosterUrl(movie.backdropPath ?? ''),
    );
  }

  void setGenreFilter(int index, String genreName) {
    listResultsFilter.clear();
    loadingStatus.value = LoadingStatus.loading;
    genreSelectedIndex.value = index;
    genreFilterActive.value = !genreFilterActive.value;

    if (listResults.isNotEmpty && genreFilterActive.value) {
      listResultsFilter.value = filterByGenreUsecase(
        results: listResults,
        genreName: genreName,
        genres: genresList,
      );
    }

    loadingStatus.value = LoadingStatus.complete;
  }

  String _messageForFailure(FailureError failure) {
    if (failure is InvalidSearchText) {
      return 'Digite um termo de busca válido.';
    }
    if (failure is NullError) {
      return 'Nenhum resultado encontrado.';
    }
    return 'Não foi possível carregar os filmes. Tente novamente.';
  }
}
