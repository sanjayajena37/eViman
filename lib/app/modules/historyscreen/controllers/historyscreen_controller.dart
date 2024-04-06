import 'dart:convert';
import 'dart:developer';

import 'package:dateplan/app/providers/Utils.dart';
import 'package:get/get.dart';

import '../../../constants/shared_preferences_keys.dart';
import '../../../widgets/MyWidget.dart';
import '../../ConnectorController.dart';
import '../RideHistoryModel.dart';

class HistoryscreenController extends GetxController {
  //TODO: Implement HistoryscreenController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getRiderId();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String? riderId;
  String? authToken;
  getRiderId() async {
    MyWidgets.showLoading3();
    riderId = await SharedPreferencesKeys().getStringData(key: 'riderId');
    authToken = await SharedPreferencesKeys().getStringData(key: 'authToken');
    Get.back();
    getProfileDetails();
  }
  RideHistoryModel? rideHistoryModel;
  List<Rides> rideHistory = [];
  getProfileDetails() {
    MyWidgets.showLoading3();
    Get.find<ConnectorController>().GETMETHODCALL_TOKEN(
        api:
            "https://backend.eviman.co.in/api/rides/v1/get-rider-rides",
        token: authToken ?? "",
        fun: (map) {
          log(">>>>${jsonEncode(map)}");
          Get.back();
          if (map is Map &&
              map.containsKey("success") &&
              map['success'] == true) {
            rideHistory.clear();
            rideHistoryModel = RideHistoryModel.fromJson(map as Map<String,dynamic>);
            rideHistory = rideHistoryModel?.rides??[];
            rideHistory.sort((a,b) => Utils.convertDateFormat2(b.rideStartTime).compareTo(Utils.convertDateFormat2(a.rideStartTime)) );
            update(['his']);
          } else {
            rideHistoryModel = null;
            rideHistory = [];
            Get.back();
          }
        });
  }

  void increment() => count.value++;
}
