import 'package:flutter/material.dart';
import 'package:le_vech/screens/Cow%20Screen/cow_screen.dart';
import 'package:le_vech/screens/Fourwheel%20Screen/four_wheel.dart';
import 'package:le_vech/screens/Horse%20Screen/horse_screen.dart';
import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';
import 'package:le_vech/screens/Twowheel%20Screen/two_wheel.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';

import '../Other Screen/other_screen.dart';

class TractorScreen extends StatefulWidget {
  String itemName;

  TractorScreen({Key? key, required this.itemName}) : super(key: key);

  @override
  State<TractorScreen> createState() => _TractorScreenState();
}

class _TractorScreenState extends State<TractorScreen> {
  List<String> imageList = [AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];
  List itemName = [AppString.tractor, AppString.cow, AppString.horse, AppString.twoWheel, AppString.fourWheel, AppString.others];
  String selectedItem = AppString.tractor;

  @override
  void initState() {
    setState(() {
      selectedItem = widget.itemName;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.txtfilled,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(
                height: 130,
                width: double.infinity,
                isLogo: false,
                info: selectedItem,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 130,
                child: ListView.builder(
                    itemCount: imageList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedItem = itemName[index];
                          });
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: selectedItem == itemName[index] ? AppColor.themecolor : AppColor.primarycolor, width: 3), color: AppColor.primarycolor),
                            child: Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                  child: Container(
                                    height: 70,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(image: AssetImage(imageList[index]), fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    itemName[index],
                                    style: TextStyle(color: AppColor.primarycolorblack, fontSize: 14, fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              selectedItem == AppString.cow
                  ? CowScreen()
                  : selectedItem == AppString.horse
                      ? HorseScreen()
                      : selectedItem == AppString.twoWheel
                          ? TwoWheel()
                          : selectedItem == AppString.fourWheel
                              ? FourWheel()
                              : selectedItem == AppString.others
                                  ? OtherScreen()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                      child: GridView.builder(
                                          itemCount: 5,
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4.8 / 5.8, crossAxisSpacing: 2, mainAxisSpacing: 2),
                                          itemBuilder: (context, index) {
                                            return itemWidget(
                                              index: index,
                                            );
                                          }),
                                    )
            ],
          ),
        ),
      ),
    );
  }
}

class itemWidget extends StatefulWidget {
  int index;

  itemWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<itemWidget> createState() => _itemWidgetState();
}

class _itemWidgetState extends State<itemWidget> {
  bool isIcon = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LeVechProfile(),
        ));
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.primarycolor),
          child: Column(
            children: [
              SizedBox(
                height: 08,
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                child: Container(
                  height: 100,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(image: AssetImage(AppImage.tractorEicher), fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.tractorName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "₹2,40,000",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: AppColor.price, fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isIcon = !isIcon;
                            });
                          },
                          child: Icon(
                            isIcon ? Icons.favorite_border : Icons.favorite,
                            color: isIcon ? AppColor.primarycolorblack : AppColor.iconColor,
                            size: 24,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
