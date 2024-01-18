import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class MobileController extends GetxController {
 // RxBool isIcon = true.obs;
  RxBool isLodingmobile = false.obs;
  RxList<QueryDocumentSnapshot> sellAllMobile = <QueryDocumentSnapshot>[].obs;
  List favMobileList = [];

  sellMobile(BuildContext context) async {
    try {
      isLodingmobile.value = true;
      sellAllMobile.value = await firebaseGetwhere("advertise", "item_type", "મોબાઇલ લે-વેચ");
      if (sellAllMobile.isNotEmpty) {
        for (int i = 0; i < sellAllMobile.length; i++) {
          favMobileList.add(sellAllMobile[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingmobile.value = false;
    } on Exception catch (e) {
      isLodingmobile.value = false;
      print(e);
    }
  }
}
