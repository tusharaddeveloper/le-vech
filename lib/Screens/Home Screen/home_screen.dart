import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/profile_controller.dart';
import 'package:le_vech/Controller/home_controller.dart';
import 'package:le_vech/Screens/catrgory_item_screen.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/screens/Ad%20Screen/add_screen.dart';
import 'package:le_vech/screens/Ad%20Screen/send_add.dart';
import 'package:le_vech/screens/Like%20Screen/like_screen.dart';
import 'package:le_vech/screens/Profile%20Screen/profile_screen.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:share_plus/share_plus.dart';

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
    setState(() {});
    homeController.setLogin(widget.mobileNo!);
    profileController.getMobileNumber(context);
    super.initState();
  }

  @override
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
                      options: CarouselOptions(height: 150, autoPlay: true, autoPlayInterval: const Duration(seconds: 2), aspectRatio: 16 / 9, viewportFraction: 1),
                      items: homeController.imageList.map((i) {
                        return Builder(builder: (BuildContext context) {
                          return Column(children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), image: DecorationImage(image: AssetImage(i), fit: BoxFit.cover))))
                          ]);
                        });
                      }).toList()),
                  const SizedBox(height: 16)
                ])),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: GridView.builder(
                    itemCount: homeController.itemName.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 5.2 / 5.8, crossAxisSpacing: 2, mainAxisSpacing: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                           // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllCategoryScreen(itemName: homeController.itemName[index])));
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CatrgoryItemScreen( selectedindex: index)));
                          },
                          child: Card(
                              elevation: 2,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8), topLeft: Radius.circular(8), topRight: Radius.circular(8))),

                              child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColor.primarycolor),
                                  child: Column(children: [
                                    Card(
                                      margin: EdgeInsets.zero,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8), topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                                      child: Container(
                                          height: 90,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8), topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                                              color: AppColor.primarycolor,
                                              image: DecorationImage(
                                                image: AssetImage(homeController.imageList[index]),
                                                fit: BoxFit.cover,
                                              ))),
                                    ),
                                    Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            homeController.itemName[index],
                                            maxLines: 1,
                                            style: TextStyle(color: AppColor.primarycolorblack, fontSize: 14, fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          )),
                                    )
                                  ]))));
                    }))
          ]))),
          drawer: Drawer(
              child: ListView(children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen()));
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
                              child: CachedNetworkImage(
                                  height: 90,
                                  width: 90,
                                  imageUrl: profileController.profileUrl.value,
                                  placeholder: (context, url) => Image(image: AssetImage(AppImage.blurLogoImg)),
                                  errorWidget: (context, url, error) => Image(image: AssetImage(AppImage.blurLogoImg)),
                                  fit: BoxFit.cover),
                            )),
                        const SizedBox(width: 18),
                        profileController.profileUrl.value.isNotEmpty
                            ? SizedBox(width: MediaQuery.of(context).size.width*0.35,

                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text("${profileController.nameController.value.text} ${profileController.surnameController.value.text}",
                                      overflow: TextOverflow.ellipsis,maxLines: 1 ,style: TextStyle(fontSize: 18, color: AppColor.primarycolor)),
                                  const SizedBox(height: 6),
                                  Text("+91 ${profileController.mobileController.value.text}", overflow: TextOverflow.ellipsis,maxLines: 1, style: TextStyle(fontSize: 16, color: AppColor.primarycolor))
                                ]),
                            )
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
                    ]) //BoxDecoration
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
                  //Navigator.pop(context);
                  Share.share("com.example.le_vech");
                }),
            const Divider(thickness: 2),
            ListTile(
                leading: Icon(Icons.logout, size: 28, color: AppColor.themecolor),
                title: Text(AppString.logOut, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w500)),
                onTap: () {
                  homeController.logOutAlertDialog(context);
                })
          ])) //Drawer
          );
    });
  }
}
