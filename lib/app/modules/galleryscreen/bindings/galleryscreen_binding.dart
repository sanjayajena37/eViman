import 'package:get/get.dart';

import '../controllers/galleryscreen_controller.dart';

class GalleryscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GalleryscreenController>(
      () => GalleryscreenController(),
    );
  }
}
