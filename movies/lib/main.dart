import 'package:flutter/material.dart';

import 'package:movies/app/app_widget.dart';

import 'app/core/utils/dependency_creator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyCreator.init();
  runApp(const AppWidget());
}
