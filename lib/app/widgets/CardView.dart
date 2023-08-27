import 'package:dateplan/app/widgets/tap_effect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/text_styles.dart';

class CardView extends StatelessWidget {
  IconData? icon;
  Color? color;
  String ?title;
   CardView({super.key,this.color,this.icon,this.title});

  @override
  Widget build(BuildContext context) {
    return TapEffect(

      onClick: () {  },
      child: Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),),shadowColor: Colors.grey,
              child:Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(icon??Icons.add,color: color ??Colors.red),
              ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(title??"Transfer",style:TextStyles(Get.context!).getRegularStyle().copyWith(fontSize: 10) ,)
        ],
      ),
    );
  }
}
