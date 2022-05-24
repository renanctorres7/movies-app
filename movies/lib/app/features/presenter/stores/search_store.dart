import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movies/app/features/domain/entities/search_genres.dart';
import 'package:movies/app/features/domain/usecases/search_genres_usecase.dart';

import '../../../core/utils/loading_status.dart';
import '../../domain/entities/search_results.dart';
import '../../domain/usecases/search_by_text.dart';

import '../../domain/errors/errors.dart';

class SearchStore extends GetxController {
  final SearchByText usecase;
  final SearchGenresUsecase genresUsecase;

  SearchStore({required this.usecase, required this.genresUsecase}) : super();

  TextEditingController textEditingController = TextEditingController();

  Future<Either<Failure, List<SearchResults>>> getListResults(
      String text) async {
    final result = await usecase(text);
    return result;
  }

  var listResults = <SearchResults>[].obs;
  var loadingStatus = LoadingStatus.none.obs;

  @override
  void onInit() {
    super.onInit();
    addGenresToList();
  }

  var listGenresByName = <String>[].obs;

  addToList(String text) async {
    loadingStatus.value = LoadingStatus.loading;
    listResults.clear();

    if (text.isNotEmpty) {
      final result = await getListResults(text);
      result.fold((failure) => null, (List<SearchResults> value) {
        if (value.isNotEmpty) {
          listResults.value = value;
          addSpecificGenresNameToList();
          Future.delayed(const Duration(seconds: 1),
              () => loadingStatus.value = LoadingStatus.complete);
        } else if (value.isEmpty) {
          Future.delayed(const Duration(seconds: 1),
              () => loadingStatus.value = LoadingStatus.empty);
        } else {
          Future.delayed(const Duration(seconds: 1),
              () => loadingStatus.value = LoadingStatus.error);
        }
      });
    }
  }

  var genresList = <SearchGenres>[].obs;

  Future<Either<Failure, List<SearchGenres>>> getGenresList() async {
    final result = await genresUsecase();
    return result;
  }

  addGenresToList() async {
    final result = await getGenresList();
    result.fold((failure) => null, (List<SearchGenres> value) {
      if (value.isNotEmpty) {
        genresList.addAll(value);
      }
    });
  }

  List<String> getGenresListNameByIdList(List idList) {
    List<String> list = [];
    if (genresList.isNotEmpty && idList.isNotEmpty) {
      for (int i = 0; i < idList.length; i++) {
        for (var element in genresList) {
          if (idList[i] == element.id) {
            list.add(element.name);
          }
        }
      }
    }
    return list;
  }

  String getSpecificGenreName(int index, int number) {
    if (genreFilterActive.value == false) {
      final list = getGenresListNameByIdList(listResults[index].genreIds!);

      if (list.isNotEmpty) {
        return list[number];
      }
      return '';
    } else {
      final list =
          getGenresListNameByIdList(listResultsFilter[index].genreIds!);

      if (list.isNotEmpty) {
        return list[number];
      }
      return '';
    }
  }

  List<String> addSpecificGenresNameToList() {
    listGenresByName.clear();
    List list = [];
    for (var item in listResults) {
      list.addAll(item.genreIds!);
    }
    final result = list.toSet().toList();
    listGenresByName.value = getGenresListNameByIdList(result);
    return listGenresByName;
  }

  var imageUrl = ''.obs;
  var title = ''.obs;
  var originalTitle = ''.obs;
  var popularity = 0.0.obs;
  var overview = ''.obs;
  var year = ''.obs;
  var genresDetailsPage = <String>[].obs;

  setDataToDetailsPage(int index) {
    genresDetailsPage.clear();

    if (genreFilterActive.value == false) {
      imageUrl.value = listResults[index].backdropPath ?? "";
      title.value = listResults[index].title ?? "";

      originalTitle.value = listResults[index].originalTitle ?? "";
      popularity.value = listResults[index].voteAverage?.toDouble() ?? 0;
      overview.value = listResults[index].overview ?? "";
      year.value = listResults[index].releaseDate?.substring(0, 4) ?? "";
      genresDetailsPage.value =
          getGenresListNameByIdList(listResults[index].genreIds!);
    } else {
      imageUrl.value = listResultsFilter[index].backdropPath ?? "";
      title.value = listResultsFilter[index].title ?? "";

      originalTitle.value = listResultsFilter[index].originalTitle ?? "";
      popularity.value = listResultsFilter[index].voteAverage?.toDouble() ?? 0;
      overview.value = listResultsFilter[index].overview ?? "";
      year.value = listResultsFilter[index].releaseDate?.substring(0, 4) ?? "";
      genresDetailsPage.value =
          getGenresListNameByIdList(listResultsFilter[index].genreIds!);
    }
  }

  var genreSelectedIndex = 0.obs;
  var genreFilterActive = false.obs;
  var listResultsFilter = <SearchResults>[].obs;

  setGenreFilter(int index, String genreName) {
    listResultsFilter.clear();
    loadingStatus.value = LoadingStatus.loading;
    genreSelectedIndex.value = index;
    genreFilterActive.value = !genreFilterActive.value;
    if (listResults.isNotEmpty && genreFilterActive.value == true) {
      for (var item in listResults) {
        List list = getGenresListNameByIdList(item.genreIds!);
        if (list.contains(genreName)) {
          listResultsFilter.add(item);
        }
      }
    }
    Future.delayed(const Duration(seconds: 1),
        () => loadingStatus.value = LoadingStatus.complete);
  }
}
