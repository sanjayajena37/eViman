import 'package:dateplan/app/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../models/room_data.dart';
import '../widgets/custom_dialog.dart';

mixin Helper {
  static String getRoomText(RoomData roomData) {
    return "${roomData.numberRoom}  ${roomData.people} ";
  }

  static String getDateText(DateText dateText) {
    String languageCode = "Get.find<Loc>().locale.languageCode";
    return "0${dateText.startDate} ${DateFormat('MMM', languageCode).format(DateTime.now())} - 0${dateText.endDate} ${DateFormat('MMM', languageCode).format(DateTime.now().add(const Duration(days: 2)))}";
  }

  static String getLastSearchDate(DateText dateText) {
    String languageCode = "Get.find<Loc>().locale.languageCode";
    return "${dateText.startDate} - ${dateText.endDate} ${DateFormat('MMM', languageCode).format(DateTime.now().add(const Duration(days: 2)))}";
  }

  static String getPeopleandChildren(RoomData roomData) {
    return " ${roomData.numberRoom}  + ${roomData.numberRoom}  ";
  }

  static Widget ratingStar({double rating = 4.5}) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: AppTheme.primaryColor,
      ),
      itemCount: 5,
      unratedColor: AppTheme.secondaryTextColor,
      itemSize: 18.0,
      direction: Axis.horizontal,
    );
  }

  Future<bool> showCommonPopupNew(
      String title, String descriptionText, BuildContext context,
      {bool isYesOrNoPopup = false, bool barrierDismissible = true}) async {
    bool isOkClick = false;
    return await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => CustomDialog(
        title: title,
        description: descriptionText,
        onCloseClick: () {
          Navigator.of(context).pop();
        },
        actionButtonList: isYesOrNoPopup
            ? <Widget>[
                CustomDialogActionButton(
                  buttonText: "NO",
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CustomDialogActionButton(
                  buttonText: "YES",
                  color: Colors.red,
                  onPressed: () {
                    isOkClick = true;
                    Navigator.of(context).pop();
                  },
                )
              ]
            : <Widget>[
                CustomDialogActionButton(
                  buttonText: "OK",
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
      ),
    ).then((_) {
      return isOkClick;
    });
  }

  Future<bool> showCommonPopupNew2(
      String title, String descriptionText,
      {bool isYesOrNoPopup = false, bool barrierDismissible = true}) async {
    bool isOkClick = false;
    return await Get.dialog(
      barrierDismissible: barrierDismissible,
      CustomDialog(
        title: title,
        topWidget:Lottie.asset(
           "assets/json/under_process.json",
            fit: BoxFit.contain
        ),
        description: descriptionText,
        onCloseClick: () {
         Get.back();
        },
        actionButtonList: isYesOrNoPopup
            ?<Widget>[
          CustomDialogActionButton(
            buttonText: "NO",
            color: Colors.red,
            onPressed: () {
              Get.back();
            },
          ),
          CustomDialogActionButton(
            buttonText: "YES",
            color: Colors.green,
            onPressed: () {
              isOkClick = true;
              Get.back();
            },
          )
        ]
            : <Widget>[
          CustomDialogActionButton(
            buttonText: "OK",
            color: Colors.green,
            onPressed: () {
              isOkClick = true;
              Get.back();
            },
          )
        ],
      ),
    ).then((_) {
      return isOkClick;
    });
  }

  Future<bool> showCommonPopupNew3(
      String title, String descriptionText,
      {bool isYesOrNoPopup = false, bool barrierDismissible = true,String? filePath}) async {
    bool isOkClick = false;
    return await Get.dialog(
      barrierDismissible: barrierDismissible,
      CustomDialog(
        title: title,
        topWidget:Lottie.asset(
            filePath??"assets/json/done.json",
            fit: BoxFit.contain,
        ),
        description: descriptionText,
        onCloseClick: () {
          Get.back();
        },
        actionButtonList: isYesOrNoPopup
            ?<Widget>[
          CustomDialogActionButton(
            buttonText: "NO",
            color: Colors.red,
            onPressed: () {
              Get.back();
            },
          ),
          CustomDialogActionButton(
            buttonText: "YES",
            color: Colors.green,
            onPressed: () {
              isOkClick = true;
              Get.back();
            },
          )
        ]
            : <Widget>[
          CustomDialogActionButton(
            buttonText: "OK",
            color: Colors.green,
            onPressed: () {
              isOkClick = true;
              Get.back();
            },
          )
        ],
      ),
    ).then((_) {
      return isOkClick;
    });
  }

  Future<bool> showCommonPopupNew5(
      String title, String descriptionText,
      {bool isYesOrNoPopup = false, bool barrierDismissible = true,String? filePath}) async {
    bool isOkClick = false;
    return await Get.dialog(
      barrierDismissible: barrierDismissible,
      CustomDialog(
        title: title,
        topWidget:Lottie.asset(
          filePath??"assets/json/done.json",
          fit: BoxFit.contain,
        ),
        description: descriptionText,
        onCloseClick: () {
          Get.back();
        },
        actionButtonList: isYesOrNoPopup
            ?<Widget>[
          CustomDialogActionButton(
            buttonText: "NO",
            color: Colors.red,
            onPressed: () {
              Get.back();
            },
          ),
          CustomDialogActionButton(
            buttonText: "COMPLETE RIDE",
            color: Colors.green,
            onPressed: () {
              isOkClick = true;
              Get.back();
            },
          )
        ]
            : <Widget>[
          CustomDialogActionButton(
            buttonText: "OK",
            color: Colors.green,
            onPressed: () {
              isOkClick = true;
              Get.back();
            },
          )
        ],
      ),
    ).then((_) {
      return isOkClick;
    });
  }

  Future<bool> showCommonPopupNew4(
      String title, String descriptionText,
      {bool isYesOrNoPopup = false, bool barrierDismissible = true,String? filePath}) async {
    bool isOkClick = false;
    return await Get.dialog(
      barrierDismissible: barrierDismissible,
      CustomDialog(
        title: title,
        topWidget:Lottie.asset(
          filePath??"assets/json/done.json",
          fit: BoxFit.contain,
        ),
        description: descriptionText,
        onCloseClick: () {
          Get.back();
        },
        actionButtonList: isYesOrNoPopup
            ?<Widget>[
          CustomDialogActionButton(
            buttonText: "Offline",
            color: Colors.red,
            onPressed: () {
              Get.back();
            },
          ),
          CustomDialogActionButton(
            buttonText: "Online",
            color: Colors.green,
            onPressed: () {
              isOkClick = true;
              Get.back();
            },
          )
        ]
            : <Widget>[
          CustomDialogActionButton(
            buttonText: "Offline",
            color: Colors.green,
            onPressed: () {
              isOkClick = true;
              Get.back();
            },
          )
        ],
      ),
    ).then((_) {
      return isOkClick;
    });
  }

}
