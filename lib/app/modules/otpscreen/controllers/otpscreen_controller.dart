import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../../constants/helper.dart';
import '../../../constants/shared_preferences_keys.dart';
import '../../../data/ApiFactory.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/MyWidget.dart';
import '../../../widgets/Snack.dart';
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
    mapData = Get.arguments;
    super.onInit();
    listenOtp();
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
    otpEditingController.dispose();
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
          closeDialogIfOpen();
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
          closeDialogIfOpen();
          if(map is Map && map.containsKey('success')&& map['success'] == true){
            otpEditingController.text="";
            // Get.toNamed(Routes.KYCSCREEN,arguments:mapData['mobile']?? "" );
            if(map['status'] == "new-user"){
              Get.toNamed(Routes.KYCSCREEN,arguments: {"mobile":mapData['mobile'] ?? "","index":0});
            }else if(map['status'] == "vehicle-pending"){
              Get.toNamed(Routes.KYCSCREEN,arguments: {"mobile":mapData['mobile'] ?? "","index":2,"riderId":(map['riderId'])??0});
            }else if(map['status'] == "kyc-pending"){
              await SharedPreferencesKeys().setStringData(key: "riderId", text: (map['riderId']??0).toString());
              showUnderProcess();
            }else if(map['status'] == "kyc-verified"){
              await SharedPreferencesKeys().setStringData(key: "riderId", text: (map['riderId']??0).toString());
              Get.offAndToNamed(Routes.DRIVER_DASHBOARD);
            }else{
              Snack.callError("Something went wrong");
            }
          }else{
            Snack.callError("Something went wrong");
          }
          print(">>>>>" + map.toString());
        });
  }
  void showUnderProcess() async {
    bool isOk = await showCommonPopupNew2(
      "Your kyc verification under process?",
      "Please wait until nex update.",
      barrierDismissible: true,
      isYesOrNoPopup: false,
    );
    if (isOk) {
      Get.toNamed(Routes.DRIVER_DASHBOARD);
      // ignore: use_build_context_synchronously
    }
  }
  @override
  void codeUpdated() {
    // TODO: implement codeUpdated
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
