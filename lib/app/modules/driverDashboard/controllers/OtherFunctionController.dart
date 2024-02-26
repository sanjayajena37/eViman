part of 'driver_dashboard_controller.dart';


extension OtherFunctionController on DriverDashboardController {

  getProfileDetails() {
    MyWidgets.showLoading3();
    Get.find<ConnectorController>().GETMETHODCALL_TOKEN(
        api:
        "https://backend.eviman.co.in/api/riders/v1/profile/${riderIdNew ?? 0}",
        token: authToken ?? "",
        fun: (map) {
          print(">>>>" + map.toString());
          Get.back();
          if (map is Map &&
              map.containsKey("success") &&
              map['success'] == true) {
            profileViewModel =
                ProfileViewModel.fromJson(map as Map<String, dynamic>);
            update(['prof']);
          } else {
            profileViewModel = null;
            Get.back();
            // Snack.callError("Something went wrong");
          }
        });
  }

  checkStatus() {
    MyWidgets.showLoading3();
    Get.find<ConnectorController>().GETMETHODCALL(
        api:
        "https://backend.eviman.co.in/api/riders/v1/online-status/${riderIdNew ?? ""}",
        fun: (map) {
          incomingBookingModel = null;
          print(">>>>>>>>>>>>>online-status" + map.toString());
          Get.back();
          if (map != null &&
              map is Map &&
              map.containsKey('success') &&
              map['success'] == true) {
            checkStatusModel =
                CheckStatusModel.fromJson(map as Map<String, dynamic>);
            if (checkStatusModel != null &&
                checkStatusModel?.riderStatus != null &&
                checkStatusModel?.riderStatus?.activeRide != null) {
              if (checkStatusModel?.riderStatus?.activeRide?.rideStatus
                  .toString()
                  .trim() ==
                  "CONFIRMED" ||
                  checkStatusModel?.riderStatus?.activeRide?.rideStatus
                      .toString()
                      .trim() ==
                      "OTP VERIFIED") {
                incomingBookingModel = IncomingBooikingModel(
                    incomingBooking: IncomingBooking(
                      bookingId:
                      checkStatusModel?.riderStatus?.activeRide?.bookingId ??
                          "",
                      clientLat:
                      checkStatusModel?.riderStatus?.activeRide?.pickupLat ??
                          "",
                      clientLng:
                      checkStatusModel?.riderStatus?.activeRide?.pickupLng ??
                          "",
                      destinationLng:
                      checkStatusModel?.riderStatus?.activeRide?.dropLng ?? "",
                      destinationLat:
                      checkStatusModel?.riderStatus?.activeRide?.dropLat ?? "",
                      dropAddress:
                      checkStatusModel?.riderStatus?.activeRide?.dropAddress ??
                          "",
                      pickupAddress: checkStatusModel
                          ?.riderStatus?.activeRide?.pickupAddress ??
                          "",
                      clientId:
                      checkStatusModel?.riderStatus?.activeRide?.clientId ?? 0,
                      // clientName: "",
                      clientName:
                      checkStatusModel?.riderStatus?.clientName ??
                          "JKS",
                      clientPhone: checkStatusModel?.riderStatus?.clientPhone ?? "",
                      fareInfo:
                      checkStatusModel?.riderStatus?.activeRide?.fareInfo ?? 0,
                      status:
                      checkStatusModel?.riderStatus?.activeRide?.rideStatus ??
                          "",
                      rider: int.tryParse(checkStatusModel
                          ?.riderStatus?.activeRide?.riderAssigned ??
                          "0"),
                    ));
                subscribeBookingDetailsModel = SubscribeBookingDetailsModel(
                    subscribeBookingDetails: SubscribeBookingDetails(
                      bookingId:
                      checkStatusModel?.riderStatus?.activeRide?.bookingId ??
                          "",
                      bookingStatus:
                      checkStatusModel?.riderStatus?.activeRide?.rideStatus ??
                          "",
                      otp: checkStatusModel?.riderStatus?.activeRide?.otp ?? 0000,
                      riderId: int.tryParse(checkStatusModel
                          ?.riderStatus?.activeRide?.riderAssigned ??
                          "0"),
                      updatedById: int.tryParse(riderIdNew ?? "0"),
                      vehicleId: int.tryParse(vehicleIdNew ?? "0"),
                    ));
                travelDist =
                    checkStatusModel?.riderStatus?.activeRide?.distance ?? "0";
                maxChildSize = Rx<double>(0.7);
                initialChildSize = Rx<double>(0.5);
                snapSize = Rx<List<double>>(
                    [0.1, 0.2, 0.25, 0.3, 0.35, 0.4, 0.5, 0.6]);
                subscribeBookingDetails(
                    checkStatusModel?.riderStatus?.activeRide?.bookingId ?? "");
                if (checkStatusModel?.riderStatus?.activeRide?.rideStatus
                    .toString()
                    .trim() ==
                    "OTP VERIFIED") {
                  otpVerifiedStatus = true;
                }
                // getPolyPoints();
                setCustomMarkerIcon();
                update(['top']);
              }
            }

            if (checkStatusModel != null &&
                checkStatusModel?.riderStatus?.isOnline != null) {
              if (checkStatusModel?.riderStatus?.isOnline ?? false) {
                isDisappear = Rx<bool>(true);
                isDisappear.refresh();
                calBackgroundServices("true");
                subscribeIncomingBooking();
              } else {
                isDisappear = Rx<bool>(false);
                isDisappear.refresh();
                callOrStopServices();
              }
            }
            update(['top']);
          }
          else {
            incomingBookingModel = null;
            Snack.callError((map ?? "Something went wrong").toString());
          }
        });
  }

