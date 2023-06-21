import 'package:flutter/material.dart';
import 'package:mllp/constant/colors.dart';
import 'package:mllp/constant/dimens.dart';

class EasyText extends StatelessWidget {
  const EasyText(
      {Key? key,
      required this.text,
      this.fontSize = kFontSize14x,
      this.fontWeight = FontWeight.w400,
      this.color = kBlackColor})
      : super(key: key);
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }
}
