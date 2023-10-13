import 'package:dateplan/app/providers/Utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/text_styles.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/Snack.dart';
import '../../../widgets/bottom_top_move_animation_view.dart';
import '../../../widgets/common_appbar_view.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_text_field_view.dart';
import '../../../widgets/remove_focuse.dart';
import '../FacebookTwitterButtonView.dart';
import '../controllers/loginscreen_controller.dart';

class LoginscreenView extends StatelessWidget {
  // final AnimationController ? animationController;
  LoginscreenView({Key? key}) : super(key: key);

  LoginscreenController controllerX = Get.put<LoginscreenController>(
      LoginscreenController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFFFFFFF),
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.arrow_back,
              titleText: "Login",
              onBackClick: () {
                Navigator.pop(context);
              },
            ),
            GetBuilder<LoginscreenController>(
                id: "ref",
                builder: (controller) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.06,
                          ),
                          Container(
                            // width:MediaQuery.of(context).size.width,
                              child: Image.asset(
                                "assets/images/logo.png",
                                fit: BoxFit.fill,
                                height: 200, width: 200,
                              )),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.1,
                          ),
                          CommonTextFieldView(
                            controller: controller.mobileController,
                            errorText: controller.errorEmail,
                            maxLength: 10,
                            titleText: "Your Mobile",
                            contextNew: context,
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, bottom: 5),
                            hintText: "enter your Mobile",
                            keyboardType: TextInputType.number,
                            onChanged: (String txt) {},
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, bottom: 1, top: 0),
                            child: Row(
                              children: [
                                Obx(() {
                                  return Checkbox(
                                      value: controllerX.termAndCondition.value, onChanged: (val) {
                                    controllerX.termAndCondition.value = val!;
                                    controllerX.termAndCondition.refresh();
                                  });
                                }),
                                SizedBox(
                                    width: Get.width * 0.7,
                                    child: InkWell(
                                      onTap: () async {
                                        var url = Uri.parse(
                                            "https://eviman.co.in/privacy-policy/");
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: Text("Terms & Conditions",
                                        style: TextStyles(context)
                                            .getRegularStyle()
                                            .copyWith(
                                            color: Colors.blue,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    ))
                              ],
                            ),
                          ),
                          CommonButton(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, bottom: 16),
                            buttonText: "Send The Code",
                            onTap: () {
                               if (controllerX.allValidation()) {
                                 if(controllerX.termAndCondition.value == false){
                                   Snack.callError("Please accept our term & condition");
                                 }else{
                                   controllerX.submit();
                                 }

                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
