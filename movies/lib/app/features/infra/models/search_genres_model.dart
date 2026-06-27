import 'package:json_annotation/json_annotation.dart';
import 'package:movies/app/features/domain/entities/search_genres.dart';

part 'search_genres_model.g.dart';

@JsonSerializable()
class SearchGenresModel {
  final int id;
  final String name;

  const SearchGenresModel({
    required this.id,
    required this.name,
  });

  factory SearchGenresModel.fromJson(Map<String, dynamic> json) =>
      _$SearchGenresModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchGenresModelToJson(this);

  SearchGenres toEntity() {
    return SearchGenres(id: id, name: name);
  }
}
