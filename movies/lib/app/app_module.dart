import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies/app/features/presenter/pages/search_page.dart';
import 'package:movies/app/features/presenter/stores/search/search_store.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => SearchStore(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const SearchPage()),
  ];
}
