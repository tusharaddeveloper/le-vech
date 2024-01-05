import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/All%20Screen%20Controller/two_wheel_controller.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';

class TwoWheel extends StatefulWidget {
  const TwoWheel({Key? key}) : super(key: key);

  @override
  State<TwoWheel> createState() => _TwoWheelState();
}

class _TwoWheelState extends State<TwoWheel> {
  TwoWheelController twoWheelController = Get.put(TwoWheelController());

  @override
  void initState() {
    setState(() {});
    twoWheelController.sellTwoWheel(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Obx(() {
          return twoWheelController.isLodingData.value
              ? CircularProgressIndicator()
              : GridView.builder(
                  itemCount: twoWheelController.allSellTwoWheel.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4.8 / 5.8, crossAxisSpacing: 2, mainAxisSpacing: 2),
                  itemBuilder: (context, index) {
                    return ItemWidget(index: index);
                  });
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
  TwoWheelController twoWheelController = Get.put(TwoWheelController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeVechProfile(detail: twoWheelController.allSellTwoWheel[widget.index])));
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
                            height: 100, width: 140, decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), image: DecorationImage(image: AssetImage(AppImage.bike), fit: BoxFit.cover)))),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(twoWheelController.allSellTwoWheel[widget.index]["item_type"],
                              overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                                child: Text(twoWheelController.allSellTwoWheel[widget.index]["price"],
                                    overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.price, fontSize: 16, fontWeight: FontWeight.w700))),
                            InkWell(
                                onTap: () {
                                  twoWheelController.isIcon.value = !twoWheelController.isIcon.value;
                                },
                                child: Icon(twoWheelController.isIcon.value ? Icons.favorite_border : Icons.favorite,
                                    color: twoWheelController.isIcon.value ? AppColor.primarycolorblack : AppColor.iconColor, size: 24))
                          ])
                        ]))
                  ]))));
    });
  }
}
