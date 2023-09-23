import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/text_styles.dart';
import '../../../constants/themes.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/CustomeTittleText.dart';
import '../../../widgets/DraggablePopup.dart';
import '../../../widgets/MovableContainer.dart';
import '../../../widgets/RoundedButtonWidget.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_text_field_view.dart';
import '../../../widgets/remove_focuse.dart';
import '../../../widgets/tap_effect.dart';
import '../controllers/driver_dashboard_controller.dart';
import 'package:dateplan/app/constants/helper.dart';

class DriverDashboardView extends StatelessWidget {
  DriverDashboardView({Key? key}) : super(key: key);

  DriverDashboardController controllerX =
  Get.put<DriverDashboardController>(DriverDashboardController());

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        /* decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.tealAccent.withOpacity(0.2),
              Colors.blueGrey.withOpacity(0.2),
              Colors.tealAccent.withOpacity(0.2)
            ],
          ),
        ),*/
      ),
      controller: controllerX.advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: true,
      backdropColor: Colors.white,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.red,
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.27,
                  child: DrawerHeader(
                    // decoration: const BoxDecoration(color: Colors.),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GetBuilder<DriverDashboardController>(
                          assignId: true,
                          id: "prof",
                          builder: (controllerX) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width:Get.width*0.5,
                                      child: Text("${controllerX.profileViewModel
                                          ?.riderData?.firstName ??
                                          ""} ${controllerX.profileViewModel
                                          ?.riderData?.lastName ?? ""}",
                                          style: TextStyles(context)
                                              .getBoldStyle().copyWith(fontSize: 18),
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 05,
                                    ),
                                    Container(
                                      width:Get.width*0.5,
                                      child: Text(controllerX.profileViewModel?.riderData?.email??"evidriver12@gmail.com",
                                          style: TextStyles(context)
                                              .getBoldStyle().copyWith(fontSize: 12),maxLines: 2,
                                      ),

                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(1), // Border radius
                                    child: ClipOval(
                                        child:(controllerX.profileViewModel
                                            ?.riderData?.profile_image != null)?
                                        Image.network(controllerX.profileViewModel
                                            ?.riderData?.profile_image??"",
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
                                          return Image.asset(
                                            'assets/images/man.jpg',
                                            filterQuality: FilterQuality.high,
                                            fit: BoxFit.cover,
                                          );
                                        },): Image.asset(
                                          'assets/images/man.jpg',
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // driverINfoWidget("assets/icon/time.png", "10.2", "Hours online"),
                            driverINfoWidget("assets/icon/meter.png", "30 kM",
                                "Total Distance"),
                            driverINfoWidget(
                                "assets/icon/jobs.png", "20", "Total Jobs"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    controllerX.advancedDrawerController.hideDrawer();
                  },
                  leading:
                  Icon(Icons.home, color: Theme
                      .of(context)
                      .primaryColor),
                  title: Text(
                    'Home',
                    style: TextStyles(context)
                        .getRegularStyle()
                        .copyWith(fontSize: 15),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.PROFILESCREEN);
                  },
                  leading: Icon(Icons.account_circle_rounded,
                      color: Theme
                          .of(context)
                          .primaryColor),
                  title: Text(
                    'Profile',
                    style: TextStyles(context)
                        .getRegularStyle()
                        .copyWith(fontSize: 15),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.VEHICLE_DETAILS);
                  },
                  leading: Icon(Icons.electric_car,
                      color: Theme
                          .of(context)
                          .primaryColor),
                  title: Text(
                    'Vehicle Details',
                    style: TextStyles(context)
                        .getRegularStyle()
                        .copyWith(fontSize: 15),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading:
                  Icon(Icons.money, color: Theme
                      .of(context)
                      .primaryColor),
                  title: Text(
                    'My Earning',
                    style: TextStyles(context)
                        .getRegularStyle()
                        .copyWith(fontSize: 15),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.WALETSCREEN);
                  },
                  leading:
                  Icon(Icons.wallet, color: Theme
                      .of(context)
                      .primaryColor),
                  title: Text(
                    'My Wallet',
                    style: TextStyles(context)
                        .getRegularStyle()
                        .copyWith(fontSize: 15),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.HISTORYSCREEN);
                  },
                  leading: Icon(Icons.history,
                      color: Theme
                          .of(context)
                          .primaryColor),
                  title: Text(
                    'History',
                    style: TextStyles(context)
                        .getRegularStyle()
                        .copyWith(fontSize: 15),
                  ),
                ),
                /*  ListTile(
                  onTap: () {},
                  leading: Icon(Icons.notifications_active,
                      color: Theme.of(context).primaryColor),
                  title: Text(
                    'Notification',
                    style: TextStyles(context)
                        .getRegularStyle()
                        .copyWith(fontSize: 15),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.INVITESCREEN);
                  },
                  leading: Icon(Icons.card_giftcard_outlined,
                      color: Theme.of(context).primaryColor),
                  title: Text(
                    'Invite a Friend',
                    style: TextStyles(context)
                        .getRegularStyle()
                        .copyWith(fontSize: 15),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.SETTINGSCREEN);
                  },
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyles(context)
                        .getRegularStyle()
                        .copyWith(fontSize: 15),
                  ),
                ),*/
                ListTile(
                  onTap: () {
                    controllerX.gotoSplashScreen();
                  },
                  leading:
                  Icon(Icons.logout, color: Theme
                      .of(context)
                      .primaryColor),
                  title: Text(
                    'Logout',
                    style: TextStyles(context)
                        .getRegularStyle()
                        .copyWith(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        body: GetBuilder<DriverDashboardController>(
            id: "top",
            builder: (controllerX) {
              return Stack(
                children: [
                  LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return SizedBox(
                      height: controllerX.getHeight(constraints),
                      child: GetBuilder<DriverDashboardController>(
                          id: "map",
                          builder: (controllerX) {
                            return (controllerX.currentLocation == null)
                                ? Center(
                              child: Container(
                                child: CircularProgressIndicator(),
                              ),
                            )
                                : GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      controllerX.currentLocation
                                          ?.latitude ??
                                          0,
                                      controllerX.currentLocation
                                          ?.longitude ??
                                          0),
                                  zoom: 14.5),
                              mapType: MapType.normal,
                              key: UniqueKey(),
                              onMapCreated: (GoogleMapController contr) {
                                controllerX.mapControl = Completer();
                                controllerX.mapController = contr;
                                controllerX.mapControl.complete(contr);
                                // controllerX.adjustBounds();
                              },
                              compassEnabled: true,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                              mapToolbarEnabled: true,
                              padding: EdgeInsets.all(25),
                              polylines: /*(controllerX
                                            .routeCoordinates.isNotEmpty)
                                        ? Set<Polyline>.from(
                                            controllerX.routeCoordinates
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              final index = entry.key;
                                              final route = entry.value;
                                              // final color = controllerX.routeColors[index % controllerX.routeColors.length];
                                              final color = controllerX
                                                  .routeColorsMap[route];
                                              final isSelected = (index ==
                                                  controllerX
                                                      .selectedRouteIndex);
                                              return Polyline(
                                                  polylineId: PolylineId(
                                                      "route_$index"),
                                                  color: isSelected
                                                      ? Colors.orange
                                                      : color ?? Colors.blue,
                                                  width: isSelected ? 12 : 8,
                                                  points: route,
                                                  consumeTapEvents: true,
                                                  onTap: () {
                                                    controllerX
                                                            .selectedRouteIndex =
                                                        index;
                                                    print(">>>>index" +
                                                        index.toString());
                                                    controllerX.update(['map']);
                                                  });
                                            }),
                                          )
                                        : {},*/
                              {
                                Polyline(
                                    polylineId: PolylineId('route'),
                                    points:
                                    controllerX.polylineCoordinates,
                                    color: Colors.deepPurpleAccent,
                                    endCap: Cap.roundCap,
                                    startCap: Cap.roundCap,
                                    consumeTapEvents: true,
                                    geodesic: true)
                              },
                              markers: {
                                Marker(
                                    markerId: MarkerId("source"),
                                    position: controllerX.sourceLocation),
                                Marker(
                                    markerId: MarkerId("Destination"),
                                    position: controllerX.destination),
                                Marker(
                                    markerId:
                                    MarkerId("Current Location"),
                                    position: LatLng(
                                        controllerX
                                            .currentLocation!.latitude!,
                                        controllerX
                                            .currentLocation!.longitude!),
                                    icon: controllerX.currentLocationIcon)
                              },
                            );
                          }),
                    );
                  }),
                  Positioned(
                    top: MediaQuery
                        .of(context)
                        .padding
                        .top + 25,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(5.0), //<-- SEE HERE
                            ),
                            margin: EdgeInsets.all(2),
                            elevation: 5,
                            child: IconButton(
                              onPressed: controllerX.handleMenuButtonPressed,
                              padding: EdgeInsets.all(2),
                              visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                                valueListenable:
                                controllerX.advancedDrawerController,
                                builder: (_, value, __) {
                                  return AnimatedSwitcher(
                                    duration: Duration(milliseconds: 250),
                                    child: Icon(
                                      value.visible ? Icons.clear : Icons.menu,
                                      key: ValueKey<bool>(value.visible),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Card(
                                elevation: 5,
                                color: Theme
                                    .of(context)
                                    .cardColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "₹0.00",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                )),
                          ),
                          Obx(() {
                            return (controllerX.isDisappear.value)
                                ? CupertinoSwitch(
                              value: controllerX.isDisappear.value,
                              dragStartBehavior: DragStartBehavior.start,
                              onChanged: (value) {
                                controllerX.goOnline(value);
                              },
                            )
                                : Container();
                          }),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                        () =>
                    (controllerX.isDisappear.value == false)
                        ? MovableContainer(onTap: () {
                      controllerX.goOnline(true);
                    })
                        : Container(),
                  ),
                  GetBuilder<DriverDashboardController>(
                    assignId: true,
                    id: 'drag',
                    builder: (controllerX) {
                      return Obx(
                            () =>
                        (controllerX.isDisappear.value == true)
                            ? DraggableScrollableSheet(
                            initialChildSize:
                            controllerX.initialChildSize.value,
                            minChildSize: 0.1,
                            maxChildSize: controllerX.maxChildSize.value,
                            // snapSizes: [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7],
                            snapSizes: controllerX.snapSize.value,
                            snap: true,
                            expand: true,
                            builder: (BuildContext context,
                                scrollSheetController) {
                              return Container(
                                  color: Colors.white,
                                  child: ListView(
                                    controller: scrollSheetController,
                                    padding: EdgeInsets.zero,
                                    physics: ClampingScrollPhysics(),
                                    children: [
                                      // Text(controllerX.subscribeBookingDetailsModel?.subscribeBookingDetails?.bookingId??""),

                                      (controllerX.incomingBookingModel !=
                                          null)
                                          ? RemoveFocuse(
                                        onClick: () {
                                          FocusScope.of(context)
                                              .requestFocus(
                                              FocusNode());
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 5.0,
                                                  vertical: 2),
                                              child: Container(
                                                color: Colors.white,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const CircleAvatar(
                                                          backgroundColor:
                                                          Colors
                                                              .transparent,
                                                          backgroundImage:
                                                          AssetImage(
                                                              "assets/images/man.jpg"),
                                                          maxRadius:
                                                          20,
                                                          minRadius:
                                                          10,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        CustomeTittleText(
                                                          text: controllerX
                                                              .incomingBookingModel
                                                              ?.incomingBooking
                                                              ?.clientName ??
                                                              "Amrit Jena",
                                                          textsize:
                                                          18,
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        controllerX
                                                            .makingPhoneCall(
                                                            controllerX
                                                                .incomingBookingModel
                                                                ?.incomingBooking
                                                                ?.clientPhone);
                                                        // await FlutterPhoneDirectCaller.callNumber("919178488130");
                                                      },
                                                      child: lottie
                                                          .Lottie
                                                          .asset(
                                                        "assets/json/call.json",
                                                        fit: BoxFit
                                                            .contain,
                                                        height: 70,
                                                        width: 70,
                                                        filterQuality:
                                                        FilterQuality
                                                            .high,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 5.0,
                                                  vertical: 0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .location_searching_rounded,
                                                    size: 20,
                                                    color:
                                                    Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width: Get.width *
                                                        0.86,
                                                    child: Text(
                                                      controllerX
                                                          .incomingBookingModel
                                                          ?.incomingBooking
                                                          ?.pickupAddress ??
                                                          "Lagos-Abeokuta Expressway KM 748",
                                                      maxLines: 3,
                                                      softWrap: true,
                                                      style: TextStyles(
                                                          context)
                                                          .getDescriptionStyle()
                                                          .copyWith(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          fontSize:
                                                          13),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 5.0,
                                                  vertical: 2),
                                              child: Container(
                                                margin:
                                                const EdgeInsets
                                                    .only(
                                                    left: 9),
                                                height: 8,
                                                width: 2,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 5.0,
                                                  vertical: 2),
                                              child: Container(
                                                margin:
                                                const EdgeInsets
                                                    .only(
                                                    left: 9),
                                                height: 8,
                                                width: 2,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 5.0,
                                                  vertical: 2),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 20,
                                                    color: Color(
                                                        0xffADD685),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width: Get.width *
                                                        0.86,
                                                    child: Text(
                                                      controllerX
                                                          .incomingBookingModel
                                                          ?.incomingBooking
                                                          ?.dropAddress ??
                                                          "Queen Street 73",
                                                      maxLines: 3,
                                                      style: TextStyles(
                                                          context)
                                                          .getDescriptionStyle()
                                                          .copyWith(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          fontSize:
                                                          13),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          5.0,
                                                          vertical:
                                                          2),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Container(
                                                            child:
                                                            Text(
                                                              "PickUp Distance: ",
                                                              style: TextStyles(
                                                                  context)
                                                                  .getDescriptionStyle()
                                                                  .copyWith(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize: 13),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            controllerX
                                                                .pickUpDist ??
                                                                "4.0 K.M.",
                                                            style: TextStyles(
                                                                context)
                                                                .getBoldStyle()
                                                                .copyWith(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 15),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          5.0,
                                                          vertical:
                                                          2),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Container(
                                                            child:
                                                            Text(
                                                              "Travel Distance: ",
                                                              style: TextStyles(
                                                                  context)
                                                                  .getDescriptionStyle()
                                                                  .copyWith(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize: 13),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            controllerX
                                                                .travelDist ??
                                                                "40.0 K.M.",
                                                            style: TextStyles(
                                                                context)
                                                                .getBoldStyle()
                                                                .copyWith(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 15),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    controllerX.otpDialog(
                                                        Get.context!,
                                                        Get.width *
                                                            0.85);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      lottie.Lottie
                                                          .asset(
                                                        "assets/json/enterotp.json",
                                                        fit: BoxFit
                                                            .contain,
                                                        height: 40,
                                                        width: 40,
                                                        filterQuality:
                                                        FilterQuality
                                                            .high,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                            "Enter OTP",
                                                            style: TextStyles(
                                                                context)
                                                                .getBoldStyle()
                                                                .copyWith(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 15)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            CommonTextFieldView(
                                              controller: controllerX
                                                  .amountEditingController,
                                              maxLength: 10,
                                              titleText:
                                              "Amount Received",
                                              contextNew: context,
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  left: 24,
                                                  right: 24,
                                                  bottom: 16),
                                              hintText:
                                              "enter amount you have received",
                                              keyboardType:
                                              TextInputType
                                                  .number,
                                              onChanged:
                                                  (String txt) {},
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child:
                                                    CommonButton(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 2,
                                                          right:
                                                          2,
                                                          bottom:
                                                          1),
                                                      buttonText:
                                                      "Cancel",
                                                      onTap: () {
                                                        controllerX
                                                            .userDetails = "";
                                                        controllerX
                                                            .initialChildSize =
                                                            Rx<double>(
                                                                0.1);
                                                        controllerX
                                                            .maxChildSize =
                                                            Rx<double>(
                                                                0.1);
                                                        controllerX
                                                            .snapSize = Rx<
                                                            List<
                                                                double>>(
                                                            [0.1]);
                                                        controllerX
                                                            .incomingBookingModel =
                                                        null;
                                                        controllerX
                                                            .polylineCoordinates =
                                                        [];

                                                        controllerX
                                                            .update([
                                                          'drag',
                                                          'map'
                                                        ]);
                                                        controllerX
                                                            .upDateRideStatus(
                                                            "CANCELLED BY RIDER",
                                                            bookingId: controllerX
                                                                .subscribeBookingDetailsModel
                                                                ?.subscribeBookingDetails
                                                                ?.bookingId ??
                                                                "")
                                                            .then(
                                                                (value) {
                                                              controllerX
                                                                  .unsubscribe2();
                                                            });
                                                      },
                                                      radius: 10,
                                                      height: 37,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 2,
                                                  ),
                                                  Expanded(
                                                    child:
                                                    CommonButton(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 2,
                                                          right:
                                                          2,
                                                          bottom:
                                                          1),
                                                      buttonText:
                                                      "Completed",
                                                      onTap: () {
                                                        controllerX
                                                            .userDetails = "";
                                                        controllerX
                                                            .initialChildSize =
                                                            Rx<double>(
                                                                0.1);
                                                        controllerX
                                                            .maxChildSize =
                                                            Rx<double>(
                                                                0.1);
                                                        controllerX
                                                            .snapSize = Rx<
                                                            List<
                                                                double>>(
                                                            [0.1]);
                                                        controllerX
                                                            .incomingBookingModel =
                                                        null;
                                                        controllerX
                                                            .polylineCoordinates =
                                                        [];

                                                        controllerX
                                                            .update([
                                                          'drag',
                                                          'map'
                                                        ]);
                                                        controllerX
                                                            .upDateRideStatus(
                                                            "COMPLETED",
                                                            bookingId: controllerX
                                                                .subscribeBookingDetailsModel
                                                                ?.subscribeBookingDetails
                                                                ?.bookingId ??
                                                                "")
                                                            .then(
                                                                (value) {
                                                              controllerX
                                                                  .unsubscribe2();
                                                            });
                                                      },
                                                      radius: 10,
                                                      height: 37,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 2,
                                                  ),
                                                  Expanded(
                                                    child:
                                                    CommonButton(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 2,
                                                          right:
                                                          2,
                                                          bottom:
                                                          1),
                                                      buttonText:
                                                      "Delay",
                                                      onTap: () {},
                                                      radius: 10,
                                                      height: 37,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  SizedBox(
                                                    width: Get.width *
                                                        0.3,
                                                    child:
                                                    CommonButton(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 2,
                                                          right:
                                                          2,
                                                          bottom:
                                                          1),
                                                      buttonText:
                                                      "Map",
                                                      onTap: () {
                                                        controllerX
                                                            .goToMapDialog(
                                                            Get
                                                                .context!,
                                                            Get.width *
                                                                0.85);
                                                      },
                                                      radius: 10,
                                                      height: 37,
                                                      isIcon: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                          : SizedBox(
                                        height: Get.height * 0.05,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            DefaultTextStyle(
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .headline3!
                                                  .copyWith(
                                                fontSize: 25.0,
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                              ),
                                              child: AnimatedTextKit(
                                                animatedTexts: [
                                                  FadeAnimatedText(
                                                      'You are online'),
                                                  FadeAnimatedText(
                                                      'Finding trips'),
                                                ],
                                                repeatForever: true,
                                                isRepeatingAnimation:
                                                true,
                                                onTap: () {
                                                  print("Tap Event");
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      (controllerX.incomingBookingModel !=
                                          null)
                                          ? Container()
                                          : const LinearProgressIndicator(
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ));
                            })
                            : Container(),
                      );
                    },
                  )
                ],
              );
            }),
      ),
    );
  }
}

Widget driverINfoWidget(String img, String tittle, String Subtittle) {
  return Column(
    children: [
      Image.asset(
        img,
        height: 30,
        width: 30,
        // color: Color(0xFF4FBE9F),
        color: Theme
            .of(Get.context!)
            .primaryColor,
      ),
      const SizedBox(
        height: 5,
      ),
      CustomeTittleText(
        text: tittle,
        textsize: 15,
        color: Colors.black,
      ),
      const SizedBox(
        height: 5,
      ),
      CustomeSubTittleText(
        text: Subtittle,
        textsize: 13,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
    ],
  );
}
