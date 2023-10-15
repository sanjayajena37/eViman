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
    super.onInit();
  }





  @override
  void onReady() {
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
