import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/get_storage_data.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/responce_model/phone_verification_model.dart';
import 'package:beep_car_wash/screens/sign_in_otp_screen/sign_in_otp_binding.dart';
import 'package:beep_car_wash/screens/sign_in_otp_screen/sign_in_otp_screen.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:sizer/sizer.dart';

class SignInController extends GetxController {
  Utils utils = Utils();
  GetStorageData getStorage = GetStorageData();

  Country? selectedCountry;
  TextEditingController phoneNumberController = TextEditingController();
  RxBool? phoneNumberError = false.obs;

  @override
  void onInit() {
    initCountry();
    super.onInit();
  }

  /// ---- Show Defult Country ------------>>>
  void initCountry() async {
    printAction("initCountry");
    final country = await getDefaultCountry(Get.context!);
    selectedCountry = country;
    update();
  }

  /// ---- Show Country Code Picker ------------>>>
  void showCountryCodePicker() async {
    final country = await showCountryPickerSheet(
      Get.context!,
      title: Text(
        Strings.chooseCountry,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      cancelWidget: Positioned(
        right: 8,
        top: 4,
        bottom: 0,
        child: TextButton(
          child: Text(
            Strings.cancel,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () => Navigator.pop(Get.context!),
        ),
      ),
    );

    if (country != null) {
      selectedCountry = country;
      printAction("Country Code --------->> ${selectedCountry!.callingCode}");
      update();
    }
  }

  /// ---- Login Api ------------>>>
  phoneVerificationAPI() async {
    var formData = ({
      'phone': selectedCountry!.callingCode + phoneNumberController.text.trim(),
    });
    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.phoneVerification,
      params: formData,
    );

    PhoneVerificationModel model = PhoneVerificationModel.fromJson(data);
    if (model.code == 200) {
      utils.showToast(context: Get.context!, message: model.msg!);
      Get.to(() => const SignInOTPScreen(), binding: SignInOTPBindings(), arguments: [selectedCountry!.callingCode , phoneNumberController.text.trim(), model.token]);
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: model.msg!);
    }
  }

  bool validation() {
    if (phoneNumberController.text.isEmpty) {
      phoneNumberError!.value = true;
      utils.showSnackBar(context: Get.context!, message: "Plese enter phone number");
    } else if (!utils.phoneValidator(phoneNumberController.text)) {
      phoneNumberError!.value = true;
      utils.showSnackBar(context: Get.context!, message: "Plese enter valid phone number");
    } else {
      phoneNumberError!.value = false;
      return true;
    }
    return false;
  }
}
