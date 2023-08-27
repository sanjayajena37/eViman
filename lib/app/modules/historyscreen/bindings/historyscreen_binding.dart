import 'package:get/get.dart';

import '../controllers/historyscreen_controller.dart';

class HistoryscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryscreenController>(
      () => HistoryscreenController(),
    );
  }
}
