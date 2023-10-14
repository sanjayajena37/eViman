part of 'driver_dashboard_controller.dart'; // Refer to the main controller file

extension MapHelper on DriverDashboardController {
  void callTest() {
    print(">>>>>>>>>>>>>>>>>Jatin");
  }

  Future<void> fetchDirections() async {
    routeCoordinates.clear();
    List<String> travelModes = ["driving"]; // Add more modes as needed
    int colorIndex = 0;
    for (String mode in travelModes) {
      Get.find<ConnectorController>().GETMETHODCALL(
          api: "https://maps.googleapis.com/maps/api/directions/json?" +
              "origin=${sourceLocation.latitude},${sourceLocation.longitude}" + // Replace with source coordinates
              "&destination=${destination.latitude},${destination.longitude}" + // Replace with destination coordinates
              "&mode=$mode" +
              "&alternatives=true" +
              "&key=AIzaSyDwVSaWuD9KLlbKhJWj9tgKZN_QDDrvmpQ",
          fun: (data) {
            print(">>>>>" + data.toString());
            if (data["routes"] != null && data["routes"].length > 0) {
              // final route = data["routes"][0];
              List<dynamic> routes = data["routes"];

              /* final overviewPolyline = route["overview_polyline"]["points"];
              final List<LatLng> decodedRoute = decodeEncodedPolyline(overviewPolyline);
              routeCoordinates.add(decodedRoute);
              Color color = routeColors[colorIndex % routeColors.length];
              routeColorsMap[decodedRoute] = color;*/

              for (var route in routes) {
                final overviewPolyline = route["overview_polyline"]["points"];
                final List<LatLng> decodedRoute =
                    decodeEncodedPolyline(overviewPolyline);
                routeCoordinates.add(decodedRoute);
                Color color = routeColors[colorIndex % routeColors.length];
                routeColorsMap[decodedRoute] = color;
                colorIndex++;
              }

              update(['map']);
              print(">>>>>>>>resp" + routeCoordinates.toString());
            }
          });
    }
  }

  Future<String> calculateDistanceUsingAPI(
      {double? desLat,
      double? desLong,
      double? originLat,
      double? originLong}) async {
    List<String> travelModes = ["driving"]; //
    String apiKey = "AIzaSyDwVSaWuD9KLlbKhJWj9tgKZN_QDDrvmpQ";
    String origin =
        "${originLat ?? 0},${originLong ?? 0}"; // Replace with actual values
    String destination =
        "${desLat ?? 0},${desLong ?? 0}"; // Replace with actual values
    String travelMode =
        "driving"; // Replace with the desired travel mode ("driving", "walking", "transit", "bicycling")

    String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?origins=$origin&destinations=$destination&mode=$travelMode&key=$apiKey";
    print(">>>>>>>>>url" + url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(">>>>>>>>>>>" + data.toString());
      if (data["status"] == "OK" &&
          data["rows"] != null &&
          data["rows"].length > 0 &&
          data["rows"][0]["elements"][0]["distance"] != null) {
        String? distanceText =
            data["rows"][0]["elements"][0]["distance"]["text"];
        int distanceValue = data["rows"][0]["elements"][0]["distance"]["value"];

        print(
            "Distance: $distanceText"); // Distance in text format (e.g., "5.4 km")
        print("Distance Value: $distanceValue meters"); // Distance in meters
        return distanceText ?? "";
      } else {
        return "0.00";
        print("Error calculating distance");
      }
    } else {
      return "0.00";
    }
  }

  Future<double> calculateDistanceUsingAPIReturnMeter(
      {double? desLat,
      double? desLong,
      double? originLat,
      double? originLong}) async {
    List<String> travelModes = ["driving"]; //
    String apiKey = "AIzaSyDwVSaWuD9KLlbKhJWj9tgKZN_QDDrvmpQ";
    String origin =
        "${originLat ?? 0},${originLong ?? 0}"; // Replace with actual values
    String destination =
        "${desLat ?? 0},${desLong ?? 0}"; // Replace with actual values
    String travelMode =
        "driving"; // Replace with the desired travel mode ("driving", "walking", "transit", "bicycling")

    String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?origins=$origin&destinations=$destination&mode=$travelMode&key=$apiKey";
    print(">>>>>>>>>url" + url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(">>>>>>>>>>>" + data.toString());
      if (data["status"] == "OK" &&
          data["rows"] != null &&
          data["rows"].length > 0 &&
          data["rows"][0]["elements"][0]["distance"] != null) {
        String? distanceText =
            data["rows"][0]["elements"][0]["distance"]["text"];
        double distanceValue =
            data["rows"][0]["elements"][0]["distance"]["value"];

        print(
            "Distance: $distanceText"); // Distance in text format (e.g., "5.4 km")
        print("Distance Value: $distanceValue meters"); // Distance in meters
        return distanceValue ?? 0;
      } else {
        return 0.00;
        print("Error calculating distance");
      }
    } else {
      return 0.00;
    }
  }

