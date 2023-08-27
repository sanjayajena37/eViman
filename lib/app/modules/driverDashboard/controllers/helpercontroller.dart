part of 'driver_dashboard_controller.dart';

extension HelperController on DriverDashboardController {
  goOnline(bool val) {
    Map sendData = {
      "status": (val)?1:0,
    };
    print(">>>>>"+sendData.toString());
    Get.find<ConnectorController>().PATCHMETHODCALL(
        api: "http://65.1.169.159:3000/api/riders/v1/update-online-status/30",
        json: sendData,
        fun: (map) {
          print(">>>>>>" + map.toString());
          if (map is Map &&
              map.containsKey("success") &&
              map['success'] == true) {
            if (isDisappear.value == true) {
              isDisappear = Rx<bool>(false);
            } else {
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
                height: MediaQuery.of(context).size.height * 0.35,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.location_on_sharp),
                                  Container(
                                    child: Text(
                                      "Lane Number 3,Nyapalli, Beherasahi,Odisha",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Iconsax.location),
                                  Container(
                                    child: Text(
                                        "Lane Number 3,Nyapalli, Beherasahi,Odisha"),
                                  ),
                                ],
                              )
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

  double getHeight(BoxConstraints constraints) {
    if (isDisappear.value) {
      mapHeight = (constraints.maxHeight / 10) * 9;
    } else {
      mapHeight = (constraints.maxHeight);
    }
    // update(['map']);
    return mapHeight;
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