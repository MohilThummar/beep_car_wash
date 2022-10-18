import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/bottom_sheet/nearest_beep_sheet/nearest_beep_sheet.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/find_a_beep_controller.dart';
import 'package:beep_car_wash/widgets/custom_container.dart';
import 'package:beep_car_wash/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FindABeepScreen extends GetView<FindABeepController> {
  const FindABeepScreen({Key? key}) : super(key: key);
  static const routeName = "/FindABeepScreen";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          ImagePath.dummyImage5,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Obx(() {
          return Container(
            child: controller.mapView.value
                ? Image.asset(
                    ImagePath.dummyImage4,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : const SizedBox(),
          );
        }),
        Padding(
          padding: EdgeInsets.only(left: 6.w, right: 6.w, top: MediaQuery.of(context).padding.top + 1.5.h, bottom: 1.5.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Constants.scaffoldKey.currentState!.openDrawer();
                    },
                    child: CustomContainer(
                      height: 5.h,
                      width: 5.h,
                      circleView: true,
                      boxShadowVisible: true,
                      horizontalPadding: 1.4.h,
                      child: Image.asset(ImagePath.drawer),
                    ),
                  ),
                  Image.asset(
                    ImagePath.appNameImageShadow,
                    width: 11.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.mapView.value = true;

                      showModalBottomSheet(
                        context: context,
                        backgroundColor: AppColors.transparentColor,
                        barrierColor: AppColors.transparentColor,
                        builder: (context) => const NearestBeepSheet(),
                      );
                    },
                    child: CustomContainer(
                      height: 5.h,
                      width: 5.h,
                      circleView: true,
                      boxShadowVisible: true,
                      horizontalPadding: 1.2.h,
                      child: Image.asset(ImagePath.location),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              CustomContainer(
                isHeight: false,
                boxShadowVisible: true,
                borderRadius: 1.h,
                padding: EdgeInsets.only(left: 1.6.h, top: 0.8.h, bottom: 0.8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextView(
                      Strings.setALocation,
                      textStyleNew: MyTextStyle(
                        textColor: AppColors.appColor,
                        textWeight: FontWeight.w600,
                        textSize: 8.6.sp,
                      ),
                    ),
                    SizedBox(height: 0.6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.search_rounded,
                          size: 2.8.h,
                          color: AppColors.appColor,
                        ),
                        SizedBox(width: 0.8.h),
                        Expanded(
                          child: CustomTextField(
                            controller: controller.searchController,
                            textInputAction: TextInputAction.done,
                            hintText: Strings.yourLocation,
                            textSize: 10.sp,
                            isDense: true,
                            containerVisible: false,
                            borderVisible: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
