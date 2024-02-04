import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants/text_styles.dart';
import '../../../widgets/common_appbar_view.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/remove_focuse.dart';
import '../controllers/up_coming_ride_details_page_controller.dart';

class UpComingRideDetailsPageView
    extends GetView<UpComingRideDetailsPageController> {
  UpComingRideDetailsPageView({Key? key}) : super(key: key);

  UpComingRideDetailsPageController controllerX =
  Get.put<UpComingRideDetailsPageController>(
      UpComingRideDetailsPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.arrow_back,
              titleText: "Ride Details",
              onBackClick: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: GetBuilder<UpComingRideDetailsPageController>(
                assignId: true,
                id: "all",
                builder: (controllerX) {
                  return Container(
                    child: (controllerX.ridesData != null) ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: Get.height * 0.3,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(15)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  15),
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(
                                    48), // Image radius
                                child: Image.asset(
                                  'assets/images/mapImg.jpg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Card(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            color: Colors.grey.withOpacity(0.2),
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("${controllerX.ridesData?.fromDate ?? ""} to ${controllerX.ridesData?.toDate??"" ??
                                          "...."}",
                                          style: TextStyles(context).getBoldStyle()),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                              height: 55,
                                              width: 10,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: <Widget>[
                                                  Container(
                                                    height: 8,
                                                    width: 8,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(
                                                          8 / 2),
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  MediaQuery.removePadding(
                                                    context: context,
                                                    removeTop: true,
                                                    removeRight: true,
                                                    removeLeft: true,
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: 11,
                                                        itemBuilder:
                                                            (BuildContext context,
                                                            int index) {
                                                          return Column(
                                                            children: <Widget>[
                                                              SizedBox(
                                                                height: 1,
                                                              ),
                                                              Container(
                                                                height: 2,
                                                                width: 2,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        2 / 2),
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          );
                                                        }),
                                                  ),
                                                  SizedBox(
                                                    height: 1,
                                                  ),
                                                  Container(
                                                    height: 8,
                                                    width: 8,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(8 / 2),
                                                        color: Colors.red),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Opacity(
                                                  opacity: 0.6,
                                                  child: SizedBox(
                                                      width: Get.width * 0.5,
                                                      child: Text(controllerX.ridesData?.pickupAddress??"",
                                                          style: TextStyles(context)
                                                              .getBoldStyle(),
                                                          maxLines: 2)),
                                                ),
                                                SizedBox(
                                                  height: 21,
                                                ),
                                                Opacity(
                                                  opacity: 0.6,
                                                  child: SizedBox(
                                                      width: Get.width * 0.5,
                                                      child: Text(controllerX.ridesData?.dropAddress ?? "",
                                                          style: TextStyles(context)
                                                              .getBoldStyle(),
                                                          maxLines: 2)),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),

                          Card(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            elevation: 7,
                            color: Colors.grey.withOpacity(0.2),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          SizedBox(
                                              width: Get.width * 0.25,
                                              child: Text("Total Amount: ",
                                                  style: TextStyles(context)
                                                      .getDescriptionStyle())),
                                          SizedBox(
                                              width: Get.width * 0.2,
                                              height: Get.height * 0.02,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text("₹ ${controllerX.ridesData?.totalAmount ?? 0}", style:
                                                TextStyles(context)
                                                    .getBoldStyle()
                                                    .copyWith(
                                                    color: Colors.blue, fontSize: 10),),
                                              ))
                                        ],
                                      ),
                                      // Text("\$${amount??0}",style:  TextStyles(context).getBoldStyle().copyWith(color: Colors.blue,fontSize: 18),)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          SizedBox(
                                              width: Get.width * 0.25,
                                              child: Text("Amount Paid: ",
                                                  style: TextStyles(context)
                                                      .getDescriptionStyle())),
                                          SizedBox(
                                              width: Get.width * 0.2,
                                              height: Get.height * 0.02,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text("₹ ${controllerX.ridesData?.amountPaid ?? 0}", style:
                                                TextStyles(context)
                                                    .getBoldStyle()
                                                    .copyWith(
                                                    color: Colors.blue, fontSize: 10),),
                                              ))
                                        ],
                                      ),
                                      // Text("\$${amount??0}",style:  TextStyles(context).getBoldStyle().copyWith(color: Colors.blue,fontSize: 18),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),


                          Expanded(child: Container()),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.28,
                                height: 35,
                                child: CommonButton(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 0, bottom: 0, top: 0),

                                  buttonText: "Cancel",
                                  onTap: () {
                                    controllerX.upDateRideStatusComplete
                                      ("CANCEL BY RIDER",controllerX.ridesData?.totalAmount??"",
                                        bookingId: controllerX.ridesData?.bookingId??"");
                                  },
                                  radius: 6,
                                  height: 28,
                                  // backgroundColor: Colors.green,
                                  // isIcon: true,
                                  // icon: Icons.refresh,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.28,
                                height: 35,
                                child: CommonButton(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 0, bottom: 0, top: 0),

                                  buttonText: "Call",
                                  isIcon: true,
                                  icon: Icons.call,
                                  onTap: () {},
                                  radius: 6,
                                  height: 25,
                                  // backgroundColor: Colors.green,
                                  // isIcon: true,
                                  // icon: Icons.refresh,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.28,
                                height: 35,
                                child: CommonButton(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 0, bottom: 0, top: 0),

                                  buttonText: "Complete",
                                  onTap: () {
                                    controllerX.upDateRideStatusComplete
                                      ("COMPLETED",controllerX.ridesData?.totalAmount??"",
                                        bookingId: controllerX.ridesData?.bookingId??"");
                                  },
                                  radius: 6,
                                  height: 25,
                                  // backgroundColor: Colors.green,
                                  // isIcon: true,
                                  // icon: Icons.refresh,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),


                        ],
                      ),
                    ) : Container(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
