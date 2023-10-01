import 'package:get/get.dart';

import '../controllers/earningpage_controller.dart';

class EarningpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EarningpageController>(
      () => EarningpageController(),
    );
  }
}
