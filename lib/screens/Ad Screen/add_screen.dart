import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  const AddItemsScreen({Key? key}) : super(key: key);

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
    getDis();
    mobileNo();
    super.initState();
  }

  void getDis() async {
    districList.clear();
    districListId.clear();
    districSelect = '';
    districSelectId = '';
    try {
      listOfDistrict = await firebaseGet('district');
    } catch (e) {
      print(e);
    }
    for (int i = 0; i < listOfDistrict.length; i++) {
      districList.add(listOfDistrict[i]["district_name"]);
      districListId.add(listOfDistrict[i].id);
    }
    districSelect = districList.first;
    districSelectId = districListId.first;
    setState(() {});
    getTaluka();
  }

  void getTaluka() async {
    talukaList.clear();
    talukaListId.clear();
    talukaSelect = '';
    talukaSelectId = '';

    // var storeData = await FirebaseFirestore.instance.collection("taluka").where("district_id", isEqualTo: districSelectId).get();
    listOfTaluka = await firebaseGetwhere('taluka', 'district_id', districSelectId);

    for (int i = 0; i < listOfTaluka.length; i++) {
      talukaList.add(listOfTaluka[i]["taluka_name"]);
      talukaListId.add(listOfTaluka[i].id);
    }
    talukaSelect = talukaList.first;
    talukaSelectId = talukaListId.first;
    setState(() {});
    getVillage();
  }

  void getVillage() async {
    villageList.clear();
    villageListId.clear();
    villageSelect = '';
    villageSelectId = '';
    //  var storeData = await FirebaseFirestore.instance.collection("village").where("taluka_id", isEqualTo: talukaSelectId).get();
    listOfVillage = await firebaseGetwhere('village', 'taluka_id', talukaSelectId);

    for (int i = 0; i < listOfVillage.length; i++) {
      villageList.add(listOfVillage[i]["village_name"]);
      villageListId.add(listOfVillage[i].id);
    }
    villageSelect = villageList.first;
    villageSelectId = villageListId.first;
    setState(() {});
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
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("AppString.nothingSelected")));
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

    storeDataDocs('advertise', mo,{
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
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("data add")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
      AppBarWidget(isLogo: false, height: 130, width: double.infinity, info: AppString.addItem),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: InkWell(
          onTap: () {
            getImages();
          },
          child: Row(
            children: [
              Text(AppString.addPhoto, style: const TextStyle(color: Color(0xff000000), fontSize: 20, fontWeight: FontWeight.w500)),
              const SizedBox(width: 8),
              Icon(Icons.add_circle_outline, size: 28, color: AppColor.themecolor),
            ],
          ),
        ),
      ),
      CarouselSlider(
        options: CarouselOptions(height: 190, autoPlay: true, autoPlayInterval: const Duration(seconds: 2), aspectRatio: 16 / 9, viewportFraction: 1),
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
      const SizedBox(height: 20),
      Text(AppString.sellingItem, style: TextStyle(color: AppColor.primarycolorblack, fontWeight: FontWeight.w400, fontSize: 18)),
      const SizedBox(height: 20),
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
            const SizedBox(height: 10),
            AppTextField(controller: nameController, txtValue: AppString.name, ),
             const SizedBox(height: 20),
            AppTextField(controller: priceController, txtValue: AppString.price, keytype: TextInputType.number),
            const SizedBox(height: 20),
            Text(AppString.sellingInfo, style: TextStyle(color: AppColor.primarycolorblack, fontWeight: FontWeight.w400, fontSize: 18)),
            const SizedBox(height: 20),
            AppTextField(controller: detailsController, txtValue: AppString.infoSend,maxLines: 4, counterTxt: ""),
            const SizedBox(height: 20),
            Text(AppString.sellingplace, style: TextStyle(color: AppColor.primarycolorblack, fontWeight: FontWeight.w400, fontSize: 18)),
            const SizedBox(height: 20),
            AppTextField(txtValue: AppString.guj, readOnly: true),
            const SizedBox(height: 10),
            DropDown(
                items: districList,
                dropdownvalue: districSelect,
                onTap: (String value) {
                  setState(() {
                    districSelect = value;
                    districSelectId = districListId[districList.indexOf(districSelect)];
                    isFirst = false;
                    getTaluka();
                  });
                }),
            const SizedBox(height: 10),
            DropDown(
                items: talukaList,
                dropdownvalue: talukaSelect,
                onTap: (String value) {
                  setState(() {
                    talukaSelect = value;
                    talukaSelectId = talukaListId[talukaList.indexOf(talukaSelect)];
                    getVillage();
                  });
                }),
            const SizedBox(height: 10),
            DropDown(
                items: villageList,
                dropdownvalue: villageSelect,
                onTap: (String value) {
                  setState(() {
                    villageSelect = value;
                    villageSelectId = villageListId[villageList.indexOf(villageSelect)];
                  });
                }),
            const SizedBox(height: 10),
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
