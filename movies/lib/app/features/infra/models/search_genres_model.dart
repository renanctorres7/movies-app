import 'dart:convert';

import 'package:movies/app/features/domain/entities/search_genres.dart';

class SearchGenresModel extends SearchGenres {
  SearchGenresModel({required int id, required String name})
      : super(id: id, name: name);

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  static SearchGenresModel fromMap(Map<String, dynamic> map) {
    return SearchGenresModel(id: map['id'], name: map['name']);
  }

  String toJson() => jsonEncode(toMap());

  static SearchGenresModel fromJson(String source) =>
      fromMap(jsonDecode(source));
}
