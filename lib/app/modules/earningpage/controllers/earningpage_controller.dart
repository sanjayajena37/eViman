import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../constants/shared_preferences_keys.dart';
import '../../../widgets/MyWidget.dart';
import '../../ConnectorController.dart';
import '../EarningModel.dart';

class EarningpageController extends GetxController {
  //TODO: Implement EarningpageController

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
  EarningModel ?earningModel;
  getRiderId() async {
    MyWidgets.showLoading3();
    riderId = await SharedPreferencesKeys().getStringData(key: 'riderId');
    authToken = await SharedPreferencesKeys().getStringData(key: 'authToken');
    Get.back();
    getEarningDetails();
  }
  getEarningDetails() {
    MyWidgets.showLoading3();
    Get.find<ConnectorController>().GETMETHODCALL_TOKEN(
        api:
        "http://65.1.169.159:3000/api/rides/v1/get-earning-history",
        token: authToken ?? "",
        fun: (map) {
          log(">>>>${jsonEncode(map)}");
          Get.back();
          if (map is Map &&
              map.containsKey("success") &&
              map['success'] == true) {
            earningModel = EarningModel.fromJson(map as Map<String,dynamic>);
            update(['earn']);
          } else {
            earningModel = null;
            Get.back();
          }
        });
  }

  void increment() => count.value++;
}
