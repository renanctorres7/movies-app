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
  var loadingStatus = LoadingStatus.none.obs;

  addToList(String? text) async {
    loadingStatus.value = LoadingStatus.loading;
    listResults.clear();
    if (text != null && text.isNotEmpty) {
      final result = await getListResults(text);
      result.fold((failure) => null, (List<SearchResults>? value) {
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
}
