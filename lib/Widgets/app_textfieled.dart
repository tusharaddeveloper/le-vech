import 'dart:collection';

import 'package:flutter/material.dart';

import 'color_const.dart';

class AppTextField extends StatefulWidget {
  String txtValue;
  String? lableValue;
  bool? isIcon;
  IconData? prefixIcon;
  int? maxLines;
  int? maxLength;
  TextInputType? keytype;
  String? counterTxt;
  bool? readOnly;
  TextEditingController? controller;
  Function? validator;

  AppTextField({Key? key, required this.txtValue, this.maxLines, this.maxLength, this.keytype, this.counterTxt, this.lableValue, this.prefixIcon, this.readOnly, this.controller, this.validator})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  String dropdownvalue = 'junagadh';

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        cursorColor: AppColor.primarycolorblack,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        keyboardType: widget.keytype ?? TextInputType.streetAddress,
        readOnly: widget.readOnly ?? false,
        decoration: InputDecoration(
            filled: true,
            counterText: widget.counterTxt,
            fillColor: AppColor.primarycolor,
            focusColor: AppColor.primarycolorblack,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            hintText: widget.txtValue,
            hintStyle: TextStyle(fontSize: 20),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            labelText: widget.lableValue,
            labelStyle: TextStyle(fontSize: 18, color: AppColor.primarycolorblack),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.themecolor), borderRadius: BorderRadius.circular(30))),
        onChanged: (a) {
          setState(() {});
        });
  }
}
