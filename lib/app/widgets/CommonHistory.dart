import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/text_styles.dart';

class CommonHistoryWidget extends StatelessWidget {
  final String ?date;
  final String ?destination;
  final String ?source;
  final String ?amount;
  final String ?driverName;
  final String ?status;
  final String ?assetUrl;
  final bool ?imgVisibility;

   const CommonHistoryWidget({super.key,this.date,this.destination,this.source,this.amount,this.driverName,this.status = "",this.assetUrl,this.imgVisibility = true});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
         Positioned(top: 10,
            right: 6,
            left: 266, child: Text((status??""),style: TextStyles(context).getBoldStyle().
             copyWith(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.black),)),
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
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date??"Today, 10:30 AM",style: TextStyles(context).getBoldStyle()),
                const SizedBox(
                  height: 8,
                ),
                (imgVisibility == true)?Container(
                  width: double.infinity,
                  height: Get.height * 0.2,
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
                        'assets/images/mapHistory.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ):Container(),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      itemBuilder:
                                          (BuildContext context, int index) {
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
                                                  BorderRadius.circular(
                                                      2 / 2),
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
                                      borderRadius:
                                      BorderRadius.circular(8 / 2),
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
                                child:  SizedBox(
                                    width: Get.width*0.5,
                                    child: Text(source??"",style: TextStyles(context).getBoldStyle(),maxLines: 2)),
                              ),
                              SizedBox(
                                height: 21,
                              ),
                              Opacity(
                                opacity: 0.6,
                                child:  SizedBox(
                                    width: Get.width*0.5,
                                    child: Text(destination??"",style: TextStyles(context).getBoldStyle(),maxLines: 2)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: Get.width*0.2,
                        height:Get.height*0.03 ,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text("₹ ${amount??0}",style:
                          TextStyles(context).getBoldStyle().copyWith(color: Colors.blue,fontSize: 15),),
                        ))
                  ],
                ),
              /*  Text(source??"",style: TextStyles(context).getBoldStyle()),
                Text("To",style:  TextStyles(context).getDescriptionStyle()),
                Text(destination??"",style: TextStyles(context).getBoldStyle(),),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Operated by: ",style:  TextStyles(context).getDescriptionStyle()),
                        Text((driverName??""),style:  TextStyles(context).getBoldStyle()),
                      ],
                    ),
                    // Text("\$${amount??0}",style:  TextStyles(context).getBoldStyle().copyWith(color: Colors.blue,fontSize: 18),)
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
