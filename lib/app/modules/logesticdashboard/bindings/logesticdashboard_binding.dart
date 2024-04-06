import 'package:get/get.dart';

import '../controllers/logesticdashboard_controller.dart';

class LogesticdashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogesticdashboardController>(
      () => LogesticdashboardController(),
    );
  }
}
