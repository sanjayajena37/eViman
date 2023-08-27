import 'package:get/get.dart';

import '../controllers/keyscreen_controller.dart';

class KeyscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeyscreenController>(
      () => KeyscreenController(),
    );
  }
}
