import 'package:get/get.dart';

import '../controllers/settingscreen_controller.dart';

class SettingscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingscreenController>(
      () => SettingscreenController(),
    );
  }
}
