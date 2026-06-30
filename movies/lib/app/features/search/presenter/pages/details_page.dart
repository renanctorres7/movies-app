import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/features/search/presenter/components/components.dart';
import 'package:movies/app/features/search/presenter/models/movie_details_args.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as MovieDetailsArgs;
    final movie = args.movie;
    final year = movie.releaseDate != null && movie.releaseDate!.length >= 4
        ? movie.releaseDate!.substring(0, 4)
        : '';
    final size = MediaQuery.of(context).size;

    return Container(
      color: AppColors.colorGray08,
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.colorGray08,
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: ListView(
              children: [
                const DetailsBackButton(),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Container(
                        color: Colors.white,
                        width: size.width,
                        height: size.height,
                      ),
                    ),
                    DetailsContent(
                      imageUrl: args.imageUrl,
                      title: movie.title ?? '',
                      originalTitle: movie.originalTitle ?? '',
                      popularity: movie.voteAverage?.toDouble() ?? 0,
                      year: year,
                      genreNames: args.genreNames,
                      overview: movie.overview ?? '',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
