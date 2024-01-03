import 'package:flutter/material.dart';
import 'color_const.dart';

class AppButton extends StatefulWidget {
  double height;
  double width;
  String buttontxt;
  bool? isLoad;
  Function? onTap;

  AppButton({Key? key, required this.height, required this.width, required this.buttontxt, this.isLoad, this.onTap}) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.onTap!();
        },
        child: Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppColor.themecolor),
            child: Center(
              child: widget.isLoad ?? false
                  ? Padding(padding: EdgeInsets.all(3.0), child: CircularProgressIndicator(color: AppColor.primarycolor))
                  : Text(widget.buttontxt, style: TextStyle(color: AppColor.primarycolor, fontSize: 20, fontWeight: FontWeight.w500)),
            )));
  }
}
