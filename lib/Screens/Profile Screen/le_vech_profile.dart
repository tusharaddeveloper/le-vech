import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/Profile%20Controller/profile_controller.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/app_text.dart';
import 'package:le_vech/Widgets/app_textfieled.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LeVechProfile extends StatefulWidget {
  QueryDocumentSnapshot detail;

  LeVechProfile({Key? key, required this.detail}) : super(key: key);

  @override
  State<LeVechProfile> createState() => _LeVechProfileState();
}

class _LeVechProfileState extends State<LeVechProfile> {

  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    setData();
    super.initState();
  }

   setData(){
    setState(() {
      profileController. levechImageList = widget.detail["item_img"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.txtfilled,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          AppBarWidget(isLogo: false, height: 124, width: double.infinity, info: AppString.detail),
          const SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(children: [
                CarouselSlider(
                    options: CarouselOptions(height: 190, autoPlay: false,enableInfiniteScroll: false, autoPlayInterval: const Duration(seconds: 2), aspectRatio: 16 / 9, viewportFraction: 1),
                    items: profileController.levechImageList.map((i) {
                      return Builder(builder: (BuildContext context) {
                        return Column(children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                  height: 190,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(image: NetworkImage(i), fit: BoxFit.cover),
                                  )))
                        ]);
                      });
                    }).toList()),

                const SizedBox(height: 20),
                Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: const BoxDecoration(shape: BoxShape.circle),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(80),
                                        child:  CachedNetworkImage(
                                            height: 100,
                                            width: 100,
                                            imageUrl: profileController.profileUrl.value,
                                            placeholder: (context, url) => const Image(image: AssetImage('assets/images/logops.jpg')),
                                            errorWidget: (context, url, error) => const Image(image: AssetImage('assets/images/logops.jpg')),
                                            fit: BoxFit.cover),)),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                               /* Text(widget.detail['name'],
                                    overflow: TextOverflow.ellipsis, maxLines: 3, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w600)),*/
                                    AppText(text: widget.detail['name'],txtColor: AppColor.primarycolorblack,size: 20,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis,maxLine: 3),
                                const SizedBox(height: 10),
                                /*Text(widget.detail['price'], overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.themecolor, fontSize: 20, fontWeight: FontWeight.w500))*/
                                    AppText(text: widget.detail['price'],txtColor: AppColor.themecolor,size: 20,fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis),
                              ]))
                            ])))),
                const SizedBox(height: 10),
                Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                        child: Column(children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: /*Text(AppString.addLevech, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w600))*/
                              AppText(text: AppString.addLevech,txtColor: AppColor.primarycolorblack,size: 20,fontWeight: FontWeight.w600),
                          ),
                          Divider(color: AppColor.txtfilled, thickness: 2),
                          const SizedBox(height: 10),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(children: [
                                AppTextField(txtValue: widget.detail['district'], readOnly: true),
                                const SizedBox(height: 10),
                                AppTextField(txtValue: widget.detail['taluka'], readOnly: true),
                                const SizedBox(height: 10),
                                AppTextField(txtValue: widget.detail['village'], readOnly: true),
                                const SizedBox(height: 10),
                                AppTextField(txtValue: '+91 ${widget.detail['mobile_number']}', maxLength: 10, readOnly: true, counterTxt: "")
                              ])),
                          const SizedBox(height: 10),
                          Divider(color: AppColor.txtfilled, thickness: 2),
                          /*Text(widget.detail['item_type'], style: TextStyle(color: AppColor.primarycolorblack, fontSize: 20, fontWeight: FontWeight.w600)),*/
                          AppText(text: widget.detail['item_type'],txtColor: AppColor.primarycolorblack,size: 20,fontWeight: FontWeight.w600),
                          Divider(color: AppColor.txtfilled, thickness: 2),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColor.txtfilled),
                                  child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: /*Text(widget.detail['detail'], style: TextStyle(color: AppColor.primarycolorblack, fontSize: 18, fontWeight: FontWeight.w500))*/
                                      AppText(text: widget.detail['detail'],txtColor: AppColor.primarycolorblack,size: 18,fontWeight: FontWeight.w500),
                                  )))
                        ])))
              ]))
        ]))));
  }
}
