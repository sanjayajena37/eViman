import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dateplan/app/providers/Utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upgrader/upgrader.dart';

import '../../../constants/localfiles.dart';
import '../../../constants/text_styles.dart';
import '../../../constants/themes.dart';
import '../../../logic/controllers/theme_provider.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/Snack.dart';
import '../../../widgets/common_button.dart';
import '../controllers/spalshscreen_controller.dart';
import 'package:lottie/lottie.dart' as lottie;

class SpalshscreenView extends GetView<SpalshscreenController> {
  SpalshscreenView({Key? key}) : super(key: key);

  SpalshscreenController controllerX = Get.put<SpalshscreenController>(
      SpalshscreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: GetBuilder<SpalshscreenController>(
        assignId: true,
        id: "allPage",
        builder: (controllerX) {
          return Container(
            child: (controllerX.permissionAllow) ? Stack(
              children: <Widget>[
                Container(
                  foregroundDecoration: !Get
                      .find<ThemeController>()
                      .isLightMode
                      ? BoxDecoration(
                      color: Theme
                          .of(context)
                          .backgroundColor
                          .withOpacity(0.4))
                      : null,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: Lottie.asset(
                    'assets/json/lottie4.json', fit: BoxFit.contain,),
                ),
                Column(
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.17,
                        /* decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Theme.of(context).dividerColor,
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),*/
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          child: Image.asset(Localfiles.appIcon),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // Color(0xFFC8B79F)
                    const Expanded(
                      flex: 4,
                      child: SizedBox(),
                    ),

                    /*AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(milliseconds: 680),
                      child: CommonButton(
                        padding: const EdgeInsets.only(
                            left: 48, right: 48, bottom: 8, top: 8),
                        buttonText: "Get Started",
                        onTap: () {
                          Utils.checkInternetConnectivity().then((value) {
                            if (value) {
                              controllerX.getLoginDetails();
                            } else {
                              Snack.callError("Please turn on your internet");
                            }
                          });

                          // NavigationServices(context).gotoIntroductionScreen();
                        },
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(milliseconds: 1200),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.LOGINSCREEN);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: 24.0 + MediaQuery
                                  .of(context)
                                  .padding
                                  .bottom,
                              top: 16),
                          child: Text(
                            "Already have Account? Log in",
                            textAlign: TextAlign.left,
                            style: TextStyles(context)
                                .getDescriptionStyle()
                                .copyWith(
                              color: AppTheme.backColor,
                            ),
                          ),
                        ),
                      ),
                    ),*/
                  ],
                ),
              ],
            ) :
            SizedBox(
              width: Get.width,
              height: Get.height * 0.9,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: Get.height * 0.3,
                                  child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Image.asset(
                                          "assets/images/appPermission.jpg",
                                          fit: BoxFit.contain,
                                          height: Get.height * 0.2)),
                                ),
                              ),
                              Text("Step 1", style: TextStyles(context)
                                  .getTitleStyle()
                                  .copyWith(fontSize: 11),)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: Get.height * 0.3,
                                  child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Image.asset(
                                          "assets/images/appSetting.jpg",
                                          fit: BoxFit.contain,
                                          height: Get.height * 0.2)),
                                ),
                              ),
                              Text("Step 2", style: TextStyles(context)
                                  .getTitleStyle()
                                  .copyWith(fontSize: 11),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width *
                          0.6,
                      height: Get.height * 0.07,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: lottie.Lottie.asset(
                            "assets/json/allowLocation.json",
                            fit: BoxFit.contain,
                            height: Get.height * 0.07),
                      ),
                    ),
                  ),
                  Center(
                      child: Text(
                        "Location Permission(Allow all the time) Denied",
                        style: TextStyles(context)
                            .getBoldStyle()
                            .copyWith(
                            fontSize: 15, color: Colors.red),
                      )),
                  Center(
                      child: Text(
                        "or",
                        style: TextStyles(context)
                            .getBoldStyle()
                            .copyWith(
                            fontSize: 15, color: Colors.red),
                      )),
                  Center(
                      child: Text(
                        "Notification Permission Denied",
                        style: TextStyles(context)
                            .getBoldStyle()
                            .copyWith(
                            fontSize: 15, color: Colors.red),
                      )),
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8,
                    ),
                    child: SizedBox(
                      width: Get.width * 0.86,
                      child: Center(
                          child: Text(
                            "> Please enable your location(Allow all the time),It's mandatory to use our application.Because we need to collect your location data even if your application is close.It's our requirement to give smooth less service to our user.",
                            style: TextStyles(context)
                                .getTitleStyle()
                                .copyWith(fontSize: 11),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8,
                    ),
                    child: SizedBox(
                      width: Get.width * 0.86,
                      child: Center(
                          child: Text(
                            "> Please enable your notification permission,It's required to notify you for further information",
                            style: TextStyles(context)
                                .getTitleStyle()
                                .copyWith(fontSize: 11),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8,
                    ),
                    child: SizedBox(
                      width: Get.width * 0.86,
                      child: Center(
                          child: Text(
                            "> Please go to the app setting and enable your location(allow all the time) and notification. after that re open the app or press refresh buttons",
                            style: TextStyles(context)
                                .getTitleStyle()
                                .copyWith(fontSize: 11),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15,
                        top: 6,
                        bottom: 5),
                    child: CommonButton(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 16),
                        isIcon: true,
                        height: Get.height * 0.05,
                        icon: Icons.settings,
                        buttonText: "App Setting",
                        onTap: () {
                          openAppSettings();
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15,
                        top: 3,
                        bottom: 5),
                    child: CommonButton(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 16),
                        buttonText: "Refresh The page",
                        isIcon: true,
                        height: Get.height * 0.05,
                        icon: Icons.refresh,
                        onTap: () {
                          controllerX
                              .handleLocationPermission()
                              .then((value) {
                            if (value) {
                              controllerX.permissionAllow =
                              true;
                              controllerX.update(['allPage']);
                            } else {
                              controllerX.infoDialog1();
                            }
                          });
                        }),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
