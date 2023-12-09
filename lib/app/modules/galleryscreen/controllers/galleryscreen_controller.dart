import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../widgets/MyWidget.dart';
import '../../ConnectorController.dart';
import '../GalleryModel.dart';

class GalleryscreenController extends GetxController {
  //TODO: Implement GalleryscreenController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }
  GalleryModel ? galleryModel = GalleryModel(gallery: [Gallery(id: 0,
    image: "https://assets-v2.lottiefiles.com/a/2db986d0-1170-11ee-b6b9-0f0164de6dcb/og-image-IYU49RM5yTkgv36Kjn1b6.png",
    isActive: 1,)]);
  getGalleryDetails() {
    try{
      MyWidgets.showLoading3();
      Get.find<ConnectorController>().GETMETHODCALL(
          api:
          "https://backend.eviman.co.in/api/gallery/v1/list",
          fun: (map) {
            Get.back();
            if(map is Map && map['gallery'] != null && map['gallery'].length > 0){
              galleryModel = GalleryModel.fromJson(map as Map<String,dynamic>);
              update(['ref']);
            }else{
              galleryModel = GalleryModel(gallery: [Gallery(id: 0,
                image: "https://assets-v2.lottiefiles.com/a/2db986d0-1170-11ee-b6b9-0f0164de6dcb/og-image-IYU49RM5yTkgv36Kjn1b6.png",
                isActive: 1,)]);
              update(['ref']);
            }
            log(">>>>>>>>>>>>map"+jsonEncode(map) .toString());
          });
    }catch(e){
      Get.back();
    }

  }

  @override
  void onReady() {
    getGalleryDetails();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
