import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/tractor_screen_controller.dart';
import 'package:le_vech/Widgets/app_conts.dart';
import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/utils/firebase_get.dart';

class TractorScreen extends StatefulWidget {
  const TractorScreen({Key? key}) : super(key: key);

  @override
  State<TractorScreen> createState() => _TractorScreenState();
}

class _TractorScreenState extends State<TractorScreen> {
  TractorScreenController tractorController = Get.put(TractorScreenController());

  @override
  void initState() {
    setState(() {});
    tractorController.sellTractor(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Obx(() {
          return tractorController.isLodingData.value
              ? const CircularProgressIndicator()
              : tractorController.allSellTractor.isNotEmpty
                  ? GridView.builder(
                      itemCount: tractorController.allSellTractor.length,
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
  TractorScreenController tractorController = Get.put(TractorScreenController());
  List favTractorTempList = [];
  @override
  void initState() {
    favTractorTempList = tractorController.favTractorList[widget.index];
    print(favTractorTempList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeVechProfile(detail: tractorController.allSellTractor[widget.index])));
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
                                image: NetworkImage(tractorController.allSellTractor[widget.index]["item_img"][0].toString().isNotEmpty
                                    ? tractorController.allSellTractor[widget.index]["item_img"][0].toString()
                                    : "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                fit: BoxFit.cover,
                              ),
                            ))),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(tractorController.allSellTractor[widget.index]["item_type"],
                              overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                                child: Text(tractorController.allSellTractor[widget.index]["price"],
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.price, fontSize: 16, fontWeight: FontWeight.w700))),
                            InkWell(
                                onTap: () {
                                  if (favTractorTempList.contains(userId)) {
                                    favTractorTempList.remove(userId);
                                  } else {
                                    favTractorTempList.add(userId);
                                  }
                                  updateData('advertise', tractorController.allSellTractor[widget.index].id, {'fav_user': favTractorTempList});
                                  setState(() {});
                                },
                                child: Icon(favTractorTempList.contains(userId) ? Icons.favorite:Icons.favorite_border ,
                                    color: favTractorTempList.contains(userId)  ?  AppColor.iconColor:AppColor.primarycolorblack , size: 24))
                          ])
                        ]))
                  ]))));
    });
  }
}
