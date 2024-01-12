import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/cow_screen_controller.dart';
import 'package:le_vech/Widgets/app_conts.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/utils/firebase_get.dart';

class CowScreen extends StatefulWidget {
  const CowScreen({Key? key}) : super(key: key);

  @override
  State<CowScreen> createState() => _CowScreenState();
}

class _CowScreenState extends State<CowScreen> {
  CowScreenController cowController = Get.put(CowScreenController());

  @override
  void initState() {
    setState(() {});
    cowController.sellCow(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Obx(() {
          return cowController.isLodingData.value
              ? const CircularProgressIndicator()
              : cowController.allSellCow.isNotEmpty
                  ? GridView.builder(
                      itemCount: cowController.allSellCow.length,
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
  CowScreenController cowController = Get.put(CowScreenController());
  List favCowTempList = [];

  @override
  void initState() {
    favCowTempList = cowController.favCowList[widget.index];
    // print(favCowTempList);
    super.initState();
  }

  @override
  void dispose() {
    favCowTempList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeVechProfile(detail: cowController.allSellCow[widget.index])));
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
                              image: DecorationImage(image: NetworkImage(cowController.allSellCow[widget.index]["item_img"][0].toString().isNotEmpty
                                  ? cowController.allSellCow[widget.index]["item_img"][0].toString()
                                  : "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),fit: BoxFit.cover),
                            ))),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(cowController.allSellCow[widget.index]["item_type"],
                              overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                                child: Text(cowController.allSellCow[widget.index]["price"],
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.price, fontSize: 16, fontWeight: FontWeight.w700))),
                            InkWell(
                                onTap: () {
                                  if (favCowTempList.contains(userId)) {
                                    favCowTempList.remove(userId);
                                  } else {
                                    favCowTempList.add(userId);
                                  }
                                  updateData('advertise', cowController.allSellCow[widget.index].id, {'fav_user': favCowTempList});
                                  setState(() {});
                                },
                                child: Icon(favCowTempList.contains(userId) ? Icons.favorite : Icons.favorite_border,
                                    color: favCowTempList.contains(userId) ? AppColor.iconColor : AppColor.primarycolorblack, size: 24))
                          ])
                        ]))
                  ]))));
    });
  }
}
