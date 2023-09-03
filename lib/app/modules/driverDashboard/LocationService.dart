import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  late StreamSubscription<LocationData?> locationSubscription;

  Future<void> startLocationUpdates(Function(LocationData) onLocationUpdate) async {
    DartPluginRegistrant.ensureInitialized();
    await location.enableBackgroundMode(enable: true);
    locationSubscription = location.onLocationChanged.listen((locationData) {
      if (locationData != null) {
        onLocationUpdate(locationData);
      }
    });
  }

  Future<void> stopLocationUpdates() async {
    await locationSubscription.cancel();
  }
}
