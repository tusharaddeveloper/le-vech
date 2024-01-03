import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/Auth%20Controller/splash_controller.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/image_const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    splashController.logedin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child: Container(
                height: double.infinity,
                width: double.infinity,
                color: AppColor.themecolor,
                child: Center(
                    child: Container(
                        height: size.width * 0.60,
                        width: size.width * 0.60,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), image: DecorationImage(image: AssetImage(AppImage.imglogo), fit: BoxFit.cover), boxShadow: [
                          BoxShadow(
                            color: AppColor.shadow.withOpacity(0.5),
                            spreadRadius: 7,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ]))))));
  }
}
