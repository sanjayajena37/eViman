import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DocumentUploadController extends GetxController with GetSingleTickerProviderStateMixin{
  //TODO: Implement DocumentUploadController

  File? imageData;
  AnimationController? controllerAnimation;
  final count = 0.obs;
  bool isEnabled = false;
  @override
  void onInit() {
    controllerAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.onInit();
  }
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);

      imageData = imageTemporary;
      update(['image']);
    } on PlatformException catch (e) {
      print("Failed  to pick image: $e");
    }
    Navigator.of(Get.context!).pop(true);
  }

  void show() {
    showCupertinoModalPopup(
        context: Get.context!,
        builder: (BuildContext cont) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(cont).pop;
                },
                child: const Text('Use Camera'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(cont).pop;
                },
                child: const Text('Upload from files'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(cont);

              },
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
          );
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
