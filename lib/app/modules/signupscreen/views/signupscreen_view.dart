import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants/text_styles.dart';
import '../../../constants/themes.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_text_field_view1.dart';
import '../../../widgets/remove_focuse.dart';
import '../../loginscreen/FacebookTwitterButtonView.dart';
import '../controllers/signupscreen_controller.dart';

class SignupscreenView extends GetView<SignupscreenController> {
  const SignupscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            controller.appBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: FacebookTwitterButtonView(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "or log in with email",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                    CommonTextFieldView1(
                      controller: controller.fnameController,
                      errorText: controller.errorFName,
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 24, right: 24),
                      titleText: "First name",
                      hintText: "Enter first name",
                      keyboardType: TextInputType.name,
                      onChanged: (String txt) {},
                    ),
                    CommonTextFieldView1(
                      controller: controller.lnameController,
                      errorText: controller.errorLName,
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 24, right: 24),
                      titleText: "Last name",
                      hintText: "Enter last name",
                      keyboardType: TextInputType.name,
                      onChanged: (String txt) {},
                    ),
                    CommonTextFieldView1(
                      controller: controller.emailController,
                      errorText: controller.errorEmail,
                      titleText: "Your email",
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 16),
                      hintText: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String txt) {},
                    ),
                    CommonTextFieldView1(
                      titleText: "Password",
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 24),
                      hintText: "Enter password",
                      isObscureText: true,
                      onChanged: (String txt) {},
                      errorText: controller.errorPassword,
                      controller: controller.passwordController,
                    ),
                    CommonButton(
                      padding:
                      const EdgeInsets.only(left: 24, right: 24, bottom: 8),
                      buttonText: "Sign Up",
                      onTap: () {
                        if (controller.allValidation()) {
                          // NavigationServices(context).gotoTabScreen();
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "By Signing up,you agreed with our terms of\n Services and privacy policy",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already have a account? Log in",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                        InkWell(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(8)),
                          onTap: () {
                            Get.toNamed(Routes.LOGINSCREEN);
                            // NavigationServices(context).gotoLoginScreen();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Login",
                              style: TextStyles(context)
                                  .getRegularStyle()
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 24,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
