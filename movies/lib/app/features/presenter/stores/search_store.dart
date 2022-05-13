import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../domain/entities/search_results.dart';
import '../../domain/usecases/search_by_text.dart';

import '../../domain/errors/errors.dart';

class SearchStore extends GetxController {
  final SearchByText usecase;

  SearchStore(this.usecase);

  TextEditingController textEditingController = TextEditingController();

  Future<Either<Failure, List<SearchResults>>> getListResults(
      String text) async {
    return await usecase(text);
  }
}
