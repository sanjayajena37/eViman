import 'package:get/get.dart';

import '../controllers/waletscreen_controller.dart';

class WaletscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaletscreenController>(
      () => WaletscreenController(),
    );
  }
}