  double calculateDistance(List<LatLng> route) {
    double distance = 0;
    for (int i = 0; i < route.length - 1; i++) {
      distance += calculateSegmentDistance(route[i], route[i + 1]);
    }
    return distance;
  }

  double calculateSegmentDistance(LatLng start, LatLng end) {
    const int radiusOfEarth = 6371; // Earth's radius in kilometers

    double lat1 = degreesToRadians(start.latitude);
    double lon1 = degreesToRadians(start.longitude);
    double lat2 = degreesToRadians(end.latitude);
    double lon2 = degreesToRadians(end.longitude);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = radiusOfEarth * c; // Distance in kilometers

    return distance;
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  Future<void> getCurrentLocation() async {
    // print(">>>>>>>>>>callGetLocation"+currentLocation.toString());
    Location location = Location();
    location.getLocation().then((value) {
      currentLocation = LatLng(value.latitude!, value.longitude!);
      // sourceLocation = LatLng(value.latitude!, value.longitude!);
      // currentLocation = LatLng(20.296367,85.8085564);
      print(">>>>>>>>>>callGetLocation"+currentLocation.toString());
      update(['top','map']);
    });
    GoogleMapController googleMapController = await mapControl.future;
    geoLoc.LocationSettings locationSettings = geoLoc.AndroidSettings(
        accuracy: geoLoc.LocationAccuracy.high,
        distanceFilter: 500,
        forceLocationManager: true);
    geoLoc.GeolocatorPlatform geolocator = geoLoc.GeolocatorPlatform.instance;

    positionStream =
        geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (geoLoc.Position position) async {
        currentLocation = LatLng(position.latitude, position.longitude);
        // sourceLocation = LatLng(position.latitude, position.longitude);
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                zoom: 13.5,
                target: LatLng(position.latitude, position.longitude))));
        update(['top','map']);
      },
      onError: (e) {
        print(">>>>>>>>>>exception" + e.toString());
        // sendPort.send("Error: $e");
      },
      cancelOnError: true,
    );
  }

  Future<geoc.Placemark?> getDetailsByLatLong(double? lat, double? lon) async {
    geoc.Placemark? locationDetailsUser;
    if (lat != null && lon != null && lat != 0 && lon != 0) {
      try {
        List<geoc.Placemark> placeMarks =
            await geoc.placemarkFromCoordinates(lat, lon);
        if (placeMarks.isNotEmpty) {
          locationDetailsUser = placeMarks.first;
        }
        return locationDetailsUser;
      } catch (e) {
        return locationDetailsUser;
      }
    } else {
      return locationDetailsUser;
    }
  }

  Future<String> getCityName(
      double latitude, double longitude, String apiKey) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final results = data['results'];
        if (results.isNotEmpty) {
          for (final component in results[0]['address_components']) {
            final types = component['types'];
            if (types.contains('locality') ||
                types.contains('administrative_area_level_2')) {
              return component['long_name'];
            }
          }
        }
      }
    }

    return 'Unknown';
  }

  void adjustBounds() {
    double minLat = polylineCoordinates[0].latitude;
    double maxLat = polylineCoordinates[0].latitude;
    double minLng = polylineCoordinates[0].longitude;
    double maxLng = polylineCoordinates[0].longitude;

    for (LatLng point in polylineCoordinates) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 100);
    mapController?.animateCamera(cameraUpdate);
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyDwVSaWuD9KLlbKhJWj9tgKZN_QDDrvmpQ",
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude));
    print(">>>>>" + result.points.toString());
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      update(['map']);
    }
  }

  void setCustomMarkerIcon() {
    /*  BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/location.png")
        .then((value) => sourceIcon = value);
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/location.png")
        .then((value) => destinationIcon = value);*/
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/motorbike.png")
        .then((value) => currentLocationIcon = value);
    update(['map']);
  }

  List<LatLng> decodeEncodedPolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lat += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }
}
