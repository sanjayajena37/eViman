import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/bottom_top_move_animation_view.dart';
import '../../../widgets/common_appbar_view.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_text_field_view.dart';
import '../../../widgets/remove_focuse.dart';
import '../FacebookTwitterButtonView.dart';
import '../controllers/loginscreen_controller.dart';

class LoginscreenView extends GetView<LoginscreenController> {
  // final AnimationController ? animationController;
   LoginscreenView({Key? key}) : super(key: key);

   LoginscreenController controller = Get.find<LoginscreenController>();



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
                          height: MediaQuery.of(context).size.height*0.06,
                        ),
                        Container(
                          // width:MediaQuery.of(context).size.width,
                            child: Image.asset(
                              "assets/images/logo.png",
                              fit: BoxFit.fill,
                              height: 200, width: 200,
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.1,
                        ),
                        CommonTextFieldView(
                          controller: controller.mobileController,
                          errorText: controller.errorEmail,
                          maxLength: 10,
                          titleText: "Your Mobile",
                          contextNew: context,
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, bottom: 16),
                          hintText: "enter your Mobile",
                          keyboardType: TextInputType.number,
                          onChanged: (String txt) {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CommonButton(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, bottom: 16),
                          buttonText: "Send The Code",
                          onTap: () {
                            if (controller.allValidation()) {
                              controller.submit();
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
