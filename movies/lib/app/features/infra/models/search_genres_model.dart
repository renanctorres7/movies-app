import 'package:json_annotation/json_annotation.dart';
import 'package:movies/app/features/domain/entities/search_genres.dart';

part 'search_genres_model.g.dart';

@JsonSerializable()
class SearchGenresModel extends SearchGenres {
  SearchGenresModel({required int id, required String name})
      : super(id: id, name: name);

  factory SearchGenresModel.fromJson(Map<String, dynamic> json) =>
      _$SearchGenresModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchGenresModelToJson(this);
}
