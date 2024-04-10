import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:upgrader/upgrader.dart';

import '../../../../MainClass.dart';
import '../../../constants/text_styles.dart';
import '../../../logic/controllers/theme_provider.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/CommonHistory.dart';
import '../../../widgets/CustomeTittleText.dart';
import '../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../widgets/MovableContainer.dart';
import '../../../widgets/UpComingRidesWidget.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/remove_focuse.dart';
// import '../../driverDashboard/views/driver_dashboard_view.dart';
import '../controllers/logesticdashboard_controller.dart';
import 'package:lottie/lottie.dart' as lottie;

class LogesticdashboardView extends StatelessWidget {
  LogesticdashboardView({Key? key}) : super(key: key);

  // @override
  LogesticdashboardController controllerX =
      Get.put<LogesticdashboardController>(LogesticdashboardController());

  @override
  Widget build(BuildContext context) {
    controllerX.getPendingRides();
    return AdvancedDrawer(
      backdrop: Container(
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
        child: Container(
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
                        GetBuilder<LogesticdashboardController>(
                          id: "prof",
                          builder: (controllerX) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipOval(
                                      child: SizedBox.fromSize(
                                          size: const Size.fromRadius(
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
                                                  imageUrl: controllerX
                                                          .profileViewModel
                                                          ?.riderData
                                                          ?.profile_image ??
                                                      "",
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        border: Border.all(
                                                            color: Colors.red,
                                                            width: 1,
                                                            style: BorderStyle
                                                                .solid),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    40))),
                                                  ),
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.04,
                                                        width: Get.width * 0.15,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(18.0),
                                                          child: CircularProgressIndicator(
                                                              value:
                                                                  downloadProgress
                                                                      .progress),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                )
                                              : Image.asset(
                                                  'assets/images/man.jpg',
                                                  fit: BoxFit.cover,
                                                )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GetBuilder<LogesticdashboardController>(
                                      id: "analytics",
                                      builder: (controllerX) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            // driverINfoWidget("assets/icon/time.png", "10.2", "Hours online"),
                                            driverINfoWidget(
                                                "assets/icon/meter.png",
                                                controllerX.totalDistanceNew ??
                                                    "30 kM",
                                                "Total Distance"),
                                            SizedBox(
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
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // width: Get.width * 0.5,
                                      child: Text(
                                        "${controllerX.profileViewModel?.riderData?.firstName ?? ""} ${controllerX.profileViewModel?.riderData?.lastName ?? ""}",
                                        style: TextStyles(context)
                                            .getBoldStyle()
                                            .copyWith(fontSize: 18),
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 05,
                                    ),
                                    Container(
                                      // width: Get.width * 0.5,
                                      child: Text(
                                        controllerX.profileViewModel?.riderData
                                                ?.email ??
                                            "",
                                        style: TextStyles(context)
                                            .getBoldStyle()
                                            .copyWith(fontSize: 12),
                                        maxLines: 2,
                                      ),
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
                  leading:
                      Icon(Icons.home, color: Theme.of(context).primaryColor),
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
                  leading:
                      Icon(Icons.money, color: Theme.of(context).primaryColor),
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
                    Get.toNamed(Routes.INVITESCREEN,
                        arguments: (controllerX
                                .profileViewModel?.riderData?.referralCode ??
                            "XXXXXXXXXXXXX"));
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
                    Share.share(
                        'Click this link 👉 https://play.google.com/store/apps/details?id=com.eviman.rider',
                        subject: 'Look what I made!');
                  },
                  leading:
                      Icon(Icons.share, color: Theme.of(context).primaryColor),
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
                  leading:
                      Icon(Icons.image, color: Theme.of(context).primaryColor),
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
                  leading:
                      Icon(Icons.logout, color: Theme.of(context).primaryColor),
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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              controller: controllerX.tabController,
              // isScrollable: true,
              onTap: (index) {
                if (index == 0) {
                  controllerX.getPendingRides();
                } else if (index == 1) {
                  controllerX.getUpcomingRides();
                }
              },
              tabs: [
                Tab(text: "Pending Rides"),
                Tab(
                  text: "Upcoming Rides",
                ),
                // Tab(icon: Icon(Icons.directions_car)),
              ],
              dividerColor: Colors.red,
              indicatorColor: Colors.red,
              labelStyle:
                  TextStyles(context).getBoldStyle().copyWith(fontSize: 17),
            ),
            backgroundColor: Color(0xFFFFFFFF),
            title: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0), //<-- SEE HERE
                    ),
                    margin: EdgeInsets.all(2),
                    elevation: 5,
                    child: IconButton(
                      onPressed: controllerX.handleMenuButtonPressed,
                      padding: EdgeInsets.all(2),
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      icon: ValueListenableBuilder<AdvancedDrawerValue>(
                        valueListenable: controllerX.advancedDrawerController,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: Duration(milliseconds: 250),
                            child: Icon(
                              value.visible ? Icons.clear : Icons.menu,
                              color: Colors.black,
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
                    child: GetBuilder<LogesticdashboardController>(
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
                                    "₹${double.parse(controllerX.totalAmount ?? "0").toStringAsFixed(2)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                            fontSize: 25, color: Colors.white),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      right: 5.0, left: 0, top: 0, bottom: 0),
                                  child: Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                )
                              ],
                            ));
                      },
                    ),
                  ),
                  /*CupertinoSwitch(
                    value: true,
                    dragStartBehavior: DragStartBehavior.start,
                    onChanged: (value) {
                      // controllerX.goOnline(value);
                    },
                  ),*/
                  Container(
                    width: Get.width*0.14,
                    // child: Text("jks",style: TextStyle(color: Colors.black),),
                  )
                ],
              ),
            ),
          ),
          body: UpgradeAlert(
              upgrader: Upgrader(dialogStyle: UpgradeDialogStyle.cupertino,canDismissDialog: false,),
              child: maiWidgetFun(context)),
        ),
      ),
    );
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Widget maiWidgetFun(BuildContext context) {
    try {
      return TabBarView(
        controller: controllerX.tabController,
        children: [
          GetBuilder<LogesticdashboardController>(
            // assignId: true,
            id: "lst",
            builder: (controllerX) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: (controllerX.pendingRidesDataModel != null &&
                        controllerX.pendingRidesDataModel?.rides != null &&
                        (controllerX.pendingRidesDataModel?.rides?.length ??
                                0) >
                            0)
                    ? RefreshIndicator(
                        onRefresh: () {
                          return Future.delayed(
                            const Duration(seconds: 1),
                            () {
                              controllerX.getPendingRides();
                            },
                          );
                        },
                        child: ListView.builder(
                            itemCount: controllerX
                                    .pendingRidesDataModel?.rides?.length ??
                                0,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 8.0, right: 8, bottom: 5, top: 2),
                                child: GetBuilder<LogesticdashboardController>(
                                  // assignId: true,
                                  id: "lstData",
                                  builder: (controllerX) {
                                    return Container(
                                      child: InkWell(
                                        onTap: () {},
                                        child: UpComingRidesWidget(
                                            totalAmount: (controllerX
                                                        .pendingRidesDataModel
                                                        ?.rides?[index]
                                                        .totalAmount ??
                                                    "0.00")
                                                .toString(),
                                            paidAmount:
                                                (controllerX.pendingRidesDataModel?.rides?[index].amountPaid ?? "0")
                                                    .toString(),
                                            status: "Waiting...",
                                            fromDate: controllerX
                                                    .pendingRidesDataModel
                                                    ?.rides?[index]
                                                    .fromDate ??
                                                "",
                                            toDate: controllerX
                                                    .pendingRidesDataModel
                                                    ?.rides?[index]
                                                    .toDate ??
                                                "",
                                            onTapCancel: () {
//ACCEPT
                                              controllerX
                                                  .upDateRideStatusComplete(
                                                      "REJECT",
                                                      bookingId: (controllerX
                                                                  .pendingRidesDataModel
                                                                  ?.rides?[
                                                                      index]
                                                                  .id ??
                                                              "")
                                                          .toString(),
                                                      riderId: controllerX
                                                          .riderIdNew)
                                                  .then((value) {
                                                if (value) {
                                                  controllerX
                                                      .pendingRidesDataModel
                                                      ?.rides?[index]
                                                      .acceptClick = false;
                                                  controllerX
                                                      .pendingRidesDataModel
                                                      ?.rides?[index]
                                                      .rejectClick = true;
                                                  controllerX
                                                      .update(['lstData']);
                                                  controllerX.getPendingRides();
                                                } else {
                                                  Get.snackbar("",
                                                      "Something went wrong\nPlease try after sometime");
                                                }
                                              });
                                            },
                                            acceptClick: controllerX
                                                    .pendingRidesDataModel
                                                    ?.rides?[index]
                                                    .acceptClick ??
                                                false,
                                            rejectClick: controllerX.pendingRidesDataModel?.rides?[index].rejectClick ?? false,
                                            imgVisibility: false,
                                            onTapAccept: () {
                                              print(
                                                  ">>>>>>>>>>>>>Index${index}");
                                              controllerX
                                                  .upDateRideStatusComplete(
                                                      "ACCEPT",
                                                      bookingId: (controllerX
                                                                  .pendingRidesDataModel
                                                                  ?.rides?[
                                                                      index]
                                                                  .id ??
                                                              "")
                                                          .toString(),
                                                      riderId: controllerX
                                                          .riderIdNew)
                                                  .then((value) {
                                                if (value) {
                                                  controllerX
                                                      .pendingRidesDataModel
                                                      ?.rides?[index]
                                                      .acceptClick = true;
                                                  controllerX
                                                      .pendingRidesDataModel
                                                      ?.rides?[index]
                                                      .rejectClick = false;
                                                  controllerX.getPendingRides();
                                                  controllerX
                                                      .update(['lstData']);
                                                } else {
                                                  Get.snackbar("",
                                                      "Something went wrong\nPlease try after sometime");
                                                }
                                              });
                                            },
                                            destination: controllerX.pendingRidesDataModel?.rides?[index].dropAddress ?? "",
                                            source: controllerX.pendingRidesDataModel?.rides?[index].pickupAddress ?? "Korua, L.N. College",
                                            driverName: "eVIMAN"),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                      )
                    : Center(
                        child: RefreshIndicator(
                            onRefresh: () {
                              return Future.delayed(
                                const Duration(seconds: 1),
                                () {
                                  controllerX.getPendingRides();
                                },
                              );
                            },
                            child: ListView.builder(
                              itemCount: 1,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context,index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: Get.height*0.4,
                                    ),
                                    Text("No Pending Rides Found"),
                                  ],
                                );
                              }
                            )),
                      ),
              );
            },
          ),
          GetBuilder<LogesticdashboardController>(
              id: "lst2",
              builder: (controllerX) {
                return Container(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: (controllerX.upcomingRidesDataModel != null &&
                              controllerX.upcomingRidesDataModel?.rides != null &&
                              (controllerX.upcomingRidesDataModel?.rides
                                          ?.length ??
                                      0) >
                                  0)
                          ? RefreshIndicator(
                        onRefresh: () {
                          return Future.delayed(
                            const Duration(seconds: 1),
                                () {
                              controllerX.getUpcomingRides();
                            },
                          );
                        },
                            child: ListView.builder(
                                itemCount: controllerX
                                        .upcomingRidesDataModel?.rides?.length ??
                                    0,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 5, top: 2),
                                    child: Container(
                                      child: InkWell(
                                        onTap: () async {
                                         bool sta = await Get.toNamed(
                                              Routes.UP_COMING_RIDE_DETAILS_PAGE,
                                              arguments: controllerX
                                                  .upcomingRidesDataModel
                                                  ?.rides?[index]
                                                  .toJson());
                                         if(sta){
                                           controllerX.getUpcomingRides();
                                         }
                                        },
                                        child: UpComingRidesWidget(
                                            totalAmount: (controllerX
                                                        .upcomingRidesDataModel
                                                        ?.rides?[index]
                                                        .totalAmount ??
                                                    "0.00")
                                                .toString(),
                                            paidAmount:
                                                (controllerX.upcomingRidesDataModel?.rides?[index].amountPaid ?? "0")
                                                    .toString(),
                                            status: "Waiting...",
                                            fromDate: controllerX
                                                    .upcomingRidesDataModel
                                                    ?.rides?[index]
                                                    .fromDate ??
                                                "",
                                            toDate: controllerX
                                                    .upcomingRidesDataModel
                                                    ?.rides?[index]
                                                    .toDate ??
                                                "",
                                            onTapCancel: () {},
                                            acceptClick: controllerX
                                                    .upcomingRidesDataModel
                                                    ?.rides?[index]
                                                    .acceptClick ??
                                                false,
                                            rejectClick: controllerX.upcomingRidesDataModel?.rides?[index].rejectClick ?? false,
                                            imgVisibility: false,
                                            btnVisibility: false,
                                            onTapAccept: () {
                                              print(">>>>>>>>>>>>>Index${index}");
                                            },
                                            destination: controllerX.upcomingRidesDataModel?.rides?[index].dropAddress ?? "",
                                            source: controllerX.upcomingRidesDataModel?.rides?[index].pickupAddress ?? "Korua, L.N. College",
                                            driverName: "eVIMAN"),
                                      ),
                                    ),
                                  );
                                }),
                          )
                          :  Center(
                        child: RefreshIndicator(
                            onRefresh: () {
                              return Future.delayed(
                                const Duration(seconds: 1),
                                    () {
                                  controllerX.getUpcomingRides();
                                },
                              );
                            },
                            child: ListView.builder(
                                itemCount: 1,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context,index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: Get.height*0.4,
                                      ),
                                      Text("No Upcoming Rides Found"),
                                    ],
                                  );
                                }
                            )),
                      ),
                    ));
              })
        ],
      );
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
