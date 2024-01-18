import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/electronic_controller.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/laptop_tv_computer_controller.dart';
import 'package:le_vech/Widgets/app_conts.dart';
import 'package:le_vech/Widgets/app_text.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';
import 'package:le_vech/utils/firebase_get.dart';

class LaptopTVComputerItemScreen extends StatefulWidget {
  const LaptopTVComputerItemScreen({Key? key}) : super(key: key);

  @override
  State<LaptopTVComputerItemScreen> createState() => _LaptopTVComputerItemScreenState();
}

class _LaptopTVComputerItemScreenState extends State<LaptopTVComputerItemScreen> {
  LaptopTVComputerController laptopTVComputerController = Get.put(LaptopTVComputerController());

  @override
  void initState() {
    setState(() {});
    laptopTVComputerController.sellLaptopTVComputer(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Obx(() {
          return laptopTVComputerController.isLodingLaptoptv.value
              ? const CircularProgressIndicator()
              : laptopTVComputerController.allSellLeptopTvComputer.isNotEmpty
                  ? GridView.builder(
                      itemCount: laptopTVComputerController.allSellLeptopTvComputer.length,
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
  LaptopTVComputerController laptopTVComputerController = Get.put(LaptopTVComputerController());
  List favLodingLaptoptvTempList = [];

  @override
  void initState() {
    favLodingLaptoptvTempList = laptopTVComputerController.favLodingLaptoptvList[widget.index];
    //  print(favTractorTempList);
    super.initState();
  }

  @override
  void dispose() {
    favLodingLaptoptvTempList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeVechProfile(detail: laptopTVComputerController.allSellLeptopTvComputer[widget.index])));
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
                              image: DecorationImage(image: NetworkImage(laptopTVComputerController.allSellLeptopTvComputer[widget.index]["item_img"][0].toString().isNotEmpty
                                  ? laptopTVComputerController.allSellLeptopTvComputer[widget.index]["item_img"][0].toString()
                                  : "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),fit: BoxFit.cover),
                            ))),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          AppText(text: laptopTVComputerController.allSellLeptopTvComputer[widget.index]["name"],txtColor: AppColor.primarycolorblack,size: 16,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis),
                          /*Text(twoWheelController.allSellTwoWheel[widget.index]["item_type"],
                              overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600)),*/
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                                child: Text(laptopTVComputerController.allSellLeptopTvComputer[widget.index]["price"],
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.price, fontSize: 16, fontWeight: FontWeight.w700))),
                            InkWell(
                                onTap: () {
                                  if (favLodingLaptoptvTempList.contains(userId)) {
                                    favLodingLaptoptvTempList.remove(userId);
                                  } else {
                                    favLodingLaptoptvTempList.add(userId);
                                  }
                                  updateData('advertise', laptopTVComputerController.allSellLeptopTvComputer[widget.index].id, {'fav_user': favLodingLaptoptvTempList});
                                  setState(() {});
                                },
                                child: Icon(favLodingLaptoptvTempList.contains(userId) ? Icons.favorite : Icons.favorite_border,
                                    color: favLodingLaptoptvTempList.contains(userId) ? AppColor.iconColor : AppColor.primarycolorblack, size: 24))
                          ])
                        ])),
                    const SizedBox(height: 5),
                    AppText(text: laptopTVComputerController.allSellLeptopTvComputer[widget.index]["item_type"],txtColor: AppColor.grey700,size: 13),
                  ]))));
    });
  }
}
