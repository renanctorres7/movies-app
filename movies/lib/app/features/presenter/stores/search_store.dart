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
    return await usecase(text);
  }

  var listResults = <SearchResults>[].obs;
  var loadingStatus = LoadingStatus.none.obs;

  @override
  void onInit() {
    super.onInit();
    addGenresToList();
  }

  addToList(String? text) async {
    loadingStatus.value = LoadingStatus.loading;
    listResults.clear();
    if (text != null && text.isNotEmpty) {
      final result = await getListResults(text);
      result.fold((failure) => null, (List<SearchResults>? value) async {
        if (value != null && value.isNotEmpty) {
          listResults.value = value;

          Future.delayed(const Duration(seconds: 1),
              () => loadingStatus.value = LoadingStatus.complete);
        } else if (value != null && value.isEmpty) {
          Future.delayed(const Duration(seconds: 1),
              () => loadingStatus.value = LoadingStatus.empty);
        } else if (value == null) {
          Future.delayed(const Duration(seconds: 1),
              () => loadingStatus.value = LoadingStatus.error);
        } else {
          Future.delayed(const Duration(seconds: 1),
              () => loadingStatus.value = LoadingStatus.none);
        }
      });
    }
  }

  var genresList = <SearchGenres>[].obs;

  Future<Either<Failure, List<SearchGenres>>> getGenresList() async {
    return await genresUsecase();
  }

  addGenresToList() async {
    final result = await getGenresList();
    result.fold((failure) => null, (List<SearchGenres>? value) {
      if (value != null && value.isNotEmpty) {
        genresList.addAll(value);
      }
    });
  }

  List<String> getGenresListName(List? idList) {
    List<String> list = [];
    if (genresList.isNotEmpty && idList != null && idList.isNotEmpty) {
      for (int i = 0; i < idList.length; i++) {
        for (var element in genresList) {
          if (idList[i] == element.id) {
            list.add(element.name ?? "");
          }
        }
      }
    }

    return list;
  }

  var genresListNames = <String>[].obs;
  String getTwoGenresName(int index, int number) {
    genresListNames.value = getGenresListName(listResults[index].genreIds!);

    if (genresListNames.isNotEmpty && genresListNames.length >= 2) {
      return genresListNames[number];
    }
    return '';
  }
}
