import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:le_vech/Controller/Profile%20Controller/profile_controller.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/screens/Auth/login_screen.dart';
import 'package:le_vech/utils/firebase_get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/string_const.dart';

class HomeController extends GetxController {
  late SharedPreferences prefs;
  RxList<QueryDocumentSnapshot> profileData = <QueryDocumentSnapshot>[].obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  RxString profilePic = ''.obs;

  RxList<Icon> drowerIcon = [
    Icon(Icons.home_outlined, size: 30, color: AppColor.themecolor),
    Icon(Icons.add_circle_outline, size: 28, color: AppColor.themecolor),
    Icon(Icons.favorite_border, size: 28, color: AppColor.themecolor),
    Icon(Icons.save, size: 28, color: AppColor.themecolor),
    Icon(Icons.share, size: 28, color: AppColor.themecolor)
  ].obs;
  RxList drowerName = [AppString.allInfo, AppString.addInfo, AppString.like, AppString.youSendInfo, AppString.share].obs;
  RxList itemName = [AppString.tractor, AppString.cow, AppString.horse, AppString.twoWheel, AppString.fourWheel, AppString.others].obs;
  RxList<String> imageList = [AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo].obs;

  // get MobileNo. in firebase
  setLogin(String mobileNo) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", true);
    prefs.setString('mobile_number', mobileNo);
    getProfileData(mobileNo);
  }

  // Firebase get profile & where condition
  getProfileData(String mobileNo) async {
    /*getProfileData(String mobileNo) async {
    profileData.value = await firebaseGetwhere('users', 'mobile_number', mobileNo);
    if (profileData.isNotEmpty) {
      profilePic.value = profileData[0]['image'];
    }
  }*/
  }
  logOutAlertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout ?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure To Logout ?'),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the Dialog
              },
            ),
            ElevatedButton(
                child: const Text('Yes'),
                onPressed: () {
                  logOut(context);
                  Navigator.of(context).pop();
                  // Navigate to login
                }
            ),
          ],
        );
      },
    );
  }
  // logout profile
  void logOut(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginSCreen()), (Route<dynamic> route) => false);
  }
}
