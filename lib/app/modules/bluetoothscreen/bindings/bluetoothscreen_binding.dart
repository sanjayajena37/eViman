import 'package:get/get.dart';

import '../controllers/bluetoothscreen_controller.dart';

class BluetoothscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BluetoothscreenController>(
      () => BluetoothscreenController(),
    );
  }
}
