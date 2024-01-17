import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';

class KhetPedashController extends GetxController {
  // RxBool isIcon = true.obs;
  RxBool isLodingKhetPedash = false.obs;
  RxList<QueryDocumentSnapshot> allSellkhetPedash = <QueryDocumentSnapshot>[].obs;
  // RxBool isLoader = false.obs;
  List favHorseList = [];

  sellkhetPedash(BuildContext context) async {
    try {
      isLodingKhetPedash.value = true;
      allSellkhetPedash.value = await firebaseGetwhere("advertise", "item_type", "ખેત પેદાશ લે - વેચ");

      if (allSellkhetPedash.isNotEmpty) {
        for(int i=0;i<allSellkhetPedash.length;i++){
          favHorseList.add(allSellkhetPedash[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingKhetPedash.value = false;
    } on Exception catch (e) {
      isLodingKhetPedash.value = false;
      print(e);
    }
  }
}
