import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/app/core/utils/loading_status.dart';
import 'package:movies/app/features/domain/entities/search_results.dart';
import 'package:movies/app/features/domain/errors/errors.dart';
import 'package:movies/app/features/domain/usecases/genre_usecases.dart';
import 'package:movies/app/features/domain/usecases/search_by_text.dart';
import 'package:movies/app/features/domain/usecases/search_genres_usecase.dart';
import 'package:movies/app/features/presenter/stores/search_store.dart';

class SearchByTextMock extends Mock implements SearchByText {}

class SearchGenresUsecaseMock extends Mock implements SearchGenresUsecase {}

void main() {
  late SearchStore store;
  late SearchByText usecase;
  late SearchGenresUsecase genresUsecase;

  setUp(() {
    Get.testMode = true;
    usecase = SearchByTextMock();
    genresUsecase = SearchGenresUsecaseMock();
    store = SearchStore(
      usecase: usecase,
      genresUsecase: genresUsecase,
      resolveGenreNamesUsecase: ResolveGenreNamesUsecase(),
      filterByGenreUsecase:
          FilterSearchResultsByGenreUsecase(ResolveGenreNamesUsecase()),
      collectUniqueGenreNamesUsecase:
          CollectUniqueGenreNamesUsecase(ResolveGenreNamesUsecase()),
    );
  });

  tearDown(() {
    store.onClose();
    Get.reset();
  });

  test('searchMovies sets complete status when use case succeeds', () async {
    const text = 'vingadores';
    final results = [SearchResults(title: 'Vingadores')];

    when(() => usecase(text)).thenAnswer((_) async => Right(results));
    when(() => genresUsecase()).thenAnswer((_) async => const Right([]));

    await store.searchMovies(text);

    expect(store.loadingStatus.value, LoadingStatus.complete);
    expect(store.listResults.length, 1);
  });

  test('searchMovies sets error status when use case fails', () async {
    const text = 'vingadores';

    when(() => usecase(text))
        .thenAnswer((_) async => Left(UnexpectedFailure()));

    await store.searchMovies(text);

    expect(store.loadingStatus.value, LoadingStatus.error);
    expect(store.failureMessage.value, isNotEmpty);
  });
}
