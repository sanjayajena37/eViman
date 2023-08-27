import 'package:get/get.dart';

import '../controllers/driverprofile_controller.dart';

class DriverprofileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverprofileController>(
      () => DriverprofileController(),
    );
  }
}
