import 'package:get/get.dart';

import '../controllers/image_details_page_controller.dart';

class ImageDetailsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageDetailsPageController>(
      () => ImageDetailsPageController(),
    );
  }
}
