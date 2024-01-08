import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';

class HorseScreenController extends GetxController {
 // RxBool isIcon = true.obs;
  RxBool isLodingData = false.obs;
  RxList<QueryDocumentSnapshot> allSellHorse = <QueryDocumentSnapshot>[].obs;
 // RxBool isLoader = false.obs;
  List favHorseList = [];

  sellHorse(BuildContext context) async {
    try {
      isLodingData.value = true;
      allSellHorse.value = await firebaseGetwhere("advertise", "item_type", AppString.horse);

      if (allSellHorse.isNotEmpty) {
        for(int i=0;i<allSellHorse.length;i++){
          favHorseList.add(allSellHorse[i]['fav_user']);
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
