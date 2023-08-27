import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dateplan/amplifyconfiguration.dart';
import 'package:dateplan/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_polyline_points_plus/flutter_polyline_points_plus.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:location/location.dart';
import 'package:vibration/vibration.dart';

import '../../../../models/ModelProvider.dart';
import '../../../constants/helper.dart';
import '../../../widgets/CustomeTittleText.dart';
import '../../../widgets/MyWidget.dart';
import '../../../widgets/RoundedButtonWidget.dart';
import '../../../widgets/common_button.dart';
import '../../ConnectorController.dart';
import '../IncomingBooking.dart';
import 'package:amplify_core/src/types/api/graphql/graphql_response.dart' as gr;


part 'mapcontroller.dart';
part 'appsyncController.dart';
part 'helpercontroller.dart';

class DriverDashboardController extends GetxController with Helper {
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
  StreamSubscription<gr.GraphQLResponse<InComingBooking>>? subscription;

  void _configureAmplify() async {
    try {
      await Amplify.addPlugins([
        AmplifyAPI(
          subscriptionOptions: const GraphQLSubscriptionOptions(
            retryOptions: RetryOptions(maxAttempts: 10),
          ),
        )
      ]);
      await Amplify.configure(jsonEncode(amplifyconfig));
      // subscribe();
    } on AmplifyAlreadyConfiguredException {
      safePrint(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    } catch (e) {
      print("Amplify configuration failed: $e");
    }
  }

  Future<void> configureAmplify() async {
    try {
      final api = AmplifyAPI(modelProvider: ModelProvider.instance);
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugins([api, auth]);
      if (!Amplify.isConfigured) {
        await Amplify.configure(amplifyconfig);
      }
      safePrint("Amplify configured successfully");
    } catch (e) {
      safePrint("Error configuring Amplify: $e");
    }
  }

  void subscribe() {
    final subscriptionRequest =
        ModelSubscriptions.onCreate(InComingBooking.classType);
    final Stream<gr.GraphQLResponse<InComingBooking>> operation =
        Amplify.API.subscribe(
      subscriptionRequest,
      onEstablished: () => safePrint('Subscription established'),
    );
    subscription = operation.listen(
      (event) {
        safePrint('Subscription event data received: ${event.data}');
      },
      onError: (Object e) => safePrint('Error in subscription stream: $e'),
    );
  }

  void unsubscribe() {
    subscription?.cancel();
    subscription = null;
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

  @override
  void onInit() {
    configureAmplify();
    callTest();
    super.onInit();
  }

  @override
  void onReady() {
    getCurrentLocation();
    // getPolyPoints();
    /* setCustomMarkerIcon();

    fetchDirections();*/
    showModalbottomSheet();
    super.onReady();
  }

  // Add more colors as needed

  @override
  void onClose() {
    advancedDrawerController.dispose();
    mapControl = Completer<GoogleMapController>();
    super.onClose();
  }

  void increment() => count.value++;
}
