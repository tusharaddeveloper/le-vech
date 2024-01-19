import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/bhangar_controller.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/sheep_goat_controller.dart';
import 'package:le_vech/Widgets/app_conts.dart';
import 'package:le_vech/Widgets/app_text.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';
import 'package:le_vech/utils/firebase_get.dart';

class SheepGoatScreen extends StatefulWidget {
  const SheepGoatScreen({Key? key}) : super(key: key);

  @override
  State<SheepGoatScreen> createState() => _SheepGoatScreenState();
}

class _SheepGoatScreenState extends State<SheepGoatScreen> {
  SheepGoatController sheepGoatController = Get.put(SheepGoatController());

  @override
  void initState() {
    setState(() {});
    sheepGoatController.sellAllSheepGoat(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Obx(() {
          return sheepGoatController.isLodingSheepGoat.value
              ? const CircularProgressIndicator()
              : sheepGoatController.sellSheepGoat.isNotEmpty
                  ? GridView.builder(
                      itemCount: sheepGoatController.sellSheepGoat.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4.8 / 5.8, crossAxisSpacing: 2, mainAxisSpacing: 2),
                      itemBuilder: (context, index) {
                        return ItemWidget(index: index);
                      })
                  : Container(
                      height: 400,
                      alignment: Alignment.center,
                    child: AppText(text: "કોઈ જાહેરાત નથી મળી.",txtColor: AppColor.iconColor,size: 22,fontWeight: FontWeight.w500,txtAlign: TextAlign.center));
          ;
        }));
  }
}

class ItemWidget extends StatefulWidget {
  int index;
  ItemWidget({Key? key,required this.index}) : super(key: key);
  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  SheepGoatController sheepGoatController = Get.put(SheepGoatController());
  List favSheepGoatTempList = [];

  @override
  void initState() {
    favSheepGoatTempList = sheepGoatController.favSheepGoatList[widget.index];
    //  print(favTractorTempList);
    super.initState();
  }

  @override
  void dispose() {
    favSheepGoatTempList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeVechProfile(detail: sheepGoatController.sellSheepGoat[widget.index])));
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
                              image: DecorationImage(image: NetworkImage(sheepGoatController.sellSheepGoat[widget.index]["item_img"][0].toString().isNotEmpty
                                  ? sheepGoatController.sellSheepGoat[widget.index]["item_img"][0].toString()
                                  : "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),fit: BoxFit.cover),
                            ))),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          AppText(text: sheepGoatController.sellSheepGoat[widget.index]["name"],txtColor: AppColor.primarycolorblack,size: 16,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis),
                          /*Text(twoWheelController.allSellTwoWheel[widget.index]["item_type"],
                              overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600)),*/
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                                child: Text(sheepGoatController.sellSheepGoat[widget.index]["price"],
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.price, fontSize: 16, fontWeight: FontWeight.w700))),
                            InkWell(
                                onTap: () {
                                  if (favSheepGoatTempList.contains(userId)) {
                                    favSheepGoatTempList.remove(userId);
                                  } else {
                                    favSheepGoatTempList.add(userId);
                                  }
                                  updateData('advertise', sheepGoatController.sellSheepGoat[widget.index].id, {'fav_user': favSheepGoatTempList});
                                  setState(() {});
                                },
                                child: Icon(favSheepGoatTempList.contains(userId) ? Icons.favorite : Icons.favorite_border,
                                    color: favSheepGoatTempList.contains(userId) ? AppColor.iconColor : AppColor.primarycolorblack, size: 24))
                          ])
                        ])),
                    const SizedBox(height: 5),
                    AppText(text: sheepGoatController.sellSheepGoat[widget.index]["item_type"],txtColor: AppColor.grey700,size: 13),
                  ]))));
    });
  }
}
