import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:movies/app/features/domain/usecases/search_by_text.dart';

import '../../../domain/entities/search_results.dart';
import '../../../domain/errors/errors.dart';

class SearchStore extends NotifierStore<Failure, List<SearchResults>> {
  final SearchByText usecase;
  SearchStore(this.usecase) : super([]);

  getListResults(String text) async {
    executeEither(() async => await usecase(text)
        as Future<EitherAdapter<Failure, List<SearchResults>>>);
  }
}
