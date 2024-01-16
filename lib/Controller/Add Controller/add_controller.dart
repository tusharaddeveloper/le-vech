import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:le_vech/Controller/Auth%20Controller/noted_controller.dart';
import 'package:le_vech/Controller/Profile%20Controller/profile_controller.dart';
import 'package:le_vech/Widgets/app_text.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:le_vech/utils/firebase_get.dart';
import 'package:le_vech/utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddController extends GetxController {
  NotedController notedController = Get.put(NotedController());
  ProfileController profileController = Get.put(ProfileController());

  TextEditingController addNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController addMobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<Uint8List> images = [];
  List<String> imagePath = [];
  List<String> url = [];

  RxBool isItemAddLoader = false.obs;
  final picker = ImagePicker();
  RxList<File> selectedImages = [File('')].obs;
  String selectItem = AppString.tractor;
  RxBool isFirst = true.obs;
  late SharedPreferences prefs;
  List<String> imageList = [AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];

  void getFromGallery(BuildContext context) async {
    final List<XFile> pickedFile = await _picker.pickMultiImage();
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AppText(text: "Images Not Select",size: 14,)));
    }
    if (pickedFile.isNotEmpty) {
      for (var element in pickedFile) {
        images.add(await element.readAsBytes());
      }
    } else {
      print('No image selected..');
    }
  }

  generateId() {
    DateTime now = DateTime.now();
    String key = "${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}${now.millisecond}";
    return key;
  }

// Setdata in firebase
  setItemData(BuildContext context) async {
    isItemAddLoader.value = true;
    try {
      for (int index = 0; index < images.length; index++) {
        try {
          String fName = generateId();
          final destination = 'files/$fName.jpeg';
          final ref = FirebaseStorage.instance.ref(destination).child('file/');
          await ref.putData(images[index], SettableMetadata(contentType: 'image/jpeg'));
          String downloadUrl = await ref.getDownloadURL();
          url.add(downloadUrl);
        } on FirebaseException catch (e) {
          print(e);
        }
      }

     // FirebaseFirestore.instance.collection('le-vech_config').doc('developer').collection('advertise').doc().set({''});

      storeData('advertise',  {
        'item_img': url,
        'name': addNameController.text,
        'item_type': selectItem,
        'price': priceController.text,
        'detail': detailsController.text,
        'district': notedController.districSelect.value,
        'taluka': notedController.talukaSelect.value,
        'village': notedController.villageSelect.value,
        'mobile_number': addMobileController.text,
        'address': addressController.text,
        'login_mo': profileController.mobileController.text,
        'fav_user':[]
      });
    } catch (e) {
      isItemAddLoader.value = false;
    }
    clearData(context);
  }

  void clearData(BuildContext context) {
    images.clear();
    imagePath.clear();
    url.clear();
    selectedImages.clear();
    priceController.clear();
    addNameController.clear();
    detailsController.clear();
    addMobileController.clear();
    addressController.clear();

    isItemAddLoader.value = false;
    Navigator.pop(context);
    succesSnackBar(context, AppString.successfullyAdd);
  }
}
