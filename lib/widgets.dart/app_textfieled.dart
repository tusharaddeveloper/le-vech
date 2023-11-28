import 'dart:collection';

import 'package:flutter/material.dart';

import 'color_const.dart';

class AppTextField extends StatefulWidget {
  String txtValue;
  String? lableValue;
  bool? isIcon;
  bool? preIcon;
  IconData? preIconData;
  int? maxLines;
  int? maxLength;
  TextInputType? keytype;
  String? counterTxt;
  bool? readOnly;
  TextEditingController? controller;

  AppTextField(
      {Key? key, required this.txtValue, this.isIcon, this.preIcon, this.maxLines, this.maxLength, this.keytype, this.counterTxt, this.lableValue, this.preIconData, this.readOnly, this.controller})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  String dropdownvalue = 'junagadh';
  var items = [
    'junagadh',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

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
        fillColor: AppColor.txtfilled,
        focusColor: AppColor.primarycolorblack,
        prefixIcon: widget.preIcon ?? false ? Icon(widget.preIconData ?? Icons.person) : SizedBox(),
        suffixIcon: widget.isIcon ?? false
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
              )
            : SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        hintText: widget.txtValue,
        hintStyle: TextStyle(fontSize: 18),
        labelText: widget.lableValue,
        labelStyle: TextStyle(fontSize: 18, color: AppColor.primarycolorblack),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primarycolorblack),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onChanged: (a) {
        setState(() {});
      },
    );
  }
}
