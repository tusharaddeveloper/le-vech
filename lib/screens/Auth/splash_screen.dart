import 'package:flutter/material.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/screens/Home%20Screen/home_screen.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences prefs;

  @override
  void initState() {
    logedin();
    super.initState();
  }

  void logedin() async {
    bool logedin = false;
    prefs = await SharedPreferences.getInstance();
    logedin = prefs.getBool("isLogin") ?? false;
    if (logedin) {
      Future.delayed(Duration(seconds: 4), () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false);
      });
    } else {
      Future.delayed(Duration(seconds: 4), () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginSCreen()), (Route<dynamic> route) => false);
      });
    }
  }

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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    image: DecorationImage(image: AssetImage(AppImage.imglogo), fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.shadow.withOpacity(0.5),
                        spreadRadius: 7,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  )),
            )),
      ),
    );
  }
}
