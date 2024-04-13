import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:upgrader/upgrader.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/common_button.dart';
import '../controllers/introscreen_controller.dart';
import '../pagePopup.dart';

class IntroscreenView extends GetView<IntroscreenController> {
   IntroscreenView({Key? key}) : super(key: key);

   IntroscreenController controller = Get.find<IntroscreenController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpgradeAlert(
        upgrader: Upgrader(dialogStyle: UpgradeDialogStyle.cupertino,canDismissDialog: false,),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                pageSnapping: true,
                onPageChanged: (index) {
                  controller.currentShowIndex = index;
                },
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  PagePopup(imageData: controller.pageViewModelData[0]),
                  PagePopup(imageData: controller.pageViewModelData[1]),
                  PagePopup(imageData: controller.pageViewModelData[2]),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: controller.pageController, // PageController
              count: 3,
              effect: WormEffect(
                  activeDotColor: Theme.of(context).primaryColor,
                  dotColor: Theme.of(context).dividerColor,
                  dotHeight: 10.0,
                  dotWidth: 10.0,
                  spacing: 5.0), // your preferred effect
              onDotClicked: (index) {},
            ),
            CommonButton(
              padding:
              const EdgeInsets.only(left: 48, right: 48, bottom: 8, top: 32),
              buttonText: "Login",
              onTap: () {
                Get.delete<IntroscreenController>();
                Get.toNamed(Routes.LOGINSCREEN);
                // Get.to(()=> LoginscreenView(),transition: Transition.zoom);
                // NavigationServices(context).gotoLoginScreen();
              },
            ),
            /*CommonButton(
              padding:
              const EdgeInsets.only(left: 48, right: 48, bottom: 32, top: 8),
              buttonText: "Create account",
              backgroundColor: AppTheme.backgroundColor,
              textColor: AppTheme.primaryTextColor,
              onTap: () {
                // Get.toNamed(Routes.DRIVER_DASHBOARD);
                // NavigationServices(context).gotoSignScreen();
              },
            ),*/
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }
}
