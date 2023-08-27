import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lo;

class MapPopup extends StatefulWidget {
  @override
  _MapPopupState createState() => _MapPopupState();
}

class _MapPopupState extends State<MapPopup> {
  LatLng selectedLatLng = LatLng(20.288187, 85.817814);
  GoogleMapController? mapController;
  CameraPosition? cameraPosition = const CameraPosition(target: LatLng(20.288187, 85.817814));
  String location = "Location Name:";
  Placemark ?locationDetails;
  Future<void> getCurrentLocation() async {
    lo.Location location = new lo.Location();
    location.getLocation().then((value) async {
      selectedLatLng = LatLng(value.latitude??0, value.longitude??0);
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          selectedLatLng.latitude,
          selectedLatLng.longitude);
      if(placeMarks.isNotEmpty){
        locationDetails = placeMarks.first;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    mapController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Location'),
      insetPadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(10),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.92,
        height: MediaQuery.of(context).size.height * 0.6,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: selectedLatLng,
            zoom: 15,
          ),

          mapType: MapType.normal,
          // on below line setting user location enabled.
          myLocationEnabled: true,
          // on below line setting compass enabled.
          compassEnabled: true,
          onTap: (LatLng latLng) {
            setState(() {
              selectedLatLng = latLng;
            });
            // mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng,15));
            mapController?.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: latLng, zoom: 17)
                //17 is new zoom level
                ));
          },
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              mapController = controller;
            });
          },
          markers: {
            Marker(
                markerId: MarkerId("Destination"),
                position:
                    LatLng(selectedLatLng.latitude, selectedLatLng.longitude),
                draggable: true,
                onDragEnd: (latLong) async {
                  selectedLatLng = latLong;
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      latLong.latitude,
                      latLong.longitude);
                  if(placemarks .isNotEmpty){
                    locationDetails = placemarks.first;
                  }
                  setState(() {});
                })
          },

          onCameraMove: (CameraPosition cameraPositiona) {
            cameraPosition = cameraPositiona; //when map is dragging
          },
          onCameraIdle: () async {
            //when map drag stops
            List<Placemark> placemarks = await placemarkFromCoordinates(
                cameraPosition!.target.latitude,
                cameraPosition!.target.longitude);
              //get place name from lat and lang
              location = placemarks.first.administrativeArea.toString() +
                  ", " +
                  placemarks.first.street.toString();
              if(placemarks .isNotEmpty){
                locationDetails = placemarks.first;
              }

              // print(">>>>name " + location);
              print(">>>>name " + locationDetails.toString());

          },
        ),
      ),
      actions: [
        Column(
          children: [
            Container(
              child: Text(
                  "${selectedLatLng.longitude},${selectedLatLng.latitude}"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Cancel')),
                SizedBox(width: 6),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pop(context, selectedLatLng);
                    Get.back<Map<String,dynamic>>(result: {"details":locationDetails,"lat":selectedLatLng.latitude,
                      "lng":selectedLatLng.longitude});
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
