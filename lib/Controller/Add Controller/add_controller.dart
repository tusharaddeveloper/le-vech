import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:le_vech/Controller/Auth%20Controller/noted_controller.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:le_vech/utils/firebase_get.dart';
import 'package:le_vech/utils/storage_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddController extends GetxController {
  NotedController notedController = Get.put(NotedController());

  TextEditingController addNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController addMobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();


  RxBool isLoading = false.obs;
  final picker = ImagePicker();
  RxList<File> selectedImages = [File('')].obs;
 //  List<File> selectedImages=[];
  String selectItem = AppString.tractor;
  RxBool isFirst = true.obs;
  late SharedPreferences prefs;
  RxString mo = ''.obs;
  List<String> imageList = [AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];
  List<String> productPhotos = [];


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

  void mobileNo() async {
    prefs = await SharedPreferences.getInstance();
    mo.value = prefs.getString("mobile_number").toString();
  }

// Setdata in firebase
  setItemData(BuildContext context) async {
    try {
      //isUpdateLoding.value=true;
     /* FirebaseStorage firebasestorage = FirebaseStorage.instance;
      if (selectedImages.isNotEmpty) {
        try {
          StorageProvider storageProvider = StorageProvider(firebaseStorage: firebasestorage);
          profileUrl.value = await storageProvider.uploadUserProfile(image: selectedProfile.value);
        } catch (e) {
          print(e);
        }
      }*/
    List<String> tempImg = [];
    for (int i = 0; i < selectedImages.length; i++) {
      tempImg.add(selectedImages[i].path);
    }
    storeDataDocs('advertise', mo.value, {
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
    } catch (e) {
      isLoading.value = false;
    }

    Navigator.pop(context);
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("data add")));
  }
}
