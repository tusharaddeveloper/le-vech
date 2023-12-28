import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/screens/Auth/login_screen.dart';
import 'package:le_vech/screens/Home%20Screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController{

  late SharedPreferences prefs;

  // MobileNo. get in SharedPreferences & Navigate
  void logedin(BuildContext context) async {
    RxBool logedin = false.obs;
    String mo = '';
    prefs = await SharedPreferences.getInstance();
    logedin.value = prefs.getBool("isLogin") ?? false;
    mo = prefs.getString("mobile_number").toString() ?? '';

    if (logedin.value) {
      Future.delayed(Duration(seconds: 4), () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(mobileNo: mo)), (Route<dynamic> route) => false);
      });
    } else {
      Future.delayed(Duration(seconds: 4), () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginSCreen()), (Route<dynamic> route) => false);
      });
    }
  }
}