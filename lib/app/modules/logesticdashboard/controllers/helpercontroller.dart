part of 'logesticdashboard_controller.dart';

extension HelperController on LogesticdashboardController {


  void showRideAcceptDialog(BuildContext context, double screenSizeWidth,
      {String? pickUpDistance,
        String? travelDistance,
        String? pickupAddress,
        String? dropAddress,
        Map? receiveData}) {
    Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          content: Stack(children: [
            Container(
              height: Get.height * 0.5,
              width: screenSizeWidth,
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xff16192C),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 1,
                        color: Colors.grey.shade300)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.03,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultTextStyle(
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              FadeAnimatedText('You have only 40 second',
                                  duration: const Duration(seconds: 4)),
                              FadeAnimatedText('You have only 35 second',
                                  duration: const Duration(seconds: 4)),
                              FadeAnimatedText('You have only 30 second',
                                  duration: const Duration(seconds: 4)),
                              FadeAnimatedText('You have only 25 second',
                                  duration: const Duration(seconds: 4)),
                              FadeAnimatedText('You have only 20 second',
                                  duration: const Duration(seconds: 4)),
                              FadeAnimatedText('You have only 15 second',
                                  duration: const Duration(seconds: 4)),
                              FadeAnimatedText('You have only 10 second',
                                  duration: const Duration(seconds: 4)),
                              FadeAnimatedText('You have only 5 second'),
                              FadeAnimatedText('Please take quick action'),
                            ],
                            repeatForever: false,
                            isRepeatingAnimation: true,
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  LinearTimer(
                    duration: const Duration(seconds: 40),
                    onTimerEnd: () {
                      if (Get.isDialogOpen == true) {
                        print("timer ended");
                        // userDetails = "";
                        maxChildSize = Rx<double>(0.2);
                        snapSize = Rx<List<double>>([0.1, 0.2]);
                        pickUpDistance = null;
                        pickUpDistance = null;
                        maxChildSize = Rx<double>(0.2);
                        initialChildSize = Rx<double>(0.1);
                        snapSize = Rx<List<double>>([0.1, 0.2]);
                        update(['drag']);
                        // unsubscribe2();
                        snapSize.refresh();
                        maxChildSize.refresh();
                        Get.back();
                      }
                    },
                    // controller: timerController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "There’s a new trip around you",
                    style: TextStyles(context)
                        .getBoldStyle()
                        .copyWith(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_searching_rounded,
                        size: 20,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: Get.width * 0.7,
                        child: Text(
                          pickupAddress ?? "Lagos-Abeokuta Expressway KM 748",
                          style: TextStyles(context)
                              .getBoldStyle()
                              .copyWith(color: Colors.white, fontSize: 14),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 9),
                    height: 8,
                    width: 2,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 9),
                    height: 8,
                    width: 2,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20,
                        color: Color(0xffADD685),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: Get.width * 0.7,
                        child: Text(
                          dropAddress ?? "Queen Street 73",
                          style: TextStyles(context)
                              .getBoldStyle()
                              .copyWith(color: Colors.white, fontSize: 14),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2.0, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 70,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: const Icon(
                                      Icons.map,
                                      color: Color(0xffA6B7D4),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      pickUpDistance ?? "32Km",
                                      style: TextStyles(context)
                                          .getBoldStyle()
                                          .copyWith(
                                          color: Colors.white,
                                          fontSize: 28),
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    "PickUp distance",
                                    style: TextStyles(context)
                                        .getDescriptionStyle()
                                        .copyWith(fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 2,
                          color: Color(0xffA6B7D4),
                        ),
                        SizedBox(
                          height: 70,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: const Icon(
                                      Icons.map,
                                      color: Color(0xffA6B7D4),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      travelDistance ?? "32Km",
                                      style: TextStyles(context)
                                          .getBoldStyle()
                                          .copyWith(
                                          color: Colors.white,
                                          fontSize: 28),
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    "Traveled distance",
                                    style: TextStyles(context)
                                        .getDescriptionStyle()
                                        .copyWith(fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "(Expected Price ₹${receiveData?['incomingBooking']['amount'] ??
                            0.00})",
                        style: TextStyles(context)
                            .getBoldStyle()
                            .copyWith(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CommonButton(
                          padding: const EdgeInsets.only(
                              left: 2, right: 2, bottom: 4),
                          buttonText: "Cancel",
                          backgroundColor: Colors.red,
                          onTap: () {
                            // userDetails = "";
                            maxChildSize = Rx<double>(0.2);
                            snapSize = Rx<List<double>>([0.1, 0.2]);
                            pickUpDistance = null;
                            pickUpDistance = null;
                            maxChildSize = Rx<double>(0.2);
                            initialChildSize = Rx<double>(0.1);
                            snapSize = Rx<List<double>>([0.1, 0.2]);
                            update(['drag']);
                            // unsubscribe2();
                            snapSize.refresh();
                            maxChildSize.refresh();
                            Get.back();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: CommonButton(
                            padding: const EdgeInsets.only(
                                left: 2, right: 2, bottom: 4),
                            buttonText: "Accept",
                            onTap: () {}
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                top: 10,
                right: 6,
                left: 266,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                  child: Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ))
          ]),
          backgroundColor: const Color(0xff16192C),
          insetPadding: EdgeInsets.all(2),
          contentPadding: EdgeInsets.all(0),
        ));
  }


  callServices() async {
    final service = FlutterBackgroundService();
    bool isRunning = await service.isRunning();
    if (isRunning) {
      service.invoke("stopService");
    }
    /* else{
      service.startService();
      FlutterBackgroundService().invoke("setAsForeground");
      Future.delayed(const Duration(seconds: 7));
      FlutterBackgroundService().invoke("setAsBackground");
    }*/
  }

  Future<void> callOrStopServices() async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    try {
      final service = FlutterBackgroundService();
      bool isRunning = await service.isRunning();
      if (isRunning) {
        service.invoke("stopService");
      }
      return;
    } catch (e) {
      print(">>>>>>\n\n" + e.toString());
      return;
    }
  }

  Future<void> calBackgroundServices(String? sta) async {
    try {
      final service = FlutterBackgroundService();
      bool isRunning = await service.isRunning();
      if (isRunning == false) {
        service.startService();
        // FlutterBackgroundService().invoke("setAsForeground");
      }
      // FlutterBackgroundService().invoke("isForeGround",{"sta":sta??"true"});
      return;
    } catch (e) {
      print(">>>>>>>>>>>error JKs\n\n" + e.toString());
      return;
    }
  }

  void gotoSplashScreen() async {
    bool isOk = await showCommonPopupNew(
      "Are you sure?",
      "You want to Sign Out.",
      Get.context!,
      barrierDismissible: true,
      isYesOrNoPopup: true,
    );
    if (isOk) {
      await SharedPreferencesKeys().setStringData(key: "authToken", text: "");
      await SharedPreferencesKeys()
          .setStringData(key: "isLogin", text: "false");
      await SharedPreferencesKeys().setStringData(key: "riderId", text: "");
      callOrStopServices().then((value) {
        Get.delete<LoginscreenController>();
        Get.delete<DriverDashboardController>();
        Get.offAndToNamed(Routes.LOGINSCREEN);
      });

      // ignore: use_build_context_synchronously
    }
  }

}
