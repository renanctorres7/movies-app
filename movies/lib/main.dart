import 'package:flutter/material.dart';
import 'package:movies/app/app_widget.dart';
import 'package:movies/app/core/utils/dependency_creator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyCreator.init();
  runApp(const AppWidget());
}
