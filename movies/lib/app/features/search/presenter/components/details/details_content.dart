import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/core/widgets/horizontal_chip_list.dart';

class DetailsContent extends StatelessWidget {
  const DetailsContent({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.originalTitle,
    required this.popularity,
    required this.year,
    required this.genreNames,
    required this.overview,
  });

  final String imageUrl;
  final String title;
  final String originalTitle;
  final double popularity;
  final String year;
  final List<String> genreNames;
  final String overview;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(2, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    height: 318,
                    width: 216,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return SizedBox(
                        width: size.width,
                        height: size.height,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: 200,
                            child: LinearProgressIndicator(
                              color: AppColors.colorGray03,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${popularity.toStringAsFixed(1)} ',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  color: AppColors.colorHighlight,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                ' /10',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: AppColors.colorGray03,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Text(
            title.toUpperCase(),
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: AppColors.colorGray01,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            'Título original: $originalTitle',
            style: GoogleFonts.montserrat(
              fontSize: 10,
              color: AppColors.colorGray02,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            alignment: Alignment.center,
            width: 100,
            height: 35,
            decoration: BoxDecoration(
              color: AppColors.colorGray08,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Ano: ',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: AppColors.colorGray03,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  year,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: AppColors.colorGray01,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
          child: HorizontalChipList(items: genreNames),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 56, left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Descrição',
              textAlign: TextAlign.left,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: AppColors.colorGray02,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 20,
            right: 20,
            bottom: 32,
          ),
          child: Text(
            overview,
            textAlign: TextAlign.left,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: AppColors.colorGray01,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
