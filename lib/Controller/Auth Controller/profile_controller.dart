import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:le_vech/Controller/Auth%20Controller/noted_controller.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/screens/Profile%20Screen/profile_screen.dart';
import 'package:le_vech/utils/firebase_get.dart';
import 'package:le_vech/utils/image_helper.dart';
import 'package:le_vech/utils/snackbar.dart';
import 'package:le_vech/utils/storage_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  NotedController notedController = Get.put(NotedController());

  RxList<QueryDocumentSnapshot> listOfDistrict = <QueryDocumentSnapshot>[].obs;
  List<QueryDocumentSnapshot> listOfTaluka = <QueryDocumentSnapshot>[];
  List<QueryDocumentSnapshot> listOfVillage = <QueryDocumentSnapshot>[];
  List<QueryDocumentSnapshot> profileData = <QueryDocumentSnapshot>[];

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RxList districList = [].obs;
  RxList districListId = [].obs;
  RxString districSelect = ''.obs;
  RxString districSelectId = ''.obs;
  RxList<String> talukaList = [''].obs;
  RxList talukaListId = [].obs;
  RxString talukaSelect = ''.obs;
  RxString talukaSelectId = ''.obs;
  RxList<String> villageList = [''].obs;
  RxList villageListId = [].obs;
  RxString villageSelect = ''.obs;
  RxString villageSelectId = ''.obs;
  String? mo;
  RxBool isFirst = true.obs;
  RxBool isUpdateLoding = false.obs;


  Rx<File> selectedProfile = File("").obs;

  late SharedPreferences prefs;
  RxString profileUrl = ''.obs;
  RxBool isLoader = false.obs;

  getProfileData(BuildContext context) async {
     try {
       isLoader.value=true;
       profileData = await firebaseGetwhere("users", "mobile_number", mo!);
       if (profileData.isNotEmpty) {
        profileUrl.value = profileData[0]['image'];
        nameController.text = profileData[0]['name'];
        surnameController.text = profileData[0]['surname'];
        mobileController.text = profileData[0]["mobile_number"];
        addressController.text = profileData[0]['address'];
           }else{
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Data Found")));
       }
       isLoader.value=false;
     } on Exception catch (e) {
       isLoader.value=false;
       print(e);
     }
  }

  getMobileNumber(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    mo = prefs.getString("mobile_number").toString();
    getProfileData(context);
  }



  void selectImageFromGallery(BuildContext context) async {
    final pickedFile = await ImageHelper.pickImageFromGallery(context: context, cropStyle: CropStyle.rectangle, title: 'Profile Image');
    if (pickedFile != null) {
      selectedProfile.value = pickedFile;
    } else {}
  }
  void selectImageFromCamera(BuildContext context) async {
    final pickedFile = await ImageHelper.pickImageFromCamera(context: context, cropStyle: CropStyle.rectangle, title: 'Profile Image');
    if (pickedFile != null) {
      selectedProfile.value = pickedFile;
    } else {}
  }

   updateProfile(BuildContext context, String id) async {
     prefs = await SharedPreferences.getInstance();
     prefs.setString('mobile_number', mobileController.value.text);
    try {
      isUpdateLoding.value=true;
      FirebaseStorage firebasestorage = FirebaseStorage.instance;
      if (selectedProfile.value.path.isNotEmpty) {
        try {
          StorageProvider storageProvider = StorageProvider(firebaseStorage: firebasestorage);
          profileUrl.value = await storageProvider.uploadUserProfile(image: selectedProfile.value);
        } catch (e) {
          print(e);
        }
      }
      updateData('users', id, {
        'image': profileUrl.value,
        'name': nameController.value.text,
        'surname': surnameController.text,
        'mobile_number': mobileController.value.text,
        'district': notedController.districSelect.value,
        'taluka': notedController.talukaSelect.value,
        'village': notedController.villageSelect.value,
        'address': addressController.text
      });
      succesSnackBar(context, AppString.updateProfile);
      Navigator.pop(context);

      isUpdateLoding.value=false;
    } catch (e) {
      isUpdateLoding.value=false;
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
