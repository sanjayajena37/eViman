import 'package:get/get.dart';

import '../controllers/kycscreen_controller.dart';

class KycscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KycscreenController>(
      () => KycscreenController(),
    );
  }
}
