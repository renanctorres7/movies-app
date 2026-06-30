import 'package:flutter/material.dart';
import 'package:movies/app/core/theme/app_colors.dart';

class LoadingSliver extends StatelessWidget {
  const LoadingSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.colorHighlight,
          strokeWidth: 6,
        ),
      ),
    );
  }
}
