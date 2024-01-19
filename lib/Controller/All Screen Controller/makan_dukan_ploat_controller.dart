import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class MakanDukanPloatController extends GetxController {

  RxBool isLodingMakanDukan = false.obs;
  RxList<QueryDocumentSnapshot> getAllMakanDukan = <QueryDocumentSnapshot>[].obs;
  List favMakanDukanList = [];

  getMakanDukan(BuildContext context) async {
    try {
      isLodingMakanDukan.value = true;
      getAllMakanDukan.value = await firebaseGetwhere("advertise", "item_type", "મકાન દુકાન પ્લોટ જમીન લે-વેચ");
      if (getAllMakanDukan.isNotEmpty) {
        for (int i = 0; i < getAllMakanDukan.length; i++) {
          favMakanDukanList.add(getAllMakanDukan[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingMakanDukan.value = false;
    } on Exception catch (e) {
      isLodingMakanDukan.value = false;
      print(e);
    }
  }
}
