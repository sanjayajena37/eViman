import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shake/shake.dart';
import 'package:telephony/telephony.dart';
import 'package:vibration/vibration.dart';
import 'package:dio/dio.dart' as service1;

import '../constants/shared_preferences_keys.dart';
import '../data/Const.dart';

sendMessage(String messageBody) async {
  List<TContact> contactList = [TContact("9560388712", "JKS")];
  if (contactList.isEmpty) {
    Fluttertoast.showToast(msg: "no number exist please add a number");
  } else {
    for (var i = 0; i < contactList.length; i++) {
      Telephony.backgroundInstance
          .sendSms(to: contactList[i].number, message: messageBody)
          .then((value) {
        Fluttertoast.showToast(msg: "message send");
      });
    }
  }
}

Map<String, dynamic> failedMap = {
  Const.STATUS: Const.FAILED,
  Const.MESSAGE: Const.NETWORK_ISSUE,
};
Map<String, dynamic> alreadyMap = {
  Const.STATUS: Const.FAILED,
  Const.MESSAGE: "Already Available",
};
Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    "script academy",
    "foregrounf service",
    importance: Importance.high,
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
        notificationChannelId: "script academy",
        initialNotificationTitle: "foregrounf service",
        initialNotificationContent: "initializing",
        foregroundServiceNotificationId: 888,
      ));
  service.startService();
}

postCurrentLoc(ServiceInstance service,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  String? vehicleId =
      await SharedPreferencesKeys().getStringData(key: 'vehicleId');
  String? authToken =
      await SharedPreferencesKeys().getStringData(key: 'authToken');
  // print(">>>>>>>>>>>authToken????\n " + authToken.toString());

  Timer.periodic(Duration(seconds: 25), (timer) async {
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
            Map<String, dynamic> postData = {
              "currentCity": "BBSR",
              "currentLocality": "Nyapalli",
              "lat": (position.latitude ?? 0).toString(),
              "lng": (position.longitude ?? 0).toString()
            };
            // print(">>>>>postData" + postData.toString());
            print(">>>>>>>>api" +
                "http://65.1.169.159:3000/api/vehicles/v1/update/location/" +
                (vehicleId ?? 0).toString());
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
                  print(">>>>>>>>>>>>response" + response.data.toString());
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
    } else {
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
              "women safety app" + (curentPosition?.latitude).toString(),
              "shake feature enable",
              NotificationDetails(
                  android: AndroidNotificationDetails(
                "script academy",
                "foregrounf service",
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

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Location services are disabled. Please enable the services')));*/
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      /*ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));*/
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    /*ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text(
            'Location permissions are permanently denied, we cannot request permissions.')));*/
    return false;
  }
  return true;
}

PATCH_METHOD_TOKEN(
    {required String api,
    required String token,
    dynamic? json,
    required Function fun}) async {
  try {
    var dio = Dio();
    print("API NAME:>" + api);
    print("Token NAME:>" + token);
    service1.Response response = await dio.patch(
      api,
      options: Options(headers: {
        "Authorization": "Bearer " + ((token != null) ? token : "")
      }),
      data: (json != null) ? jsonEncode(json) : null,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        fun(response.data);
      } catch (e) {
        print("Message is: " + e.toString());
      }
    } else if (response.statusCode == 417) {
      fun(response.data);
    } else {
      print("Message is: >>1");
      fun(failedMap);
    }
  } on DioError catch (e) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.cancel:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.other:
        fun(failedMap);
        break;
      case DioErrorType.response:
        fun(e.response?.data);
    }
  }
}

@pragma('vm-entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  // handleLocationPermission();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      print(">>>>>>>>>>>>>event" + event.toString());
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  postCurrentLoc(service, flutterLocalNotificationsPlugin);
}

class TContact {
  int? _id;
  String? _number;
  String? _name;

  TContact(this._number, this._name);
  TContact.withId(this._id, this._number, this._name);

  //getters
  int get id => _id!;
  String get number => _number!;
  String get name => _name!;

  @override
  String toString() {
    return 'Contact: {id: $_id, name: $_name, number: $_number}';
  }

  //setters
  set number(String newNumber) => this._number = newNumber;
  set name(String newName) => this._name = newName;

  //convert a Contact object to a Map object
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['id'] = this._id;
    map['number'] = this._number;
    map['name'] = this._name;

    return map;
  }

  //Extract a Contact Object from a Map object
  TContact.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._number = map['number'];
    this._name = map['name'];
  }
}
