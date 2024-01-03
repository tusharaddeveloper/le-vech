import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'color_const.dart';
import 'image_const.dart';

class AppBarWidget extends StatefulWidget {
  double height;
  double width;
  double? logoHeight;
  double? logoWidth;
  bool isLogo;
  String? info;

  AppBarWidget({
    Key? key,
    required this.height,
    required this.width,
    this.logoHeight,
    this.logoWidth,
    required this.isLogo,
    this.info,
  }) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ClipPath(
          clipper: WaveClipperTwo(),
          child: Container(
              height: widget.height,
              width: widget.width,
              color: AppColor.themecolor,
              child: Center(
                  child: widget.isLogo
                      ? Container(
                          height: widget.logoHeight ?? 0,
                          width: widget.logoWidth ?? 0,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), image: DecorationImage(image: AssetImage(AppImage.imglogo), fit: BoxFit.cover), boxShadow: [
                            BoxShadow(color: AppColor.shadow.withOpacity(0.5), spreadRadius: 7, blurRadius: 7, offset: Offset(0, 3) // changes position of shadow
                                )
                          ]))
                      : Padding(
                          padding: const EdgeInsets.only(left: 28, bottom: 26),
                          child: Row(children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(Icons.arrow_back_ios, color: AppColor.primarycolor, size: 28)),
                            Spacer(),
                            Text(widget.info!, style: TextStyle(color: AppColor.primarycolor, fontSize: 28)),
                            Spacer(),
                            Spacer()
                          ])))))
    ]);
  }
}
