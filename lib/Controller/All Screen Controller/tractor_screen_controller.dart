import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';

class TractorScreenController extends GetxController {
  RxBool isIcon = true.obs;
  RxBool isLodingData = false.obs;
  RxList<QueryDocumentSnapshot> allSellTractor = <QueryDocumentSnapshot>[].obs;
  RxBool isLoader = false.obs;

  sellTractor(BuildContext context) async {
    try {
      isLoader.value = true;
      allSellTractor.value = await firebaseGetwhere("advertise", "item_type", AppString.tractor);

      if (allSellTractor.isNotEmpty) {
        print("object GET Tractorgggggggggggggggggggggggggggggfgfg");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Data Found")));
      }

      isLoader.value = false;
    } on Exception catch (e) {
      isLoader.value = false;
      print(e);
    }
  }
}
