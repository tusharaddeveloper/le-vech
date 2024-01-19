import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class SheepGoatController extends GetxController {
  //RxBool isIcon = true.obs;
  RxBool isLodingSheepGoat = false.obs;
  RxList<QueryDocumentSnapshot> sellSheepGoat = <QueryDocumentSnapshot>[].obs;
  List favSheepGoatList = [];

  sellAllSheepGoat(BuildContext context) async {
    try {
      isLodingSheepGoat.value = true;
      sellSheepGoat.value = await firebaseGetwhere("advertise", "item_type","ઘેટાં બકરાં લે-વેચ");
      if (sellSheepGoat.isNotEmpty) {
        for (int i = 0; i < sellSheepGoat.length; i++) {
          favSheepGoatList.add(sellSheepGoat[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingSheepGoat.value = false;
    } on Exception catch (e) {
      isLodingSheepGoat.value = false;
      print(e);
    }
  }
}
