import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/all_category_controller.dart';
import 'package:le_vech/Screens/Profile%20Screen/le_vech_profile.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  AllCategoryController allCategoryController = Get.put(AllCategoryController());



  @override
  void initState() {
    setState(() {
      allCategoryController.getAllads(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: GridView.builder(
              itemCount: allCategoryController.profileData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4.8 / 5.8, crossAxisSpacing: 2, mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                return  allCategoryController.isLodingData.value? const CircularProgressIndicator():ItemWidget(index: index);
              }));
    });
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
  List<String> imageList = [AppImage.allCategory,AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];
  List itemName = [AppString.allInfo,AppString.tractor, AppString.cow, AppString.horse, AppString.twoWheel, AppString.fourWheel, AppString.others];

  @override
  void initState() {
    setState(() {
      allCategoryController.getAllads(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeVechProfile(detail:allCategoryController.profileData[widget.index])));
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
                                  allCategoryController.isIcon.value = !allCategoryController.isIcon.value;
                                },
                                child: Icon(allCategoryController.isIcon.value ? Icons.favorite_border : Icons.favorite,
                                    color: allCategoryController.isIcon.value ? AppColor.primarycolorblack : AppColor.iconColor, size: 24))
                          ])
                        ]))
                  ]))));
    });
  }
}