  getRiderId() async {
    riderIdNew = await SharedPreferencesKeys().getStringData(key: 'riderId');
    vehicleIdNew =
    await SharedPreferencesKeys().getStringData(key: 'vehicleId');
    authToken = await SharedPreferencesKeys().getStringData(key: 'authToken');
    getProfileDetails();
    getRideAnalytics();
    configureAmplify().then((value) {
      checkStatus();
    });
  }



  void infoDialog() async {
    bool isOk = await showCommonPopupNew3(
        "eViman App collect location(Background location) data to enable identification of nearby driver even when the app is closed or not in use",
        "No need to worry",
        barrierDismissible: true,
        isYesOrNoPopup: false,
        filePath: "assets/json/done.json");
    if (isOk) {
      goOnline(true);
    }
  }

  void infoDialog1() async {
    var status = await permission.Permission.location.status;
    var status1 = await permission.Permission.locationAlways.status;
    // var status2 = await permission.Permission.notification.status;
    print(">>>>>>>>>>>>>>status$status");

    if (status.isDenied || status.isPermanentlyDenied || status1.isDenied || status1.isPermanentlyDenied ) {
      bool isOk = await showCommonPopupNew6(
          (status.isDenied )?"This app collects location data to enable features like Live vehicle tracking ,Calculate ride price as per K.M and Time, even when the app is closed or not in use."
              :"If you are not allowing the permission then you are not able to use the application features. To use this features go to App settings page and follow the instruction mentioned on the screen.",
          "are you agree?",
          barrierDismissible: true,
          isYesOrNoPopup: true
      );
      if (isOk) {
        print(">>>>>>>>>>>>>>>sta loc"+status.toString());
        if(status.isDenied){
          await permission. Permission.location.request();
          await permission. Permission.notification.request();

          var status = await permission.Permission.location.status;
          if (status.isDenied || status.isPermanentlyDenied){
            permission.openAppSettings();
          }
        }else{
          permission.openAppSettings();
        }
      }
    }else{
      await permission. Permission.notification.request();
      permissionAllow = true;
      getRiderId();
      getCurrentLocation();
    }
  }

