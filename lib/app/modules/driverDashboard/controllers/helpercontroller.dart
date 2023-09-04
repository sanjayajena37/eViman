part of 'driver_dashboard_controller.dart';

extension HelperController on DriverDashboardController {
  goOnline(bool val) {
    Map sendData = {
      "status": (val)?1:0,
    };
    print(">>>>>"+sendData.toString());
    Get.find<ConnectorController>().PATCH_METHOD_TOKEN(
        api: "http://65.1.169.159:3000/api/riders/v1/update-online-status/30",
        json: sendData,
        token:authToken??"",
        fun: (map) {
          print(">>>>>>" + map.toString());
          if (map is Map &&
              map.containsKey("success") &&
              map['success'] == true) {

            if (isDisappear.value == true) {
              userDetails = "";
              unsubscribe();
              isDisappear = Rx<bool>(false);
            } else {
              subscribe();
              userDetails = "";
              isDisappear = Rx<bool>(true);
            }
            isDisappear.refresh();
            update(['top']);
          } else {}
        });
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

  void showRideAcceptDialog(BuildContext context, double screenSizeWidth) {
    Get.dialog(
      barrierDismissible: false,
       AlertDialog(
          content:  Stack(children: [
            Container(
              height: Get.height*0.44,

              width: screenSizeWidth,
              padding: const EdgeInsets.all(16),
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
                   Text(
                    "There’s a new trip around you",
                    style: TextStyles(context).getBoldStyle().copyWith(color: Colors.white,fontSize: 16),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children:  [
                      Icon(
                        Icons.location_searching_rounded,
                        size: 20,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Lagos-Abeokuta Expressway KM 748",
                        style: TextStyles(context).getBoldStyle().copyWith(color: Colors.white,fontSize: 14),
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
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 9),
                    height: 8,
                    width: 2,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children:  [
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
                        style: TextStyles(context).getBoldStyle().copyWith(color: Colors.white,fontSize: 14),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
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
                                      color:  Color(0xffA6B7D4),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children:  [
                                  Text(
                                    "32Km",
                                    style: TextStyles(context).getBoldStyle().copyWith(color: Colors.white,fontSize: 32),
                                  ),
                                  Text(
                                    "Traveled distance",
                                    style: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 2,
                          color:  Color(0xffA6B7D4),
                        ),
                        SizedBox(
                          height: 70,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Icon(
                                      Icons.person,
                                      color:  Color(0xffA6B7D4),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children:  [
                                  Text(
                                    "12",
                                    style: TextStyles(context).getBoldStyle().copyWith(color: Colors.white,fontSize: 32),
                                  ),
                                  Text(
                                    "Passengers",
                                    style: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 12),
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
                            userDetails = "";

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
          ]),backgroundColor: const Color(0xff16192C),
          insetPadding: EdgeInsets.all(2),
          contentPadding: EdgeInsets.all(0),
        )
    );
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
    if(isRunning){
      service.invoke("stopService");
    }
    /* else{
      service.startService();
      FlutterBackgroundService().invoke("setAsForeground");
      Future.delayed(const Duration(seconds: 7));
      FlutterBackgroundService().invoke("setAsBackground");
    }*/
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
      await SharedPreferencesKeys().setStringData(key: "isLogin", text: "false");
      await SharedPreferencesKeys().setStringData(key: "riderId", text: "");
      callServices();
      Get.delete<LoginscreenController>();
      Get.offAndToNamed(Routes.LOGINSCREEN);
      // ignore: use_build_context_synchronously
    }
  }

  void handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    advancedDrawerController.showDrawer();
  }
}