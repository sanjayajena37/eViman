import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/text_styles.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double? BtnTextSize;
  final double? width;
  final Gradient? gradient;
  final Color? textColor;
  final bool? enableShadow;

  const RoundedButtonWidget({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.BtnTextSize,
    this.width,
    this.gradient,
    required this.textColor,
    this.enableShadow
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 50,
        width: width ?? Get.width,
        decoration: BoxDecoration(
          // boxShadow: const [
          //   BoxShadow(
          //     color: Color.fromARGB(255, 122, 247, 108),
          //     offset: Offset(
          //       3.0,
          //       3.0,
          //     ),
          //     blurRadius: 10.0,
          //     spreadRadius: 1.0,
          //   ), //BoxShadow
          //   BoxShadow(
          //     color: Colors.white,
          //     offset: Offset(0.0, 0.0),
          //     blurRadius: 0.0,
          //     spreadRadius: 0.0,
          //   ),
          // ],

            boxShadow: (enableShadow == false) ? []  :const [
              BoxShadow(
                color: Color(0x80000000),
                blurRadius: 12.0,
                offset: Offset(0.0, 5.0),
              ),
            ],
            gradient: gradient ??
                const LinearGradient(colors: [
                  Color.fromARGB(255, 87, 175, 248),
                  Color.fromARGB(255, 2, 105, 190)
                ]),
            borderRadius: BorderRadius.circular(15.0)),
        // borderRadius: BorderRadius.only(
        //     topLeft: Radius.elliptical(35, 35),
        //     bottomRight: Radius.elliptical(35, 35))),
        child: OutlinedButton(
          // color: buttonColor,
          // shape: StadiumBorder(),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyles(context).getRegularStyle().copyWith(
              color: textColor,
              fontSize: 16,
            ),
          ),
        ),
      );

  }
}