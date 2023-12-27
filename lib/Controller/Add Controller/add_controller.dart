import 'package:get/get.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:le_vech/utils/firebase_get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddController extends GetxController {
  Rx<TextEditingController> priceController = TextEditingController().obs;
  Rx<TextEditingController> detailsController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> mobileController = TextEditingController().obs;

  RxBool isLoading = false.obs;
  final picker = ImagePicker();
  RxList<File> selectedImages = [File('')].obs;


  String selectItem = AppString.tractor;
  RxBool isFirst = true.obs;
  late SharedPreferences prefs;
  RxString mo = ''.obs;
  List<String> imageList = [AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];

  // Image Picker
  Future getImages(BuildContext context) async {
    final pickedFile = await picker.pickMultiImage(imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }
      //    getUrl();
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
     List<String> tempImg = [];
    for (int i = 0; i < selectedImages.length; i++) {
      tempImg.add(selectedImages[i].path);
    }

    storeDataDocs('advertise', mo.value, {
      'item_img': tempImg,
      'item_type': selectItem,
      'price': priceController.value.text,
      'detail': detailsController.value.text,
      'mobile_number': mobileController.value.text,
    });
    isLoading.value = false;
    //Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("data add")));
  }
}
