import 'package:json_annotation/json_annotation.dart';
import 'package:movies/app/features/genres/domain/entities/entities.dart';

part 'genres_model.g.dart';

@JsonSerializable()
class GenresModel extends GenresEntity {
  const GenresModel({
    required super.id,
    required super.name,
  });

  factory GenresModel.fromJson(Map<String, dynamic> json) =>
      _$GenresModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenresModelToJson(this);

  factory GenresModel.fromEntity(GenresEntity entity) => GenresModel(
        id: entity.id,
        name: entity.name,
      );
}
