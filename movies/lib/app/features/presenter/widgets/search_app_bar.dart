import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 245.h,
      width: size.width,
    );
  }
}
