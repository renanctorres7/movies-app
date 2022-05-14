import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/features/presenter/widgets/genres_tab_bar.dart';
import 'package:movies/app/features/presenter/widgets/search_box.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar(
      {Key? key,
      required this.controller,
      required this.onSubmitted,
      required this.list})
      : super(key: key);

  final TextEditingController controller;
  final Function(String) onSubmitted;
  final List list;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.white, Colors.white.withOpacity(0.1)],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Container(
        color: AppColors.colorWhite,
        height: 230.h,
        width: size.width,
        child: Padding(
          padding: EdgeInsets.only(top: 48.h, left: 20.w, right: 20.w),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Filmes',
                  style: themeData.textTheme.headline2,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 24.h),
                  child: SearchBox(
                    controller: controller,
                    onSubmitted: onSubmitted,
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: GenresTabBar(
                    list: list,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
