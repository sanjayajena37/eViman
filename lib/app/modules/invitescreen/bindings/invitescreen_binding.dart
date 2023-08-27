import 'package:get/get.dart';

import '../controllers/invitescreen_controller.dart';

class InvitescreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvitescreenController>(
      () => InvitescreenController(),
    );
  }
}
