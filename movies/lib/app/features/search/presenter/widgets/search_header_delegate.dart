import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/features/search/presenter/widgets/genres_tab_bar.dart';
import 'package:movies/app/features/search/presenter/widgets/search_box.dart';

class SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  SearchHeaderDelegate({
    required this.controller,
    required this.onSubmitted,
    required this.topPadding,
  });

  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final double topPadding;

  static const double _searchHeight = 36;
  static const double _verticalPadding = 16;
  static const double _expandedBodyHeight = 190;

  double get _collapsedBodyHeight =>
      _searchHeight.h + _verticalPadding.h;

  @override
  double get maxExtent => _expandedBodyHeight.h + topPadding;

  @override
  double get minExtent => _collapsedBodyHeight + topPadding;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final themeData = Theme.of(context);
    final currentExtent = maxExtent - shrinkOffset;
    final shrinkRange = maxExtent - minExtent;
    final shrinkPercent =
        shrinkRange > 0 ? (shrinkOffset / shrinkRange).clamp(0.0, 1.0) : 0.0;

    final showTitle = shrinkPercent < 0.8;
    final showGenres = shrinkPercent < 0.25;
    final isCompact = shrinkPercent > 0.05;

    final titleHeight =
        showTitle ? (32 * (1 - shrinkPercent)).clamp(0.0, 32.0).h : 0.0;
    final spacingHeight =
        showTitle ? (20 * (1 - shrinkPercent)).clamp(0.0, 20.0).h : 0.0;
    final genresTopPadding =
        showGenres ? (16 * (1 - shrinkPercent * 3)).clamp(0.0, 16.0).h : 0.0;

    return SizedBox(
      height: currentExtent,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: ColoredBox(
          color: AppColors.colorWhite,
          child: Padding(
            padding: EdgeInsets.only(
              top: topPadding + 8.h,
              left: 20.w,
              right: 20.w,
              bottom: 8.h,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ClipRect(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (titleHeight > 0)
                          SizedBox(
                            height: titleHeight,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Filmes',
                                style: themeData.textTheme.headlineSmall,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                        if (spacingHeight > 0) SizedBox(height: spacingHeight),
                        SearchBox(
                          controller: controller,
                          onSubmitted: onSubmitted,
                          compact: isCompact,
                        ),
                        if (showGenres && genresTopPadding > 0)
                          Padding(
                            padding: EdgeInsets.only(top: genresTopPadding),
                            child: SizedBox(
                              height: 30.h,
                              child: const GenresTabBar(),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SearchHeaderDelegate oldDelegate) {
    return oldDelegate.controller != controller ||
        oldDelegate.onSubmitted != onSubmitted ||
        oldDelegate.topPadding != topPadding;
  }
}
