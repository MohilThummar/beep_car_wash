import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/screens/timer_screen/timer_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TimerScreen extends GetView<TimerController> {
  final String? washId;
  final String? washTimer;
  const TimerScreen({this.washId, this.washTimer, Key? key}) : super(key: key);

  static const routeName = "/TimerScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimerController>(
      builder: (logic) {
        return Scaffold(
          body: SafeArea(
            bottom: false,
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const CustomAppBar(
                  title: "Timer",
                  isButton: false,
                ),
                SizedBox(height: 4.h),
                Obx(() {
                  return Text(
                    "Your remains time is ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  );
                }),
                SizedBox(height: 5.h),
                Container(
                  width: 72.w,
                  height: 72.w,
                  padding: EdgeInsets.all(6.w),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE7FBF4),
                  ),
                  child: Container(
                    width: 76.w,
                    height: 76.w,
                    padding: EdgeInsets.all(6.w),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFD9F3EA),
                    ),
                    child: CircularCountDownTimer(
                      duration: 36000,
                      initialDuration: 0,
                      controller: controller.countDownController.value,
                      width: 60.w,
                      height: 60.w,
                      ringColor: AppColors.whiteColor,
                      fillColor: AppColors.appColorText,
                      strokeWidth: 0.6.h,
                      strokeCap: StrokeCap.round,
                      textStyle: TextStyle(
                        fontSize: 20.sp,
                        color: AppColors.appColorText,
                        fontWeight: FontWeight.bold,
                      ),
                      textFormat: CountdownTextFormat.MM_SS,
                      isReverse: false,
                      isReverseAnimation: false,
                      isTimerTextShown: true,
                      autoStart: true,
                      onStart: () {
                        printAction('Countdown Started');
                      },
                      onComplete: () {
                        printOkStatus('Countdown Ended');
                      },
                      onChange: (String timeStamp) {
                        printAction('Countdown Changed $timeStamp');
                      },
                      timeFormatterFunction: (defaultFormatterFunction, duration) {
                        if (duration.inSeconds == 0) {
                          return "00:00";
                        } else {
                          controller.min.value = duration.inMinutes;
                          return Function.apply(defaultFormatterFunction, [duration]);
                        }
                      },
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: CustomButton(
                    onPressed: () {
                      controller.stopMachineAPI(washId!);
                    },
                    text: "Stop",
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 1.6.h),
              ],
            ),
          ),
        );
      },
    );
  }
}