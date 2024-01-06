import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/othen_screen_controller.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';

class OtherScreen extends StatefulWidget {
  const OtherScreen({Key? key}) : super(key: key);

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
 // List<String> imageList = [AppImage.allCategory, AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];
 // List itemName = [AppString.allInfo, AppString.tractor, AppString.cow, AppString.horse, AppString.twoWheel, AppString.fourWheel, AppString.others];
  OtherScreenController otherScreenController = Get.put(OtherScreenController());

  @override
  void initState() {
    setState(() {});
    otherScreenController.sellOtherAds(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: otherScreenController.isOtharLodingData.value
              ? const CircularProgressIndicator()
              : GridView.builder(
                  itemCount: otherScreenController.getOtherAds.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4.8 / 5.8, crossAxisSpacing: 2, mainAxisSpacing: 2),
                  itemBuilder: (context, index) {
                    return ItemWidget(index: index);
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
  OtherScreenController otherScreenController = Get.put(OtherScreenController());
  List<String> imageList = [AppImage.allCategory, AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];
  List itemName = [AppString.allInfo, AppString.tractor, AppString.cow, AppString.horse, AppString.twoWheel, AppString.fourWheel, AppString.others];
  bool isIcon = true;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeVechProfile(detail: otherScreenController.getOtherAds[widget.index])));
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
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), image: DecorationImage(image: AssetImage( AppImage.imglogo), fit: BoxFit.cover)))),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(otherScreenController.getOtherAds[widget.index]["item_type"],
                              overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                                child: Text(otherScreenController.getOtherAds[widget.index]["price"],
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.price, fontSize: 16, fontWeight: FontWeight.w700))),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    isIcon = !isIcon;
                                  });
                                },
                                child: Icon(isIcon ? Icons.favorite_border : Icons.favorite, color: isIcon ? AppColor.primarycolorblack : AppColor.iconColor, size: 24))
                          ])
                        ]))
                  ]))));
    });
  }
}
