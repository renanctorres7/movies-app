import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/app/core/widgets/big_poster_widget.dart';
import 'package:movies/app/features/search/domain/entities/entities.dart';

class SearchResultsSliver extends StatelessWidget {
  const SearchResultsSliver({
    super.key,
    required this.results,
    required this.bottomPadding,
    required this.onMovieTap,
    required this.genreNamesFor,
    required this.imageUrlFor,
  });

  final List<SearchResultsEntity> results;
  final double bottomPadding;
  final void Function(SearchResultsEntity movie) onMovieTap;
  final List<String> Function(SearchResultsEntity movie) genreNamesFor;
  final String Function(SearchResultsEntity movie) imageUrlFor;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 8.h + bottomPadding),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final movie = results[index];
            final genreNames = genreNamesFor(movie);
            final subtitle = genreNames.length >= 2
                ? '${genreNames[0]} - ${genreNames[1]}'
                : genreNames.isNotEmpty
                    ? genreNames.first
                    : '';

            return GestureDetector(
              onTap: () => onMovieTap(movie),
              child: BigPosterWidget(
                imageUrl: imageUrlFor(movie),
                title: movie.title ?? '',
                subtitle: subtitle,
              ),
            );
          },
          childCount: results.length,
        ),
      ),
    );
  }
}
