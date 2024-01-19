import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/fruits_vegetables_controller.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/job_controller.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/mobile_controller.dart';
import 'package:le_vech/Widgets/app_conts.dart';
import 'package:le_vech/Widgets/app_text.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';
import 'package:le_vech/utils/firebase_get.dart';

class FruitsVegetablesScreen extends StatefulWidget {
  const FruitsVegetablesScreen({Key? key}) : super(key: key);

  @override
  State<FruitsVegetablesScreen> createState() => _FruitsVegetablesScreenState();
}

class _FruitsVegetablesScreenState extends State<FruitsVegetablesScreen> {
  FruitsVegetablesController fruitsVegetablesController = Get.put(FruitsVegetablesController());

  @override
  void initState() {
    setState(() {});
    fruitsVegetablesController.sellFruitsVegetables(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Obx(() {
          return fruitsVegetablesController.isLodingFruitsVegetables.value
              ? const CircularProgressIndicator()
              : fruitsVegetablesController.sellAllFruitsVegetables.isNotEmpty
                  ? GridView.builder(
                      itemCount: fruitsVegetablesController.sellAllFruitsVegetables.length,
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
  FruitsVegetablesController fruitsVegetablesController = Get.put(FruitsVegetablesController());
  List favFruitsVegetableTempList = [];

  @override
  void initState() {
    favFruitsVegetableTempList = fruitsVegetablesController.favFruitsVegetablesList[widget.index];
    //  print(favTractorTempList);
    super.initState();
  }

  @override
  void dispose() {
    favFruitsVegetableTempList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeVechProfile(detail: fruitsVegetablesController.sellAllFruitsVegetables[widget.index])));
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
                              image: DecorationImage(image: NetworkImage(fruitsVegetablesController.sellAllFruitsVegetables[widget.index]["item_img"][0].toString().isNotEmpty
                                  ? fruitsVegetablesController.sellAllFruitsVegetables[widget.index]["item_img"][0].toString()
                                  : "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),fit: BoxFit.cover),
                            ))),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          AppText(text: fruitsVegetablesController.sellAllFruitsVegetables[widget.index]["name"],txtColor: AppColor.primarycolorblack,size: 16,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis),
                          /*Text(twoWheelController.allSellTwoWheel[widget.index]["item_type"],
                              overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600)),*/
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                                child: Text(fruitsVegetablesController.sellAllFruitsVegetables[widget.index]["price"],
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.price, fontSize: 16, fontWeight: FontWeight.w700))),
                            InkWell(
                                onTap: () {
                                  if (favFruitsVegetableTempList.contains(userId)) {
                                    favFruitsVegetableTempList.remove(userId);
                                  } else {
                                    favFruitsVegetableTempList.add(userId);
                                  }
                                  updateData('advertise', fruitsVegetablesController.sellAllFruitsVegetables[widget.index].id, {'fav_user': favFruitsVegetableTempList});
                                  setState(() {});
                                },
                                child: Icon(favFruitsVegetableTempList.contains(userId) ? Icons.favorite : Icons.favorite_border,
                                    color: favFruitsVegetableTempList.contains(userId) ? AppColor.iconColor : AppColor.primarycolorblack, size: 24))
                          ])
                        ])),
                    const SizedBox(height: 5),
                    AppText(text: fruitsVegetablesController.sellAllFruitsVegetables[widget.index]["item_type"],txtColor: AppColor.grey700,size: 13),
                  ]))));
    });
  }
}
