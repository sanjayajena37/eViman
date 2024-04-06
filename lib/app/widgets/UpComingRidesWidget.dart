import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../constants/text_styles.dart';
import 'common_button.dart';

class UpComingRidesWidget extends StatelessWidget {
  final String? fromDate;
  final String? toDate;
  final String? destination;
  final String? source;
  final String? totalAmount;
  final String? paidAmount;
  final String? driverName;
  final String? status;
  final String? assetUrl;
  final bool? imgVisibility;
  final bool? btnVisibility;
  final bool? acceptClick;
  final bool? rejectClick;
  final Function? onTapAccept;
  final Function? onTapCancel;

  const UpComingRidesWidget(
      {
      this.fromDate,
      this.toDate,
      this.destination,
      this.source,
      this.totalAmount,
      this.paidAmount,
      this.driverName,
      this.status = "",
      this.assetUrl,
      this.imgVisibility = true,
      this.onTapAccept,
      this.onTapCancel,
      this.acceptClick = false,
      this.rejectClick = false,this.btnVisibility = true});

  @override
  Widget build(BuildContext context) {
    // Rx<bool> isClick = Rx<bool>(false);
    return Stack(
      children: [
        Positioned(
            top: 10,
            right: 6,
            left: 266,
            child: Text(
              (status ?? ""),
              style: TextStyles(context)
                  .getBoldStyle()
                  .copyWith(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
            )),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 7,
                spreadRadius: 2, //New
              )
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child:(btnVisibility == true)? Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 4, top: 1),
                    child: (acceptClick == false && rejectClick == false)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: CommonButton(
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),

                                  buttonText: "Reject",

                                  onTap: () {
                                    if (onTapCancel != null) {
                                      onTapCancel!();
                                    }
                                    // isClick.value = true;
                                    // isClick.refresh();
                                  },
                                  radius: 6,
                                  height: 25,
                                  backgroundColor: Colors.red,
                                  // isIcon: true,
                                  // icon: Icons.refresh,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: CommonButton(
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),

                                  buttonText: "Accept",

                                  onTap: () {
                                    if (onTapAccept != null) {
                                      onTapAccept!();
                                    }
                                    // isClick.value = true;
                                    // isClick.refresh();
                                  },
                                  radius: 6,
                                  height: 25,
                                  backgroundColor: Colors.green,
                                  // isIcon: true,
                                  // icon: Icons.refresh,
                                ),
                              ),
                            ],
                          )
                        : (rejectClick == false)
                            ? Lottie.asset("assets/json/done.json", fit: BoxFit.contain, height: 60)
                            : Lottie.asset("assets/json/reject.json", fit: BoxFit.contain, height: 60),
                  ):Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: const Icon(Icons.info),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("${fromDate ?? ""} to ${toDate ?? "...."}",
                            style: TextStyles(context).getBoldStyle()),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    (imgVisibility == true)
                        ? Container(
                            width: double.infinity,
                            height: Get.height * 0.2,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(48), // Image radius
                                child: Image.asset(
                                  'assets/images/mapHistory.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 5,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 8,
                                      width: 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8 / 2),
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
                                          itemBuilder: (BuildContext context, int index) {
                                            return Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Container(
                                                  height: 2,
                                                  width: 2,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(2 / 2),
                                                      color: Colors.black),
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
                                          borderRadius: BorderRadius.circular(8 / 2),
                                          color: Colors.red),
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Opacity(
                                    opacity: 0.6,
                                    child: SizedBox(
                                        width: Get.width * 0.5,
                                        child: Text(source ?? "",
                                            style: TextStyles(context).getBoldStyle(),
                                            maxLines: 2)),
                                  ),
                                  SizedBox(
                                    height: 21,
                                  ),
                                  Opacity(
                                    opacity: 0.6,
                                    child: SizedBox(
                                        width: Get.width * 0.5,
                                        child: Text(destination ?? "",
                                            style: TextStyles(context).getBoldStyle(),
                                            maxLines: 2)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        (acceptClick == true)
                            ? Container()
                            : (rejectClick == true)
                                ? Container()
                                : Container(
                                    child: Lottie.asset("assets/json/active.json",
                                            fit: BoxFit.contain, height: 60),
                                  ),
                      ],
                    ),
                    /*  Text(source??"",style: TextStyles(context).getBoldStyle()),
                    Text("To",style:  TextStyles(context).getDescriptionStyle()),
                    Text(destination??"",style: TextStyles(context).getBoldStyle(),),*/
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: Get.width * 0.25,
                                child: Text("Total Amount: ",
                                    style: TextStyles(context).getDescriptionStyle())),
                            SizedBox(
                                width: Get.width * 0.2,
                                height: Get.height * 0.02,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "₹ ${totalAmount ?? 0}",
                                    style: TextStyles(context)
                                        .getBoldStyle()
                                        .copyWith(color: Colors.blue, fontSize: 10),
                                  ),
                                ))
                          ],
                        ),
                        // Text("\$${amount??0}",style:  TextStyles(context).getBoldStyle().copyWith(color: Colors.blue,fontSize: 18),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: Get.width * 0.25,
                                child: Text("Amount Paid: ",
                                    style: TextStyles(context).getDescriptionStyle())),
                            SizedBox(
                                width: Get.width * 0.2,
                                height: Get.height * 0.02,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "₹ ${paidAmount ?? 0}",
                                    style: TextStyles(context)
                                        .getBoldStyle()
                                        .copyWith(color: Colors.blue, fontSize: 10),
                                  ),
                                ))
                          ],
                        ),
                        // Text("\$${amount??0}",style:  TextStyles(context).getBoldStyle().copyWith(color: Colors.blue,fontSize: 18),)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
