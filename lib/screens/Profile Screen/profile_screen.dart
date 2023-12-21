import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/app_button.dart';
import 'package:le_vech/Widgets/app_textfieled.dart';
import 'package:le_vech/Widgets/drop_down.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';
import 'package:le_vech/utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<QueryDocumentSnapshot> listOfDistrict = <QueryDocumentSnapshot>[];
  List<QueryDocumentSnapshot> listOfTaluka = <QueryDocumentSnapshot>[];
  List<QueryDocumentSnapshot> listOfVillage = <QueryDocumentSnapshot>[];
  List<QueryDocumentSnapshot> profileData = <QueryDocumentSnapshot>[];

  TextEditingController disController = TextEditingController();
  TextEditingController eMailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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
  bool isFirst = true;
  String mo = '';
  File selectedProfile = File("");
  late SharedPreferences prefs;
  String profileUrl = '';
  bool isLoader = false;

  @override
  void initState() {
    getMobileNumber();
    getDis();
    super.initState();
  }

  getProfileData() async {
    var store = await FirebaseFirestore.instance.collection("le-vech_config").doc('developer').collection("users").where("mobile_number", isEqualTo: mo).get();
    setState(() {
      profileData = store.docs;
    });
    if (profileData.isNotEmpty) {
      profileUrl = profileData[0]['image'];
      nameController.text = profileData[0]['name'];
      surnameController.text = profileData[0]['surname'];
      mobileController.text = profileData[0]["mobile_number"];
      addressController.text = profileData[0]['address'];
    }
  }

  getMobileNumber() async {
    prefs = await SharedPreferences.getInstance();
    mo = prefs.getString("mobile_number").toString();
    getProfileData();
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

  void selectImageFromGallery() async {
    final pickedFile = await ImageHelper.pickImageFromGallery(context: context, cropStyle: CropStyle.rectangle, title: 'Profile Image');
    if (pickedFile != null) {
      setState(() {
        selectedProfile = pickedFile;
      });
    } else {}
  }

  void selectImageFromCamera(context) async {
    final pickedFile = await ImageHelper.pickImageFromCamera(context: context, cropStyle: CropStyle.rectangle, title: 'Profile Image');
    if (pickedFile != null) {
      setState(() {
        selectedProfile = pickedFile;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
      AppBarWidget(height: 130, width: double.infinity, isLogo: false, info: AppString.noteAddText),
      const SizedBox(height: 10),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                onTap: () {
                  selectImage();
                },
                child: Stack(
                  children: [
                    Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(color: AppColor.primarycolor, border: Border.all(color: AppColor.themecolor, width: 2), borderRadius: BorderRadius.circular(80)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: selectedProfile.path.isEmpty
                                ? profileUrl != ''
                                    ? Image(
                                        image: NetworkImage(profileUrl),
                                        fit: BoxFit.cover,
                                      )
                                    : Image(image: AssetImage('assets/images/logops.jpg'))
                                : Image.file(selectedProfile, fit: BoxFit.cover))),
                    Positioned(
                        bottom: 0,
                        right: 10,
                        child: CircleAvatar(
                            backgroundColor: AppColor.themecolor,
                            radius: 14,
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColor.primarycolor,
                              size: 16,
                            )))
                  ],
                )),
            SizedBox(height: 20),
            AppTextField(txtValue: AppString.name, controller: nameController),
            const SizedBox(height: 10),
            AppTextField(txtValue: AppString.surName, controller: surnameController),
            const SizedBox(height: 10),
            AppTextField(txtValue: AppString.mobileNo, keytype: TextInputType.number, controller: mobileController, maxLength: 10, counterTxt: ''),
            const SizedBox(height: 10),
            AppTextField(txtValue: AppString.guj, readOnly: true),
            const SizedBox(height: 10),
            districSelect != ''
                ? DropDown(
                    items: districList,
                    dropdownvalue: districSelect,
                    onTap: (String value) {
                      setState(() {
                        districSelect = value;
                        districSelectId = districListId[districList.indexOf(districSelect)];
                        isFirst = false;
                        getTaluka();
                      });
                    })
                : SizedBox(),
            const SizedBox(height: 10),
            talukaSelect != ''
                ? DropDown(
                    items: talukaList,
                    dropdownvalue: talukaSelect,
                    onTap: (String value) {
                      setState(() {
                        talukaSelect = value;
                        talukaSelectId = talukaListId[talukaList.indexOf(talukaSelect)];
                        getVillage();
                      });
                    },
                  )
                : SizedBox(),
            const SizedBox(height: 10),
            villageSelect != ''
                ? DropDown(
                    items: villageList,
                    dropdownvalue: villageSelect,
                    onTap: (String value) {
                      setState(() {
                        villageSelect = value;
                        villageSelectId = villageListId[villageList.indexOf(villageSelect)];
                      });
                    })
                : SizedBox(),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            AppTextField(txtValue: AppString.add, maxLines: 4, controller: addressController),
            const SizedBox(height: 20),
            AppButton(
                height: 54,
                width: double.infinity,
                buttontxt: AppString.update,
                onTap: () {
                  updateProfile(profileData[0].id);
                },
                isLoad: isLoader)
          ]))
    ]))));
  }

  void updateProfile(String id) async {
    try {
      setState(() {
        isLoader = true;
      });
      updateData('users', id, {
        'image': profileUrl,
        'name': nameController.text,
        'surname': surnameController.text,
        'mobile_number': mobileController.text,
        'district': districSelect,
        'taluka': talukaSelect,
        'village': villageSelect,
        'address': addressController.text
      });
      succesSnackBar(context, AppString.updateProfile);
      Navigator.pop(context);
      setState(() {
        isLoader = false;
      });
    } catch (e) {
      setState(() {
        isLoader = false;
      });
    }
  }

  void selectImage() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: SizedBox(
                  child: Wrap(children: [
            ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  selectImageFromGallery();
                  Navigator.of(context).pop();
                }),
            ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  selectImageFromCamera(context);
                  Navigator.of(context).pop();
                })
          ])));
        });
  }
}

class ImageHelper {
  static Future<File?> pickImageFromGallery({
    required BuildContext context,
    required CropStyle cropStyle,
    required String title,
  }) async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    var file = File(pickedFile!.path);
    return file;
  }

  static Future<File?> pickImageFromCamera({
    required BuildContext context,
    required CropStyle cropStyle,
    required String title,
  }) async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    var file = File(pickedFile!.path);
    return file;
  }
}
