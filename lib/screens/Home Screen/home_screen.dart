import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/Auth%20Controller/profile_controller.dart';
import 'package:le_vech/Controller/Home%20Screen/home_controller.dart';
import 'package:le_vech/Controller/Home%20Controller/home_controller.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/screens/Ad%20Screen/add_screen.dart';
import 'package:le_vech/screens/Ad%20Screen/send_add.dart';
import 'package:le_vech/screens/Like%20Screen/like_screen.dart';
import 'package:le_vech/screens/Profile%20Screen/profile_screen.dart';
import 'package:le_vech/screens/Tractor%20Screen/tractor_screen.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/string_const.dart';

class HomeScreen extends StatefulWidget {
  String? mobileNo;

  HomeScreen({Key? key, this.mobileNo}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    homeController.setLogin(widget.mobileNo!);
    profileController.getMobileNumber(context);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          backgroundColor: AppColor.txtfilled,
          key: homeController.scaffoldKey,
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(children: [
            ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                    height: 130,
                    width: double.infinity,
                    color: AppColor.themecolor,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 28, bottom: 26),
                        child: Row(children: [
                          InkWell(
                              onTap: () {
                                homeController.scaffoldKey.currentState!.openDrawer();
                              },
                              child: Icon(Icons.list, color: AppColor.primarycolor, size: 32)),
                          const Spacer(),
                          Text(AppString.appName, style: TextStyle(color: AppColor.primarycolor, fontSize: 26)),
                          const Spacer(),
                          const Spacer()
                        ])))),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(children: [
                  CarouselSlider(
                      options: CarouselOptions(height: 190, autoPlay: true, autoPlayInterval: const Duration(seconds: 2), aspectRatio: 16 / 9, viewportFraction: 1),
                      items: homeController.imageList.map((i) {
                        return Builder(builder: (BuildContext context) {
                          return Column(children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                    height: 190,
                                    width: double.infinity,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), image: DecorationImage(image: AssetImage(i), fit: BoxFit.cover))))
                          ]);
                        });
                      }).toList()),
                  const SizedBox(height: 26),
                ])),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: GridView.builder(
                    itemCount: homeController.itemName.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 5.2 / 5.8, crossAxisSpacing: 2, mainAxisSpacing: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TractorScreen(itemName: homeController.itemName[index]),
                            ));
                          },
                          child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.primarycolor),
                                  child: Column(children: [
                                    const SizedBox(height: 8),
                                    Expanded(
                                        child: Card(
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                            child: Container(
                                                width: 140,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(6), image: DecorationImage(image: AssetImage(homeController.imageList[index]), fit: BoxFit.cover))))),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(homeController.itemName[index],
                                            style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600), textAlign: TextAlign.center))
                                  ]))));
                    }))
          ]))),
          drawer: Drawer(
              child: ListView(children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ));
                },
                child: DrawerHeader(
                  decoration: BoxDecoration(color: AppColor.themecolor),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Container(
                          height: 90,
                          width: 90,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: profileController.selectedProfile.value.path.isEmpty
                                  ? profileController.profileUrl.value != ''
                                      ? Image(
                                          image: NetworkImage(profileController.profileUrl.value),
                                          fit: BoxFit.cover,
                                        )
                                      : const Image(image: AssetImage('assets/images/logops.jpg'))
                                  : Image.file(profileController.selectedProfile.value, fit: BoxFit.cover))),
                      const SizedBox(width: 18),
                      profileController.profileUrl.value.isNotEmpty
                          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text("${profileController.nameController.text}", overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, color: AppColor.primarycolor)),
                              const SizedBox(height: 8),
                              Text("+91 ${profileController.mobileController.text}", overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18, color: AppColor.primarycolor))
                            ])
                          : Text(" Le-vecha ", overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18, color: AppColor.primarycolor))
                    ]),
                    const Spacer(),
                    Row(children: [
                      const Spacer(),
                      Text(AppString.edit, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18, color: AppColor.primarycolor)),
                      const SizedBox(width: 10),
                      Icon(Icons.edit, color: AppColor.primarycolor, size: 22),
                      const SizedBox(width: 20)
                    ]),
                    const SizedBox(height: 10)
                  ]), //BoxDecoration
                )),
            ListTile(
                leading: Icon(Icons.home_outlined, size: 28, color: AppColor.themecolor),
                title: Text(homeController.drowerName[0], style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                }),
            const Divider(thickness: 2),
            ListTile(
                leading: Icon(Icons.add_circle_outline, size: 28, color: AppColor.themecolor),
                title: Text(homeController.drowerName[1], style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                  Timer(const Duration(microseconds: 500), () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddItemsScreen()));
                  });
                }),
            const Divider(thickness: 2),
            ListTile(
                leading: Icon(Icons.favorite_border, size: 28, color: AppColor.themecolor),
                title: Text(homeController.drowerName[2], style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                  Future.delayed(const Duration(microseconds: 500));
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LikeScreen()));
                }),
            const Divider(thickness: 2),
            ListTile(
                leading: Icon(Icons.save, size: 28, color: AppColor.themecolor),
                title: Text(homeController.drowerName[3], style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SendAdd()));
                }),
            const Divider(thickness: 2),
            ListTile(
                leading: Icon(Icons.share, size: 28, color: AppColor.themecolor),
                title: Text(homeController.drowerName[4], style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                }),
            const Divider(thickness: 2),
            ListTile(
                leading: Icon(Icons.logout, size: 28, color: AppColor.themecolor),
                title: Text(AppString.logOut, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w500)),
                onTap: () {
                  homeController.logOut(context);
                })
          ])) //Drawer
          );
    });
  }
}
