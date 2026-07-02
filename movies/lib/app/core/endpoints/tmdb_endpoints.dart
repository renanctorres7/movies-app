class TmdbEndpoints {
  static String getUrlMovieSearch(String apiKey, String text) =>
      'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&language=pt-BR&query=$text&include_adult=false';

  static String getGenresSearch(String apiKey) =>
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=pt-BR';

  static String getPopularMovies(String apiKey, {int page = 1}) =>
      'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=pt-BR&page=$page';

  static const String baseImageUrl = 'https://image.tmdb.org/t/p/original/';
}
