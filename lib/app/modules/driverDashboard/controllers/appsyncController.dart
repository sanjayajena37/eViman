part of 'driver_dashboard_controller.dart';

extension AppSyncController on DriverDashboardController {
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

  void subscribeIncomingBooking() {
    print(">>>>>>>>>>>>>>>>>riderId" + riderIdNew.toString());
    int riderId = int.parse((riderIdNew != null && riderIdNew != "")
        ? ((riderIdNew ?? 0).toString())
        : "0"); // Replace with the desired rider ID

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
              destinationLat
              destinationLng
              dropAddress
              pickupAddress
              status
              amount
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
        if (event.data != null) {
          print(">>>>>>>>>>>>>>>>event.data"+event.data.toString());
          Map? receiveDataNewClose = jsonDecode(event.data as String) ?? {};
          if(receiveDataNewClose != null &&
              receiveDataNewClose['incomingBooking']['status'].toString().trim() == "Booking Timeout"){
            // incomingBookingModel = null;
            // subscribeBookingDetailsModel = null;
            userDetails = "";
            assetsAudioPlayer?.stop();
            assetsAudioPlayer?.dispose();
            closeDialogIfOpen();
          }
          else if (userDetails == "" && incomingBookingModel == null) {
            Map? receiveDataNew = jsonDecode(event.data as String) ?? {};
            // Booking Timeout
            if (receiveDataNew != null &&
                receiveDataNew['incomingBooking']['status'].toString().trim() ==
                    "Incoming Booking") {
              userDetails = (event.data ?? "").toString();
              Map? receiveData = jsonDecode(event.data as String) ?? {};
              incomingBookingModel = null;
              Vibration.vibrate();
              flutterLocalNotificationsPlugin.show(
                888,
                "Eviman App",
                "Please be ready for trips",
                const NotificationDetails(
                    android: AndroidNotificationDetails(
                        "eViman-rider", "foregrounf service",
                        icon: '@mipmap/ic_launcher',
                        ongoing: true,
                        enableVibration: true,
                        importance: Importance.high,
                        autoCancel: true,
                        sound: RawResourceAndroidNotificationSound(
                            'excuseme_boss'),
                        channelShowBadge: true,
                        enableLights: true,
                        color: Colors.green,
                        colorized: true,
                        playSound: true)),
              );
              calculateDistanceUsingAPI(
                  desLat: double.tryParse(
                      receiveData?['incomingBooking']['clientLat'] ?? "0"),
                  desLong: double.tryParse(
                      receiveData?['incomingBooking']['clientLng'] ?? "0"),
                  originLat: currentLocation?.latitude ?? 0,
                  originLong: currentLocation?.longitude ?? 0)
                  .then((value1) {
                calculateDistanceUsingAPI(
                    desLat: double.tryParse(receiveData?['incomingBooking']
                    ['destinationLat'] ??
                        "0"),
                    desLong: double.tryParse(receiveData?['incomingBooking']
                    ['destinationLng'] ??
                        "0"),
                    originLat: double.tryParse(
                        receiveData?['incomingBooking']['clientLat'] ??
                            "0"),
                    originLong: double.tryParse(
                        receiveData?['incomingBooking']['clientLng'] ??
                            "0"))
                    .then((value2) {
                      try{
                        assetsAudioPlayer?.stop();
                        openPlayer();
                        // assetsAudioPlayer?.play();
                      }catch(e){
                        if (kDebugMode) {
                          print("exception$e");
                        }

                      }
                  showRideAcceptDialog(Get.context!, Get.width * 0.9,
                      dropAddress: receiveData?['incomingBooking']
                      ['dropAddress'],
                      pickupAddress: receiveData?['incomingBooking']
                      ['pickupAddress'],
                      pickUpDistance: value1,
                      travelDistance: value2,
                      receiveData: receiveData);
                  safePrint("distance value2" + value2.toString());
                });
                safePrint("distance value1" + value1.toString());
              });

              safePrint(">>>>>>>>>>>mapData" + receiveData.toString());
            }
            else {
              // Snack.callSuccess("Please take action quick");
            }
          }
          else {
            // Snack.callSuccess("Please take action quick");
          }
        }
        safePrint('Subscription event data received: ${event.data}');
      },
      onError: (Object e) => safePrint('Error in subscription stream: $e'),
    );
  }

  void subscribeBookingDetails(String? bookingId) {
    // Replace with the desired rider ID

    // Subscribe to the GraphQL subscription with the parameter
    final Stream<gr.GraphQLResponse<String>> operation = Amplify.API.subscribe(
        GraphQLRequest<String>(
          document: """
         subscription subscribeBookingDetails(\$bookingId: String!) {
    subscribeBookingDetails(bookingId: \$bookingId) {
    bookingId
    bookingStatus
    otp
    riderId
    updatedBy
    updatedById
    updatedByUserType
    vehicleId
    }
}
        """,
          variables: {
            'bookingId': bookingId,
          },
        ), onEstablished: () {
      safePrint('Subscription established2');
    });

    subscription2 = operation.listen(
          (event) {
        if (event.data != null) {
          Map? receiveDataNew = jsonDecode(event.data as String) ?? {};
          if (receiveDataNew != null &&
              ((receiveDataNew['subscribeBookingDetails']['bookingStatus']
                  .toString()
                  .trim() ==
                  "Booking Timeout") ||
                  (receiveDataNew['subscribeBookingDetails']['bookingStatus']
                      .toString()
                      .trim() ==
                      "CANCELLED BY CUSTOMER") ||
                  (receiveDataNew['subscribeBookingDetails']['bookingStatus']
                      .toString()
                      .trim() ==
                      "CANCELLED BY RIDER"))) {
            userDetails = "";
            initialChildSize = Rx<double>(0.1);
            maxChildSize = Rx<double>(0.1);
            snapSize = Rx<List<double>>([0.1]);
            incomingBookingModel = null;
            subscribeBookingDetailsModel = null;
            polylineCoordinates = [];
            assetsAudioPlayer?.stop();
            assetsAudioPlayer?.dispose();
            unsubscribe2();
            update(['top']);
          } else {
            Map? receiveData = jsonDecode(event.data as String) ?? {};
            subscribeBookingDetailsModel =
                SubscribeBookingDetailsModel.fromJson(
                    receiveData as Map<String, dynamic>);
            update(['top']);
          }
        }
        safePrint('Subscription event data received2: ${event.data}');
      },
      onError: (Object e) => safePrint('Error in subscription stream: $e'),
    );
  }

  void unsubscribe() {
    if (subscription != null) {
      incomingBookingModel = null;
      subscription?.cancel();
    }
  }

  void unsubscribe2() {
    if (subscription2 != null) {
      subscribeBookingDetailsModel = null;
      subscription2?.cancel();
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

}