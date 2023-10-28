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
import '../../../routes/app_pages.dart';
import 'package:geolocator/geolocator.dart' as geoLoc;

import 'package:permission_handler/permission_handler.dart' as permission;
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


  getLoginDetails() async {
    // callOrStopServices();
    String? isLogin = await SharedPreferencesKeys().getStringData(key: 'isLogin');
    if(isLogin == "true"){
      Get.offAllNamed(Routes.DRIVER_DASHBOARD);
    }else{
      Get.toNamed(Routes.INTROSCREEN);
    }
  }

}
