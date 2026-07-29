sealed class SearchEvent {}

class SearchStarted extends SearchEvent {}

class SearchPopularMoviesRequested extends SearchEvent {}

class SearchGenresListRequested extends SearchEvent {}

class SearchByTextRequested extends SearchEvent {
  final String text;
  SearchByTextRequested(this.text);
}

class SearchGenreFilterToggled extends SearchEvent {
  final int index;
  final String name;
  SearchGenreFilterToggled(this.index, this.name);
}

