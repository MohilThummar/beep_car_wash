import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:beep_car_wash/screens/timer_screen/timer_binding.dart';
import 'package:beep_car_wash/screens/timer_screen/timer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrCodeController extends GetxController {
  Utils utils = Utils();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? qrViewController;
  RxString screen = "".obs;
  RxString machineId = "".obs;
  TextEditingController code = TextEditingController();

  onQRViewCreated(QRViewController controller) {
    qrViewController = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      printAction(result!.code!);
      controller.pauseCamera();
      if (screen.value == "Report") {
        reportScanToStartAPI(false);
      } else {
        scanToStartAPI();
      }
      update();
    });
  }

  /// ---- Scan To Start API ------------>>>
  scanToStartAPI() async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "qr_code": result!.code,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.scanToStart,
      params: formData,
    );

    if (data["code"] == 200) {
      if (data["data"]["is_machine_start"] == 0) {
        utils.showSnackBar(context: Get.context!, message: "Machine is reserve for someone, Please wait to his time end.");
        qrViewController!.resumeCamera();
      } else {
        utils.showToast(context: Get.context!, message: "Machine start successfully");
        qrViewController?.stopCamera();
        qrViewController!.dispose();
        Get.to(() => const TimerScreen(), binding: TimerBinding(), arguments: [data["data"]["data"]["wash_id"], data["data"]["data"]["wash_timer"]]);
      }
    } else if (data["code"] == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
      qrViewController!.resumeCamera();
    }
  }

  //{"code":200,"data":{"is_machine_start":1,"data":{"wash_id":"13221668963914637a5e4a2fc296.71030739","wash_timer":"10","wash_start":"2022-11-20 17:05:14"}}}

  /// ---- Report Scan To Start API ------------>>>
  reportScanToStartAPI(bool very) async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "machine_id": machineId.value,
      "qr_code": very ? code.text.trim() : result!.code,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.scanToReport,
      params: formData,
    );

    if (data["code"] == 200) {
      Get.back(result: result?.code.toString());
    } else if (data["code"] == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
      qrViewController!.resumeCamera();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    qrViewController?.dispose();
  }

  @override
  void onInit() {
    screen.value = Get.arguments[0].toString();
    machineId.value = Get.arguments[1].toString();
    update();
    super.onInit();
  }
}
