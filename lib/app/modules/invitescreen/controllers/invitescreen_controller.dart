import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:get/get.dart';

import '../../../widgets/CustomeTittleText.dart';

class InvitescreenController extends GetxController  with GetSingleTickerProviderStateMixin  {
  //TODO: Implement InvitescreenController

  final count = 0.obs;
  FlutterGifController? flutterGifController;
  String ?referralCode;
  @override
  void onInit() {
    flutterGifController = FlutterGifController(
      vsync: this,
    );
    referralCode = Get.arguments;
    super.onInit();
  }
  void openCustomDialog(FlutterGifController controller) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutCubic.transform(a1.value) - 1.0;
          // return Transform.scale(
          //   scale: a1.value,
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GifImage(
                      controller: controller,
                      image: const AssetImage("assets/json/invite_sent.gif"),
                    ),
                    // Image.asset(
                    //   "Assets/Images/invite_sent.gif",
                    //   height: 80,
                    //   width: 80,
                    //   filterQuality: FilterQuality.high,
                    //   fit: BoxFit.contain,
                    // ),
                    CustomeTittleText(text: 'Invitation Sent'),
                  ],
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: Get.context!,
        pageBuilder: (context, animation1, animation2) {
          return const SizedBox();
        });
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
