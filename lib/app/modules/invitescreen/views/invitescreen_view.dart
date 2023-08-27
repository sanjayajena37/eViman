import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';

import 'package:get/get.dart';

import '../../../constants/text_styles.dart';
import '../../../constants/themes.dart';
import '../../../widgets/CustomeTittleText.dart';
import '../../../widgets/common_button.dart';
import '../controllers/invitescreen_controller.dart';

class InvitescreenView extends GetView<InvitescreenController> {
   InvitescreenView({Key? key}) : super(key: key);
   InvitescreenController controller = Get.find<InvitescreenController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16),
                child: Image.asset("assets/images/inviteImage.png"),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Invite your Friend",
                  style: TextStyles(context).getBoldStyle().copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: Text(
                 "are you one of those who makes everything at the last moment",
                  textAlign: TextAlign.center,
                  style: TextStyles(context).getRegularStyle().copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonButton(
                      radius: 4,
                      buttonTextWidget: SizedBox(
                        height: 40,
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 22,
                            ),
                            InkWell(
                              onTap: (){
                                controller.openCustomDialog(controller.flutterGifController!);
                                controller.flutterGifController?.animateTo(
                                  80,
                                  duration: const Duration(seconds: 3),
                                );
                                Future.delayed(Duration(seconds: 3),() {

                                  Get.back();

                                },);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                 "Share",
                                  style: TextStyles(context)
                                      .getRegularStyle()
                                      .copyWith(color: AppTheme.whiteColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Row(
              children: <Widget>[appBar()],
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8),
        child: SizedBox(
          width: AppBar().preferredSize.height - 8,
          height: AppBar().preferredSize.height - 8,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(32.0),
              ),
              onTap: () {

              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
