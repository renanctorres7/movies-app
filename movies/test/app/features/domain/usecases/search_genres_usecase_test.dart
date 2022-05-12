import 'package:flutter_test/flutter_test.dart';
import 'package:movies/app/features/domain/repositories/search_genres_repository.dart';
import 'package:movies/app/features/domain/usecases/search_by_text.dart';
import 'package:movies/app/features/domain/usecases/search_genres_usecase.dart';

void main() {
  final repository = SearchGenresRepository();
  final usecase = SearchGenresUsecaseImpl();
  test('Should receive a Search Genres list', () async {});
}
