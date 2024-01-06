import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/four_wheel_controller.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';

class FourWheel extends StatefulWidget {
  const FourWheel({Key? key}) : super(key: key);

  @override
  State<FourWheel> createState() => _FourWheelState();
}

class _FourWheelState extends State<FourWheel> {
  FourWheelController fourWheelController = Get.put(FourWheelController());

  @override
  void initState() {
    setState(() {});
    fourWheelController.sellFourWheel(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Obx(() {
          return fourWheelController.isLodingData.value
              ? const CircularProgressIndicator()
              : fourWheelController.allSellFourWheel.isNotEmpty
                  ? GridView.builder(
                      itemCount: fourWheelController.allSellFourWheel.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4.8 / 5.8, crossAxisSpacing: 2, mainAxisSpacing: 2),
                      itemBuilder: (context, index) {
                        return ItemWidget(index: index);
                      })
                  : Container(
                      height: 400,
                      alignment: Alignment.center,
                      child: Text("કોઈ જાહેરાત નથી મળી.", style: TextStyle(color: AppColor.iconColor, fontSize: 22, fontWeight: FontWeight.w500), textAlign: TextAlign.center));
        }));
  }
}

class ItemWidget extends StatefulWidget {
  int index;

  ItemWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  FourWheelController fourWheelController = Get.put(FourWheelController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeVechProfile(detail: fourWheelController.allSellFourWheel[widget.index])));
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
                            height: 100, width: 140, decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), image: DecorationImage(image: AssetImage(AppImage.car), fit: BoxFit.cover)))),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(fourWheelController.allSellFourWheel[widget.index]["item_type"],
                              overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                                child: Text(fourWheelController.allSellFourWheel[widget.index]["price"],
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.price, fontSize: 16, fontWeight: FontWeight.w700))),
                            InkWell(
                                onTap: () {
                                  fourWheelController.isIcon.value = !fourWheelController.isIcon.value;
                                },
                                child: Icon(fourWheelController.isIcon.value ? Icons.favorite_border : Icons.favorite,
                                    color: fourWheelController.isIcon.value ? AppColor.primarycolorblack : AppColor.iconColor, size: 24))
                          ])
                        ]))
                  ]))));
    });
  }
}
