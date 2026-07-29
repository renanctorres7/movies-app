import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';

class BigPosterWidget extends StatelessWidget {
  const BigPosterWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  final String imageUrl;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black],
                    ).createShader(
                      Rect.fromLTRB(0, 0, rect.width, rect.height),
                    );
                  },
                  blendMode: BlendMode.darken,
                  child: Image.network(
                    imageUrl,
                    height: 430,
                    width: 300,
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
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
                  ),
                ),
              )
            else
              Container(
                width: 300,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.colorGray03),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 12, top: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      Icons.movie,
                      size: 24,
                      color: AppColors.colorGray03,
                    ),
                  ),
                ),
              ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.only(left: 24, bottom: 32, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        title,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: imageUrl.isNotEmpty
                              ? AppColors.colorWhite
                              : AppColors.colorGray01,
                        ),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: imageUrl.isNotEmpty
                            ? AppColors.colorWhite
                            : AppColors.colorGray01,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
