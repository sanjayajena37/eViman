import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';

import 'MainClass.dart';
import 'app/constants/shared_preferences_keys.dart';
import 'app/data/BinderData.dart';
import 'app/logic/controllers/theme_provider.dart';
import 'app/modules/driverDashboard/controllers/workmanager_initializer.dart';
import 'app/providers/flutterbackgroundservices.dart';
import 'app/routes/app_pages.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:dio/dio.dart' as service1;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

/*  await Permission.locationAlways.isDenied.then((value) {
    if(value){
      Permission.locationAlways.request();
    }
  }) ;
  await Permission.location.isDenied.then((value) {
    if(value){
      Permission.location.request();
    }
  }) ;
  await Permission.notification.isDenied.then((value) {
    if(value){
      Permission.notification.request();
    }
  }) ;*/
  await Get.putAsync<ThemeController>(() => ThemeController.init(),
      permanent: true);
  // final int helloAlarmID = 0;
  // await AndroidAlarmManager.initialize();
  // await AndroidAlarmManager.periodic(const Duration(seconds: 3), helloAlarmID, BackgroundTask.printHello);

  // initializeWorkManager();
  await initializeService();

  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MainClass()));



  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    mapsImplementation.useAndroidViewSurface = true;
    mapsImplementation
        .initializeWithRenderer(AndroidMapRenderer.latest);
  }
}

@pragma("vm:entry-point")
@pragma("vm:entry-point", true)
@pragma("vm:entry-point", !bool.fromEnvironment("dart.vm.product"))
@pragma("vm:entry-point", "get")
@pragma("vm:entry-point", "call")
Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  // handleLocationPermission();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsBackground').listen((event) {
      print(">>>>>>>>>>>>>eventsetAsBackground" + event.toString());
      service.setAsBackgroundService();
    });

    service.on('setAsForeground').listen((event) {
      print(">>>>>>>>>>>>>eventsetAsForeground" + event.toString());
      service.setAsForegroundService();
    });


   /* service.on('isForeGround').listen((event) async {
      print(">>>>>>>>>>>>>eventJKsBCg$event");
      var sta = event?.values??"";
      if(sta == "true"){
        service.setAsForegroundService();
      }else{
        service.setAsBackgroundService();
      }
    });*/

  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });





  String? vehicleId =
  await SharedPreferencesKeys().getStringData(key: 'vehicleId');
  String? authToken =
  await SharedPreferencesKeys().getStringData(key: 'authToken');
  // print(">>>>>>>>>>>authToken????\n " + authToken.toString());

  Timer.periodic(Duration(seconds: 10), (timer) async {
    Position? curentPosition;
    vehicleId = await SharedPreferencesKeys().getStringData(key: 'vehicleId');
    authToken = await SharedPreferencesKeys().getStringData(key: 'authToken');
    // print(">>>>>>>>>>>authToken????\n " + authToken.toString());
    if (vehicleId != null && authToken != null) {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
              forceAndroidLocationManager: true)
              .then((Position position) async {
            curentPosition = position;
            print("bg location ${position.latitude}");
            Placemark? locationDetails ;
            List<Placemark> placeMarks = await placemarkFromCoordinates(
                position.latitude,
                position.longitude);
            if(placeMarks.isNotEmpty){
              locationDetails = placeMarks.first;
            }
            Map<String, dynamic> postData = {
              "currentCity":locationDetails?.locality?? "",
              "currentLocality":locationDetails?.subLocality?? "",
              "lat": (position.latitude ?? 0).toString(),
              "lng": (position.longitude ?? 0).toString()
            };
            // print(">>>>>postData" + postData.toString());
            // print(">>>>>>>>api" + "http://65.1.169.159:3000/api/vehicles/v1/update/location/" + (vehicleId ?? 0).toString());

            ShakeDetector.autoStart(
                shakeThresholdGravity: 7,
                shakeSlopTimeMS: 500,
                shakeCountResetTime: 3000,
                minimumShakeCount: 1,
                onPhoneShake: () async {
                  if (await Vibration.hasVibrator() ?? false) {
                    print("Test 2");
                    if (await Vibration.hasCustomVibrationsSupport() ?? false) {
                      print("Test 3");
                      Vibration.vibrate(duration: 1000);
                    } else {
                      print("Test 4");
                      Vibration.vibrate();
                      await Future.delayed(Duration(milliseconds: 500));
                      Vibration.vibrate();
                    }
                    print("Test 5");
                  }
                });

            try {
              var dio = Dio();
              service1.Response response = await dio.patch(
                "http://65.1.169.159:3000/api/vehicles/v1/update/location/${vehicleId ?? 0}",
                options: Options(
                    headers: {
                      "Authorization":
                      "Bearer " + ((authToken != null) ? authToken ?? '' : "")
                    }),
                data: (postData != null) ? jsonEncode(postData) : null,
              );
              if (response.statusCode == 200 || response.statusCode == 201) {
                try {
                  // print(">>>>>>>>>>>>response" + response.data.toString());
                  /*flutterLocalNotificationsPlugin.show(
                    888,
                    "Eviman App",
                    "Currently we are starting our background service for updating you current location"+response.data.toString(),
                    NotificationDetails(
                        android: AndroidNotificationDetails(
                          "eViman-rider",
                          "foregrounf service",
                          icon: 'ic_bg_service_small',
                          ongoing: true,
                          enableVibration: true,
                          color: Colors.green,
                          importance: Importance.high
                        )),
                  );*/
                } catch (e) {
                  print("Message is: " + e.toString());
                }
              } else if (response.statusCode == 417) {
              } else {
                print("Message is: >>1");
              }
            } on DioError catch (e) {
              switch (e.type) {
                case DioErrorType.connectTimeout:
                case DioErrorType.cancel:
                case DioErrorType.sendTimeout:
                case DioErrorType.receiveTimeout:
                case DioErrorType.other:
                  print("Message is: >>1" + e.toString());
                  break;
                case DioErrorType.response:
                  print(
                      "Message is: >>1" + (e.response?.data ?? "").toString());
              }
            }
          }).catchError((e) {
            Fluttertoast.showToast(msg: e.toString());
          });
        }
      }
    }
    else {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
              forceAndroidLocationManager: true)
              .then((Position position) {
            curentPosition = position;
            print("bg location ${position.latitude}");
            flutterLocalNotificationsPlugin.show(
              888,
              "Eviman App",
              "Currently we are starting our background service for updating you current location",
              const NotificationDetails(
                  android: AndroidNotificationDetails(
                    "eViman-rider",
                    "MY FOREGROUND SERVICE",
                    icon: 'ic_bg_service_small',
                    ongoing: true,
                  )),
            );
          }).catchError((e) {
            Fluttertoast.showToast(msg: e.toString());
          });
        }
      }
    }
  });

}

@pragma("vm:entry-point")
@pragma("vm:entry-point", true)
@pragma("vm:entry-point", !bool.fromEnvironment("dart.vm.product"))
@pragma("vm:entry-point", "get")
@pragma("vm:entry-point", "call")
Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    "eViman-rider",
    "initializing eViman background service",
    enableLights: true,
    sound: RawResourceAndroidNotificationSound('excuseme_boss'),
    description: "Background service for location fetching",
    importance: Importance.high,playSound: true,enableVibration: true,ledColor: Colors.green,showBadge: true
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
        notificationChannelId: "eViman-rider",
        initialNotificationTitle: "Location service enable",
        initialNotificationContent: "initializing eViman background service",
        foregroundServiceNotificationId: 888,
        autoStartOnBoot: true
    ),);
  service.startService();
}






