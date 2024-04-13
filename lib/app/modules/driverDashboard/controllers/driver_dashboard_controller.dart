import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'dart:math';
import 'dart:ui';
import 'dart:developer' as dev;

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:dateplan/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_polyline_points_plus/flutter_polyline_points_plus.dart';
import 'package:geolocator/geolocator.dart' as geoLoc;

import 'package:permission_handler/permission_handler.dart' as permission;

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:location/location.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

import '../../../../amplifyconfiguration.dart';

import '../../../../models/ModelProvider.dart';
import '../../../constants/helper.dart';
import '../../../constants/shared_preferences_keys.dart';
import '../../../constants/text_styles.dart';
import '../../../widgets/CustomeTittleText.dart';
import '../../../widgets/MyWidget.dart';
import '../../../widgets/Snack.dart';
import '../../../widgets/common_button.dart';
import '../../ConnectorController.dart';
import '../../loginscreen/controllers/loginscreen_controller.dart';
import '../../profilescreen/ProfileViewModel.dart';
import '../CheckStatusModel.dart';
import '../IncomingBooikingModel.dart';
import 'package:amplify_core/src/types/api/graphql/graphql_response.dart' as gr;

import '../LocationService.dart';
import '../SubscribeBookingDetailsModel.dart';
import 'package:geocoding/geocoding.dart' as geoc;
import 'package:http/http.dart' as http;

part 'mapcontroller.dart';
part 'appsyncController.dart';
part 'helpercontroller.dart';
part 'OtherFunctionController.dart';

