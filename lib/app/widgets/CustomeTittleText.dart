import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/text_styles.dart';
// import 'package:google_fonts/google_fonts.dart';


class CustomeTittleText extends StatelessWidget {
  String text;
  double? textsize;
  FontWeight? fontWeight;
  Color? color;

  CustomeTittleText(
      {Key? key,
        required this.text,
        this.textsize,
        this.fontWeight,
        this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
      TextStyles(context)
          .getBoldStyle().copyWith(fontSize: 20)
    );
  }
}

class CustomeSubTittleText extends StatelessWidget {
  String text;
  double? textsize;
  FontWeight? fontWeight;
  Color? color;
  TextAlign? alignment;
  int? maxlines;

  CustomeSubTittleText(
      {Key? key,
        required this.text,
        this.textsize,
        this.fontWeight,
        this.alignment,
        this.maxlines,
        this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles(context)
          .getBoldStyle().copyWith(fontSize: 12,color: color) ,
      maxLines: maxlines ?? 1,
      overflow: TextOverflow.ellipsis,
      textAlign: alignment,
    );
  }
}

