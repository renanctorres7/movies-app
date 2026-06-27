import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/app/core/utils/loading_status.dart';
import 'package:movies/app/features/domain/entities/search_genres.dart';
import 'package:movies/app/features/domain/entities/search_results.dart';
import 'package:movies/app/features/domain/errors/errors.dart';
import 'package:movies/app/features/domain/usecases/genre_usecases.dart';
import 'package:movies/app/features/domain/usecases/search_by_text.dart';
import 'package:movies/app/features/domain/usecases/search_genres_usecase.dart';
import 'package:movies/app/features/presenter/models/movie_details_args.dart';

class SearchStore extends GetxController {
  final SearchByText usecase;
  final SearchGenresUsecase genresUsecase;
  final ResolveGenreNamesUsecase resolveGenreNamesUsecase;
  final FilterSearchResultsByGenreUsecase filterByGenreUsecase;
  final CollectUniqueGenreNamesUsecase collectUniqueGenreNamesUsecase;

  SearchStore({
    required this.usecase,
    required this.genresUsecase,
    required this.resolveGenreNamesUsecase,
    required this.filterByGenreUsecase,
    required this.collectUniqueGenreNamesUsecase,
  });

  final textEditingController = TextEditingController();

  final listResults = <SearchResults>[].obs;
  final listResultsFilter = <SearchResults>[].obs;
  final genresList = <SearchGenres>[].obs;
  final listGenresByName = <String>[].obs;
  final loadingStatus = LoadingStatus.none.obs;
  final failureMessage = ''.obs;
  final genreSelectedIndex = 0.obs;
  final genreFilterActive = false.obs;

  List<SearchResults> get displayedResults =>
      genreFilterActive.value ? listResultsFilter : listResults;

  @override
  void onInit() {
    super.onInit();
    loadGenres();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  Future<void> searchMovies(String text) async {
    loadingStatus.value = LoadingStatus.loading;
    failureMessage.value = '';
    listResults.clear();
    listResultsFilter.clear();
    genreFilterActive.value = false;
    listGenresByName.clear();

    final result = await usecase(text);
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
    final result = await genresUsecase();
    result.fold(
      (_) => null,
      (value) {
        if (value.isNotEmpty) {
          genresList.assignAll(value);
        }
      },
    );
  }

  List<String> genreNamesFor(SearchResults movie) {
    return resolveGenreNamesUsecase(
      genreIds: movie.genreIds ?? [],
      genres: genresList,
    );
  }

  MovieDetailsArgs buildDetailsArgs(SearchResults movie) {
    return MovieDetailsArgs(
      movie: movie,
      genreNames: genreNamesFor(movie),
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

  String _messageForFailure(Failure failure) {
    if (failure is InvalidSearchText) {
      return 'Digite um termo de busca válido.';
    }
    if (failure is EmptyResultFailure) {
      return 'Nenhum resultado encontrado.';
    }
    return 'Não foi possível carregar os filmes. Tente novamente.';
  }
}
