import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/all_category_controller.dart';
import 'package:le_vech/Controller/Auth%20Controller/noted_controller.dart';
import 'package:le_vech/Screens/All%20Category%20Screen/Tractor%20Screen/tractor_screen.dart';
import 'package:le_vech/Screens/Profile%20Screen/le_vech_profile.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/Screens/All%20Category%20Screen/Cow%20Screen/cow_screen.dart';
import 'package:le_vech/Screens/All%20Category%20Screen/Fourwheel%20Screen/four_wheel.dart';
import 'package:le_vech/Screens/All%20Category%20Screen/Horse%20Screen/horse_screen.dart';
import 'package:le_vech/Screens/All%20Category%20Screen/Other%20Screen/other_screen.dart';
import 'package:le_vech/Screens/All%20Category%20Screen/Twowheel%20Screen/two_wheel.dart';
import 'package:le_vech/Widgets/app_bar.dart';

class AllCategoryScreen extends StatefulWidget {
  String itemName;

  AllCategoryScreen({Key? key, required this.itemName}) : super(key: key);

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  AllCategoryController allCategoryController = Get.put(AllCategoryController());

  List<String> imageList = [AppImage.allCategory, AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];
  List itemName = [AppString.allInfo, AppString.tractor, AppString.cow, AppString.horse, AppString.twoWheel, AppString.fourWheel, AppString.others];
  String? selectedItem;

  @override
  void initState() {
    setState(() {
      selectedItem = widget.itemName;
      allCategoryController.getAllads(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.txtfilled,
        body: SafeArea(child: SingleChildScrollView(child: Obx(() {
          return Column(children: [
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
                                    Container(
                                        height: 70,
                                        width: 80,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), image: DecorationImage(image: AssetImage(imageList[index]), fit: BoxFit.cover))),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(itemName[index], style: TextStyle(color: AppColor.primarycolorblack, fontSize: 14, fontWeight: FontWeight.w600), textAlign: TextAlign.center))
                                  ]))));
                    })),
            const SizedBox(height: 20),
            selectedItem == AppString.tractor
                ? const TractorScreen()
                : selectedItem == AppString.cow
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
                                        child: allCategoryController.isLodingData.value
                                            ? const CircularProgressIndicator()
                                            : GridView.builder(
                                                itemCount: allCategoryController.profileData.length,
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4.8 / 5.8, crossAxisSpacing: 2, mainAxisSpacing: 2),
                                                itemBuilder: (context, index) {
                                                  return ItemWidget(index: index);
                                                }))
          ]);
        }))));
  }
}

class ItemWidget extends StatefulWidget {
  int index;

  ItemWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  AllCategoryController allCategoryController = Get.put(AllCategoryController());
  NotedController notedController = Get.put(NotedController());

  /* List<String> imageList = [AppImage.allCategory,AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];
  List itemName = [AppString.allInfo,AppString.tractor, AppString.cow, AppString.horse, AppString.twoWheel, AppString.fourWheel, AppString.others];*/

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeVechProfile(detail: allCategoryController.profileData[widget.index])));
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
                                image: NetworkImage(allCategoryController.profileData[widget.index]["item_img"][0].toString().isNotEmpty
                                    ? allCategoryController.profileData[widget.index]["item_img"][0].toString()
                                    : "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                fit: BoxFit.cover,
                              ),
                            ))),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(allCategoryController.profileData[widget.index]["item_type"],
                              overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                                child: Text(allCategoryController.profileData[widget.index]["price"],
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.price, fontSize: 16, fontWeight: FontWeight.w700))),
                            InkWell(
                                onTap: () {
                                  if (notedController.favoriteList.contains(allCategoryController.profileData[widget.index].id)) {
                                    notedController.favoriteList.remove(allCategoryController.profileData[widget.index].id);
                                  } else {
                                    notedController.favoriteList.add(allCategoryController.profileData[widget.index].id);
                                  }
                                  allCategoryController.addFavorite(context);
                                },
                                child: Icon(notedController.favoriteList.contains(allCategoryController.profileData[widget.index].id) ? Icons.favorite : Icons.favorite_border,
                                    color: notedController.favoriteList.contains(allCategoryController.profileData[widget.index].id) ? AppColor.iconColor : AppColor.primarycolorblack, size: 24))
                          ])
                        ]))
                  ]))));
    });
  }
}
