import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BigPosterWidget extends StatelessWidget {
  const BigPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 470.h,
          width: 320.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r), color: Colors.yellow),
        ),
      ],
    );
  }
}
