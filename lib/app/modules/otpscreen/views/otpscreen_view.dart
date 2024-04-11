import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../constants/text_styles.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common_appbar_view.dart';
import '../../../widgets/common_button.dart';
import '../controllers/otpscreen_controller.dart';

class OtpscreenView extends GetView<OtpscreenController> {

   OtpscreenView({Key? key}) : super(key: key);

   OtpscreenController controllerX = Get.put<OtpscreenController>(OtpscreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbarView(
              iconData: Icons.arrow_back,
              titleText: "OTP View",
              onBackClick: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: GetBuilder<OtpscreenController>(
                    id: "otp",
                    assignId: true,
                    builder: (logic) {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          Image.asset(
                            "assets/images/enterotp.png",
                            fit: BoxFit.fill,
                            height: 200,
                            width: 200,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Verification",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Enter Your OTP here",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          // Text((controllerX.mapData['otp']??"").toString()),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                          Obx(
                            () => PinFieldAutoFill(
                              textInputAction: TextInputAction.done,
                              /*  autoFocus: true,
                      cursor: Cursor(color: Colors.black,width: 2),
                      enabled: true,
                          codeLength: 6,
                          enableInteractiveSelection: true,
                          focusNode:FocusNode() ,*/
                              codeLength: 6,
                              controller: controllerX.otpEditingController,
                              decoration: UnderlineDecoration(
                                textStyle: const TextStyle(
                                    fontSize: 16, color: Colors.blue),
                                colorBuilder: const FixedColorBuilder(
                                  Colors.transparent,
                                ),
                                bgColorBuilder: FixedColorBuilder(
                                  Colors.grey.withOpacity(0.2),
                                ),
                              ),
                              currentCode: controllerX.messageOtpCode.value,
                              onCodeSubmitted: (code) {
                                print("onCodeSubmitted $code");
                              },
                              onCodeChanged: (code) {
                                controllerX.messageOtpCode.value = code??"000000";
                                // controller.countdownController.pause();
                                if (code?.length == 6 && code != "000000") {
                                  controllerX.verifyOtp(code ??"000000");
                                  // To perform some operation
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          (!controllerX.reSendOtp)
                              ? Countdown(
                                  controller: controllerX.countdownController,
                                  seconds: 15,
                                  interval: const Duration(milliseconds: 1000),
                                  build: (context, currentRemainingTime) {
                                    return Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(
                                          left: 14,
                                          right: 14,
                                          top: 14,
                                          bottom: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: Colors.blue, width: 1),
                                      ),
                                      width: context.width,
                                      child: Text(
                                          "Wait | 00:${currentRemainingTime.toString().length == 4 ? currentRemainingTime.toString().substring(0, 2) : currentRemainingTime.toString().substring(0, 1)}",
                                          style: const TextStyle(fontSize: 16)),
                                    );
                                  },
                                  onFinished: () {
                                    // reSendOtp
                                    controllerX.reSendOtp = true;

                                    controllerX.update(['otp']);
                                  },
                                )
                              : InkWell(
                                  onTap:(){
                                    controllerX.otpResend();
                                  },
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Resend",
                                            style: TextStyles(Get.context!)
                                                .getBoldStyle()
                                                .copyWith(
                                                    color: Colors.blue,
                                                    decoration:
                                                        TextDecoration.underline,
                                                    fontSize: 20)),
                                      ],
                                    ),
                                  ),
                              ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
