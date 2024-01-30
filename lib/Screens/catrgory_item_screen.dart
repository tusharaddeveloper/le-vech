import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/category_item_controller.dart';
import 'package:le_vech/Screens/Profile%20Screen/le_vech_profile.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/app_conts.dart';
import 'package:le_vech/Widgets/app_text.dart';
import 'package:le_vech/Widgets/app_textfieled.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';

class CatrgoryItemScreen extends StatefulWidget {
  CatrgoryItemScreen({super.key, this.selectedindex});

  int? selectedindex;

  @override
  State<CatrgoryItemScreen> createState() => _CatrgoryItemScreenState();
}

class _CatrgoryItemScreenState extends State<CatrgoryItemScreen> {
  CatrgoryItemController catrgoryItemController = Get.put(CatrgoryItemController());

  @override
  void initState() {

    catrgoryItemController.controllerGreedView.addListener(() {
     // print("Daaaaa");
     // print(catrgoryItemController.controllerGreedView.positions);
      double maxScroll=catrgoryItemController.controllerGreedView.position.maxScrollExtent;
      double currentScroll=catrgoryItemController.controllerGreedView.position.pixels;
      double delta=MediaQuery.of(context).size.height*0.25;
      if(maxScroll-currentScroll < delta){
        if (widget.selectedindex == 0) {
          catrgoryItemController.getMoreActivityData();
        } else {
          catrgoryItemController.getLoadMoreData(catrgoryItemController.itemName[widget.selectedindex!]);
          print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
        }
      }

    });



    Future.delayed(Duration(milliseconds: 1), () {
      catrgoryItemController.runData(context,widget.selectedindex!);
    });
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Obx(() {
        return Column(
          children: [
            AppBarWidget(height: 130, width: double.infinity, isLogo: false, info: catrgoryItemController.itemName[widget.selectedindex!]),
            SizedBox(
                height: 132,
                child: ListView.builder(
                    controller: catrgoryItemController.controller,
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
            Padding(padding: const EdgeInsets.symmetric(horizontal: 8,vertical:10), child: AppTextField(txtValue: AppString.searchBar, prefixIcon: Icons.search)),
            catrgoryItemController.isLodingData.value
                ? const Padding(
                padding: EdgeInsets.only(top: 200.0),
                child: CircularProgressIndicator(),
                  )
                : catrgoryItemController.allSellCow.isNotEmpty
                    ? Expanded(
                        child: GridView.builder(
                          controller: catrgoryItemController.controllerGreedView,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemCount: catrgoryItemController.allSellCow.length,
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4.8 / 5.8, crossAxisSpacing: 2, mainAxisSpacing: 2),
                            itemBuilder: (context, index) {
                              return ItemName( indexofItem: index,itemIndex: widget.selectedindex,);
                            }),
                      )
                    : Expanded(
                      child: Container(

                          alignment: Alignment.center,
                          child: AppText(text: "કોઈ જાહેરાત નથી મળી.", txtColor: AppColor.iconColor, size: 22, fontWeight: FontWeight.w500, txtAlign: TextAlign.center)),
                    )
          ],
        );
      })),
    );
  }
}
class ItemName extends StatefulWidget {
   ItemName({super.key, required this.indexofItem,this.itemIndex});
   int indexofItem;
   int? itemIndex;
   @override
    State<ItemName> createState() => _ItemNameState();
}

class _ItemNameState extends State<ItemName> {
  CatrgoryItemController catrgoryItemController = Get.put(CatrgoryItemController());
  @override
  void initState() {
    favListCatrgoryItemTemp = catrgoryItemController.favCategoryItemList[widget.indexofItem];
    super.initState();
  }
  List favListCatrgoryItemTemp = [];
  @override
  void dispose() {
    favListCatrgoryItemTemp.clear();

   // catrgoryItemController.gettingMoreProduct.value=false;
   // catrgoryItemController.moreProductAvailable.value=true;
   // catrgoryItemController.allSellCow.clear();
   // catrgoryItemController.startAfterDocument=null;

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeVechProfile(detail: catrgoryItemController.allSellCow[widget.indexofItem])));
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
                      child:
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CachedNetworkImage(
                            height: 100,
                            width: 140,

                            imageUrl: catrgoryItemController.allSellCow[widget.indexofItem]["item_img"][0],
                            placeholder: (context, url) => Image(image: AssetImage(catrgoryItemController.imageList[widget.itemIndex!]),fit: BoxFit.cover,),
                            errorWidget: (context, url, error) => Image(image: AssetImage(catrgoryItemController.imageList[widget.itemIndex!]),fit: BoxFit.cover),
                            fit: BoxFit.cover),
                      )


                  ),
                  const SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        AppText(
                            text: catrgoryItemController.allSellCow[widget.indexofItem]["name"],
                            txtColor: AppColor.primarycolorblack,
                            size: 16,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 10),
                        Row(children: [

                          Expanded(
                              child: AppText(
                                  text: "₹ ${catrgoryItemController.allSellCow[widget.indexofItem]["price"]}",
                                  txtColor: AppColor.primarycolorblack,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                  size: 16)),
                          InkWell(
                              onTap: () {
                                if (favListCatrgoryItemTemp.contains(userId)) {
                                  favListCatrgoryItemTemp.remove(userId);
                                } else {
                                  favListCatrgoryItemTemp.add(userId);
                                }
                                updateData('advertise', catrgoryItemController.allSellCow[widget.indexofItem].id, {'fav_user': favListCatrgoryItemTemp});
                                setState(() {});
                              },
                              child: Icon(favListCatrgoryItemTemp.contains(userId) ? Icons.favorite : Icons.favorite_border,
                                  color: favListCatrgoryItemTemp.contains(userId) ? AppColor.iconColor : AppColor.primarycolorblack, size: 24))
                        ])
                      ])),
                  const SizedBox(height: 5),
                  AppText(text: catrgoryItemController.allSellCow[widget.indexofItem]["item_type"], txtColor: AppColor.grey700, size: 13),
                ]))));
  }
}

