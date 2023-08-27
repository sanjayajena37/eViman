part of 'driver_dashboard_controller.dart'; // Refer to the main controller file

extension MapHelper on DriverDashboardController {
  void callTest(){
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

  Future<void> calculateDistanceUsingAPI() async {
    List<String> travelModes = ["driving", "walking"]; //
    String apiKey = "YOUR_GOOGLE_MAPS_API_KEY";
    String origin =
        "Source Latitude,Source Longitude"; // Replace with actual values
    String destination =
        "Dest Latitude,Dest Longitude"; // Replace with actual values
    String travelMode =
        "driving"; // Replace with the desired travel mode ("driving", "walking", "transit", "bicycling")

    String url = "https://maps.googleapis.com/maps/api/distancematrix/json?" +
        "origins=$origin" +
        "&destinations=$destination" +
        "&mode=$travelMode" +
        "&key=$apiKey";

    // final response = await http.get(Uri.parse(url));
    final response = Response();

    final data = json.decode(response.body);

    if (data["status"] == "OK") {
      String distanceText = data["rows"][0]["elements"][0]["distance"]["text"];
      int distanceValue = data["rows"][0]["elements"][0]["distance"]["value"];

      print(
          "Distance: $distanceText"); // Distance in text format (e.g., "5.4 km")
      print("Distance Value: $distanceValue meters"); // Distance in meters
    } else {
      print("Error calculating distance");
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
    Location location = new Location();
    location.getLocation().then((value) {
      currentLocation = LatLng(value.latitude!, value.longitude!);
      // currentLocation = LatLng(20.296367,85.8085564);
      update(['map']);
    });
    GoogleMapController googleMapController = await mapControl.future;
    location.onLocationChanged.listen((newLoc) {
      currentLocation = LatLng(newLoc.latitude!, newLoc.longitude!);
      // currentLocation = LatLng(20.296367,85.8085564);
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 13.5,
              target: LatLng(newLoc.latitude!, newLoc.longitude!))));
      update(['map']);
    });
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
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/car.png")
        .then((value) => sourceIcon = value);
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/location.png")
        .then((value) => destinationIcon = value);
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