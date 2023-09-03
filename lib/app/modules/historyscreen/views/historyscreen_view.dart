import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/CommonHistory.dart';
import '../../../widgets/common_appbar_view.dart';
import '../../../widgets/remove_focuse.dart';
import '../controllers/historyscreen_controller.dart';

class HistoryscreenView extends GetView<HistoryscreenController> {
  const HistoryscreenView({Key? key}) : super(key: key);
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
              child: ListView.builder(
                  itemCount: 30,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(left: 12.0,right: 12,bottom: 5,top: 2),
                      child: CommonHistoryWidget(amount: "123",date: "Today, 10:30 AM",
                          destination: "Nyapalli,BeheraSahi BBSR",source: "Korua, L.N. College",driverName: "JKS"),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
