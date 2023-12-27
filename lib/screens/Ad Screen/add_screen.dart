import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/Auth%20Controller/noted_controller.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/app_button.dart';
import 'package:le_vech/Widgets/app_textfieled.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/drop_down.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';
import 'package:le_vech/utils/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddItemsScreen extends StatefulWidget {
  AddItemsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

String leVech = "LeVech";

class _AddItemsScreenState extends State<AddItemsScreen> {
  NotedController notedController = Get.put(NotedController());

  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  final picker = ImagePicker();
  List<File> selectedImages = [];

  List<QueryDocumentSnapshot> listOfDistrict = <QueryDocumentSnapshot>[];
  List<QueryDocumentSnapshot> listOfTaluka = <QueryDocumentSnapshot>[];
  List<QueryDocumentSnapshot> listOfVillage = <QueryDocumentSnapshot>[];
  List<String> districList = [];
  List<String> districListId = [];
  String districSelect = '';
  String districSelectId = '';
  List<String> talukaList = [''];
  List<String> talukaListId = [];
  String talukaSelect = '';
  String talukaSelectId = '';
  List<String> villageList = [''];
  List<String> villageListId = [];
  String villageSelect = '';
  String villageSelectId = '';
  String selectItem = AppString.tractor;
  bool isFirst = true;
  late SharedPreferences prefs;
  String mo = '';
  List<String> imageList = [AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];

  @override
  void initState() {
    notedController.getDis();
    mobileNo();
    super.initState();
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    setState(
      () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }
          //    getUrl();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("AppString.nothingSelected")));
        }
      },
    );
  }

  void mobileNo() async {
    prefs = await SharedPreferences.getInstance();
    mo = prefs.getString("mobile_number").toString();
  }

  setItemData() async {
    setState(() {
      isLoading = true;
    });
    List<String> tempImg = [];
    for (int i = 0; i < selectedImages.length; i++) {
      tempImg.add(selectedImages[i].path);
    }

    storeDataDocs('advertise', mo, {
      'item_img': tempImg,
      'name': nameController.text,
      'item_type': selectItem,
      'price': priceController.text,
      'detail': detailsController.text,
      'district': districSelect,
      'taluka': talukaSelect,
      'village': villageSelect,
      'mobile_number': mobileController.text,
      'address': addressController.text
    });
    setState(() {
      isLoading = false;
    });
    //Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("data add")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
      AppBarWidget(isLogo: false, height: 130, width: double.infinity, info: AppString.addItem),
      SizedBox(height: 10),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: InkWell(
              onTap: () {
                getImages();
              },
              child: Row(children: [
                Text(AppString.addPhoto, style: TextStyle(color: Color(0xff000000), fontSize: 20, fontWeight: FontWeight.w500)),
                SizedBox(width: 8),
                Icon(Icons.add_circle_outline, size: 28, color: AppColor.themecolor)
              ]))),
      CarouselSlider(
        options: CarouselOptions(height: 190, autoPlay: true, autoPlayInterval: Duration(seconds: 2), aspectRatio: 16 / 9, viewportFraction: 1),
        items: selectedImages.isEmpty
            ? imageList.map((i) {
                return Builder(builder: (BuildContext context) {
                  return Column(children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                            height: 190, width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), image: DecorationImage(image: AssetImage(i), fit: BoxFit.cover))))
                  ]);
                });
              }).toList()
            : selectedImages.map((i) {
                return Builder(builder: (BuildContext context) {
                  return Column(children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(height: 190, width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)), child: Image.file(i, fit: BoxFit.cover)))
                  ]);
                });
              }).toList(),
      ),
      SizedBox(height: 20),
      Text(AppString.sellingItem, style: TextStyle(color: AppColor.primarycolorblack, fontWeight: FontWeight.w400, fontSize: 18)),
      SizedBox(height: 20),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(children: [
            DropDown(
                items: [AppString.tractor, AppString.cow, AppString.horse, AppString.twoWheel, AppString.fourWheel, AppString.others],
                dropdownvalue: selectItem,
                onTap: (String value) {
                  setState(() {
                    selectItem = value;
                  });
                }),
            SizedBox(height: 10),
            AppTextField(controller: nameController, txtValue: AppString.name),
            SizedBox(height: 20),
            AppTextField(controller: priceController, txtValue: AppString.price, keytype: TextInputType.number),
            SizedBox(height: 20),
            Text(AppString.sellingInfo, style: TextStyle(color: AppColor.primarycolorblack, fontWeight: FontWeight.w400, fontSize: 18)),
            SizedBox(height: 20),
            AppTextField(controller: detailsController, txtValue: AppString.infoSend, maxLines: 4, counterTxt: ""),
            SizedBox(height: 20),
            Text(AppString.sellingplace, style: TextStyle(color: AppColor.primarycolorblack, fontWeight: FontWeight.w400, fontSize: 18)),
            SizedBox(height: 20),
            AppTextField(txtValue: AppString.guj, readOnly: true),
            SizedBox(height: 10),
            DropDown(
                items: notedController.districList.value,
                dropdownvalue: notedController.districSelect.value,
                onTap: (String value) {
                  setState(() {
                    notedController.districSelect.value = value;
                    notedController.districSelectId.value = notedController.districListId[notedController.districList.indexOf(notedController.districSelect.value)];
                    notedController.isFirst.value = false;
                    notedController.getTaluka();
                  });
                }),
            SizedBox(height: 10),
            DropDown(
                items: notedController.talukaList,
                dropdownvalue: notedController.talukaSelect.value,
                onTap: (String value) {
                  setState(() {
                    notedController.talukaSelect.value = value;
                    notedController.talukaSelectId.value = notedController.talukaListId[notedController.talukaList.indexOf(notedController.talukaSelect.value)];
                    notedController.getVillage();
                  });
                }),
            SizedBox(height: 10),
            DropDown(
                items: notedController.villageList,
                dropdownvalue: notedController.villageSelect.value,
                onTap: (String value) {
                  setState(() {
                    notedController.villageSelect.value = value;
                    notedController.villageSelectId.value = notedController.villageListId[notedController.villageList.indexOf(notedController.villageSelect.value)];
                  });
                }),
            SizedBox(height: 10),
            AppTextField(controller: mobileController, txtValue: AppString.mobileNo, keytype: TextInputType.number, lableValue: AppString.mobileNo, counterTxt: '', maxLength: 10),
            SizedBox(height: 10),
            AppTextField(controller: addressController, txtValue: AppString.add, maxLines: 4, counterTxt: ""),
            SizedBox(height: 20),
            AppButton(
                height: 60,
                width: double.infinity,
                isLoad: isLoading,
                buttontxt: AppString.send,
                onTap: () {
                  if (notedController.selectedProfile.value.path.isEmpty) {
                    errorSnackBar(context, AppString.pleaseAddImage);
                  } else if (notedController.nameController.value.text.isEmpty) {
                    errorSnackBar(context, AppString.pleaseName);
                  } else if (priceController.text.isEmpty) {
                    errorSnackBar(context, AppString.pleaseAddprice);
                  } else if (detailsController.text.isEmpty) {
                    errorSnackBar(context, AppString.pleaseAddinfo);
                  } else if (mobileController.text.isEmpty) {
                    errorSnackBar(context, AppString.enterNum);
                  } else if (notedController.addressController.value.text.isEmpty) {
                    errorSnackBar(context, AppString.pleaseAdd);
                  } else {
                    setItemData();
                  }
                })
          ]))
    ]))));
  }
}
