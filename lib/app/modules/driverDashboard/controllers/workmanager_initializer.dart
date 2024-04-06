// workmanager_initializer.dart
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import '../LocationService.dart';

@pragma('vm:entry-point')
void printHello() {
  DartPluginRegistrant.ensureInitialized();
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().cancelAll();
  Workmanager().executeTask((task, inputData) async {
    // final locationData = await _getCurrentLocation();
    // print(">>>>>>>>>>>>>>>>>>>location" + locationData.toString());

    // final latitude = locationData.latitude;
    // final longitude = locationData.longitude;

    // final response = await _sendLocationToAPI(latitude ?? 0, longitude ?? 0);

    print('Location updated successfully.');
    /*
        if (response.statusCode == 200) {
          print('Location updated successfully.');
        } else {
          print('Failed to update location. Status code: ${response.statusCode}');
        }*/

    return Future.value(true);
  });
}

LocationService locationService = LocationService();

Future<LocationData?> _getCurrentLocation() async {
  try {
    LocationData? locationData1;

    locationService.location.requestPermission();
    locationService.startLocationUpdates((locationData) async {
      // Handle the location update here, e.g., send lat-long to the server.
      print(
          "Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}");
      locationData1 = locationData;
    });

    // locationData1 = await location.getLocation();
    return locationData1;
  } catch (e) {
    print('Error getting location: $e');
    return null;
  }
}

Future<http.Response> _sendLocationToAPI(
    double latitude, double longitude) async {
  final url =
      Uri.parse('https://backend.eviman.co.in/api/vehicles/v1/update/location/29');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: '{"latitude": $latitude, "longitude": $longitude}',
  );
  return response;
}

void initializeWorkManager() {
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask('1', 'simplePeriodicTask',
      frequency: Duration(seconds: 4),
      initialDelay: Duration.zero,
      constraints: Constraints(networkType: NetworkType.connected));
}
