import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:le_vech/Controller/Auth%20Controller/noted_controller.dart';
import 'package:le_vech/Controller/Profile%20Controller/profile_controller.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:le_vech/utils/firebase_get.dart';
import 'package:le_vech/utils/storage_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddController extends GetxController {
  NotedController notedController = Get.put(NotedController());
  ProfileController profileController = Get.put(ProfileController());

  TextEditingController addNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController addMobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  List<String> tempImg = [];

  //RxBool isLoading = false.obs;
  final picker = ImagePicker();

  // RxList<File> selectedImages = [File('')].obs;
  List<File> selectedImages = [];
  String selectItem = AppString.tractor;

  // RxBool isFirst = true.obs;
  late SharedPreferences prefs;
  RxString mo = ''.obs;

  // List<String> imageList = [AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];
  // List<String> productPhotos = [];

  // Image Picker
  Future getImages(BuildContext context) async {
    selectedImages.clear();
    final pickedFile = await picker.pickMultiImage(imageQuality: 100, maxHeight: 1920, maxWidth: 1080);
    List<XFile> xfilePick = pickedFile;
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("AppString.nothingSelected")));
    }
  }

  // MobileNo. get in SharedPreferences

  /*void mobileNo() async {
    prefs = await SharedPreferences.getInstance();
    mo.value = prefs.getString("mobile_number").toString();
  }*/

// Setdata in firebase
  setItemData(BuildContext context) async {
    try {
      //isUpdateLoding.value=true;

      FirebaseStorage firebasestorage = FirebaseStorage.instance;
      if (selectedImages.isNotEmpty) {
        try {
          for (int i = 0; i < selectedImages.length; i++) {
            StorageProvider storageProvider = StorageProvider(firebaseStorage: firebasestorage);
            tempImg.add(selectedImages[i].path);
            await storageProvider.uploadUserProfile(image: selectedImages[i]);
          }
        } catch (e) {
          print(e);
        }
      }

      /*for (int i = 0; i < selectedImages.length; i++) {
        tempImg.add(selectedImages[i].path);
      }
      FirebaseStorage firebasestorage = FirebaseStorage.instance;
      if (selectedImages.isNotEmpty) {
        try {
          StorageProvider storageProvider = StorageProvider(firebaseStorage: firebasestorage);
          tempImg = await storageProvider.uploadUserProfile(image: tempImg);
        } catch (e) {
          print(e);
        }
      }*/

      storeDataDocs('advertise', profileController.mo!, {
        'item_img': tempImg,
        'name': addNameController.text,
        'item_type': selectItem,
        'price': priceController.text,
        'detail': detailsController.text,
        'district': notedController.districSelect.value,
        'taluka': notedController.talukaSelect.value,
        'village': notedController.villageSelect.value,
        'mobile_number': addMobileController.text,
        'address': addressController.text
      });
      selectedImages.clear();
      tempImg.clear();

    } catch (e) {
      // isLoading.value = false;
    }

   // Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("data  jaherat")));
  }
}
