import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/validator.dart';
import '../../../widgets/common_appbar_view.dart';

class SignupscreenController extends GetxController {
  //TODO: Implement SignupscreenController
  String errorEmail = '';
  final TextEditingController emailController = TextEditingController();
  String errorPassword = '';
  final TextEditingController passwordController = TextEditingController();
  String errorFName = '';
  final TextEditingController fnameController = TextEditingController();
  String errorLName = '';
  final TextEditingController lnameController = TextEditingController();
  final count = 0.obs;

  Widget appBar() {
    return CommonAppbarView(
      iconData: Icons.arrow_back,
      titleText: "Sign up",
      onBackClick: () {
        Navigator.pop(Get.context!);
      },
    );
  }

  bool allValidation() {
    bool isValid = true;

    if (fnameController.text.trim().isEmpty) {
      errorFName = "First name can not be empty";
      isValid = false;
    } else {
      errorFName = '';
    }

    if (lnameController.text.trim().isEmpty) {
      errorLName = "Last name can not be empty";
      isValid = false;
    } else {
      errorLName = '';
    }

    if (emailController.text.trim().isEmpty) {
      errorEmail = "Email can not be empty";
      isValid = false;
    } else if (!Validator.validateEmail(emailController.text.trim())) {
      errorEmail = "Enter valid email";
      isValid = false;
    } else {
      errorEmail = '';
    }

    if (passwordController.text.trim().isEmpty) {
      errorPassword = "Password can not be empty";
      isValid = false;
    } else if (passwordController.text.trim().length < 6) {
      errorPassword = "Please enter valid password";
      isValid = false;
    } else {
      errorPassword = '';
    }
    return isValid;
  }

  @override
  void onInit() {
    super.onInit();
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
