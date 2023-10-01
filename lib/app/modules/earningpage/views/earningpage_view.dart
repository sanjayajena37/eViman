import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/text_styles.dart';
import '../../../logic/controllers/theme_provider.dart';
import '../../../widgets/common_appbar_view.dart';
import '../../../widgets/remove_focuse.dart';
import '../controllers/earningpage_controller.dart';

class EarningpageView extends GetView<EarningpageController> {
  EarningpageView({Key? key}) : super(key: key);

  @override
  EarningpageController controller =
      Get.put<EarningpageController>(EarningpageController());

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
              titleText: "My Earning",
            ),
            Expanded(
              child: GetBuilder<EarningpageController>(
                assignId: true,
                id: "earn",
                builder: (logic) {
                  return (controller.earningModel != null && (controller.earningModel?.rideArray?.length??0) > 0) ?
                  ListView.builder(
                      itemCount: controller.earningModel?.rideArray?.length??0,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 12.0, right: 12, bottom: 5, top: 2),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 7,
                                  spreadRadius: 2, //New
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0,left: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Row(
                                  children: [
                                    Container(
                                      foregroundDecoration: !Get.find<ThemeController>().isLightMode
                                          ? BoxDecoration(
                                          color: Theme.of(context).backgroundColor.withOpacity(0.4))
                                          : null,
                                      width: MediaQuery.of(context).size.width*0.15,
                                      height: MediaQuery.of(context).size.height*0.12,
                                      child:  Lottie.asset('assets/json/earning.json',fit: BoxFit.contain,),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Amount",style: TextStyles(context).getBoldStyle().copyWith(fontSize: 15)),
                                        Text("₹ ${controller.earningModel?.rideArray?[index].totalAmount??""}",style:  TextStyles(context).getDescriptionStyle().
                                        copyWith(color: Colors.blue))
                                      ],
                                    ),
                                  ],
                                ),

                                Container(
                                  child: Text("${controller.earningModel?.rideArray?[index].distance??""} K.M.",style:  TextStyles(context).getDescriptionStyle().
                                  copyWith(color: Colors.blue,fontSize: 18)),
                                )
                              ],),
                            ),
                          ),

                        );
                      }):Center(child: Text("No Data found"));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
