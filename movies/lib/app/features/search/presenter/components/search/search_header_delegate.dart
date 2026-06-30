import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/core/widgets/search_box.dart';

class SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  SearchHeaderDelegate({
    required this.controller,
    required this.onSubmitted,
    required this.topPadding,
    required this.genresSection,
  });

  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final double topPadding;
  final Widget genresSection;

  static const double _searchHeight = 36;
  static const double _bodyBottomPadding = 8;
  static const double _bodyTopPadding = 8;
  static const double _expandedBodyHeight = 190;
  static const double _genresBarHeight = 30;

  double get _collapsedBodyHeight =>
      _searchHeight + _bodyTopPadding + _bodyBottomPadding;

  @override
  double get maxExtent => _expandedBodyHeight + topPadding;

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
        showTitle ? (32 * (1 - shrinkPercent)).clamp(0.0, 32.0) : 0.0;
    final spacingHeight =
        showTitle ? (20 * (1 - shrinkPercent)).clamp(0.0, 20.0) : 0.0;
    final genresTopPadding =
        showGenres ? (16 * (1 - shrinkPercent * 3)).clamp(0.0, 16.0) : 0.0;

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
              top: topPadding + _bodyTopPadding,
              left: 20,
              right: 20,
              bottom: _bodyBottomPadding,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final genresBlockHeight = showGenres && genresTopPadding > 0
                    ? genresTopPadding + _genresBarHeight
                    : 0.0;
                final reservedHeight =
                    titleHeight + spacingHeight + genresBlockHeight;
                final maxSearchHeight = isCompact ? _searchHeight : 47.0;
                final searchHeight = (constraints.maxHeight - reservedHeight)
                    .clamp(0.0, maxSearchHeight);

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
                          height: searchHeight,
                        ),
                        if (showGenres && genresTopPadding > 0)
                          Padding(
                            padding: EdgeInsets.only(top: genresTopPadding),
                            child: SizedBox(
                              height: _genresBarHeight,
                              child: genresSection,
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
        oldDelegate.topPadding != topPadding ||
        oldDelegate.genresSection != genresSection;
  }
}
