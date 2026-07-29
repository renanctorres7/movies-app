
import 'package:equatable/equatable.dart';
import 'package:movies/app/core/utils/loading_status.dart';
import 'package:movies/app/features/search/domain/entities/search_results_entity.dart';

import '../../../genres/domain/entities/entities.dart';

class SearchState extends Equatable {

  final List<SearchResultsEntity> results;
  final List<SearchResultsEntity> filteredResults;
  final List<GenresEntity> genres;
  final List<String> genreNames;
  final LoadingStatus loadingStatus;
  final String failureMessage;
  final int genreSelectedIndex;
  final bool genreFilterActive;

  const SearchState({
    this.results = const [],
    this.filteredResults = const [],
    this.genres = const [],
    this.genreNames = const [],
    this.loadingStatus = LoadingStatus.none,
    this.failureMessage = '',
    this.genreSelectedIndex = 0,
    this.genreFilterActive = false,
  });

  @override
  List<Object?> get props => [
    results,
    filteredResults,
    genres,
    genreNames,
    loadingStatus,
    failureMessage,
    genreSelectedIndex,
    genreFilterActive,
  ];

  SearchState copyWith({
    List<SearchResultsEntity>? results,
    List<SearchResultsEntity>? filteredResults,
    List<GenresEntity>? genres,
    List<String>? genreNames,
    LoadingStatus? loadingStatus,
    String? failureMessage,
    int? genreSelectedIndex,
    bool? genreFilterActive,
  }) {
    return SearchState(
      results: results ?? this.results,
      filteredResults: filteredResults ?? this.filteredResults,
      genres: genres ?? this.genres,
      genreNames: genreNames ?? this.genreNames,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      failureMessage: failureMessage ?? this.failureMessage,
      genreSelectedIndex: genreSelectedIndex ?? this.genreSelectedIndex,
      genreFilterActive: genreFilterActive ?? this.genreFilterActive,
    );
  }
  List<SearchResultsEntity> get displayedResults => genreFilterActive ? filteredResults : results;
}