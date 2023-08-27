import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
