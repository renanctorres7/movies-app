import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/utils/loading_status.dart';
import '../../domain/entities/search_results.dart';
import '../../domain/usecases/search_by_text.dart';

import '../../domain/errors/errors.dart';

class SearchStore extends GetxController {
  final SearchByText usecase;

  SearchStore(this.usecase) : super();

  TextEditingController textEditingController = TextEditingController();

  Future<Either<Failure, List<SearchResults>>> getListResults(
      String text) async {
    return await usecase(text);
  }

  var listResults = <SearchResults>[].obs;
  var loadingStatus = LoadingStatus.loading.obs;

  addToList(String? text) async {
    loadingStatus.value = LoadingStatus.loading;
    listResults.clear();
    if (text != null && text.isNotEmpty) {
      final result = await getListResults(text);
      result.fold((failure) => null, (List<SearchResults>? value) {
        if (value != null && value.isNotEmpty) {
          loadingStatus.value = LoadingStatus.complete;
          listResults.value = value;
        } else if (value != null && value.isEmpty) {
          loadingStatus.value = LoadingStatus.empty;
        } else if (value == null) {
          loadingStatus.value = LoadingStatus.error;
        }
      });
    }
    loadingStatus.value = LoadingStatus.complete;
  }
}
