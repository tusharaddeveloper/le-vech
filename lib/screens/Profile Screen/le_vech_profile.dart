import 'package:flutter/material.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/app_textfieled.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LeVechProfile extends StatefulWidget {
  const LeVechProfile({Key? key}) : super(key: key);

  @override
  State<LeVechProfile> createState() => _LeVechProfileState();
}

class _LeVechProfileState extends State<LeVechProfile> {
  List<String> imageList = [AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.txtfilled,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(isLogo: false, height: 124, width: double.infinity, info: AppString.detail),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                    SizedBox(height: 20),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), image: DecorationImage(fit: BoxFit.cover, image: NetworkImage("https://t3.ftcdn.net/jpg/02/43/12/34/240_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg"))),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Person Name",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "₹ 2,50,000",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: AppColor.themecolor, fontSize: 20, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                AppString.add,
                                style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Divider(
                              color: AppColor.txtfilled,
                              thickness: 2,
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  AppTextField(
                                    txtValue: AppString.dis,
                                    readOnly: true,
                                  ),
                                  SizedBox(height: 10),
                                  AppTextField(
                                    txtValue: AppString.taluka,
                                    readOnly: true,
                                  ),
                                  SizedBox(height: 10),
                                  AppTextField(
                                    txtValue: AppString.village,
                                    readOnly: true,
                                  ),
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      launchUrl(Uri(scheme: 'tel', path: "9825695210"));
                                    },
                                    child: AppTextField(
                                      txtValue: "+91 9825695210",
                                      readOnly: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Divider(
                              color: AppColor.txtfilled,
                              thickness: 2,
                            ),
                            Text(
                              AppString.itemInfo,
                              style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Divider(
                              color: AppColor.txtfilled,
                              thickness: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColor.txtfilled),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      "પાવર સ્ટેરીંગ  1995 નું મોડલ   ટાયર નવા નાખેલ છે",
                                      style: TextStyle(color: AppColor.primarycolorblack, fontSize: 18, fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
