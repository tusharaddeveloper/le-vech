import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:le_vech/screens/Home%20Screen/home_screen.dart';
import 'package:le_vech/utils/firebase_get.dart';
import 'package:le_vech/utils/snackbar.dart';
import 'package:le_vech/widgets.dart/app_bar.dart';
import 'package:le_vech/widgets.dart/app_button.dart';
import 'package:le_vech/widgets.dart/app_textfieled.dart';
import 'package:le_vech/widgets.dart/drop_down.dart';

import 'package:le_vech/widgets.dart/string_const.dart';

class NotedScreen extends StatefulWidget {
  String Mobile;

  NotedScreen({Key? key, required this.Mobile}) : super(key: key);

  @override
  State<NotedScreen> createState() => _NotedScreenState();
}

class _NotedScreenState extends State<NotedScreen> {
  List<QueryDocumentSnapshot> listOfDistrict = <QueryDocumentSnapshot>[];
  List<QueryDocumentSnapshot> listOfTaluka = <QueryDocumentSnapshot>[];
  List<QueryDocumentSnapshot> listOfVillage = <QueryDocumentSnapshot>[];

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController eMailController = TextEditingController();

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
 @override
  void initState() {
    mobileController.text = widget.Mobile;
    getDis();
    super.initState();
  }

  void setData() async {
    try {
      if (nameController.text.isEmpty) {
        errorSnackBar(context, AppString.pleaseName);
      } else if (surnameController.text.isEmpty) {
        errorSnackBar(context, AppString.pleaseSurName);
      } else if (eMailController.text.isEmpty) {
        errorSnackBar(context, AppString.pleaseEMail);
      } else if (addressController.text.isEmpty) {
        errorSnackBar(context, AppString.pleaseAdd);
      } else {
        storeData('users', {
          'name': nameController.text,
          'surname': surnameController.text,
          'mobile_number': mobileController.text,
          'email': eMailController.text,
          'district': districSelect,
          'taluka': talukaSelect,
          'village': villageSelect,
          'address': addressController.text,
        });
        await Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } catch (e) {
      print(e);
      // TODO
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(
              height: 130,
              width: double.infinity,
              isLogo: false,
              info: AppString.noteText,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                    children: [
                      AppTextField(
                        txtValue: AppString.name,
                        controller: nameController,
                        isIcon: false,
                        preIcon: false,
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        txtValue: AppString.surName,
                        controller: surnameController,
                        isIcon: false,
                        preIcon: false, /*lableValue: AppString.surName*/
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        txtValue: AppString.mobileNo,
                        controller: mobileController,
                        preIcon: true,
                        keytype: TextInputType.number,
                        //lableValue: AppString.mobileNo,
                        maxLength: 10,
                        counterTxt: '',
                        readOnly: true,
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: eMailController,
                        txtValue: AppString.eMail,
                        isIcon: false,
                        preIcon: true,
                        preIconData: Icons.email,
                        //lableValue: AppString.eMail,
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        txtValue: AppString.guj,
                        readOnly: true,
                      ),
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
                        },
                      ),
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
                        },
                      ),
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
                      AppTextField(
                          txtValue: AppString.add,
                          controller: addressController,
                          isIcon: false,
                          /*lableValue: AppString.add*/
                          maxLines: 4,
                          preIcon: false),
                      const SizedBox(height: 20),
                      AppButton(
                        height: 60,
                        width: double.infinity,
                        buttontxt: AppString.noteText,
                        onTap: () {
                          setData();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
