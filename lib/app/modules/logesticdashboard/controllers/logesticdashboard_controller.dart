import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

import '../../../../amplifyconfiguration.dart';
import '../../../../models/ModelProvider.dart';
import '../../../constants/helper.dart';
import '../../../constants/shared_preferences_keys.dart';
import '../../../constants/text_styles.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/CustomeTittleText.dart';
import '../../../widgets/MyWidget.dart';
import '../../../widgets/Snack.dart';
import '../../../widgets/common_button.dart';
import '../../ConnectorController.dart';
import '../../driverDashboard/CheckStatusModel.dart';
import '../../driverDashboard/IncomingBooikingModel.dart';
import '../../driverDashboard/LocationService.dart';
import '../../driverDashboard/SubscribeBookingDetailsModel.dart';
import '../../driverDashboard/controllers/driver_dashboard_controller.dart';
import '../../loginscreen/controllers/loginscreen_controller.dart';
import '../../profilescreen/ProfileViewModel.dart';
import 'package:geocoding/geocoding.dart' as geoc;
import 'package:http/http.dart' as http;
import 'package:amplify_core/src/types/api/graphql/graphql_response.dart' as gr;
import 'package:geolocator/geolocator.dart' as geoLoc;

import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:location/location.dart';

import '../UpComingRidesModel.dart';

part 'helpercontroller.dart';
// part 'mapcontroller.dart';

