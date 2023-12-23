import 'package:get/get.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:le_vech/Controller/Auth%20Controller/login_controller.dart';
import 'package:le_vech/screens/Home%20Screen/home_screen.dart';
import 'package:le_vech/screens/Profile%20Screen/profile_screen.dart';
import 'package:le_vech/utils/firebase_get.dart';
import 'package:le_vech/utils/storage_provider.dart';

class NotedController extends GetxController {
  LoginController loginController = Get.put(LoginController());

  RxString name = "".obs;
  RxList<QueryDocumentSnapshot> listOfDistrict = <QueryDocumentSnapshot>[].obs;
  RxList<QueryDocumentSnapshot> listOfTaluka = <QueryDocumentSnapshot>[].obs;
  RxList<QueryDocumentSnapshot> listOfVillage = <QueryDocumentSnapshot>[].obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> surnameController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> eMailController = TextEditingController().obs;

  RxList<String> districList = [''].obs;
  RxList<String> districListId = [''].obs;
  RxString districSelect = ''.obs;
  RxString districSelectId = ''.obs;
  RxList<String> talukaList = [''].obs;
  RxList<String> talukaListId = [''].obs;
  RxString talukaSelect = ''.obs;
  RxString talukaSelectId = ''.obs;
  RxList<String> villageList = [''].obs;
  RxList<String> villageListId = [''].obs;
  RxString villageSelect = ''.obs;
  RxString villageSelectId = ''.obs;
  RxBool isFirst = true.obs;
  Rx<File> selectedProfile = File("").obs;
  RxBool isLoading = false.obs;
  RxString profileUrl = ''.obs;

  void setData(BuildContext context, String Mobile) async {
    try {
      isLoading.value = true;
      FirebaseStorage firebasestorage = FirebaseStorage.instance;
      if (selectedProfile.value.path.isNotEmpty) {
        try {
          StorageProvider storageProvider = StorageProvider(firebaseStorage: firebasestorage);
          profileUrl.value = await storageProvider.uploadUserProfile(image: selectedProfile.value);
        } catch (e) {
          print(e);
        }
      }

      storeDataDocs('users', loginController.mobileNoController.value.text, {
        'image': profileUrl.value,
        'name': nameController.value.text,
        'surname': surnameController.value.text,
        'mobile_number': loginController.mobileNoController.value.text,
        'district': districSelect.value,
        'taluka': talukaSelect.value,
        'village': villageSelect.value,
        'address': addressController.value.text
      });
      isLoading.value = false;
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(mobileNo: Mobile)));
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }

  void getDis() async {
    districList.clear();
    districListId.clear();
    districSelect.value = '';
    districSelectId.value = '';
    try {
      listOfDistrict.value = await firebaseGet('district');
    } catch (e) {
      print(e);
    }
    for (int i = 0; i < listOfDistrict.length; i++) {
      districList.add(listOfDistrict[i]["district_name"]);
      districListId.add(listOfDistrict[i].id);
    }
    districSelect.value = districList.first;
    districSelectId.value = districListId.first;
    getTaluka();
  }

  void getTaluka() async {
    talukaList.clear();
    talukaListId.clear();
    talukaSelect.value = '';
    talukaSelectId.value = '';
    listOfTaluka.value = await firebaseGetwhere('taluka', 'district_id', districSelectId.value);
    for (int i = 0; i < listOfTaluka.length; i++) {
      talukaList.add(listOfTaluka[i]["taluka_name"]);
      talukaListId.add(listOfTaluka[i].id);
    }
    talukaSelect.value = talukaList.first;
    talukaSelectId.value = talukaListId.first;
    getVillage();
  }

  void getVillage() async {
    villageList.clear();
    villageListId.clear();
    villageSelect.value = '';
    villageSelectId.value = '';
    listOfVillage.value = await firebaseGetwhere('village', 'taluka_id', talukaSelectId.value);
    for (int i = 0; i < listOfVillage.length; i++) {
      villageList.add(listOfVillage[i]["village_name"]);
      villageListId.add(listOfVillage[i].id);
    }
    villageSelect.value = villageList.first;
    villageSelectId.value = villageListId.first;
  }

  void selectImageFromGallery(BuildContext context) async {
    final pickedFile = await ImageHelper.pickImageFromGallery(context: context, cropStyle: CropStyle.rectangle, title: 'Profile Image');
    if (pickedFile != null) {
      selectedProfile.value = pickedFile;
    }
  }

  void selectImageFromCamera(context) async {
    final pickedFile = await ImageHelper.pickImageFromCamera(context: context, cropStyle: CropStyle.rectangle, title: 'Profile Image');
    if (pickedFile != null) {
      selectedProfile.value = pickedFile;
    }
  }

  void selectImage(BuildContext context) {
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
                  selectImageFromGallery(context);
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
