import 'package:get/get.dart';
import 'package:movies/app/core/routes/app_routes.dart';
import 'package:movies/app/features/presenter/bindings/search_bindings.dart';
import 'package:movies/app/features/presenter/pages/search_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.search,
        page: () => const SearchPage(),
        binding: SearchBindings())
  ];
}
