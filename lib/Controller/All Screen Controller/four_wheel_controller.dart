import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';

class FourWheelController extends GetxController {
  RxBool isIcon = true.obs;
  RxBool isLodingData = false.obs;
  RxList<QueryDocumentSnapshot> allSellFourWheel = <QueryDocumentSnapshot>[].obs;
  List favCarList = [];

  sellFourWheel(BuildContext context) async {
    try {
      isLodingData.value = true;
      allSellFourWheel.value = await firebaseGetwhere("advertise", "item_type", AppString.fourWheel);

      if (allSellFourWheel.isNotEmpty) {
        for(int i=0;i<allSellFourWheel.length;i++){
          favCarList.add(allSellFourWheel[i]['fav_user']);
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
