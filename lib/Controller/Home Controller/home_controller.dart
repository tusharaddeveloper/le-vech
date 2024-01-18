import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:le_vech/Widgets/app_conts.dart';
import 'package:le_vech/Widgets/app_text.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/screens/Auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/string_const.dart';

class HomeController extends GetxController {
  late SharedPreferences prefs;
  RxList<QueryDocumentSnapshot> profileData = <QueryDocumentSnapshot>[].obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  RxString profilePic = ''.obs;

  /*RxList<Icon> drowerIcon = [
    Icon(Icons.home_outlined, size: 30, color: AppColor.themecolor),
    Icon(Icons.add_circle_outline, size: 28, color: AppColor.themecolor),
    Icon(Icons.favorite_border, size: 28, color: AppColor.themecolor),
    Icon(Icons.save, size: 28, color: AppColor.themecolor),
    Icon(Icons.share, size: 28, color: AppColor.themecolor)
  ].obs;*/

  RxList drowerName = [
    AppString.allInfo,
    AppString.addInfo,
    AppString.like,
    AppString.youSendInfo,
    AppString.share,
    "ખેત પેદાશ લે - વેચ",
    "ઇલેક્ટ્રોનિક સાધનો લે-વેચ",
    "લેપટોપ કમ્પ્યુટર ટીવી લે-વેચ",
    "નોકરી",
    "મોબાઇલ લે-વેચ",
    "ભંગાર લે-વેચ",
    "મકાન દુકાન પ્લોટ લે-વેચ",
    "બિયારણ દવા લે-વેચ",
    "જમીન લે-વેચ",
    "ફળ શાકભાજી લે-વેચ",
    "નર્સરી રોપ લે-વેચ",
    "ઘેટાં બકરાં લે-વેચ",
    "સનેડો ટ્રેક્ટર લે-વેચ",
    "ટ્રેક્ટર ઓજાર લે-વેચ",
    "ખેત ઓજાર લે-વેચ",
    "પક્ષીઓ લે-વેચ",
    "બળદ લે-વેચ",
    "કુતરા લે-વેચ"
  ].obs;
  RxList<String> itemName = [
    AppString.allInfo,
    AppString.tractor,
    AppString.cow,
    AppString.horse,
    AppString.twoWheel,
    AppString.fourWheel,
    AppString.others,
    "ખેત પેદાશ લે - વેચ",
    "ઇલેક્ટ્રોનિક સાધનો લે-વેચ",
    "લેપટોપ કમ્પ્યુટર ટીવી લે-વેચ",
    "નોકરી",
    "મોબાઇલ લે-વેચ",
    "ભંગાર લે-વેચ",
    "મકાન દુકાન પ્લોટ લે-વેચ",
    "બિયારણ દવા લે-વેચ",
    "જમીન લે-વેચ",
    "ફળ શાકભાજી લે-વેચ",
    "નર્સરી રોપ લે-વેચ",
    "ઘેટાં બકરાં લે-વેચ",
    "સનેડો ટ્રેક્ટર લે-વેચ",
    "ટ્રેક્ટર ઓજાર લે-વેચ",
    "ખેત ઓજાર લે-વેચ",
    "પક્ષીઓ લે-વેચ",
    "બળદ લે-વેચ",
    "કુતરા લે-વેચ"
  ].obs;
  RxList<String> imageList = [
    AppImage.allCategory,
    AppImage.tractorEicher,
    AppImage.cow,
    AppImage.horse,
    AppImage.bike,
    AppImage.car,
    AppImage.imglogo,
    AppImage.khetFasalImg,
    "${AppImage.electricalItems}",
    AppImage.leptopTVComputer,
    AppImage.jobIcon,
    AppImage.phoneLevecha,
    AppImage.imglogo,
    AppImage.jaminMakanPloat,
    AppImage.biyaranlevech,
    AppImage.imglogo,
    AppImage.fruitsAndVegetables,
    AppImage.narsarirRop,
    AppImage.sheepAndBakra,
    AppImage.sanedoImg,
    AppImage.trecterOjar,
    AppImage.khetOjarImg,
    AppImage.imglogo,
    AppImage.oxImages,
    AppImage.dogImg
  ].obs;

  // get MobileNo. in firebase
  setLogin(String mobileNo) async {
    userId = mobileNo;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", true);
    prefs.setString('mobile_number', mobileNo);
  }

  logOutAlertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: AppColor.dialougeBoxColor,
            title: AppText(text: AppString.logOutQuestion, txtColor: AppColor.primarycolor, size: 20),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  AppText(text: AppString.logoutOption, txtColor: AppColor.primarycolor, size: 20),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                child: AppText(text: AppString.no, txtColor: AppColor.dialougeBoxColor, size: 18),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the Dialog
                },
              ),
              ElevatedButton(
                  child: AppText(text: AppString.yes, txtColor: AppColor.dialougeBoxColor, size: 18),
                  onPressed: () {
                    logOut(context);
                    Navigator.of(context).pop();
                  })
            ]);
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
