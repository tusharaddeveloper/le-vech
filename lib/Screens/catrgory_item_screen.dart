import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/catrgory_item_controller.dart';
import 'package:le_vech/Screens/Profile%20Screen/le_vech_profile.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/app_text.dart';
import 'package:le_vech/Widgets/color_const.dart';

class CatrgoryItemScreen extends StatefulWidget {
  CatrgoryItemScreen({super.key, this.selectedindex});

  int? selectedindex;

  @override
  State<CatrgoryItemScreen> createState() => _CatrgoryItemScreenState();
}

class _CatrgoryItemScreenState extends State<CatrgoryItemScreen> {
  CatrgoryItemController catrgoryItemController = Get.put(CatrgoryItemController());
  ScrollController controller = ScrollController();

  @override
  void initState() {
    if (widget.selectedindex == 0) {
      catrgoryItemController.allCategoryItem(context);

        animateToIndex();


    } else {
      catrgoryItemController.categoryItem(context, catrgoryItemController.itemName[widget.selectedindex!]);


        animateToIndex();

    }
    super.initState();
  }

  animateToIndex() {
    if (controller.hasClients) {
      Future.delayed(Duration(milliseconds: 500), () {
        controller.position.jumpTo(widget.selectedindex! * 116);
      });

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return Column(
        children: [
          AppBarWidget(height: 130, width: double.infinity, isLogo: false, info: catrgoryItemController.itemName[widget.selectedindex!]),
          SizedBox(
              height: 132,
              child: ListView.builder(
                  controller: controller,
                  itemCount: catrgoryItemController.imageList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                          widget.selectedindex = index;

                          if (widget.selectedindex == 0) {
                            catrgoryItemController.allCategoryItem(context);
                          } else {
                            catrgoryItemController.categoryItem(context, catrgoryItemController.itemName[widget.selectedindex!]);
                          }
                        },
                        child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: widget.selectedindex == index ? AppColor.themecolor : AppColor.primarycolor, width: 3),
                                    color: AppColor.primarycolor),
                                child: Column(children: [
                                  Container(
                                      height: 70,
                                      width: 80,
                                      decoration:
                                          BoxDecoration(borderRadius: BorderRadius.circular(6), image: DecorationImage(image: AssetImage(catrgoryItemController.imageList[index]), fit: BoxFit.cover))),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AppText(
                                          text: catrgoryItemController.itemName[index], size: 14, fontWeight: FontWeight.w600, txtAlign: TextAlign.center, txtColor: AppColor.primarycolorblack))
                                ]))));
                  })),
          catrgoryItemController.isLodingData.value
              ? const Center(
                  child: Padding(
                  padding: EdgeInsets.only(top: 200.0),
                  child: CircularProgressIndicator(),
                ))
              : catrgoryItemController.allSellCow.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: catrgoryItemController.allSellCow.length,
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4.8 / 5.8, crossAxisSpacing: 2, mainAxisSpacing: 2),
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeVechProfile(detail: catrgoryItemController.allSellCow[index])));
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
                                                        image: NetworkImage(
                                                            /*catrgoryItemController.allSellCow[0]["item_img"][0].toString().isNotEmpty
                                                ?
                                                :*/ /*  catrgoryItemController.allSellCow[0]["item_img"].toString().isNotEmpty?*/ catrgoryItemController
                                                                .allSellCow[index]["item_img"][0]
                                                                .toString() /*:"https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"*/),
                                                        fit: BoxFit.cover),
                                                  ))),
                                          const SizedBox(height: 10),
                                          Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                AppText(
                                                    text: catrgoryItemController.allSellCow[index]["name"],
                                                    txtColor: AppColor.primarycolorblack,
                                                    size: 16,
                                                    fontWeight: FontWeight.w600,
                                                    overflow: TextOverflow.ellipsis),
                                                const SizedBox(height: 10),
                                                Row(children: [
                                                  Expanded(
                                                    child: AppText(
                                                        text: catrgoryItemController.allSellCow[index]["price"],
                                                        txtColor: AppColor.primarycolorblack,
                                                        size: 16,
                                                        fontWeight: FontWeight.w600,
                                                        overflow: TextOverflow.ellipsis),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        /*if (favDogsTempList.contains(userId)) {
                                                  favDogsTempList.remove(userId);
                                                } else {
                                                  favDogsTempList.add(userId);
                                                }
                                                updateData('advertise', dogsController.sellDogs[widget.index].id, {'fav_user': favDogsTempList});
                                                setState(() {});*/
                                                      },
                                                      child: Icon(/*favDogsTempList.contains(userId)*/ Icons.favorite, color: AppColor.iconColor, size: 24))
                                                ])
                                              ])),
                                          const SizedBox(height: 5),
                                          AppText(text: catrgoryItemController.allSellCow[index]["item_type"], txtColor: AppColor.grey700, size: 13),
                                        ]))));
                          }),
                    )
                  : Container(
                      height: 500,
                      alignment: Alignment.center,
                      child: AppText(text: "કોઈ જાહેરાત નથી મળી.", txtColor: AppColor.iconColor, size: 22, fontWeight: FontWeight.w500, txtAlign: TextAlign.center))
        ],
      );
    }));
  }
}
