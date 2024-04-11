import 'dart:async';
import 'dart:ui';

import 'package:dateplan/app/data/ApiFactory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/validator.dart';
import '../../../widgets/MyWidget.dart';
import '../../../widgets/Snack.dart';
import '../../ConnectorController.dart';

class LoginscreenController extends GetxController {
  //TODO: Implement LoginscreenController

  final count = 0.obs;

  String errorEmail = '';
  final TextEditingController mobileController = TextEditingController();
  String errorPassword = '';
  final TextEditingController passwordController = TextEditingController();
  // late AnimationController animationController2;
  Rx<bool> termAndCondition = Rx<bool>(false);
  bool allValidation() {
    bool isValid = true;
    if (mobileController.text.trim().isEmpty) {
      errorEmail = "Mobile cannot be empty";
      isValid = false;
    } else if (mobileController.text.length < 10 ||
        mobileController.text.length > 10) {
      errorEmail = "Please enter a valid Mobile number";
      isValid = false;
    } else {
      errorEmail = '';
    }
    update(['ref']);
    return isValid;
  }

  @override
  void onInit() {
    super.onInit();
  }

  void submit() async {
    if (mobileController.text == "") return;
    var appSignatureID = await SmsAutoFill().getAppSignature;
    Map sendData = {
      "mobile": mobileController.text,
      "app_signature_id": appSignatureID
    };
    MyWidgets.showLoading3();
    Get.find<ConnectorController>().POSTMETHOD(
        api: ApiFactory.LOGIN,
        json: sendData,
        fun: (map) {
          Get.back();

          if(map is Map && map.containsKey('success')&& map['success'] == true){
            Future.delayed(const Duration(milliseconds: 600), () {
              Get.toNamed(Routes.OTPSCREEN,arguments: {"mobile":mobileController.text,"otpToken":map['token'],"otp":map['otp']});
            });
          }else{
            Snack.callError("Something went wrong");
          }
          if (kDebugMode) {
            print(">>>>>$map");
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
      if (kDebugMode) {
        print(">>>>>>\n\n$e");
      }
      return;
    }
  }

  @override
  void onReady() {
    WidgetsFlutterBinding.ensureInitialized();
    callOrStopServices();
    super.onReady();
  }

  @override
  void onClose() {
    // animationController2.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
