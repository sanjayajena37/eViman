import 'dart:async';
import 'dart:ui';

import 'package:dateplan/app/constants/helper.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants/shared_preferences_keys.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import 'package:geolocator/geolocator.dart' as geoLoc;

import 'package:permission_handler/permission_handler.dart' as permission;

import '../../../widgets/MyWidget.dart';
import '../../../widgets/Snack.dart';
import '../../ConnectorController.dart';
import '../../driverDashboard/controllers/driver_dashboard_controller.dart';
import '../../logesticdashboard/controllers/logesticdashboard_controller.dart';
import '../../loginscreen/controllers/loginscreen_controller.dart';
class SpalshscreenController extends GetxController with Helper{
  //TODO: Implement SpalshscreenController

  final count = 0.obs;
  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    super.onInit();
  }
  @override
  void onReady() {
    infoDialog2();
    askPermissions();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if(permissionAllow){
        getLoginDetails();

      /*  Utils.checkInternetConnectivity().then((value) {
          if (value) {
            getLoginDetails();
          } else {
            Snack.callError("Please turn on your internet");
          }
        });*/
      }
    });
    /*if(kDebugMode){
      FirebaseCrashlytics.instance.crash();
    }*/
    super.onReady();
  }



  @override
  void onClose() {

   /* Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SecondScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );*/
    super.onClose();
  }

  void increment() => count.value++;

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    geoLoc.LocationPermission permission;


    permission = await geoLoc.Geolocator.checkPermission();
    if(permission == geoLoc.LocationPermission.always){
      return true;
    }
    if (permission == geoLoc.LocationPermission.denied || permission == geoLoc.LocationPermission.whileInUse ) {
      return false;
    }
    if (permission == geoLoc.LocationPermission.deniedForever) {
      // openAppSettings();
      // ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied.')));
      return false;
    }
    if(permission == geoLoc.LocationPermission.whileInUse){
      return false;
    }
    return true;
  }

  void infoDialog1() async {
    var status = await permission.Permission.location.status;
    var status1 = await permission.Permission.locationAlways.status;
    // var status2 = await permission.Permission.notification.status;
    print(">>>>>>>>>>>>>>status$status");

    if (status.isDenied || status.isPermanentlyDenied || status1.isDenied || status1.isPermanentlyDenied ) {
      bool isOk = await showCommonPopupNew6(
          (status.isDenied )?"This app collects location data to enable features like Live vehicle tracking ,Calculate ride price as per K.M and Time, even when the app is closed or not in use."
              :"If you are not allowing the permission then you are not able to use the application features. To use this features go to App settings page and follow the instruction mentioned on the screen.",
          "are you agree?",
          barrierDismissible: true,
          isYesOrNoPopup: true
      );
      if (isOk) {
        print(">>>>>>>>>>>>>>>sta loc"+status.toString());
        if(status.isDenied){
          await permission. Permission.location.request();
          await permission. Permission.notification.request();

          var status = await permission.Permission.location.status;
          if (status.isDenied || status.isPermanentlyDenied){
            permission.openAppSettings();
          }
        }else{
          permission.openAppSettings();
        }
      }
    }else{
      await permission. Permission.notification.request();
      permissionAllow = true;
    }
  }

  void infoDialog2() async {
    var status = await permission.Permission.location.status;
    // var status1 = await permission.Permission.locationAlways.status;
    // var status2 = await permission.Permission.notification.status;
    print(">>>>>>>>>>>>>>status$status");
    if (status.isDenied || status.isPermanentlyDenied ) {
      bool isOk = await showCommonPopupNew6(
        // "eViman App need your run time location permission.It's required to give smooth less service to you",
          "This app collects location data to enable features like Live vehicle tracking ,Calculate ride price as per K.M and Time, even when the app is closed or not in use.",
          "are you agree?",
          barrierDismissible: true,
          isYesOrNoPopup: true
      );
      if (isOk) {
        // permission.openAppSettings();
        await permission.Permission.location.request();
        await permission.Permission.notification.request();
      }
    }
  }

  bool permissionAllow = false;
  askPermissions() async {
    // var sta =  permission.Permission.locationAlways;
    handleLocationPermission().then((value) async {

      if(value){
        var sta = await permission. Permission.notification.request();
        if(sta.isPermanentlyDenied || sta.isDenied){
          permissionAllow = false;
          update(['allPage']);
        }else{
          permissionAllow = true;
          update(['allPage']);
        }
      }else{
        permissionAllow = false;
        update(['allPage']);
      }
    });
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

  getOnlineDetails(String id) {
    try{
      MyWidgets.showLoading3();
      Get.find<ConnectorController>().GETMETHODCALL(
          api:
          "https://backend.eviman.co.in/api/vehicles/v1/online-status/"+id,
          fun: (map) {
            Get.back();
            if(map is Map && map['status'] != null && map['status'] == 0){
              callOrStopServices();
            }
          });
    }catch(e){
      Get.back();
    }

  }

  getLoginDetails() async {

    String? isLogin = await SharedPreferencesKeys().getStringData(key: 'isLogin');
    String? vehicleId = await SharedPreferencesKeys().getStringData(key: 'vehicleId');
    String? vehicleMode = await SharedPreferencesKeys().getStringData(key: 'vehicleMode');
    String? loginTime = await SharedPreferencesKeys().getStringData(key: 'loginTime');
    if(loginTime != null && loginTime != ""){
      DateTime loginDate = DateTime.parse(loginTime);
      print(">>>>>>>>>>difference${DateTime.now().difference(loginDate).inDays}");
      if(DateTime.now().difference(loginDate).inDays >= 20){
        await SharedPreferencesKeys().setStringData(key: "authToken", text: "");
        await SharedPreferencesKeys()
            .setStringData(key: "isLogin", text: "false");
        await SharedPreferencesKeys().setStringData(key: "riderId", text: "");
        callOrStopServices().then((value) {
          Get.delete<LoginscreenController>();
          Get.delete<DriverDashboardController>();
          Get.delete<LogesticdashboardController>();
          Get.offAndToNamed(Routes.LOGINSCREEN);
        });
        permissionAllow = false;
        Snack.callError("Login Expired");
      }else{
        if(isLogin == "true"){

          if(vehicleMode == "cab"){
            getOnlineDetails(vehicleId??"");
            Get.delete<SpalshscreenController>();
            Get.offAllNamed(Routes.DRIVER_DASHBOARD);
            permissionAllow = false;
          }else if(vehicleMode == "logistic"){
            Get.delete<SpalshscreenController>();
            Get.offAllNamed(Routes.LOGESTICDASHBOARD);
            permissionAllow = false;
          }else{
            Get.delete<SpalshscreenController>();
            Get.offAllNamed(Routes.INTROSCREEN);
            permissionAllow = false;
          }
        }
        else{
          Get.delete<SpalshscreenController>();
          Get.offAllNamed(Routes.INTROSCREEN);
          permissionAllow = false;
        }
      }
    }else{
      Get.delete<SpalshscreenController>();
      Get.offAllNamed(Routes.INTROSCREEN);
      permissionAllow = false;
    }

  }

}
