import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../constants/localfiles.dart';
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
  void onInit() {



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
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    sliderTimer.cancel();
    // animationController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
