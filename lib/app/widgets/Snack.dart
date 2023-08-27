import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Snack {
  static call(title) {
    return Get.snackbar(title, "",
        maxWidth: Get.width * 0.3,
        duration: Duration(seconds: 7),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.deepPurple,
        titleText: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
        messageText: const Text(
          "",
          style: TextStyle(fontSize: 1, color: Colors.white),
        ),
        mainButton: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Ok",
              style: TextStyle(color: Colors.white),
            )),
        padding: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
        margin: const EdgeInsets.only(top: 10));
    // return Get.showSnackbar(GetSnackBar(title: title,));
  }

  static callError(title) {
    return Get.snackbar(title, "",
        maxWidth: Get.width * 0.95,
        animationDuration: Duration(milliseconds: 600),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 9),
        titleText: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
        messageText: const Text(
          "",
          style: TextStyle(fontSize: 1, color: Colors.white),
        ),
        mainButton: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Ok",
              style: TextStyle(color: Colors.white),
            )),
        padding: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
        margin: const EdgeInsets.only(bottom: 10));
    // return Get.showSnackbar(GetSnackBar(title: title,));
  }

  static callSuccess(title, {Function()? callback}) {
    return Get.snackbar(title, "",
        maxWidth: Get.width * 0.95,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[400],
        titleText: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
        duration: const Duration(seconds: 5),
        messageText: const Text(
          "",
          style: TextStyle(fontSize: 1, color: Colors.white),
        ),
        mainButton: TextButton(
            onPressed: () {
              Get.back();
              callback;
            },
            child: const Text(
              "Ok",
              style: TextStyle(color: Colors.white),
            )),
        padding: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
        margin: const EdgeInsets.only(bottom: 10));
    // return Get.showSnackbar(GetSnackBar(title: title,));
  }
}
