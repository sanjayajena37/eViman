import 'package:get/get.dart';

import '../controllers/help_line_screen_controller.dart';

class HelpLineScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpLineScreenController>(
      () => HelpLineScreenController(),
    );
  }
}
