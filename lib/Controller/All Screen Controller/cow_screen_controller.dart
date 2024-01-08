import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';

class CowScreenController extends GetxController {
  RxBool isIcon = true.obs;
  RxBool isLodingData = false.obs;
  RxList<QueryDocumentSnapshot> allSellCow = <QueryDocumentSnapshot>[].obs;
  List favCowList = [];

  sellCow(BuildContext context) async {
    try {
      isLodingData.value = true;
      allSellCow.value = await firebaseGetwhere("advertise", "item_type", AppString.cow);

      if (allSellCow.isNotEmpty) {

        for(int i=0;i<allSellCow.length;i++){
          favCowList.add(allSellCow[i]['fav_user']);

        }
      } else {
        print("No Data Found");
      }

      isLodingData.value = false;
    } on Exception catch (e) {
      isLodingData.value = false;
      print(e);
    }
  }
}
