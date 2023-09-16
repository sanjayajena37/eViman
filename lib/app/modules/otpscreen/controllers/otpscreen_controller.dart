import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../../constants/helper.dart';
import '../../../constants/shared_preferences_keys.dart';
import '../../../data/ApiFactory.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/MyWidget.dart';
import '../../../widgets/Snack.dart';
import '../../../widgets/test.dart';
import '../../ConnectorController.dart';

class OtpscreenController extends GetxController with CodeAutoFill,Helper {
  //TODO: Implement OtpscreenController

  final count = 0.obs;
  CountdownController countdownController = CountdownController();
  TextEditingController otpEditingController = TextEditingController();
  var messageOtpCode = ''.obs;
  bool reSendOtp = false;
  Map mapData = {'otp':"000000"};
  @override
  void onInit() {
    getDataFromArguments();
    super.onInit();
    listenOtp();
  }

  getDataFromArguments()  {
     mapData = Get.arguments;
    update(['otp']);
  }

  Future<void> listenOtp() async {
    print(await SmsAutoFill().getAppSignature);
    await SmsAutoFill().unregisterListener();
    listenForCode();
    // Listen for SMS OTP
    await SmsAutoFill().listenForCode();
  }

  @override
  void onReady() {
    super.onReady();
    countdownController.start();
  }

  @override
  void onClose() {
    super.onClose();
    SmsAutoFill().unregisterListener();
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
  void increment() => count.value++;

  void otpResend() async {

    var appSignatureID = await SmsAutoFill().getAppSignature;
    Map sendData = {
      "mobile": mapData['mobile'],
      "app_signature_id": appSignatureID
    };
    closeDialogIfOpen();
    MyWidgets.showLoading3();
    Get.find<ConnectorController>().POSTMETHOD(
        api: ApiFactory.LOGIN,
        json: sendData,
        fun: (map) {
          Get.back();
          if(map is Map && map.containsKey('success')&& map['success'] == true){
            otpEditingController.text="";
            mapData =  {"mobile": mapData['mobile'],"otpToken":map['token'],"otp":map['otp']};
            update(['otp']);
            Snack.callSuccess("Otp sent successfully");
          }else{
            Snack.callError("Something went wrong");
          }
          print(">>>>>" + map.toString());
        });
  }


  void verifyOtp(String otp) async {
    WidgetsFlutterBinding.ensureInitialized();
    Map sendData = {
      "otpToken":mapData['otpToken']?? "",
      "otp": otp??""
    };
    print(">>>postData"+sendData.toString());

    MyWidgets.showLoading3();
    Get.find<ConnectorController>().POSTMETHOD(
        api: ApiFactory.VERIFY_OTP,
        json: sendData,
        fun: (map) async {
          Get.back();
          if(map is Map && map.containsKey('success')){
            if(map['success'] == true){
              otpEditingController.text="";
              // Get.toNamed(Routes.KYCSCREEN,arguments:mapData['mobile']?? "" );
              if(map['status'] == "new-user"){
                Get.offAndToNamed(Routes.KYCSCREEN,arguments: {"mobile":mapData['mobile'] ?? "","index":0,"authToken":map['authToken']??""});
              }else if(map['status'] == "vehicle-pending"){
                Get.offAndToNamed(Routes.KYCSCREEN,arguments: {"mobile":mapData['mobile'] ?? "","index":2,
                  "riderId":(map['riderId'])??0,"authToken":map['authToken']??""});
              }else if(map['status'] == "kyc-pending"){
                await SharedPreferencesKeys().setStringData(key: "authToken", text: (map['authToken']??"").toString());
                await SharedPreferencesKeys().setStringData(key: "isLogin", text: "true");
                await SharedPreferencesKeys().setStringData(key: "riderId", text: (map['riderId']??"").toString());
                   await SharedPreferencesKeys().setStringData(key: "vehicleId", text: (map['vehicleId']??0).toString());
                  String? authToken =
                      await SharedPreferencesKeys().getStringData(key: 'authToken');
                  log(">>>>>>>>>>>authToken"+authToken.toString());

                showUnderProcess(map);
              }else if(map['status'] == "kyc-verified"){
                await SharedPreferencesKeys().setStringData(key: "authToken", text: (map['authToken']??0).toString());
                await SharedPreferencesKeys().setStringData(key: "isLogin", text: "true");
                await SharedPreferencesKeys().setStringData(key: "riderId", text: (map['riderId']??0).toString());
                await SharedPreferencesKeys().setStringData(key: "vehicleId", text: (map['vehicleId']??0).toString());
                Get.delete<OtpscreenController>();
                Get.offAndToNamed(Routes.DRIVER_DASHBOARD);
              }else{
                Snack.callError((map['message']??"Something went wrong"));
              }
            }else{
              Snack.callError((map['message']??"Something went wrong"));
            }

          }else{
            Snack.callError((map??"Something went wrong").toString());
          }
          log(">>>>>" + map.toString());
        });
  }

  calBackgroundServices() async {
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
  calForegroundServices() async {
    try{
      final service = FlutterBackgroundService();
      bool isRunning = await service.isRunning();
      if(isRunning == false){
        service.startService();
      }
      FlutterBackgroundService().invoke("setAsForeground");
      // FlutterBackgroundService().invoke("setAsBackground");
    }catch(e){
      print(">>>>>>>>>>>"+e.toString());
    }

  }



  void showUnderProcess(Map map) async {
    bool isOk = await showCommonPopupNew2(
      "Your kyc verification under process?",
      "Please wait until nex update.",
      barrierDismissible: true,
      isYesOrNoPopup: false,
    );
    if (isOk) {
      // calBackgroundServices();
      Get.back();
      Get.back();

      /*Navigator.push(
        Get.context!,
        MaterialPageRoute(builder: (context) => TestPage()),
      );*/


      // ignore: use_build_context_synchronously
    }
  }
  @override
  void codeUpdated() {
    // TODO: implement codeUpdated
  }
  @override
  void dispose() {
    messageOtpCode.value = "";
    // TODO: implement dispose
    super.dispose();
  }
}
