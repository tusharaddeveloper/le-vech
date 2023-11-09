import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:le_vech/screens/Ad%20Screen/add_screen.dart';
import 'package:le_vech/screens/Ad%20Screen/send_add.dart';
import 'package:le_vech/screens/Like%20Screen/like_screen.dart';
import 'package:le_vech/screens/Profile%20Screen/profile_screen.dart';
import 'package:le_vech/screens/Tractor%20Screen/tractor_screen.dart';
import 'package:le_vech/screens/auth.dart/login_screen.dart';

import 'package:le_vech/widgets.dart/color_const.dart';
import 'package:le_vech/widgets.dart/image_const.dart';
import 'package:le_vech/widgets.dart/string_const.dart';


import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences prefs;

  List<Icon> drowerIcon = [
    Icon(
      Icons.home_outlined,
      size: 30,
      color: AppColor.themecolor,
    ),
    Icon(
      Icons.add_circle_outline,
      size: 28,
      color: AppColor.themecolor,
    ),
    Icon(
      Icons.favorite_border,
      size: 28,
      color: AppColor.themecolor,
    ),
    Icon(
      Icons.save,
      size: 28,
      color: AppColor.themecolor,
    ),
    Icon(
      Icons.share,
      size: 28,
      color: AppColor.themecolor,
    )
  ];
  List drowerName = [AppString.allInfo, AppString.addInfo, AppString.like, AppString.youSendInfo, AppString.share];
  List itemName = [AppString.tractor, AppString.cow, AppString.horse, AppString.twoWheel, AppString.fourWheel, AppString.others];
  List<String> imageList = [AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    setLogin();
    super.initState();
  }

  setLogin() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", true);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.txtfilled,
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  height: 130,
                  width: double.infinity,
                  color: AppColor.themecolor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28, bottom: 26),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            scaffoldKey.currentState!.openDrawer();
                          },
                          child: Icon(
                            Icons.list,
                            color: AppColor.primarycolor,
                            size: 32,
                          ),
                        ),
                        Spacer(),
                        Text(
                          AppString.appName,
                          style: TextStyle(color: AppColor.primarycolor, fontSize: 26),
                        ),
                        Spacer(),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(height: 190, autoPlay: true, autoPlayInterval: Duration(seconds: 2), aspectRatio: 16 / 9, viewportFraction: 1),
                      items: imageList.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    height: 190,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(image: AssetImage(i), fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 26),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: GridView.builder(
                    itemCount: itemName.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 5.2 / 5.8, crossAxisSpacing: 2, mainAxisSpacing: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TractorScreen(itemName: itemName[index]),
                          ));
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.primarycolor),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                    child: Container(
                                      width: 140,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(image: AssetImage(imageList[index]), fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    itemName[index],
                                    style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ));
              },
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColor.themecolor,
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: AppColor.themecolor),

                  accountName: SizedBox(
                    width: 200,
                    child: Text(
                      "Abhishek Mishra",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  accountEmail: Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text("abhishekm977@gmail.com", overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14)),
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.edit,
                        color: AppColor.primarycolor,
                        size: 22,
                      )
                    ],
                  ),
                  currentAccountPictureSize: Size.square(40),
                  currentAccountPicture: CircleAvatar(
                      backgroundColor: AppColor.primarycolor,
                      child: Image.asset(
                        AppImage.imglogo,
                        fit: BoxFit.cover,
                      )), //circleAvatar
                ), //UserAccountDrawerHeader
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                size: 28,
                color: AppColor.themecolor,
              ),
              title: Text(
                drowerName[0],
                style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Timer(Duration(seconds: 1), () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                });
              },
            ),
            Divider(thickness: 2),
            ListTile(
              leading: Icon(
                Icons.add_circle_outline,
                size: 28,
                color: AppColor.themecolor,
              ),
              title: Text(
                drowerName[1],
                style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Timer(Duration(microseconds: 500), () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddItemsScreen()),
                  );
                });
              },
            ),
            Divider(thickness: 2),
            ListTile(
              leading: Icon(
                Icons.favorite_border,
                size: 28,
                color: AppColor.themecolor,
              ),
              title: Text(
                drowerName[2],
                style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Future.delayed(const Duration(microseconds: 500));
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LikeScreen()),
                );
              },
            ),
            Divider(thickness: 2),
            ListTile(
              leading: Icon(
                Icons.save,
                size: 28,
                color: AppColor.themecolor,
              ),
              title: Text(
                drowerName[3],
                style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SendAdd()),
                );
              },
            ),
            Divider(thickness: 2),
            ListTile(
              leading: Icon(
                Icons.share,
                size: 28,
                color: AppColor.themecolor,
              ),
              title: Text(
                drowerName[4],
                style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            Divider(thickness: 2),
            ListTile(
              leading: Icon(
                Icons.logout,
                size: 28,
                color: AppColor.themecolor,
              ),
              title: Text(
                AppString.logOut,
                style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginSCreen()), (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ), //Drawer
    );
  }
}
