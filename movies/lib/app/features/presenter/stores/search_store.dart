import 'package:get/get.dart';
import 'package:movies/app/features/domain/usecases/search_by_text.dart';

class SearchStore extends GetxController {
  late SearchByText usecase;

  getListResults(String text) async {
    await usecase(text);
  }
}
