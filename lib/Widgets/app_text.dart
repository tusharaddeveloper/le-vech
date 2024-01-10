import 'package:flutter/material.dart';
import 'package:le_vech/Widgets/color_const.dart';

class AppText extends StatelessWidget {
  final String text;
  Color? txtColor;
  double? size;
  FontWeight? fontWeight;
  TextAlign? txtAlign;
  int? maxLine;
  TextOverflow? overflow;


  AppText({Key? key, required this.text, this.txtColor, this.size, this.fontWeight, this.txtAlign,this.maxLine,this.overflow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text( text,maxLines: maxLine,
        style: TextStyle(color: txtColor ?? AppColor.primarycolor, fontSize: size ?? 8, fontWeight: fontWeight ?? FontWeight.normal, fontFamily: "bah",overflow:overflow ),textAlign: txtAlign);   }
}
