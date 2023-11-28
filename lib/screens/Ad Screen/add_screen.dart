import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:le_vech/utils/firebase_get.dart';
import 'package:le_vech/utils/snackbar.dart';
import 'package:le_vech/widgets.dart/app_bar.dart';
import 'package:le_vech/widgets.dart/app_button.dart';
import 'package:le_vech/widgets.dart/app_textfieled.dart';
import 'package:le_vech/widgets.dart/drop_down.dart';
import 'package:le_vech/widgets.dart/image_const.dart';
import 'package:image_picker/image_picker.dart';

import 'package:le_vech/widgets.dart/color_const.dart';
import 'package:le_vech/widgets.dart/string_const.dart';

class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({Key? key}) : super(key: key);

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

String leVech = "LeVech";

class _AddItemsScreenState extends State<AddItemsScreen> {
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
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
  List<String> imageList = [
    AppImage.tractorEicher,
    AppImage.cow,
    AppImage.horse,
    AppImage.bike,
    AppImage.car,
    AppImage.imglogo
  ];

  @override
  void initState() {
    getDis();
    super.initState();
  }

  void getDis() async {
    districList.clear();
    districListId.clear();
    districSelect = '';
    districSelectId = '';
    try {
      var storeData =
          await FirebaseFirestore.instance.collection("district").get();
      listOfDistrict = storeData.docs;
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

    var storeData = await FirebaseFirestore.instance
        .collection("taluka")
        .where("district_id", isEqualTo: districSelectId)
        .get();
    listOfTaluka = storeData.docs;

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
    var storeData = await FirebaseFirestore.instance
        .collection("village")
        .where("taluka_id", isEqualTo: talukaSelectId)
        .get();
    listOfVillage = storeData.docs;

    for (int i = 0; i < listOfVillage.length; i++) {
      villageList.add(listOfVillage[i]["village_name"]);
      villageListId.add(listOfVillage[i].id);
    }
    villageSelect = villageList.first;
    villageSelectId = villageListId.first;
    setState(() {});
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    setState(
      () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }

          //    getUrl();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("AppString.nothingSelected")));
        }
      },
    );
  }

  setItemData() async {
    setState(() {
      isLoading = true;
    });
    List<String> tempImg=[];
    for(int i=0;i<selectedImages.length;i++){
      tempImg.add(selectedImages[i].path);
    }
    storeData('advertise', {
      'item_img': tempImg,
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
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(
                  isLogo: false,
                  height: 130,
                  width: double.infinity,
                  info: AppString.addItem),
              SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: InkWell(
                  onTap: () {
                    getImages();
                  },
                  child: Row(
                    children: [
                      Text(
                        AppString.addPhoto,
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
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
                options: CarouselOptions(
                    height: 190,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    aspectRatio: 16 / 9,
                    viewportFraction: 1),
                items: selectedImages.isEmpty
                    ? imageList.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    height: 190,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                          image: AssetImage(i),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }).toList()
                    : selectedImages.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    height: 190,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Image.file(i, fit: BoxFit.cover),
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
                style: TextStyle(
                    color: AppColor.primarycolorblack,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    DropDown(
                        items: [
                          AppString.tractor,
                          AppString.cow,
                          AppString.horse,
                          AppString.twoWheel,
                          AppString.fourWheel,
                          AppString.others
                        ],
                        dropdownvalue: selectItem,
                        onTap: (String value) {
                          setState(() {
                            selectItem = value;
                          });
                        }),
                    SizedBox(height: 10),
                    AppTextField(
                      controller: priceController,
                      txtValue: AppString.price,
                      keytype: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    Text(
                      AppString.sellingInfo,
                      style: TextStyle(
                          color: AppColor.primarycolorblack,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    AppTextField(
                        controller: detailsController,
                        txtValue: AppString.infoSend,
                        isIcon: false,
                        maxLines: 4,
                        counterTxt: "",
                        preIcon: false),
                    SizedBox(height: 20),
                    Text(
                      AppString.sellingplace,
                      style: TextStyle(
                          color: AppColor.primarycolorblack,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    AppTextField(
                      txtValue: AppString.guj,
                      readOnly: true,
                    ),
                    SizedBox(height: 10),
                    DropDown(
                      items: districList,
                      dropdownvalue: districSelect,
                      onTap: (String value) {
                        setState(() {
                          districSelect = value;
                          districSelectId =
                              districListId[districList.indexOf(districSelect)];
                          isFirst = false;
                          getTaluka();
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    DropDown(
                      items: talukaList,
                      dropdownvalue: talukaSelect,
                      onTap: (String value) {
                        setState(() {
                          talukaSelect = value;
                          talukaSelectId =
                              talukaListId[talukaList.indexOf(talukaSelect)];
                          getVillage();
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    DropDown(
                        items: villageList,
                        dropdownvalue: villageSelect,
                        onTap: (String value) {
                          setState(() {
                            villageSelect = value;
                            villageSelectId = villageListId[
                                villageList.indexOf(villageSelect)];
                          });
                        }),
                    SizedBox(height: 10),
                    AppTextField(
                      controller: mobileController,
                      txtValue: AppString.mobileNo,
                      keytype: TextInputType.number,
                      lableValue: AppString.mobileNo,
                      maxLength: 10,
                      counterTxt: '',
                    ),
                    SizedBox(height: 10),
                    AppTextField(
                        controller: addressController,
                        txtValue: AppString.add,
                        isIcon: false,
                        lableValue: AppString.add,
                        maxLines: 4,
                        counterTxt: "",
                        preIcon: false),
                    SizedBox(height: 20),
                    AppButton(
                      height: 60,
                      width: double.infinity,
                      isLoad: isLoading,
                      buttontxt: AppString.send,
                      onTap: () {
                        if (imageList.isEmpty) {
                          errorSnackBar(context,"PLEASE SELECT IMAGE");
                        } else if (selectItem.isEmpty) {
                          errorSnackBar(context,"PLEASE SELECT ITEM");

                        }else if (priceController.text.isEmpty) {
                          errorSnackBar(context,"PLEASE ENTER PRICE");
                        }else if (detailsController.text.isEmpty) {
                          errorSnackBar(context,"PLEASE ENTER DETAILS");
                        }else if (talukaSelect.isEmpty) {
                          errorSnackBar(context,"PLEASE SELECT TALUKA");
                        }else if (villageSelect.isEmpty) {
                          errorSnackBar(context,"PLEASE SELECT VILLAGE");
                        }else if (mobileController.text.isEmpty) {
                          errorSnackBar(context,"PLEASE ENTER MOBILE NO");
                        }else if (addressController.text.isEmpty) {
                          errorSnackBar(context,"PLEASE ENTER ADDRESS");
                        }

                        setItemData();
                      },
                    )
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
