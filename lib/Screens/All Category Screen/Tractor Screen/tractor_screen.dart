import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/tractor_screen_controller.dart';
import 'package:le_vech/Screens/All%20Category%20Screen/All%20Category%20Screen/all_category_screen.dart';
import 'package:le_vech/screens/All%20Category%20Screen/Cow%20Screen/cow_screen.dart';
import 'package:le_vech/screens/All%20Category%20Screen/Fourwheel%20Screen/four_wheel.dart';
import 'package:le_vech/screens/All%20Category%20Screen/Horse%20Screen/horse_screen.dart';
import 'package:le_vech/screens/All%20Category%20Screen/Other%20Screen/other_screen.dart';
import 'package:le_vech/screens/All%20Category%20Screen/Twowheel%20Screen/two_wheel.dart';
import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';

class TractorScreen extends StatefulWidget {
  String itemName;

  TractorScreen({Key? key, required this.itemName}) : super(key: key);

  @override
  State<TractorScreen> createState() => _TractorScreenState();
}

class _TractorScreenState extends State<TractorScreen> {
  TractorScreenController tractorController = Get.put(TractorScreenController());

  List<String> imageList = [AppImage.allCategory,AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];
  List itemName = [AppString.allInfo,AppString.tractor, AppString.cow, AppString.horse, AppString.twoWheel, AppString.fourWheel, AppString.others];
  String selectedItem = AppString.tractor;

  @override
  void initState() {
    tractorController.getProfileData(context);
    setState(() {
      selectedItem = widget.itemName;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.txtfilled,
        body: SafeArea(child: SingleChildScrollView(child: Obx(() {
          return tractorController.isLodingData.value
              ? Center(child: CircularProgressIndicator())
              : Column(children: [
                  AppBarWidget(height: 130, width: double.infinity, isLogo: false, info: selectedItem),
                  const SizedBox(height: 20),
                  SizedBox(
                      height: 132,
                      child: ListView.builder(
                          itemCount: imageList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedItem = itemName[index];
                                  });
                                },
                                child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(color: selectedItem == itemName[index] ? AppColor.themecolor : AppColor.primarycolor, width: 3),
                                            color: AppColor.primarycolor),
                                        child: Column(children: [
                                          Card(
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                              child: Container(
                                                  height: 70,
                                                  width: 80,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), image: DecorationImage(image: AssetImage(imageList[index]), fit: BoxFit.cover)))),
                                          Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(itemName[index], style: TextStyle(color: AppColor.primarycolorblack, fontSize: 14, fontWeight: FontWeight.w600), textAlign: TextAlign.center))
                                        ]))));
                          })),
                  const SizedBox(height: 20),
                  selectedItem == AppString.allInfo
                      ? AllCategoryScreen()
                    :selectedItem == AppString.cow
                      ? const CowScreen()
                      : selectedItem == AppString.horse
                          ? const HorseScreen()
                          : selectedItem == AppString.twoWheel
                              ? const TwoWheel()
                              : selectedItem == AppString.fourWheel
                                  ? const FourWheel()
                                  : selectedItem == AppString.others
                                      ? const OtherScreen()
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                          child: GridView.builder(
                                              itemCount: tractorController.profileData.length,
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4.8 / 5.8, crossAxisSpacing: 2, mainAxisSpacing: 2),
                                              itemBuilder: (context, index) {
                                                return itemWidget(index: index);
                                              }))
                ]);
        }))));
  }
}

class itemWidget extends StatefulWidget {
  int index;

  itemWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<itemWidget> createState() => _itemWidgetState();
}

class _itemWidgetState extends State<itemWidget> {
  TractorScreenController tractorController = Get.put(TractorScreenController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeVechProfile(detail:tractorController.profileData[widget.index])));
          },
          child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.primarycolor),
                  child: Column(children: [
                    const SizedBox(height: 08),
                    Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        child: Container(
                            height: 100,
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                image: NetworkImage(tractorController.profileData[widget.index]["item_img"][0].toString().isNotEmpty
                                    ? tractorController.profileData[widget.index]["item_img"][0].toString()
                                    : "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                fit: BoxFit.cover,
                              ),
                            ))),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(tractorController.profileData[widget.index]["item_type"],
                              overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                                child: Text(tractorController.profileData[widget.index]["price"],
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.price, fontSize: 16, fontWeight: FontWeight.w700))),
                            InkWell(
                                onTap: () {
                                  tractorController.isIcon.value = !tractorController.isIcon.value;
                                },
                                child: Icon(tractorController.isIcon.value ? Icons.favorite_border : Icons.favorite,
                                    color: tractorController.isIcon.value ? AppColor.primarycolorblack : AppColor.iconColor, size: 24))
                          ])
                        ]))
                  ]))));
    });
  }
}
