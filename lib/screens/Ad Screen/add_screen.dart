import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:le_vech/widgets.dart/app_bar.dart';
import 'package:le_vech/widgets.dart/app_button.dart';
import 'package:le_vech/widgets.dart/app_textfieled.dart';
import 'package:le_vech/widgets.dart/drop_down.dart';
import 'package:le_vech/widgets.dart/image_const.dart';


import 'package:le_vech/widgets.dart/color_const.dart';
import 'package:le_vech/widgets.dart/image_const.dart';
import 'package:le_vech/widgets.dart/string_const.dart';


class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({Key? key}) : super(key: key);

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

String leVech = "LeVech";

class _AddItemsScreenState extends State<AddItemsScreen> {
  List<String> imageList = [AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(isLogo: false, height: 130, width: double.infinity, info: AppString.addItem),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        AppString.addPhoto,
                        style: TextStyle(color: Color(0xff000000), fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.add_circle_outline,
                        size: 28,
                        color: AppColor.themecolor,
                      ),
                    ],
                  ),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(height: 190, autoPlay: true, autoPlayInterval: Duration(seconds: 2), aspectRatio: 16 / 9, viewportFraction: 1),
                items: imageList.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(image: AssetImage(i), fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                AppString.sellingItem,
                style: TextStyle(color: AppColor.primarycolorblack, fontWeight: FontWeight.w400, fontSize: 18),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  children: [
                    DropDown(items: [AppString.tractor, AppString.cow, AppString.horse, AppString.twoWheel, AppString.fourWheel, AppString.others], dropdownvalue: 'Item 1', onTap: (String value) {}),
                    SizedBox(height: 10),
                    AppTextField(
                      txtValue: AppString.price,
                      keytype: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    Text(
                      AppString.sellingInfo,
                      style: TextStyle(color: AppColor.primarycolorblack, fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    AppTextField(txtValue: AppString.infoSend, isIcon: false, maxLines: 4, counterTxt: "", preIcon: false),
                    SizedBox(height: 20),
                    Text(
                      AppString.sellingplace,
                      style: TextStyle(color: AppColor.primarycolorblack, fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    AppTextField(
                      txtValue: AppString.guj,
                      readOnly: true,
                    ),
                    SizedBox(height: 10),
                    DropDown(items: [
                      'Item 1',
                      'Item 2',
                      'Item 3',
                      'Item 4',
                      'Item 5',
                    ], dropdownvalue: 'Item 1', onTap: (String value) {}),
                    SizedBox(height: 10),
                    DropDown(items: [
                      'Item 1',
                      'Item 2',
                      'Item 3',
                      'Item 4',
                      'Item 5',
                    ], dropdownvalue: 'Item 1', onTap: (String value) {}),
                    SizedBox(height: 10),
                    DropDown(items: [
                      'Item 1',
                      'Item 2',
                      'Item 3',
                      'Item 4',
                      'Item 5',
                    ], dropdownvalue: 'Item 1', onTap: (String value) {}),
                    SizedBox(height: 10),
                    AppTextField(
                      txtValue: AppString.mobileNo,
                      keytype: TextInputType.number,
                      lableValue: AppString.mobileNo,
                      maxLength: 10,
                      counterTxt: '',
                    ),
                    SizedBox(height: 10),
                    AppTextField(txtValue: AppString.add, isIcon: false, lableValue: AppString.add, maxLines: 4, counterTxt: "", preIcon: false),
                    SizedBox(height: 20),
                    AppButton(height: 60, width: double.infinity, buttontxt: AppString.send)
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
