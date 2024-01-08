import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';

class TractorScreenController extends GetxController {
 // RxBool isIcon = true.obs;
  RxBool isLodingData = false.obs;
  RxList<QueryDocumentSnapshot> allSellTractor = <QueryDocumentSnapshot>[].obs;
 // RxBool isLoader = false.obs;
  List favTractorList = [];

  sellTractor(BuildContext context) async {
    try {
      isLodingData.value = true;
      allSellTractor.value = await firebaseGetwhere("advertise", "item_type", AppString.tractor);

      if (allSellTractor.isNotEmpty) {
        for(int i=0;i<allSellTractor.length;i++){
          favTractorList.add(allSellTractor[i]['fav_user']);
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
