import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/bhangar_controller.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/sanedo_tractor_controller.dart';
import 'package:le_vech/Widgets/app_conts.dart';
import 'package:le_vech/Widgets/app_text.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';
import 'package:le_vech/utils/firebase_get.dart';

class SanedoTractorScreen extends StatefulWidget {
  const SanedoTractorScreen({Key? key}) : super(key: key);

  @override
  State<SanedoTractorScreen> createState() => _SanedoTractorScreenState();
}

class _SanedoTractorScreenState extends State<SanedoTractorScreen> {
  
  SanedoTractorController sanedoTractorController = Get.put(SanedoTractorController());

  @override
  void initState() {
    setState(() {});
    sanedoTractorController.sellAllSanedoTractor(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Obx(() {
          return sanedoTractorController.isLodingSanedoTractor.value
              ? const CircularProgressIndicator()
              : sanedoTractorController.sellSanedoTractor.isNotEmpty
                  ? GridView.builder(
                      itemCount: sanedoTractorController.sellSanedoTractor.length,
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
  SanedoTractorController sanedoTractorController = Get.put(SanedoTractorController());
  
  List favsanedoTractorTempList = [];
  @override
  void initState() {
    favsanedoTractorTempList = sanedoTractorController.favSanedoTractorList[widget.index];

    super.initState();
  }

  @override
  void dispose() {
    favsanedoTractorTempList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeVechProfile(detail: sanedoTractorController.sellSanedoTractor[widget.index])));
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
                              image: DecorationImage(image: NetworkImage(sanedoTractorController.sellSanedoTractor[widget.index]["item_img"][0].toString().isNotEmpty
                                  ? sanedoTractorController.sellSanedoTractor[widget.index]["item_img"][0].toString()
                                  : "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),fit: BoxFit.cover),
                            ))),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          AppText(text: sanedoTractorController.sellSanedoTractor[widget.index]["name"],txtColor: AppColor.primarycolorblack,size: 16,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis),
                          /*Text(twoWheelController.allSellTwoWheel[widget.index]["item_type"],
                              overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600)),*/
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                                child: Text(sanedoTractorController.sellSanedoTractor[widget.index]["price"],
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.price, fontSize: 16, fontWeight: FontWeight.w700))),
                            InkWell(
                                onTap: () {
                                  if (favsanedoTractorTempList.contains(userId)) {
                                    favsanedoTractorTempList.remove(userId);
                                  } else {
                                    favsanedoTractorTempList.add(userId);
                                  }
                                  updateData('advertise', sanedoTractorController.sellSanedoTractor[widget.index].id, {'fav_user': favsanedoTractorTempList});
                                  setState(() {});
                                },
                                child: Icon(favsanedoTractorTempList.contains(userId) ? Icons.favorite : Icons.favorite_border,
                                    color: favsanedoTractorTempList.contains(userId) ? AppColor.iconColor : AppColor.primarycolorblack, size: 24))
                          ])
                        ])),
                    const SizedBox(height: 5),
                    AppText(text: sanedoTractorController.sellSanedoTractor[widget.index]["item_type"],txtColor: AppColor.grey700,size: 13),
                  ]))));
    });
  }
}
