import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class KhetiOjarController extends GetxController {

  RxBool isLodingKhetiOjar = false.obs;
  RxList<QueryDocumentSnapshot> sellKhetiOjar = <QueryDocumentSnapshot>[].obs;
  List favKhetiOjarList = [];

  sellAllKhetiOjar(BuildContext context) async {
    try {
      isLodingKhetiOjar.value = true;
      sellKhetiOjar.value = await firebaseGetwhere("advertise", "item_type", "ખેત ઓજાર લે-વેચ");
      if (sellKhetiOjar.isNotEmpty) {
        for (int i = 0; i < sellKhetiOjar.length; i++) {
          favKhetiOjarList.add(sellKhetiOjar[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingKhetiOjar.value = false;
    } on Exception catch (e) {
      isLodingKhetiOjar.value = false;
      print(e);
    }
  }
}
