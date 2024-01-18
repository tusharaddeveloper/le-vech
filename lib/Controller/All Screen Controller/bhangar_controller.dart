import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class BhangarController extends GetxController {
  //RxBool isIcon = true.obs;
  RxBool isLodingBhangar = false.obs;
  RxList<QueryDocumentSnapshot> sellBhangar = <QueryDocumentSnapshot>[].obs;
  List favBhangarList = [];

  sellAllBhangar(BuildContext context) async {
    try {
      isLodingBhangar.value = true;
      sellBhangar.value = await firebaseGetwhere("advertise", "item_type", "ભંગાર લે-વેચ");
      if (sellBhangar.isNotEmpty) {
        for (int i = 0; i < sellBhangar.length; i++) {
          favBhangarList.add(sellBhangar[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingBhangar.value = false;
    } on Exception catch (e) {
      isLodingBhangar.value = false;
      print(e);
    }
  }
}
