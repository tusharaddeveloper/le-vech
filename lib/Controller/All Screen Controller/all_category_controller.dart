import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/Auth%20Controller/noted_controller.dart';
import 'package:le_vech/Controller/Profile%20Controller/profile_controller.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';

class AllCategoryController extends GetxController {
  ProfileController profileController = Get.put(ProfileController());
  NotedController notedController = Get.put(NotedController());

  RxBool isIcon = true.obs;
  RxBool isLodingData = false.obs;
  RxString selectedItem=''.obs;

  List<String> imageList = [AppImage.allCategory, AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car, AppImage.imglogo];
  List itemName = [AppString.allInfo, AppString.tractor, AppString.cow, AppString.horse, AppString.twoWheel, AppString.fourWheel, AppString.others];
  List favList = [];
  RxList<QueryDocumentSnapshot> profileData = <QueryDocumentSnapshot>[].obs;
 // RxBool isLoader = false.obs;

  getAllads(BuildContext context) async {
    try {
      isLodingData.value = true;
      profileData.value = await firebaseGet('advertise');
      if (profileData.isNotEmpty) {
        for(int i=0;i<profileData.length;i++){
          favList.add(profileData[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }
      isLodingData.value = false;
      print(favList);

    } on Exception catch (e) {
      isLodingData.value = false;
      print(e);
    }
  }


}
