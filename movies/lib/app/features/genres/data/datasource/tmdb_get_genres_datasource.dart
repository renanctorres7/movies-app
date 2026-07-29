import 'dart:convert';

import 'package:http/http.dart';
import 'package:movies/app/core/core.dart';
import 'package:movies/app/features/genres/infra/datasources/datasources.dart';
import 'package:movies/app/features/genres/infra/models/models.dart';

import '../../../../core/errors/api_exception.dart';

class TmdbGetGenresDatasource implements GetGenresListDatasource {
  final Client client;
  final String apiKey;

  TmdbGetGenresDatasource(
    this.client, {
    String? apiKey,
  }) : apiKey = apiKey ?? TmdbConfig.apiKey;

  @override
  Future<List<GenresModel>> getGenresList() async {
    final result = await client.get(
      Uri.parse(TmdbEndpoints.getGenresSearch(apiKey)),
    );

    if (result.statusCode == 200) {
      final json = jsonDecode(result.body) as Map<String, dynamic>;
      final jsonList = json['genres'] as List;

      return jsonList
          .map((item) => GenresModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw ApiException(statusCode: result.statusCode, message: result.body);
  }
}
