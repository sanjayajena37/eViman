import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:share_plus/share_plus.dart';
import 'package:upgrader/upgrader.dart';


import '../../../constants/text_styles.dart';
import '../../../logic/controllers/theme_provider.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/CustomeTittleText.dart';
import '../../../widgets/MovableContainer.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/remove_focuse.dart';
import '../controllers/driver_dashboard_controller.dart';

class DriverDashboardView extends StatelessWidget {
  DriverDashboardView({Key? key}) : super(key: key);

  DriverDashboardController controllerX =
      Get.put<DriverDashboardController>(DriverDashboardController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
            bool isOk = await controllerX.showCommonPopupNew4(
                "What you want?", "Online or Offline",
                barrierDismissible: false,
                isYesOrNoPopup: true,
                filePath: "assets/json/question.json");
            bool sta = false;
            if (isOk) {
              await controllerX.goOnline1(true).then((value) {
                sta = true;
              });
              Get.back();
              return sta;
            }
            else {
              await controllerX.goOnline1(false).then((value) {
                sta = true;
              });
              Get.back();
              return sta;
            }
        },
        child: AdvancedDrawer(
          backdrop: const SizedBox(
            width: double.infinity,
            height: double.infinity,
          ),
          controller: controllerX.advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animationController: controllerX.animationController,
          animateChildDecoration: true,
          key: GlobalKey(),
          rtlOpening: false,
          // openScale: 1.0,
          disabledGestures: true,
          backdropColor: Colors.white,
          childDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Colors.red,
          ),
          drawer: SafeArea(
            child: ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: DrawerHeader(
                      // decoration: const BoxDecoration(color: Colors.),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GetBuilder<DriverDashboardController>(
                            id: "prof",
                            builder: (controllerX) {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment. center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment. spaceBetween,
                                    children: [
                                      ClipOval(
                                        child: SizedBox.fromSize(
                                          size: const Size
                                              .fromRadius(
                                              40), // Image radius
                                          child: (controllerX
                                              .profileViewModel
                                              ?.riderData
                                              ?.profile_image !=
                                              null &&
                                              controllerX
                                                  .profileViewModel
                                                  ?.riderData
                                                  ?.profile_image
                                                  .toString()
                                                  .trim() !=
                                                  "")
                                              ? CachedNetworkImage(
                                            imageUrl:
                                            controllerX
                                                .profileViewModel
                                                ?.riderData
                                                ?.profile_image ??
                                                "",
                                            imageBuilder:
                                                (context,
                                                imageProvider) =>
                                                Container(
                                                  decoration:
                                                  BoxDecoration(
                                                    image: DecorationImage(
                                                        image:
                                                        imageProvider,
                                                        fit:
                                                        BoxFit.cover,),
                                                    border: Border.all(color: Colors.red,width: 1,style: BorderStyle.solid),
                                                    borderRadius: const BorderRadius.all(Radius.circular(40))),
                                                ),
                                            progressIndicatorBuilder: (context,
                                                url,
                                                downloadProgress) =>
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                      Get.height * 0.04,
                                                      width:
                                                      Get.width * 0.15,
                                                      child:
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.all(18.0),
                                                        child:
                                                        CircularProgressIndicator(value: downloadProgress.progress),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            errorWidget: (context,
                                                url,
                                                error) =>
                                                const Icon(Icons
                                                    .error),
                                          )
                                              : Image.asset(
                                            'assets/images/man.jpg',
                                            fit: BoxFit
                                                .cover,
                                          )
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GetBuilder<DriverDashboardController>(
                                        id: "analytics",
                                        builder: (controllerX) {
                                          return Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              // driverINfoWidget("assets/icon/time.png", "10.2", "Hours online"),
                                              driverINfoWidget(
                                                  "assets/icon/meter.png",
                                                  controllerX.totalDistanceNew ?? "30 kM",
                                                  "Total Distance"),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              driverINfoWidget(
                                                  "assets/icon/jobs.png",
                                                  controllerX.totalRides ?? "0",
                                                  "Total Jobs"),
                                            ],
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${controllerX.profileViewModel?.riderData?.firstName ?? ""} ${controllerX.profileViewModel?.riderData?.lastName ?? ""}",
                                        style: TextStyles(context)
                                            .getBoldStyle()
                                            .copyWith(fontSize: 18),
                                        maxLines: 2,
                                      ),
                                      const SizedBox(
                                        height: 05,
                                      ),
                                      Text(
                                        controllerX.profileViewModel
                                                ?.riderData?.email ??
                                            "",
                                        style: TextStyles(context)
                                            .getBoldStyle()
                                            .copyWith(fontSize: 12),
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),

                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      controllerX.advancedDrawerController.hideDrawer();
                    },
                    leading: Icon(Icons.home,
                        color: Theme.of(context).primaryColor),
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
                        color: Theme.of(context).primaryColor),
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
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      'Vehicle Details',
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.EARNINGPAGE);
                    },
                    leading: Icon(Icons.money,
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      'My Earning',
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(fontSize: 15),
                    ),
                  ),
                 /* ListTile(
                    onTap: () {
                      Get.toNamed(Routes.WALETSCREEN);
                    },
                    leading: Icon(Icons.wallet,
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      'My Wallet',
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(fontSize: 15),
                    ),
                  ),*/
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.HISTORYSCREEN);
                    },
                    leading: Icon(Icons.history,
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      'History',
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(fontSize: 15),
                    ),
                  ),
                   /* ListTile(
                onTap: () {},
                leading: Icon(Icons.notifications_active,
                    color: Theme.of(context).primaryColor),
                title: Text(
                  'Notification',
                  style: TextStyles(context)
                      .getRegularStyle()
                      .copyWith(fontSize: 15),
                ),
              ),*/
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.INVITESCREEN,arguments: (controllerX.profileViewModel?.riderData?.referralCode??"XXXXXXXXXXXXX"));
                },
                leading: Icon(Icons.card_giftcard_outlined,
                    color: Theme.of(context).primaryColor),
                title: Text(
                  'Refer and Earn',
                  style: TextStyles(context)
                      .getRegularStyle()
                      .copyWith(fontSize: 15),
                ),
              ),
                  ListTile(
                    onTap: () {
                      // Get.toNamed(Routes.INVITESCREEN);
                      Share.share('Click this link 👉 https://play.google.com/store/apps/details?id=com.eviman.rider',
                          subject: 'Look what I made!');
                    },
                    leading: Icon(Icons.share,
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      'Share',
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      // Get.toNamed(Routes.INVITESCREEN);
                      controllerX.openPlayStorePage();
                    },
                    leading: Icon(Icons.star_rate,
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      'Rate Us',
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.GALLERYSCREEN);
                      // controllerX.openPlayStorePage();
                    },
                    leading: Icon(Icons.image,
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      'Gallery',
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(fontSize: 15),
                    ),
                  ),
            /*  ListTile(
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
                      Get.toNamed(Routes.HELP_LINE_SCREEN);
                    },
                    leading: Icon(Icons.help_center,
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      'Help',
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      controllerX.gotoSplashScreen();
                    },
                    leading: Icon(Icons.logout,
                        color: Theme.of(context).primaryColor),
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
          child: Scaffold(
            body: UpgradeAlert(
              upgrader: Upgrader(dialogStyle: UpgradeDialogStyle.cupertino,canDismissDialog: false,),
              child: StreamBuilder<ConnectivityResult>(
                stream: controllerX.connectivitySubscription,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    try {
                      Utils.checkInternetConnectivity().then((value) {
                        if (value) {
                          controllerX =
                              Get.put<DriverDashboardController>(
                                  DriverDashboardController());
                          // controllerX.getCurrentLocation();
                          return maiWidgetFun(context);
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      });
                    } catch (e) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final connectivityResult = snapshot.data;
                  String statusText = 'Unknown';
                  if (connectivityResult == ConnectivityResult.mobile ||
                      connectivityResult == ConnectivityResult.wifi ||
                      connectivityResult ==
                          ConnectivityResult.ethernet) {
                    statusText = 'Mobile Data';
                    controllerX = Get.put<DriverDashboardController>(
                        DriverDashboardController());
                    // controllerX.getCurrentLocation();
                    return maiWidgetFun(context);
                  } else if (connectivityResult ==
                      ConnectivityResult.none) {
                    statusText = 'No Connection';
                    return Center(
                      child: Container(
                        foregroundDecoration:
                        !Get.find<ThemeController>().isLightMode
                            ? BoxDecoration(
                            color: Theme.of(context)
                                .backgroundColor
                                .withOpacity(0.4))
                            : null,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: lottie.Lottie.asset(
                          'assets/json/offline.json',
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  } else {
                    Utils.checkInternetConnectivity().then((value) {
                      if (value) {
                        controllerX =
                            Get.put<DriverDashboardController>(
                                DriverDashboardController());
                        // controllerX.getCurrentLocation();
                        return maiWidgetFun(context);
                      } else {
                        return Center(
                          child: Container(
                            foregroundDecoration:
                            !Get.find<ThemeController>().isLightMode
                                ? BoxDecoration(
                                color: Theme.of(context)
                                    .backgroundColor
                                    .withOpacity(0.4))
                                : null,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: lottie.Lottie.asset(
                              'assets/json/offline.json',
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      }
                    });
                  }
                  return maiWidgetFun(context);
                },
              ),
            ),
          ),
        ));
  }

  Widget maiWidgetFun(BuildContext context) {
    try {
      return GetBuilder<DriverDashboardController>(
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
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          controllerX
                                                  .currentLocation?.latitude ??
                                              0,
                                          controllerX
                                                  .currentLocation?.longitude ??
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
                            // polylines:,
                                  /*    polylines:
                            (controllerX
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
                                        : {},
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
                            },*/
                                  markers: {
                                    Marker(
                                        markerId: const MarkerId("Current Location"),
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
                  top: MediaQuery.of(context).padding.top + 25,
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
                          margin: const EdgeInsets.all(2),
                          elevation: 5,
                          child: IconButton(
                            onPressed: controllerX.handleMenuButtonPressed,
                            padding: const EdgeInsets.all(2),
                            visualDensity:
                                const VisualDensity(horizontal: -4, vertical: -4),
                            icon: ValueListenableBuilder<AdvancedDrawerValue>(
                              valueListenable:
                                  controllerX.advancedDrawerController,
                              builder: (_, value, __) {
                                return AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
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
                          onTap: () {
                           controllerX.getRideAnalytics();
                          },
                          child: GetBuilder<DriverDashboardController>(
                            id: "amt",
                            builder: (controllerX) {
                              return Card(
                                  elevation: 5,
                                  color: Theme.of(context).cardColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "₹${double.parse(controllerX.totalAmount??"0").toStringAsFixed(2)}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  fontSize: 25,
                                                  color: Colors.white),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 5.0,left: 0,top: 0,bottom: 0),
                                        child: Icon(Icons.refresh,color: Colors.white,size: 15,),
                                      )
                                    ],
                                  ));
                            },
                          ),
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
                  () => (controllerX.isDisappear.value == false)
                      ? MovableContainer(onTap: () {
                          controllerX.infoDialog();
                        })
                      : Container(),
                ),
                GetBuilder<DriverDashboardController>(
                  id: 'drag',
                  builder: (controllerX) {
                    return Obx(
                      () => (controllerX.isDisappear.value == true)
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
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(25.0),
                                        topLeft: Radius.circular(25.0),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5.0,
                                          spreadRadius: 20.0,
                                          offset: const Offset(0.0, 5.0),
                                          color: Colors.black.withOpacity(0.1),
                                        )
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: ListView(
                                      controller: scrollSheetController,
                                      padding: EdgeInsets.zero,
                                      physics: const ClampingScrollPhysics(),
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 20),
                                                    Row(
                                                      children: [
                                                        const Spacer(),
                                                        Container(
                                                          height: 4,
                                                          width: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
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
                                                                  maxRadius: 20,
                                                                  minRadius: 10,
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                /* CustomeTittleText(
                                                        text: controllerX
                                                            .incomingBookingModel
                                                            ?.incomingBooking
                                                            ?.clientName ??
                                                            "Amrit Jena",
                                                        textsize:
                                                        18,
                                                      ),*/
                                                                Container(
                                                                  width:
                                                                      Get.width *
                                                                          0.6,
                                                                  child: Text(
                                                                      controllerX
                                                                              .incomingBookingModel
                                                                              ?.incomingBooking
                                                                              ?.clientName ??
                                                                          "Jatin Sahoo",
                                                                      maxLines:
                                                                          5,
                                                                      style: TextStyles(
                                                                              context)
                                                                          .getBoldStyle()
                                                                          .copyWith(
                                                                              fontSize: 20)),
                                                                )
                                                              ],
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                controllerX.makingPhoneCall(controllerX
                                                                    .incomingBookingModel
                                                                    ?.incomingBooking
                                                                    ?.clientPhone);
                                                                // await FlutterPhoneDirectCaller.callNumber("919178488130");
                                                              },
                                                              child: lottie
                                                                  .Lottie.asset(
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
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0,
                                                          vertical: 0),
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .location_searching_rounded,
                                                            size: 20,
                                                            color: Colors.black,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          SizedBox(
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
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0,
                                                          vertical: 2),
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 9),
                                                        height: 8,
                                                        width: 2,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0,
                                                          vertical: 2),
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 9),
                                                        height: 8,
                                                        width: 2,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0,
                                                          vertical: 2),
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.location_on,
                                                            size: 20,
                                                            color: Color(
                                                                0xffADD685),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          SizedBox(
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
                                                                  vertical: 2),
                                                              child: Row(
                                                                children: [
                                                                  const SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Text(
                                                                    "PickUp Distance: ",
                                                                    style: TextStyles(
                                                                            context)
                                                                        .getDescriptionStyle()
                                                                        .copyWith(
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 13),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    "${controllerX
                                                                            .pickUpDist ??
                                                                        "0.0"} K.M.",
                                                                    style: TextStyles(
                                                                            context)
                                                                        .getBoldStyle()
                                                                        .copyWith(
                                                                            fontWeight:
                                                                                FontWeight.bold,
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
                                                                  vertical: 2),
                                                              child: Row(
                                                                children: [
                                                                  const SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Text(
                                                                    "Travel Distance: ",
                                                                    style: TextStyles(
                                                                            context)
                                                                        .getDescriptionStyle()
                                                                        .copyWith(
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 13),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    "${controllerX
                                                                            .travelDist ??
                                                                        "0.0"} K.M.",
                                                                    style: TextStyles(
                                                                            context)
                                                                        .getBoldStyle()
                                                                        .copyWith(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 15),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        (controllerX
                                                                .otpVerifiedStatus)
                                                            ? Column(
                                                                children: [
                                                                  lottie.Lottie
                                                                      .asset(
                                                                    "assets/json/otp_ver.json",
                                                                    fit: BoxFit
                                                                        .contain,
                                                                    height: 40,
                                                                    width: 40,
                                                                    filterQuality:
                                                                        FilterQuality
                                                                            .high,
                                                                  ),
                                                                  Text(
                                                                      "OTP verified",
                                                                      style: TextStyles(context).getBoldStyle().copyWith(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize: 15)),
                                                                ],
                                                              )
                                                            : InkWell(
                                                                onTap: () {
                                                                  controllerX.otpDialog(
                                                                      Get
                                                                          .context!,
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
                                                                      height:
                                                                          40,
                                                                      width: 40,
                                                                      filterQuality:
                                                                          FilterQuality
                                                                              .high,
                                                                    ),
                                                                    Container(
                                                                      child: Text(
                                                                          "Enter OTP",
                                                                          style: TextStyles(context).getBoldStyle().copyWith(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 15)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                    /*   InkWell(
                                                onTap: () async {
                                                  String?  data = await SharedPreferencesKeys().getStringData(key: 'latlong');
                                                  log(">>>>>>>>val"+data.toString());
                                                },
                                                child: CommonTextFieldView(
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
                                              ),*/
                                                    const SizedBox(
                                                      height: 25,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          (controllerX
                                                              .otpVerifiedStatus == false)? Expanded(
                                                            child: CommonButton(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 2,
                                                                      right: 2,
                                                                      bottom:
                                                                          1),
                                                              buttonText:
                                                                  "Cancel",
                                                              onTap: () {
                                                                controllerX
                                                                    .cancelRide();
                                                              },
                                                              radius: 10,
                                                              height: 37,
                                                            ),
                                                          ):Container(),
                                                          const SizedBox(
                                                            width: 2,
                                                          ),
                                                          (controllerX
                                                                  .otpVerifiedStatus)
                                                              ? Expanded(
                                                                  child:
                                                                      CommonButton(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left: 2,
                                                                        right:
                                                                            2,
                                                                        bottom:
                                                                            1),
                                                                    buttonText:
                                                                        "Completed",
                                                                    onTap: () {
                                                                      // controllerX.completeRide1("20","200");
                                                                      controllerX
                                                                          .getLatLngList();
                                                                    },
                                                                    radius: 10,
                                                                    height: 37,
                                                                  ),
                                                                )
                                                              : Container(),
                                                          const SizedBox(
                                                            width: 2,
                                                          ),
                                                          Expanded(
                                                            child: CommonButton(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 2,
                                                                      right: 2,
                                                                      bottom:
                                                                          1),
                                                              buttonText: "Map",
                                                              onTap: () {
                                                                controllerX.goToMapDialog(
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
                                                   /* Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: CommonButton(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 2,
                                                                right: 2,
                                                                bottom: 1),
                                                        buttonText:
                                                            "Reached to destination",
                                                        onTap: () async {
                                                             controllerX.startIsolate();
                                                           Future.delayed(Duration(seconds: 500),() {
                                                            log(">>>>>>>>>>>>>>>>>>>>runningIsolates"+ FlutterIsolate.runningIsolates.toString());
                                                            controllerX.isolateField?.kill(priority: Isolate.immediate);
                                                             FlutterIsolate.killAll();
                                                           },);

                                                          // FlutterBackgroundService().invoke("setAsBackground",{"jks":"true"});

                                                                   await Workmanager().initialize(
                                                                callbackDispatcher, // The top level function, aka callbackDispatcher
                                                                isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
                                                            );
                                                            await Workmanager().registerPeriodicTask("task-identifier", "simpleTask",
                                                                frequency: Duration(seconds: 10));
                                                        },
                                                        radius: 10,
                                                        height: 37,
                                                      ),
                                                    ),*/
                                                  ],
                                                ),
                                              )
                                            : SizedBox(
                                                height: Get.height * 0.05,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    DefaultTextStyle(
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3!
                                                          .copyWith(
                                                            fontSize: 25.0,
                                                            fontWeight:
                                                                FontWeight.bold,
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
          });
    } catch (e) {
      return const Center(child: CircularProgressIndicator());
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
          color: Theme.of(Get.context!).primaryColor,
          // color: Colors.blue,
        ),
        const SizedBox(
          height: 5,
        ),
        CustomeTittleText(
          text: tittle,
          textsize: 10,
          color: Colors.black,
        ),
        const SizedBox(
          height: 5,
        ),
        CustomeSubTittleText(
          text: Subtittle,
          textsize: 10,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ],
    );
  }

}


