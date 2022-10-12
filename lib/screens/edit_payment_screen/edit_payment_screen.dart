import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/screens/edit_payment_screen/edit_payment_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:beep_car_wash/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EditPaymentScreen extends GetView<EditPaymentController> {
  const EditPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(vertical: 1.6.h, horizontal: 6.w).copyWith(top: MediaQuery.of(Get.context!).padding.top + AppBar().preferredSize.height + 2.h),
              children: [
                SizedBox(height: 1.h),
                Obx(() {
                  return CustomTextField(
                    isTitle: true,
                    title: "Card Number",
                    hintText: "Input Card Number",
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.number,
                    controller: controller.cardNumberController,
                    isError: controller.cardNumberError.value,
                    hintColor: controller.cardNumberError.value ? appColors.errorColor : appColors.lightTextColor,
                    textColor: controller.cardNumberError.value ? appColors.errorColor : appColors.darkTextColor,
                  );
                }),
                SizedBox(height: 1.6.h),
                Obx(() {
                  return CustomTextField(
                    isTitle: true,
                    title: "Card Holder Name",
                    hintText: "Input Name",
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    controller: controller.cardHolderNameController,
                    isError: controller.cardHolderNameError.value,
                    hintColor: controller.cardHolderNameError.value ? appColors.errorColor : appColors.lightTextColor,
                    textColor: controller.cardHolderNameError.value ? appColors.errorColor : appColors.darkTextColor,
                  );
                }),
                SizedBox(height: 1.6.h),
                Obx(() {
                  return CustomTextField(
                    isTitle: true,
                    title: "Expiration Date",
                    hintText: "DD/MM/YYYY",
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.datetime,
                    controller: controller.expirationDateController,
                    isError: controller.expirationDateError.value,
                    hintColor: controller.expirationDateError.value ? appColors.errorColor : appColors.lightTextColor,
                    textColor: controller.expirationDateError.value ? appColors.errorColor : appColors.darkTextColor,
                    suffix: Padding(
                      padding: EdgeInsets.all(1.2.h),
                      child: Image.asset(
                        ImagePath.date,
                      ),
                    ),
                  );
                }),
                SizedBox(height: 1.6.h),
                Obx(() {
                  return CustomTextField(
                    isTitle: true,
                    title: "CVV",
                    hintText: "Input CVV",
                    textInputAction: TextInputAction.done,
                    inputType: TextInputType.number,
                    controller: controller.cvvController,
                    isError: controller.cvvError.value,
                    hintColor: controller.cvvError.value ? appColors.errorColor : appColors.lightTextColor,
                    textColor: controller.cvvError.value ? appColors.errorColor : appColors.darkTextColor,
                    suffix: Padding(
                      padding: EdgeInsets.all(1.4.h),
                      child: Image.asset(
                        ImagePath.cardSmall,
                      ),
                    ),
                  );
                }),
                SizedBox(height: 1.8.h),
                Row(
                  children: [
                    MyTextView(
                      "Set as Primary Payment",
                      textStyleNew: MyTextStyle(
                        textColor: appColors.darkTextColor,
                        textWeight: FontWeight.bold,
                        textSize: 12.sp,
                      ),
                    ),
                    const Spacer(),
                    Obx(() {
                      return CupertinoSwitch(
                        value: controller.primaryPayment.value,
                        onChanged: (value) {
                          controller.primaryPayment.value = value;
                        },
                        thumbColor: CupertinoColors.white,
                        activeColor: appColors.appColorText,
                      );
                    }),
                  ],
                ),
                SizedBox(height: 3.h),
                CustomButton(
                  onPressed: () {},
                  text: "Add Payment",
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
            const CustomAppBar(
              isBack: true,
              title: "Edit Payment",
            ),
          ],
        ),
      ),
    );
  }
}
