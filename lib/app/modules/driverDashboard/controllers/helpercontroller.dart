part of 'driver_dashboard_controller.dart';

extension HelperController on DriverDashboardController {
  goOnline(bool val) {
    Map sendData = {
      "status": (val) ? 1 : 0,
    };
    print(">>>>>update-online-status" + sendData.toString());
    Get.find<ConnectorController>().PATCH_METHOD_TOKEN(
        api: "http://65.1.169.159:3000/api/riders/v1/update-online-status/" +
            riderIdNew.toString(),
        json: sendData,
        token: authToken ?? "",
        fun: (map) {
          print(">>>>>>" + map.toString());
          if (map is Map &&
              map.containsKey("success") &&
              map['success'] == true) {
            if (isDisappear.value == true) {
              callOrStopServices().then((value) {
                userDetails = "";
                incomingBookingModel = null;
                unsubscribe();
                unsubscribe2();
              });
              isDisappear = Rx<bool>(false);
              userDetails = "";
              initialChildSize = Rx<double>(0.1);
              maxChildSize = Rx<double>(0.1);
              snapSize = Rx<List<double>>([0.1]);
              incomingBookingModel = null;
              polylineCoordinates = [];
              isDisappear.refresh();
              update(['top']);
              // stopBackgroundService();
            } else {
              // callBackgroundService();
              calBackgroundServices("true");
              userDetails = "";
              subscribeIncomingBooking();
              isDisappear = Rx<bool>(true);
              isDisappear.refresh();
              userDetails = "";
              initialChildSize = Rx<double>(0.1);
              maxChildSize = Rx<double>(0.1);
              snapSize = Rx<List<double>>([0.1]);
              incomingBookingModel = null;
              polylineCoordinates = [];
              update(['top']);
            }
          } else {}
        });
  }

  Future<String> goOnline1(bool val) async {
    Completer<String> completer = Completer();
    Map sendData = {
      "status": (val) ? 1 : 0,
    };
    // print(">>>>>update-online-status" + sendData.toString());
    Get.find<ConnectorController>().PATCH_METHOD_TOKEN(
        api:
            "http://65.1.169.159:3000/api/riders/v1/update-online-status/$riderIdNew",
        json: sendData,
        token: authToken ?? "",
        fun: (map) {
          print(">>>>>>" + map.toString());
          if (map is Map &&
              map.containsKey("success") &&
              map['success'] == true) {
            if (val == false) {
              callOrStopServices().then((value) {
                userDetails = "";
                incomingBookingModel = null;
                unsubscribe();
                unsubscribe2();
              });
              isDisappear = Rx<bool>(false);
              userDetails = "";
              initialChildSize = Rx<double>(0.1);
              maxChildSize = Rx<double>(0.1);
              snapSize = Rx<List<double>>([0.1]);
              incomingBookingModel = null;
              polylineCoordinates = [];
              isDisappear.refresh();
              update(['top']);
              completer.complete("");
              // stopBackgroundService();
            } else {
              // callBackgroundService();
              calBackgroundServices("true");
              userDetails = "";
              subscribeIncomingBooking();
              isDisappear = Rx<bool>(true);
              isDisappear.refresh();
              userDetails = "";
              initialChildSize = Rx<double>(0.1);
              maxChildSize = Rx<double>(0.1);
              snapSize = Rx<List<double>>([0.1]);
              incomingBookingModel = null;
              polylineCoordinates = [];
              update(['top']);
              completer.complete("");
            }
          } else {}
        });
    return completer.future;
  }

  showModalbottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      enableDrag: true,
      showDragHandle: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 02.0, vertical: 0),
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        AssetImage("assets/images/avatar1.jpg"),
                                    maxRadius: 30,
                                    minRadius: 10,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomeTittleText(
                                    text: "Amrit Jena",
                                    textsize: 18,
                                  ),
                                ],
                              ),
                              Image.asset(
                                "assets/icon/noti_gif2.gif",
                                height: 70,
                                width: 70,
                                colorBlendMode: BlendMode.color,
                                color: Colors.red,
                                filterQuality: FilterQuality.high,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 08.0, vertical: 0),
                        child: Column(
                          children: [
                            Text("Pick Up"),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.location_searching_rounded,
                            size: 20,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Lagos-Abeokuta Expressway KM 748",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 9),
                        height: 8,
                        width: 2,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 9),
                        height: 8,
                        width: 2,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: Color(0xffADD685),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Queen Street 73",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CommonButton(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0, bottom: 1),
                              buttonText: "Ignore",
                              onTap: () {},
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: CommonButton(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0, bottom: 1),
                              buttonText: "Accept",
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

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
              height: Get.height * 0.46,
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
                          style: Theme.of(context)
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
                        userDetails = "";
                        maxChildSize = Rx<double>(0.2);
                        snapSize = Rx<List<double>>([0.1, 0.2]);
                        pickUpDistance = null;
                        pickUpDistance = null;
                        maxChildSize = Rx<double>(0.2);
                        initialChildSize = Rx<double>(0.1);
                        snapSize = Rx<List<double>>([0.1, 0.2]);
                        update(['drag']);
                        unsubscribe2();
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CommonButton(
                          padding: const EdgeInsets.only(
                              left: 2, right: 2, bottom: 4),
                          buttonText: "Cancel",
                          backgroundColor: Colors.red,
                          onTap: () {
                            userDetails = "";
                            maxChildSize = Rx<double>(0.2);
                            snapSize = Rx<List<double>>([0.1, 0.2]);
                            pickUpDistance = null;
                            pickUpDistance = null;
                            maxChildSize = Rx<double>(0.2);
                            initialChildSize = Rx<double>(0.1);
                            snapSize = Rx<List<double>>([0.1, 0.2]);
                            update(['drag']);
                            unsubscribe2();
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
                          onTap: () {
                            amountEditingController.text = "";
                            otpVerifiedStatus = false;
                            // userDetails = "";
                            print(">>>>>>>>>>" + receiveData.toString());
                            if (receiveData != null) {
                              try {
                                maxChildSize = Rx<double>(0.7);
                                initialChildSize = Rx<double>(0.5);
                                snapSize = Rx<List<double>>(
                                    [0.1, 0.2, 0.25, 0.3, 0.35, 0.4, 0.5, 0.6]);
                                pickUpDist = pickUpDistance;
                                travelDist = travelDistance;
                                snapSize.refresh();
                                maxChildSize.refresh();
                                initialChildSize.refresh();
                                incomingBookingModel =
                                    IncomingBooikingModel.fromJson(
                                        (receiveData ?? {})
                                            as Map<String, dynamic>);
                                update(['drag']);
                                print(">>>>>>>>>>" +
                                    (incomingBookingModel?.toJson())
                                        .toString());
                                subscribeBookingDetails(incomingBookingModel
                                    ?.incomingBooking?.bookingId);
                                createRide();
                                sourceLocation = LatLng(
                                    double.tryParse(incomingBookingModel
                                                ?.incomingBooking?.clientLat ??
                                            "20.288187") ??
                                        20.288187,
                                    double.tryParse(incomingBookingModel
                                                ?.incomingBooking?.clientLng ??
                                            "85.817814") ??
                                        85.817814);
                                destination = LatLng(
                                    double.tryParse(incomingBookingModel
                                                ?.incomingBooking
                                                ?.destinationLat ??
                                            "20.288187") ??
                                        20.290983,
                                    double.tryParse(incomingBookingModel
                                                ?.incomingBooking
                                                ?.destinationLng ??
                                            "85.817814") ??
                                        85.845584);
                                // getPolyPoints();
                                setCustomMarkerIcon();
                                Get.back();
                              } catch (e) {
                                userDetails = "";
                                maxChildSize = Rx<double>(0.2);
                                snapSize = Rx<List<double>>([0.1, 0.2]);
                                pickUpDistance = null;
                                pickUpDistance = null;
                                maxChildSize = Rx<double>(0.2);
                                initialChildSize = Rx<double>(0.1);
                                snapSize = Rx<List<double>>([0.1, 0.2]);
                                update(['drag']);
                                unsubscribe2();
                                snapSize.refresh();
                                maxChildSize.refresh();
                                Get.back();
                              }

                              // fetchDirections();
                            } else {
                              Get.back();
                            }
                          },
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
                        userDetails = "";
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

  void openGoogleMaps(
      {double latitude = 20.382649, double longitude = 86.367002}) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  void otpDialog(BuildContext context, double screenSizeWidth) {
    Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          content: Stack(children: [
            Container(
              height: Get.height * 0.24,
              width: screenSizeWidth,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 1,
                        color: Colors.grey.shade300)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                      "Otp: ${subscribeBookingDetailsModel?.subscribeBookingDetails?.otp ?? ""}"),
                  PinFieldAutoFill(
                    textInputAction: TextInputAction.done,
                    codeLength: 4,
                    controller: otpEditingController,
                    decoration: UnderlineDecoration(
                      textStyle:
                          const TextStyle(fontSize: 16, color: Colors.blue),
                      colorBuilder: const FixedColorBuilder(
                        Colors.transparent,
                      ),
                      bgColorBuilder: FixedColorBuilder(
                        Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    // currentCode: controllerX.messageOtpCode.value,
                    onCodeSubmitted: (code) {
                      print("onCodeSubmitted $code");
                    },
                    onCodeChanged: (code) {
                      // controllerX.messageOtpCode.value = code??"000000";
                      // controller.countdownController.pause();
                      if (code?.length == 4) {
                        // controllerX.verifyOtp(code ??"000000");
                        // To perform some operation
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CommonButton(
                          padding: const EdgeInsets.only(
                              left: 22, right: 22, bottom: 4),
                          buttonText: "Verify OTP",
                          backgroundColor: Colors.red,
                          height: 33,
                          onTap: () {
                            // userDetails = "";
                            if (subscribeBookingDetailsModel != null) {
                              if (subscribeBookingDetailsModel
                                      ?.subscribeBookingDetails?.otp
                                      .toString()
                                      .trim() ==
                                  otpEditingController.text.toString().trim()) {
                                upDateRideStatusOtpVeryFy("OTP VERIFIED",
                                        bookingId: subscribeBookingDetailsModel
                                                ?.subscribeBookingDetails
                                                ?.bookingId ??
                                            "")
                                    .then((value) {
                                  callOrStopServices().then((value) async {
                                    await SharedPreferencesKeys().setStringData(key: "startDate",
                                        text: DateTime.now().toString());
                                    Future.delayed(
                                      const Duration(seconds: 10),
                                      () {
                                        calBackgroundServices("true");
                                      },
                                    );
                                  });
                                });
                                Get.back();
                              } else {
                                Snack.callError("Please enter a valid otp");
                              }
                            } else {
                              Snack.callError("Something went wrong");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                right: 0,
                left: 266,
                top: 0,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                  child: Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // userDetails = "";
                        print(">>>>>>>>>>>>>>backPressed");
                        Get.back();
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

  void goToMapDialog(BuildContext context, double screenSizeWidth) {
    Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          content: Stack(children: [
            Container(
              height: Get.height * 0.24,
              width: screenSizeWidth,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 1,
                        color: Colors.grey.shade300)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CommonButton(
                      padding: const EdgeInsets.only(
                          left: 4, right: 4, bottom: 10, top: 10),
                      buttonText: "Move To Pick Up Address",
                      backgroundColor: Colors.red,
                      height: 25,
                      isIcon: true,
                      onTap: () {
                        Get.back();
                        openGoogleMaps(
                            latitude: double.tryParse(incomingBookingModel
                                        ?.incomingBooking?.clientLat ??
                                    "0") ??
                                0,
                            longitude: double.tryParse(incomingBookingModel
                                        ?.incomingBooking?.clientLng ??
                                    "0") ??
                                0);
                      },
                    ),
                  ),
                  Expanded(
                    child: CommonButton(
                      padding: const EdgeInsets.only(
                          left: 4, right: 4, bottom: 10, top: 10),
                      buttonText: "Move to Travel Address",
                      backgroundColor: Colors.red,
                      height: 25,
                      isIcon: true,
                      onTap: () {
                        // userDetails = "";
                        Get.back();
                        openGoogleMaps(
                            latitude: double.tryParse(incomingBookingModel
                                        ?.incomingBooking?.destinationLat ??
                                    "0") ??
                                0,
                            longitude: double.tryParse(incomingBookingModel
                                        ?.incomingBooking?.destinationLng ??
                                    "0") ??
                                0);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                right: 0,
                left: 266,
                top: 0,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                  child: Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // userDetails = "";
                        print(">>>>>>>>>>>>>>backPressed");
                        Get.back();
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

  double getHeight(BoxConstraints constraints) {
    if (isDisappear.value) {
      mapHeight = (constraints.maxHeight / 10) * 9;
    } else {
      mapHeight = (constraints.maxHeight);
    }
    // update(['map']);
    return mapHeight;
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

  void handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    print(">>>>>>>>>>>>>>>>>>>>advancedDrawerController"+advancedDrawerController.toString());
    advancedDrawerController.showDrawer();
  }

  void startIsolate() async {
    ReceivePort? receivePort = ReceivePort();
    isolateField =
        await FlutterIsolate.spawn(startIsolateFun, receivePort.sendPort);
    receivePort.listen((message) {
      print("????????????????>>>>>>>>>>>>>isolate" + message);
      // isolateField?.kill();
    });

    /*  final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(startIsolateFun2, receivePort.sendPort);

    receivePort.listen((data) {
      if (data is Map<String, double>) {
        print("Received location data: ${data['latitude']}, ${data['longitude']}");
      } else {
        print("Received message from isolate: $data");
      }
    });*/
  }
}

@pragma("vm:entry-point")
@pragma("vm:entry-point", true)
@pragma("vm:entry-point", !bool.fromEnvironment("dart.vm.product"))
@pragma("vm:entry-point", "get")
@pragma("vm:entry-point", "call")
Future<void> startIsolateFun(SendPort sendPort) async {
  DartPluginRegistrant.ensureInitialized();
  // BackgroundIsolateBinaryMessenger.ensureInitialized(args[1]);
  // SendPort sendPort = args[0] as SendPort;
  geoLoc.GeolocatorPlatform geolocator = geoLoc.GeolocatorPlatform.instance;
  List<Map<String, double>> locationData = [];
  // sendPort.send("Isolate started");
  print(">>>>>>>>>>>>>isolate run");
  await SharedPreferencesKeys()
      .setStringData(key: "latlong", text: locationData.toString());

  geoLoc.LocationSettings locationSettings = geoLoc.AndroidSettings(
      accuracy: geoLoc.LocationAccuracy.high,
      distanceFilter: 0,
      forceLocationManager: true,
      foregroundNotificationConfig: const geoLoc.ForegroundNotificationConfig(
        notificationText:
            "Example app will continue to receive your location even when you aren't using it",
        notificationTitle: "Running in Background",
        enableWakeLock: true,
      ));

  final position = await determinePosition();
  print(">>>>>>>>>position${position.longitude}");
  StreamSubscription<geoLoc.Position>? positionStream =
      geolocator.getPositionStream(locationSettings: locationSettings).listen(
    (geoLoc.Position position) async {
      // sendPort.send(position.toJson());
      final data = {
        "latitude": position.latitude,
        "longitude": position.longitude,
      };

      locationData.add(data);
      await SharedPreferencesKeys()
          .setStringData(key: "latlong", text: locationData.toString());
      sendPort.send(locationData.toString());
      print(">>>>>>>>>message from isolate JKS2" + locationData.toString());
    },
    onError: (e) {
      print(">>>>>>>>>>exception" + e.toString());
      // sendPort.send("Error: $e");
    },
    cancelOnError: true,
  );
  Future.delayed(
    Duration(seconds: 500),
    () {
      positionStream.cancel();
    },
  );

  print(">>>>>>>>>message from isolate JKS");
}

@pragma("vm:entry-point")
@pragma("vm:entry-point", true)
@pragma("vm:entry-point", !bool.fromEnvironment("dart.vm.product"))
@pragma("vm:entry-point", "get")
@pragma("vm:entry-point", "call")
void startIsolateFun2(SendPort sendPort) async {
  DartPluginRegistrant.ensureInitialized();
  geoLoc.LocationSettings locationSettings = const geoLoc.LocationSettings(
    accuracy: geoLoc.LocationAccuracy.high,
    distanceFilter: 0,
  );

  StreamSubscription<geoLoc.Position> positionStream;

  // Listen for location updates
  positionStream = geoLoc.Geolocator.getPositionStream(
    locationSettings: locationSettings,
  ).listen(
    (geoLoc.Position position) {
      final data = {
        "latitude": position.latitude,
        "longitude": position.longitude,
      };
      sendPort.send(data);
    },
    onError: (e) {
      print("Error: $e");
      sendPort.send("Error: $e");
    },
    cancelOnError: true,
  );

  // Keep the isolate running
  await Future.delayed(
      Duration(days: 365)); // You can adjust the duration as needed
}

@pragma("vm:entry-point")
@pragma("vm:entry-point", true)
@pragma("vm:entry-point", !bool.fromEnvironment("dart.vm.product"))
@pragma("vm:entry-point", "get")
@pragma("vm:entry-point", "call")
Future<geoLoc.Position> determinePosition() async {
  bool serviceEnabled;
  geoLoc.LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await geoLoc.Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await geoLoc.Geolocator.checkPermission();
  if (permission == geoLoc.LocationPermission.denied) {
    permission = await geoLoc.Geolocator.requestPermission();
    if (permission == geoLoc.LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == geoLoc.LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await geoLoc.Geolocator.getCurrentPosition();
}
