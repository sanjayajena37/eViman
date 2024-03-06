import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/helper.dart';
import '../../../constants/shared_preferences_keys.dart';
import '../../../widgets/MyWidget.dart';
import '../../ConnectorController.dart';
import '../../logesticdashboard/UpComingRidesModel.dart';




class UpComingRideDetailsPageController extends GetxController with Helper{
  //TODO: Implement UpComingRideDetailsPageController

  final count = 0.obs;
  Rides? ridesData;

  String? riderIdNew;
  String? vehicleIdNew;
  String? authToken;

  getRiderId() async {
    riderIdNew = await SharedPreferencesKeys().getStringData(key: 'riderId');
    vehicleIdNew =
    await SharedPreferencesKeys().getStringData(key: 'vehicleId');
    authToken = await SharedPreferencesKeys().getStringData(key: 'authToken');

  }
  makingPhoneCall(String? number) async {
    var url = Uri.parse("tel:${number ?? 9178109443}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void cancelRide() async {
    bool isOk = await showCommonPopupNew3(
        "Are you sure you want to cancel it?", "If yes, please press ok.",
        barrierDismissible: false,
        isYesOrNoPopup: true,
        filePath: "assets/json/question.json");
    if (isOk) {
      upDateRideStatusComplete
        ("CANCELLED BY RIDER",(ridesData?.totalAmount??"0.00").toString(),
          bookingId:ridesData?.bookingId??"");
    }
  }

  void completeRide() async {
    bool isOk = await showCommonPopupNew3(
        "Are you sure you want to complete it?", "If yes, please press ok.",
        barrierDismissible: false,
        isYesOrNoPopup: true,
        filePath: "assets/json/congratulation.json");
    if (isOk) {
      upDateRideStatusComplete
        ("COMPLETED",(ridesData?.totalAmount??"0.00").toString(),
          bookingId: ridesData?.bookingId??"");
    }
  }

  Future<void> upDateRideStatusComplete(String? sta,  String? amount,
      {String? bookingId}) async {
    MyWidgets.showLoading3();
    Map<String, dynamic> postData = {
      "bookingId": bookingId ?? "",
      "bookingStatus": sta ?? "",
      "updatedById": riderIdNew ?? "",
      "updatedByUserType": "Rider",
      "amountReceived": double.tryParse((amount??"0").toString() ?? "0") ?? 0 //Pass when bookingStatus is COMPLETED
    };
    print(">>>>>>>>>>>>>>>complete" + (postData).toString());
    Get.find<ConnectorController>().POSTMETHOD_TOKEN(
        api: "https://backend.eviman.co.in/api/rides/v1/logistics/status/update",
        token: authToken ?? "token",
        json: postData,
        fun: (map) {
          closeDialogIfOpen();
          print(">>>>>>>>>>>>>>>>>>>>>map$map");
          Get.back(result: true);
        });
  }
  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
  getData(){
    try{
      ridesData = Rides.fromJson(Get.arguments);
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
  @override
  void onInit() {
    getRiderId();
    getData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