  void infoDialog2() async {
    var status = await permission.Permission.location.status;
    // var status1 = await permission.Permission.locationAlways.status;
    // var status2 = await permission.Permission.notification.status;
    print(">>>>>>>>>>>>>>status$status");
    if (status.isDenied || status.isPermanentlyDenied ) {
      bool isOk = await showCommonPopupNew6(
        // "eViman App need your run time location permission.It's required to give smooth less service to you",
          "This app collects location data to enable features like Live vehicle tracking ,Calculate ride price as per K.M and Time, even when the app is closed or not in use.",
          "are you agree?",
          barrierDismissible: true,
          isYesOrNoPopup: true
      );
      if (isOk) {
        // permission.openAppSettings();
        await permission.Permission.location.request();
        await permission.Permission.notification.request();
      }
    }
  }
  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }


  void completeRide1(
      {double? distance, String? amount, String? durationInMinutes}) async {
    // double distanceInKilometer = (distance!) / 1000;

    bool isOk = await showCommonPopupNew5(
        "Travel Distance-${(double.parse((travelDist??"0").replaceAll("km", "").trim()) ?? 0).toStringAsFixed(2)} K.M.\nTime Taken $durationInMinutes minutes",
        "You need to collect ₹$amount from customer",
        barrierDismissible: true,
        isYesOrNoPopup: true,
        filePath: "assets/json/done.json");
    if (isOk) {
      userDetails = "";
      initialChildSize = Rx<double>(0.1);
      maxChildSize = Rx<double>(0.1);
      snapSize = Rx<List<double>>([0.1]);
      incomingBookingModel = null;
      polylineCoordinates = [];

      update(['drag', 'map']);
      upDateRideStatusComplete("COMPLETED",
          bookingId: subscribeBookingDetailsModel
              ?.subscribeBookingDetails?.bookingId ??
              "",amount)
          .then((value) {
        unsubscribe2();
      });
    }
  }

  void openPlayStorePage() async {
    const url = 'https://play.google.com/store/apps/details?id=com.eviman.rider';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    // print(">>>>>>>>>>>>>>>>>>>>advancedDrawerController"+advancedDrawerController.toString());
    if(advancedDrawerController != null){
      advancedDrawerController.showDrawer();
    }
  }

  makingPhoneCall(String? number) async {
    var url = Uri.parse("tel:${number ?? 9178109443}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  askPermissions() async {
    // var sta =  permission.Permission.locationAlways;
    handleLocationPermission().then((value) async {

      if(value){
        var sta = await permission. Permission.notification.request();
        if(sta.isPermanentlyDenied || sta.isDenied){
          permissionAllow = false;
          update(['allPage']);
        }else{
          permissionAllow = true;
          // update(['allPage']);
          getRiderId();
          getCurrentLocation();
        }
      }else{
        permissionAllow = false;
        update(['allPage']);
      }
    });
  }


  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    geoLoc.LocationPermission permission;


    permission = await geoLoc.Geolocator.checkPermission();
    if(permission == geoLoc.LocationPermission.always){
      return true;
    }
    if (permission == geoLoc.LocationPermission.denied || permission == geoLoc.LocationPermission.whileInUse ) {
      return false;
    }
    if (permission == geoLoc.LocationPermission.deniedForever) {
      // openAppSettings();
      // ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied.')));
      return false;
    }
    if(permission == geoLoc.LocationPermission.whileInUse){
      return false;
    }
    return true;
  }

  requestForNotification() async {
    await permission.Permission.notification.isDenied.then((value) {
      if(value){
        permission.Permission.notification.request();
      }
    }) ;
  }

  getLatLngList() {
    try {
      Get.find<ConnectorController>().GETMETHODCALL_TOKEN(
          api: "https://backend.eviman.co.in/api/rider_data/v1/get-rider-data",
          token: authToken ?? "",
          fun: (map) {
            if (map is Map &&
                map['success'] == true &&
                map.containsKey("ride") &&
                map['ride'] != null) {
              calculateDistance(jsonDecode((map['ride']['data']))['list']);
            } else {
              Snack.callError("Something went wrong");
            }
            dev.log(">>>>>>>>>>>latlngList" +
                jsonDecode((map['ride']['data']))['list'].toString());
          });
    } catch (e) {
      Snack.callError("Something went wrong");
    }
  }

}