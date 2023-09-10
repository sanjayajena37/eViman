import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants/shared_preferences_keys.dart';
import '../../../routes/app_pages.dart';

class SpalshscreenController extends GetxController {
  //TODO: Implement SpalshscreenController

  final count = 0.obs;
  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    handleLocationPermission();
    requestForNotification();
    super.onInit();
  }

  requestForNotification() async {
    await Permission.notification.isDenied.then((value) {
      if(value){
        Permission.notification.request();
      }
    }) ;
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

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
  Future<void> callOrStopServices() async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    try {
      final service = FlutterBackgroundService();
      bool isRunning = await service.isRunning();
      if (isRunning) {
        service.invoke("stopService");
      }
      return;
    } catch (e) {
      print(">>>>>>\n\n" + e.toString());
      return;
    }
  }

  void calBackgroundServices() async {
    try{
      final service = FlutterBackgroundService();
      bool isRunning = await service.isRunning();
      if(isRunning == false){
        service.startService();
      }
      // FlutterBackgroundService().invoke("setAsForeground");
      // FlutterBackgroundService().invoke("setAsBackground");
    }catch(e){
      print(">>>>>>>>>>>"+e.toString());
    }

  }
  getLoginDetails() async {
    callOrStopServices();
    String? isLogin = await SharedPreferencesKeys().getStringData(key: 'isLogin');
    if(isLogin == "true"){
      Get.offAndToNamed(Routes.DRIVER_DASHBOARD);
    }else{
      Get.toNamed(Routes.INTROSCREEN);
    }
  }

}
