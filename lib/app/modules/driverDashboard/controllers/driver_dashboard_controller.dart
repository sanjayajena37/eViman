import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:dateplan/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_polyline_points_plus/flutter_polyline_points_plus.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:location/location.dart';
import 'package:vibration/vibration.dart';

import '../../../../amplifyconfiguration.dart';
import '../../../../models/IncomingBooking.dart';
import '../../../../models/ModelProvider.dart';
import '../../../constants/helper.dart';
import '../../../constants/shared_preferences_keys.dart';
import '../../../constants/text_styles.dart';
import '../../../widgets/CustomeTittleText.dart';
import '../../../widgets/MyWidget.dart';
import '../../../widgets/RoundedButtonWidget.dart';
import '../../../widgets/Snack.dart';
import '../../../widgets/common_button.dart';
import '../../ConnectorController.dart';
import '../../loginscreen/controllers/loginscreen_controller.dart';
import '../IncomingBooking.dart';
import 'package:amplify_core/src/types/api/graphql/graphql_response.dart' as gr;

import '../LocationService.dart';
import 'AmplifyApiName.dart';
import 'package:geocoding/geocoding.dart' as geoc;
import 'package:http/http.dart' as http;
part 'mapcontroller.dart';
part 'appsyncController.dart';
part 'helpercontroller.dart';

class DriverDashboardController extends GetxController
    with Helper, WidgetsBindingObserver {
  //TODO: Implement DriverDashboardController
  final advancedDrawerController = AdvancedDrawerController();
  final count = 0.obs;
  LatLng sourceLocation = LatLng(20.288187, 85.817814);
  LatLng destination = LatLng(20.290983, 85.845584);

  Completer<GoogleMapController> mapControl = Completer<GoogleMapController>();
  List<LatLng> polylineCoordinates = [];
  GoogleMapController? mapController;

  LatLng? currentLocation;

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

  String? riderIdNew;
  String? authToken;

  geoc.Placemark? locationDetailsUser;

  getRiderId() async {
    riderIdNew = await SharedPreferencesKeys().getStringData(key: 'riderId');
    authToken = await SharedPreferencesKeys().getStringData(key: 'authToken');
    configureAmplify();
  }
  Future<void> configureAmplify() async {
    try {
      final api = AmplifyAPI(modelProvider: ModelProvider.instance);
      if (!(Amplify.isConfigured)) {
        await Amplify.addPlugins([api]);
        await Amplify.configure(amplifyconfig);
      }

      safePrint("Amplify configured successfully");
    } catch (e) {
      safePrint("Error configuring Amplify: $e");
    }
  }

  void subscribe() {
    print(">>>>>>>>>>>>>>>>>riderId"+riderIdNew.toString());
     int riderId = int.parse((riderIdNew != null && riderIdNew != "")?((riderIdNew??0).toString()) :"0"); // Replace with the desired rider ID

    // Subscribe to the GraphQL subscription with the parameter
    final Stream<gr.GraphQLResponse<String>> operation = Amplify.API.subscribe(
        GraphQLRequest<String>(
          document: """
          subscription IncomingBooking(\$rider: Int!) {
            incomingBooking(rider: \$rider) {
              rider
              clientLat
              clientLng
              clientName
              clientPhone
              clientId
              fareInfo
              bookingId
            }
          }
        """,
          variables: {
            'rider': riderId,
          },
        ), onEstablished: () {
      safePrint('Subscription established');
    });

    subscription = operation.listen(
      (event) {
        if(event.data != null){
          if(userDetails == ""){
            userDetails = (event.data??"").toString();
             Map? receiveData = jsonDecode(event.data as String)??{};
            calculateDistanceUsingAPI(desLat:double.tryParse(receiveData?['incomingBooking']['clientLat']??"0") ,
                desLong:double.tryParse(receiveData?['incomingBooking']['clientLng']??"0") ).then((value) {
                  print("distance"+value.toString());
            });
            showRideAcceptDialog(Get.context!,Get.width*0.9);
            safePrint(">>>>>>>>>>>mapData"+receiveData.toString());
          }else{
            Snack.callSuccess("Please take action quick");
          }
        }
        safePrint('Subscription event data received: ${event.data}');



      },
      onError: (Object e) => safePrint('Error in subscription stream: $e'),
    );
  }
  String userDetails = "";
  void unsubscribe() {
    if(subscription != null){
      subscription?.cancel();
    }
  }

  subscriptionStatus() {
    Amplify.Hub.listen(
      HubChannel.Api,
      (ApiHubEvent event) {
        if (event is SubscriptionHubEvent) {
          safePrint(event.status);
        }
      },
    );
  }

  Rx<List<double>> snapSize = Rx<List<double>>([0.1,0.2]);
  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    getRiderId();
    // getRiderId();
    super.onInit();
  }

  @override
  void onReady() {
    // Timer.periodic(Duration(seconds: 20), (timer) { showRideAcceptDialog(Get.context!,Get.width*0.9); });
    getCurrentLocation();
    // getPolyPoints();
    /* setCustomMarkerIcon();

    fetchDirections();*/
    super.onReady();
  }

  // Add more colors as needed

  @override
  void onClose() {
    advancedDrawerController.dispose();
    mapControl = Completer<GoogleMapController>();
    WidgetsBinding.instance.removeObserver(this);
    unsubscribe();
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
