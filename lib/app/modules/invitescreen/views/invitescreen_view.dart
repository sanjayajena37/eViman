import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../constants/text_styles.dart';
import '../../../constants/themes.dart';
import '../../../widgets/common_button.dart';
import '../controllers/invitescreen_controller.dart';

class InvitescreenView extends GetView<InvitescreenController> {
   InvitescreenView({Key? key}) : super(key: key);
   @override
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
                 "Use this code in your every ride to get exciting benefits and rewards.Hurry up.",
                  textAlign: TextAlign.center,
                  style: TextStyles(context).getRegularStyle().copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: Get.width*0.65,
                height:Get.height*0.06 ,
                child: CustomPaint(
                  painter: DashedBorderPainter(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: Text(
                          controller.referralCode??'XXX',
                          style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                          onTap: () async {
                            await Clipboard.setData( ClipboardData(text: (controller.referralCode?? "XXXXX")));
                          },
                          child: const Icon(Icons.copy))
                    ],
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
                                /*controller.openCustomDialog(controller.flutterGifController!);
                                controller.flutterGifController?.animateTo(
                                  80,
                                  duration: const Duration(seconds: 3),
                                );

                                Future.delayed(Duration(seconds: 3),() {

                                  Get.back();

                                },);*/
                                // String url = "https://play.google.com/store/apps/details?id=com.eviman.rider";
                                Share.share('Download Eviman Sarathi app on playstore. Use the below link to download and put my referral code to join our community and get additional benefits.\nClick this link 👉 https://play.google.com/store/apps/details?id=com.eviman.rider', subject: 'Look what I made!');
                                // Share.share('Referral Code AYCOOT567.Click this link 👉 https://play.google.com/store/apps/details?id=com.eviman.rider', subject: 'Look what I made!');
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
                Get.back();
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

class DottedBorderPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue // Border color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // Border width

    final Path path = Path();
    const double spacing = 5.0; // Adjust this value to change the spacing between dots
    const double halfSpacing = spacing / 2;

    for (double y = 0; y < size.height; y += spacing) {
      path.moveTo(0, y + halfSpacing);
      path.lineTo(size.width, y + halfSpacing);
    }

    for (double x = 0; x < size.width; x += spacing) {
      path.moveTo(x + halfSpacing, 0);
      path.lineTo(x + halfSpacing, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black // Border color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0; // Border width

    final double spacing = 10.0; // Adjust this value to change the spacing between dots

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawCircle(Offset(x, 0), 1, paint);
      canvas.drawCircle(Offset(x, size.height), 1, paint);
    }

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawCircle(Offset(0, y), 1, paint);
      canvas.drawCircle(Offset(size.width, y), 1, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red // Border color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // Border width

    final double dashWidth = 4.0; // Adjust this value to change the length of dashes
    final double dashSpace = 5.0; // Adjust this value to change the space between dashes

    for (double x = 0; x < size.width; x += dashWidth + dashSpace) {
      canvas.drawLine(Offset(x, 0), Offset(x + dashWidth, 0), paint);
      canvas.drawLine(Offset(x, size.height), Offset(x + dashWidth, size.height), paint);
    }

    for (double y = 0; y < size.height; y += dashWidth + dashSpace) {
      canvas.drawLine(Offset(0, y), Offset(0, y + dashWidth), paint);
      canvas.drawLine(Offset(size.width, y), Offset(size.width, y + dashWidth), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}