class DriverDashboardController extends GetxController
    with Helper, WidgetsBindingObserver, GetSingleTickerProviderStateMixin {
  List<Map<String, double>> locationDataFromIsolate = [];

  FlutterIsolate? isolateField;
  late AdvancedDrawerController advancedDrawerController;
  final count = 0.obs;
  LatLng sourceLocation = LatLng(20.288187, 85.817814);
  LatLng destination = LatLng(20.290983, 85.845584);

  Completer<GoogleMapController> mapControl = Completer<GoogleMapController>();
  List<LatLng> polylineCoordinates = [];
  GoogleMapController? mapController;
  AnimationController? animationController;
  LatLng? currentLocation = const LatLng(20.288187, 85.817814);

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  Rx<bool> isDisappear = Rx<bool>(false);
  double mapHeight = 0;

  List<List<LatLng>> routeCoordinates = [];

  int selectedRouteIndex = -1;
  Map<List<LatLng>, Color> routeColorsMap = {};
  List<Color> routeColors = [
    Colors.lime,
    Colors.grey,
    Colors.yellow,
    Colors.orange,
    Colors.deepPurple
  ];
  StreamSubscription<gr.GraphQLResponse<String>>? subscription;
  StreamSubscription<gr.GraphQLResponse<String>>? subscription2;

  String? riderIdNew;
  String? vehicleIdNew;
  String? authToken;

  geoc.Placemark? locationDetailsUser;
  IncomingBooikingModel? incomingBookingModel;
  CheckStatusModel? checkStatusModel;
  LinearTimerController? timerController;
  ProfileViewModel? profileViewModel;
  bool otpVerifiedStatus = false;

  AssetsAudioPlayer? assetsAudioPlayer;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String? pickUpDist;
  String? travelDist;
  String? travelDistMeter;
  SubscribeBookingDetailsModel? subscribeBookingDetailsModel;

  Future<void> upDateRideStatus(String? sta, {String? bookingId}) async {
    if (kDebugMode) {
      print(">>>>>>>>>>>>>>>>subscribeBookingDetailsModel${subscribeBookingDetailsModel?.subscribeBookingDetails?.bookingId ?? ""}");
    }
    MyWidgets.showLoading3();
    Map<String, dynamic> postData = {
      "bookingId": bookingId ?? "",
      "bookingStatus": sta ?? "",
      "updatedById": riderIdNew ?? "",
      "updatedByUserType": "Rider",
      "amountReceived": double.tryParse(amountEditingController.text ?? "0") ??
          0 //Pass when bookingStatus is COMPLETED
    };
    if (kDebugMode) {
      print(">>>>>>>>>>>>>>>$postData");
    }
    Get.find<ConnectorController>().PATCH_METHOD1_POST_TOKEN(
        api: "https://backend.eviman.co.in/api/rides/v1/update-ride-status",
        token: authToken ?? "token",
        json: postData,
        fun: (map) {
          Get.back();
          if (kDebugMode) {
            print(">>>>>>>>>>mapSta$map");
          }
        });
  }

  Future<void> upDateRideStatusOtpVeryFy(String? sta,
      {String? bookingId}) async {
    if (kDebugMode) {
      print(">>>>>>>>>>>>>>>>subscribeBookingDetailsModel${subscribeBookingDetailsModel?.subscribeBookingDetails?.bookingId ?? ""}");
    }
    MyWidgets.showLoading3();
    Map<String, dynamic> postData = {
      "bookingId": bookingId ?? "",
      "bookingStatus": sta ?? "",
      "updatedById": riderIdNew ?? "",
      "updatedByUserType": "Rider",
      "amountReceived": double.tryParse(amountEditingController.text ?? "0") ??
          0 //Pass when bookingStatus is COMPLETED
    };
    if (kDebugMode) {
      print(">>>>>>>>>>>>>>>$postData");
    }
    Get.find<ConnectorController>().PATCH_METHOD1_POST_TOKEN(
        api: "https://backend.eviman.co.in/api/rides/v1/update-ride-status",
        token: authToken ?? "token",
        json: postData,
        fun: (map) {
          Get.back();
          if (map is Map &&
              map.containsKey('success') &&
              (map['success'] == "true" || map['success'] == true)) {
            otpVerifiedStatus = true;
            update(['drag']);
          } else {
            Snack.callError((map ?? "Something went wrong").toString());
          }
          if (kDebugMode) {
            print(">>>>>>>>>>mapSta$map");
          }
        });
  }

  Future<void> upDateRideStatusComplete(String? sta, String? amount,
      {String? bookingId}) async {
    if (kDebugMode) {
      print(">>>>>>>>>>>>>>>>subscribeBookingDetailsModel${subscribeBookingDetailsModel?.subscribeBookingDetails?.bookingId ?? ""}");
    }
    // MyWidgets.showLoading3();
    Map<String, dynamic> postData = {
      "bookingId": bookingId ?? "",
      "bookingStatus": sta ?? "",
      "updatedById": riderIdNew ?? "",
      "updatedByUserType": "Rider",
      "amountReceived": double.tryParse((amount ?? "0").toString() ?? "0") ??
          0 //Pass when bookingStatus is COMPLETED
    };
    if (kDebugMode) {
      print(">>>>>>>>>>>>>>>complete$postData");
    }
    Get.find<ConnectorController>().PATCH_METHOD1_POST_TOKEN(
        api: "https://backend.eviman.co.in/api/rides/v1/update-ride-status",
        token: authToken ?? "token",
        json: postData,
        fun: (map) {
          // Get.back();
          completeRide();
          if (kDebugMode) {
            print(">>>>>>>>>>mapSta$map");
          }
        });
  }

  String userDetails = "";

  Future<String> createRide({String? paymentmode, String? paymentId}) async {
    Completer<String> completer = Completer<String>();
    if (incomingBookingModel != null) {
      try {
        Map<String, dynamic> postData = {
          "bookingId": incomingBookingModel?.incomingBooking?.bookingId ?? "",
          "paymentId": paymentId ?? "",
          "paymentmode": paymentmode ?? "",
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
        if (kDebugMode) {
          print(">>>>>>>>>createRideData$postData");
        }

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
              if (kDebugMode) {
                print(">>>>>mapData create ride$map");
              }
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

  void cancelRide() async {
    bool isOk = await showCommonPopupNew3(
        "Are you sure you want to cancel it?", "If yes, please press ok.",
        barrierDismissible: false,
        isYesOrNoPopup: true,
        filePath: "assets/json/congratulation.json");
    if (isOk) {
      userDetails = "";
      initialChildSize = Rx<double>(0.1);
      maxChildSize = Rx<double>(0.1);
      snapSize = Rx<List<double>>([0.1]);
      incomingBookingModel = null;
      polylineCoordinates = [];

      update(['drag', 'map']);
      upDateRideStatus("CANCELLED BY RIDER",
              bookingId: subscribeBookingDetailsModel
                      ?.subscribeBookingDetails?.bookingId ??
                  "")
          .then((value) {
        unsubscribe2();
      });
    }
  }

  void completeRide() async {
    bool isOk = await showCommonPopupNew3(
        "Congratulation", "You have successfully completed this ride",
        barrierDismissible: true,
        isYesOrNoPopup: false,
        filePath: "assets/json/done.json");
    if (isOk) {}
  }

  String totalDistanceNew = "0.00";
  String totalAmount = "0.00";
  String totalRides = "0.00";

  getRideAnalytics() {
    Get.find<ConnectorController>().POSTMETHOD_TOKEN(
        api: "https://backend.eviman.co.in/api/rides/v1/get-rides-analytics",
        token: authToken ?? "",
        fun: (map) {
          if (kDebugMode) {
            print(">>>>>>>>>>>rides-analytics$map");
          }
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

  calculateDistance(List<dynamic> latLngList) async {
    // calculateDistanceUsingAPI
    dev.log(">>>>>>>>>>>DISTLIST$latLngList");
    // MyWidgets.showLoading3();
    double totalDistance = 0;
    /* if (latLngList.length > 1) {
      for (int i = 0; i < (latLngList.length - 1); i++) {
        await calculateDistanceUsingAPIReturnMeter(
                originLong: latLngList[i]['longitude'],
                originLat: latLngList[i]['latitude'],
                desLat: latLngList[i + 1]['latitude'],
                desLong: latLngList[i + 1]['longitude'])
            .then((value) {
          if (value != 0.00 && value != 0) {
            print(">>>>>>>>>>>>>>>valueJKs"+value.toString());
            totalDistance = totalDistance + value;
            print(">>>>>>>>>>>>>>>valueJKs"+totalDistance.toString());
          }
        });
      }
    }*/
    // closeDialogIfOpen();

    if (kDebugMode) {
      print(">>>>>>>>>>>>>>>>>travel distance$totalDistance");
    }
    String? startDate =
        await SharedPreferencesKeys().getStringData(key: 'startDate');
    DateTime startDate1 = DateTime.parse(startDate!);
    DateTime endDate = DateTime.now();
    Duration duration = endDate.difference(startDate1);
    double distanceInKilometer = totalDistance / 1000;
    getActualAmount(travelDist.toString().replaceAll("km", ""),
            duration.inMinutes.toString())
        .then((value) {
      if (value.toString().trim() != "") {
        completeRide1(
            amount: value ?? "40",
            distance: totalDistance,
            durationInMinutes: duration.inMinutes.toString());
      } else {
        Snack.callError("Something went wrong");
      }
    });
    // subscribeBookingDetailsModel?.subscribeBookingDetails?.bookingId ??
  }

  Future<String> getActualAmount(String distance, String duration) {
    Completer<String> completer = Completer<String>();
    Map<String, dynamic> postData = {
      "rideBookingId":
          subscribeBookingDetailsModel?.subscribeBookingDetails?.bookingId ??
              "",
      "distance": distance,
      "duration": duration
    };
    if (kDebugMode) {
      print("postData$postData");
    }
    try {
      Get.find<ConnectorController>().POSTMETHOD_TOKEN(
          api: "https://backend.eviman.co.in/api/rides/v1/actual-fare",
          token: authToken ?? "",
          json: postData,
          fun: (map) {
            if (kDebugMode) {
              print(">>>>>>>>>>>>>>>>amountMap$map");
            }
            if (map is Map &&
                map.containsKey("success") &&
                map['success'] == true) {
              completer.complete(map['fare'] ?? "");
            } else {
              completer.complete("");
            }
          });
    } catch (e) {
      completer.complete("");
    }

    return completer.future;
  }

  Rx<List<double>> snapSize = Rx<List<double>>([0.1, 0.2]);
  Rx<double> maxChildSize = Rx<double>(0.2);
  Rx<double> initialChildSize = Rx<double>(0.1);
  TextEditingController otpEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();

  Stream<ConnectivityResult>? connectivitySubscription;
  StreamSubscription<geoLoc.Position>? positionStream;
  Connectivity connectivity = Connectivity();

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

  bool permissionAllow = false;

  @override
  void onReady() {
    // Timer.periodic(Duration(seconds: 20), (timer) { showRideAcceptDialog(Get.context!,Get.width*0.9); });
    // showModalbottomSheet();
    // getCurrentLocation();
    // infoDialog1();
    getRiderId();
    getCurrentLocation();
    assetsAudioPlayer = AssetsAudioPlayer();

    // infoDialog2();
    // askPermissions();
    // timerController  =LinearTimerController(this);

    super.onReady();
  }

  openPlayer() {
    assetsAudioPlayer = AssetsAudioPlayer();
    // Audio("assets/audios/song1.mp3")
    assetsAudioPlayer?.open(Audio("assets/audio/excuseme_boss.mp3"),
        showNotification: true,
        loopMode: LoopMode.single,
        autoStart: true,
        playInBackground: PlayInBackground.disabledRestoreOnForeground,
        respectSilentMode: false);
    // assetsAudioPlayer?.stop();
  }

  // Add more colors as needed

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    // advancedDrawerController.dispose();
    mapControl = Completer<GoogleMapController>();
    positionStream?.cancel();
    // timerController?.dispose();
    unsubscribe();
    assetsAudioPlayer?.dispose();
    // locationUpdateTimer?.cancel();
    // locationService.stopLocationUpdates();
    super.onClose();
  }

  LocationService locationService = LocationService();
  Timer? locationUpdateTimer;

  geoc.Placemark? locationDetails;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print(">>>>>>>>>>>>>>>>jks$state");
    }
    /*if(state == AppLifecycleState.paused){
      getRiderId();
    }*/
    if (state == AppLifecycleState.detached) {
      // locationService.stopLocationUpdates();
    }
  }
}
