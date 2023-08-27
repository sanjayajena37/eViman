import 'package:get/get.dart';

import '../controllers/spalshscreen_controller.dart';

class SpalshscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpalshscreenController>(
      () => SpalshscreenController(),
    );
  }
}
