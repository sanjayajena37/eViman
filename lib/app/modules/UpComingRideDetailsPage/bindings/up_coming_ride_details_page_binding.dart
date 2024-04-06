import 'package:get/get.dart';

import '../controllers/up_coming_ride_details_page_controller.dart';

class UpComingRideDetailsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpComingRideDetailsPageController>(
      () => UpComingRideDetailsPageController(),
    );
  }
}
