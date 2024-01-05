import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';

class FourWheelController extends GetxController {
  RxBool isIcon = true.obs;
  RxBool isLodingData = false.obs;
  RxList<QueryDocumentSnapshot> allSellFourWheel = <QueryDocumentSnapshot>[].obs;
  RxBool isLoader = false.obs;

  sellFourWheel(BuildContext context) async {
    try {
      isLodingData.value = true;
      allSellFourWheel.value = await firebaseGetwhere("advertise", "item_type", AppString.fourWheel);

      if (allSellFourWheel.isNotEmpty) {
        print("object GET Tractorgggggggggggggggggggggggggggggfgfg");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Data Found")));
      }

      isLodingData.value = false;
    } on Exception catch (e) {
      isLodingData.value = false;
      print(e);
    }
  }
}
