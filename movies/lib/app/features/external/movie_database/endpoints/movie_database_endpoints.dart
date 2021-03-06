class MovieDatabaseEndpoints {
  static String getUrlMovieSearch(String apiKey, String text) =>
      'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&language=pt-BR&query=$text&include_adult=false';

  static String getGenresSearch(String apiKey) =>
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=pt-BR';

  static String baseImageUrl = "http://image.tmdb.org/t/p/original/";
}
