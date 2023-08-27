import 'package:dateplan/app/constants/themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../constants/text_styles.dart';
import '../../../logic/controllers/theme_provider.dart';
import '../../../widgets/CardView.dart';
import '../../../widgets/common_appbar_view.dart';
import '../../../widgets/remove_focuse.dart';
import '../../../widgets/tap_effect.dart';
import '../controllers/waletscreen_controller.dart';

class WaletscreenView extends GetView<WaletscreenController> {
  const WaletscreenView({Key? key}) : super(key: key);
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
              titleText: "Wallet",
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                TapEffect(
                  onClick: () {  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 335,
                          height: 83,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Color(0xff877ef2)),
                      child:Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          Text("Quick Ride Wallet",style: TextStyles(Get.context!).getRegularStyle().copyWith(color: Colors.white)),
                          Text("43.64 Points",style: TextStyles(Get.context!).getBoldStyle().copyWith(color: Colors.white,fontSize: 20) ,)
                        ]),
                      ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CardView(color: AppTheme.primaryColor,icon:Iconsax.convert,title: "Transfer"),
                      CardView(color: AppTheme.primaryColor,icon:Iconsax.export,title: "Payment"),
                      CardView(color: AppTheme.primaryColor,icon:Iconsax.money,title: "Payout"),
                      CardView(color: AppTheme.primaryColor,icon:Iconsax.add,title: "Top Up"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:12.0,right: 12,bottom: 0),
                  child: Row(
                    children: [
                      Text("Last Transaction",style:TextStyles(Get.context!).getTitleStyle() ,)
                    ],

                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(2),
                      itemBuilder:(context,index){
                    return TapEffect(
                      onClick: () {  },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.grey,
                          child: ListTile(
                            leading: CircleAvatar(child: Image.asset("assets/images/avatar1.jpg")),
                            title: Text("JKS",style:TextStyles(Get.context!).getTitleStyle().copyWith(fontSize: 15) ),
                            subtitle: Text("Jatin Kumar Sahoo",style:TextStyles(Get.context!).getRegularStyle().copyWith(fontSize: 10) ),
                            trailing: Text("120",style:TextStyles(Get.context!).getBoldStyle().copyWith() ),
                          ),
                        ),
                      ),
                    );
                  }),
                )


              ],
            ))
          ],
        ),
      ),
    );
  }
}
