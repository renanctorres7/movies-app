import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/app/core/theme/app_colors.dart';
import 'package:movies/app/features/presenter/widgets/genres_details_page_widget.dart';

import '../../../core/utils/utils.dart';
import '../stores/search_store.dart';

class DetailsPage extends GetView<SearchStore> {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.colorGray08,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: ListView(
            children: [
              _backButtonWidget(),
              Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: Container(
                        color: Colors.white,
                        width: size.width,
                        height: size.height,
                      ),
                    ),
                    _detailsList(controller, context)
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

Widget _backButtonWidget() {
  return Padding(
    padding: EdgeInsets.only(top: 48.h, left: 20.w, bottom: 56.h),
    child: Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          padding: EdgeInsets.only(right: 10.w, left: 10.w),
          width: 75.w,
          height: 35.h,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 2.r,
                    blurRadius: 5.r,
                    offset: const Offset(2, 2))
              ],
              borderRadius: BorderRadius.circular(100.r)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 15.sp,
                  color: AppColors.colorGray02,
                ),
                Text(
                  'Voltar',
                  style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: AppColors.colorGray02,
                      fontWeight: FontWeight.w500),
                )
              ]),
        ),
      ),
    ),
  );
}

Widget _detailsList(SearchStore controller, BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Column(
    children: [
      Obx(() {
        return Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 2.r,
                blurRadius: 10.r,
                offset: const Offset(2, 5))
          ], borderRadius: BorderRadius.circular(10.r)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: controller.imageUrl.value.isNotEmpty
                  ? Image.network(
                      Utils.trimUrlImage(controller.imageUrl.value),
                      height: 318.h,
                      width: 216.w,
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
                              width: 200.w,
                              child: LinearProgressIndicator(
                                color: AppColors.colorGray03,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const SizedBox()),
        );
      }),
      Padding(
        padding: EdgeInsets.only(top: 32.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Obx(() {
                return Text(
                    '${controller.popularity.value.toStringAsFixed(1)} ',
                    style: GoogleFonts.montserrat(
                      fontSize: 24.sp,
                      color: AppColors.colorHighlight,
                      fontWeight: FontWeight.w600,
                    ));
              }),
              Text(' /10',
                  style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    color: AppColors.colorGray03,
                    fontWeight: FontWeight.w600,
                  ))
            ]),
      ),
      Padding(
        padding: EdgeInsets.only(top: 32.h),
        child: Obx(() {
          return Text(controller.title.value.toUpperCase(),
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: AppColors.colorGray01,
                fontWeight: FontWeight.w600,
              ));
        }),
      ),
      Padding(
        padding: EdgeInsets.only(top: 12.h),
        child: Obx(() {
          return Text('Título original: ${controller.originalTitle.value}',
              style: GoogleFonts.montserrat(
                fontSize: 10.sp,
                color: AppColors.colorGray02,
                fontWeight: FontWeight.w500,
              ));
        }),
      ),
      Padding(
        padding: EdgeInsets.only(top: 40.h),
        child: Container(
          alignment: Alignment.center,
          width: 100.w,
          height: 35.h,
          decoration: BoxDecoration(
              color: AppColors.colorGray08,
              borderRadius: BorderRadius.circular(5.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Ano: ',
                  style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    color: AppColors.colorGray03,
                    fontWeight: FontWeight.w600,
                  )),
              Obx(() {
                return Text(controller.year.value,
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      color: AppColors.colorGray01,
                      fontWeight: FontWeight.w600,
                    ));
              }),
            ],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 12.h),
        child: GenresDetailsPageWidget(list: controller.genresDetailsPage),
      ),
      Padding(
          padding: EdgeInsets.only(top: 56.h, left: 20.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Descrição',
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: AppColors.colorGray02,
                  fontWeight: FontWeight.w400,
                )),
          )),
      Padding(
        padding: EdgeInsets.only(top: 8.h, left: 20.w, right: 20.w),
        child: Obx(() {
          return Text(controller.overview.value,
              textAlign: TextAlign.left,
              style: GoogleFonts.montserrat(
                fontSize: 12.sp,
                color: AppColors.colorGray01,
                fontWeight: FontWeight.w600,
              ));
        }),
      ),
    ],
  );
}
