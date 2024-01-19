import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class FruitsVegetablesController extends GetxController {
 // RxBool isIcon = true.obs;
  RxBool isLodingFruitsVegetables = false.obs;
  RxList<QueryDocumentSnapshot> sellAllFruitsVegetables = <QueryDocumentSnapshot>[].obs;
  List favFruitsVegetablesList = [];

  sellFruitsVegetables(BuildContext context) async {
    try {
      isLodingFruitsVegetables.value = true;
      sellAllFruitsVegetables.value = await firebaseGetwhere("advertise", "item_type", "ફળ શાકભાજી લે-વેચ");
      if (sellAllFruitsVegetables.isNotEmpty) {
        for (int i = 0; i < sellAllFruitsVegetables.length; i++) {
          favFruitsVegetablesList.add(sellAllFruitsVegetables[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingFruitsVegetables.value = false;
    } on Exception catch (e) {
      isLodingFruitsVegetables.value = false;
      print(e);
    }
  }
}
