import 'package:dateplan/app/providers/Utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/CommonHistory.dart';
import '../../../widgets/common_appbar_view.dart';
import '../../../widgets/remove_focuse.dart';
import '../controllers/historyscreen_controller.dart';

class HistoryscreenView extends GetView<HistoryscreenController> {
  HistoryscreenView({Key? key}) : super(key: key);

  @override
  HistoryscreenController controller =
  Get.put<HistoryscreenController>(HistoryscreenController());

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
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: "History",
            ),
            Expanded(
              child: GetBuilder<HistoryscreenController>(
                assignId: true,
                id: "his",
                builder: (logic) {
                  return ListView.builder(
                      itemCount: (controller.rideHistory).length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 12.0,
                              right: 12,
                              bottom: 5,
                              top: 2),
                          child: CommonHistoryWidget(amount: (controller
                              .rideHistoryModel?.rides?[index].amountPaid ??
                              "").toString(),
                              status:controller
                                  .rideHistoryModel?.rides?[index].rideStatus??"" ,
                              date:Utils.convertDateFormat(controller
                                  .rideHistoryModel?.rides?[index].rideEndTime)?? "Today, 10:30 AM",
                              destination:controller
                                  .rideHistoryModel?.rides?[index].dropAddress ?? "Nyapalli,BeheraSahi BBSR",
                              source:controller
                                  .rideHistoryModel?.rides?[index].pickupAddress ?? "Korua, L.N. College",
                              driverName: "eVIMAN"),
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
