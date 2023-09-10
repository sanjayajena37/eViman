import 'dart:async';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';

import '../../../constants/localfiles.dart';
import '../../driverDashboard/controllers/workmanager_initializer.dart';
import '../pagePopup.dart';

class IntroscreenController extends GetxController with GetTickerProviderStateMixin{
  //TODO: Implement IntroscreenController

  final count = 0.obs;
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewModelData = [];
  // late AnimationController animationController;
  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void onInit()  {


    pageViewModelData.add(PageViewData(
      titleText: "Plan your trip",
      subText: "We have responsibility to reach your destination",
      assetsImage: 'assets/json/lottie1.json',
    ));

    pageViewModelData.add(PageViewData(
      titleText: "Plan your trip",
      subText: "We are here to give best routes",
      assetsImage: 'assets/json/lottie3.json',
    ));
    pageViewModelData.add(PageViewData(
      titleText: "Plan your trip",
      subText: "Now you reached your destination",
      assetsImage: 'assets/json/lottie6.json',
    ));

    sliderTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (currentShowIndex == 0) {
        pageController.animateTo(Get.size.width,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 1) {
        pageController.animateTo(Get.size.width * 2,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 2) {
        pageController.animateTo(0,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
    // animationController.forward();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    WidgetsFlutterBinding.ensureInitialized();
    callOrStopServices();

    super.onReady();
  }

  callOrStopServices() async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    try{
      final service = FlutterBackgroundService();
      bool isRunning = await service.isRunning();
      if(isRunning){
        service.invoke("stopService");
      }
    }catch(e){
      print(">>>>>>"+e.toString());
    }

  }

  @override
  void onClose() {
    sliderTimer.cancel();
    // animationController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
