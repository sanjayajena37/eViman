import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dateplan/app/providers/Utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/localfiles.dart';
import '../../../constants/text_styles.dart';
import '../../../constants/themes.dart';
import '../../../logic/controllers/theme_provider.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/Snack.dart';
import '../../../widgets/common_button.dart';
import '../controllers/spalshscreen_controller.dart';

class SpalshscreenView extends GetView<SpalshscreenController> {
  SpalshscreenView({Key? key}) : super(key: key);

  SpalshscreenController controllerX = Get.put<SpalshscreenController>(SpalshscreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: !Get.find<ThemeController>().isLightMode
                ? BoxDecoration(
                    color: Theme.of(context).backgroundColor.withOpacity(0.4))
                : null,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:  Lottie.asset('assets/json/lottie4.json',fit: BoxFit.contain,),
          ),
          Column(
            children: <Widget>[
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.17,
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

              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 680),
                child: CommonButton(
                  padding: const EdgeInsets.only(
                      left: 48, right: 48, bottom: 8, top: 8),
                  buttonText: "Get Started",
                  onTap: () {
                    Utils.checkInternetConnectivity().then((value) {
                      if(value){
                        controllerX.getLoginDetails();
                      }else{
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
                  onTap: (){
                    Get.toNamed(Routes.LOGINSCREEN);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: 24.0 + MediaQuery.of(context).padding.bottom,
                        top: 16),
                    child: Text(
                      "Already have Account? Log in",
                      textAlign: TextAlign.left,
                      style: TextStyles(context).getDescriptionStyle().copyWith(
                            color: AppTheme.backColor,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
