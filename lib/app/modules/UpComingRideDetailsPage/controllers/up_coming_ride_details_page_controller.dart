import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/shared_preferences_keys.dart';
import '../../ConnectorController.dart';
import '../../logesticdashboard/UpComingRidesModel.dart';



class UpComingRideDetailsPageController extends GetxController {
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
  Future<void> upDateRideStatusComplete(String? sta,  String? amount,
      {String? bookingId}) async {
    // MyWidgets.showLoading3();
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
          print(">>>>>>>>>>>>>>>>>>>>>map$map");
          // Get.back();
        });
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
