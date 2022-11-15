import 'dart:ui' as ui;

import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/responce_model/machine_responce_model.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindABeepController extends GetxController {
  Utils utils = Utils();
  TextEditingController searchController = TextEditingController();
  RxBool mapView = false.obs;

  GoogleMapController? mapController;

  RxList<Marker> markers = <Marker>[].obs;

  getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  /// ---- User Registartion Api ------------>>>
  getMachineAPI() async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "lat": "40.7127753",
      "long": "-74.0059728",
      // "lat": Constants.latitude,
      // "long": Constants.longitude,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.getMachines,
      params: formData,
    );

    MachinesResponseModel model = MachinesResponseModel.fromJson(data);
    if (model.code == 200) {
      // Uint8List markerIcon;
      //
      // for (int i = 0; i < model.data!.length; i++) {
      //   if (i == 0) {
      //     markerIcon = await getBytesFromAssets(ImagePath.selectMarker, 190);
      //   } else {
      //     markerIcon = await getBytesFromAssets(ImagePath.marker, 160);
      //   }
      //
      //   markers.add(
      //     Marker(
      //       markerId: MarkerId(i.toString()),
      //       position: LatLng(double.parse(model.data![i].lat!), double.parse(model.data![i].long!)),
      //       onTap: () {
      //         if (i == 0) {
      //         } else {
      //           mapController!.animateCamera(CameraUpdate.newLatLngZoom(LatLng(double.parse(model.data![i].lat!), double.parse(model.data![i].long!)), 18));
      //           showModalBottomSheet(
      //             context: Get.context!,
      //             backgroundColor: AppColors.transparentColor,
      //             barrierColor: AppColors.transparentColor,
      //             builder: (context) => const NearestBeepSheet(),
      //           );
      //           // bottamSheetView(context, nearestBeepResponseData![i - 1].tagline, nearestBeepResponseData![i - 1].reserveTime);
      //           // navigateLatitude = latitudeList[i].latitude;
      //           // navigateLongitude = latitudeList[i].longitude;
      //         }
      //       },
      //       icon: BitmapDescriptor.fromBytes(markerIcon),
      //     ),
      //   );
      // }
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 900), () {
      mapView.value = true;
    });
  }
}