class LogesticdashboardController extends GetxController
    with Helper, WidgetsBindingObserver, GetSingleTickerProviderStateMixin {
  List<Map<String, double>> locationDataFromIsolate = [];
  TextEditingController fromDateController = TextEditingController();

  // FlutterIsolate? isolateField;
  late AdvancedDrawerController advancedDrawerController;
  final count = 0.obs;
  LatLng sourceLocation = LatLng(20.288187, 85.817814);
  LatLng destination = LatLng(20.290983, 85.845584);

  // Completer<GoogleMapController> mapControl = Completer<GoogleMapController>();
  List<LatLng> polylineCoordinates = [];
  // GoogleMapController? mapController;
  AnimationController? animationController;
  LatLng? currentLocation = const LatLng(20.288187, 85.817814);

  // BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  // BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  // BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  Rx<bool> isDisappear = Rx<bool>(false);
  // double mapHeight = 0;

  String? riderIdNew;
  String? vehicleIdNew;
  String? authToken;

  // geoc.Placemark? locationDetailsUser;
  IncomingBooikingModel? incomingBookingModel;
  CheckStatusModel? checkStatusModel;
  LinearTimerController? timerController;
  ProfileViewModel? profileViewModel;
  // bool otpVerifiedStatus = false;
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

  getRiderId() async {
    riderIdNew = await SharedPreferencesKeys().getStringData(key: 'riderId');
    vehicleIdNew =
        await SharedPreferencesKeys().getStringData(key: 'vehicleId');
    authToken = await SharedPreferencesKeys().getStringData(key: 'authToken');
    getProfileDetails();
    getRideAnalytics();
    getUpComingBookings();
  }

  Future<String> createRide() async {
    Completer<String> completer = Completer<String>();
    if (incomingBookingModel != null) {
      try {
        Map<String, dynamic> postData = {
          "bookingId":
              incomingBookingModel?.incomingBooking?.bookingId ?? "EVIMAN_1",
          "riderAssigned": riderIdNew ?? "",
          "vehicleAssigned": vehicleIdNew ?? "",
          "vehicleTypeId":
              incomingBookingModel?.incomingBooking?.fareInfo ?? "",
          "clientId": incomingBookingModel?.incomingBooking?.clientId ?? "",
          "pickupLat": incomingBookingModel?.incomingBooking?.clientLat ?? "",
          "pickupLng": incomingBookingModel?.incomingBooking?.clientLng ?? "",
          "dropLat":
              incomingBookingModel?.incomingBooking?.destinationLat ?? "",
          "pickupCoordinates": {
            "lat": (incomingBookingModel?.incomingBooking?.clientLat ?? ""),
            "lng": (incomingBookingModel?.incomingBooking?.clientLng ?? "")
          },
          "dropCoordinates": {
            "lat":
                (incomingBookingModel?.incomingBooking?.destinationLat ?? ""),
            "lng": (incomingBookingModel?.incomingBooking?.destinationLng ?? "")
          },
          "dropLng":
              incomingBookingModel?.incomingBooking?.destinationLng ?? "",
          "pickupAddress":
              incomingBookingModel?.incomingBooking?.pickupAddress ??
                  "Angul, Odisha, India",
          "dropAddress": incomingBookingModel?.incomingBooking?.dropAddress ??
              "Bhubaneswar, Odisha"
        };
        print(">>>>>>>>>createRideData" + postData.toString());

        MyWidgets.showLoading3();
        await Get.find<ConnectorController>().POSTMETHOD_TOKEN(
            api: "https://backend.eviman.co.in/api/rides/v1/create-ride",
            json: postData,
            token: authToken ?? "",
            fun: (map) {
              // Get.back();
              closeDialogIfOpen();
              if (map is Map &&
                  map.containsKey('success') &&
                  map['success'] == true) {
                completer.complete("true");
              } else {
                completer.complete("false");
                // Snack.callError((map ?? "Something went wrong").toString());
              }
              print(">>>>>mapData create ride" + map.toString());
            });
      } catch (e) {
        closeDialogIfOpen();
        completer.complete("false");
      }
    } else {
      completer.complete("false");
    }
    return completer.future;
  }

  void openPlayStorePage() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.eviman.rider';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
  UpComingRidesModel ?upComingRidesModel;

  getUpComingBookings(){
    Get.find<ConnectorController>().GETMETHODCALL_TOKEN(
        api: "https://backend.eviman.co.in/api/rides/v1/logistics/pending-requests",
        token: authToken ?? "",
        fun: (map) {
          dev.log(">>>>>>>>>>>upcoming${jsonEncode(map)}");
          if(map['success'] == true){
            upComingRidesModel = UpComingRidesModel.fromJson(map as Map<String,dynamic>);
            update(['lst']);
          }else{
            upComingRidesModel = null;
            update(['lst']);
          }
        });
  }

  String totalDistanceNew = "0.00";
  String totalAmount = "0.00";
  String totalRides = "0.00";

  getRideAnalytics() {
    Get.find<ConnectorController>().POSTMETHOD_TOKEN(
        api: "https://backend.eviman.co.in/api/rides/v1/get-rides-analytics",
        token: authToken ?? "",
        fun: (map) {
          print(">>>>>>>>>>>rides-analytics" + map.toString());
          if (map is Map &&
              map.containsKey("result") &&
              map['result'] != null) {
            totalDistanceNew =
                (map['result']['totalDistance'] ?? "0.00").toString();
            totalAmount = (map['result']['totalAmount'] ?? "0.00").toString();
            totalRides = (map['result']['totalRides'] ?? "0.00").toString();
            update(['analytics', 'amt']);
          } else {
            totalDistanceNew = "0.00";
            totalAmount = "0.00";
            totalRides = "0.00";
            update(['analytics', 'amt']);
          }
        });
  }

  Rx<List<double>> snapSize = Rx<List<double>>([0.1, 0.2]);
  Rx<double> maxChildSize = Rx<double>(0.2);
  Rx<double> initialChildSize = Rx<double>(0.1);
  TextEditingController otpEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();

  Stream<ConnectivityResult>? connectivitySubscription;
  StreamSubscription<geoLoc.Position>? positionStream;
  Connectivity connectivity = Connectivity();
  void handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    // print(">>>>>>>>>>>>>>>>>>>>advancedDrawerController"+advancedDrawerController.toString());
    if (advancedDrawerController != null) {
      advancedDrawerController.showDrawer();
    }
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    advancedDrawerController = AdvancedDrawerController();
    connectivitySubscription = connectivity.onConnectivityChanged;
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    // getRiderId();
    super.onInit();
  }

  requestForNotification() async {
    await permission.Permission.notification.isDenied.then((value) {
      if (value) {
        permission.Permission.notification.request();
      }
    });
  }

  bool permissionAllow = false;

  @override
  void onReady() {
    // Timer.periodic(Duration(seconds: 20), (timer) { showRideAcceptDialog(Get.context!,Get.width*0.9); });
    // showModalbottomSheet();
    // getCurrentLocation();
    // infoDialog1();
    getRiderId();
    // getCurrentLocation();
    // infoDialog2();
    // askPermissions();
    // timerController  =LinearTimerController(this);

    super.onReady();
  }

  // Add more colors as needed

  makingPhoneCall(String? number) async {
    var url = Uri.parse("tel:${number ?? 9178109443}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    // advancedDrawerController.dispose();
    // mapControl = Completer<GoogleMapController>();
    positionStream?.cancel();
    // timerController?.dispose();
    // unsubscribe();
    // locationUpdateTimer?.cancel();
    // locationService.stopLocationUpdates();
    super.onClose();
  }

  void increment() => count.value++;
  LocationService locationService = LocationService();
  Timer? locationUpdateTimer;

  geoc.Placemark? locationDetails;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(">>>>>>>>>>>>>>>>jks" + state.toString());
    /*if(state == AppLifecycleState.paused){
      getRiderId();
    }*/
    if (state == AppLifecycleState.detached) {
      // locationService.stopLocationUpdates();
    }
  }
}
