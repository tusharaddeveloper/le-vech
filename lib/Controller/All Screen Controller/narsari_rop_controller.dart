import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class NarsariRopController extends GetxController {
  //RxBool isIcon = true.obs;
  RxBool isLodingNarsariRop = false.obs;
  RxList<QueryDocumentSnapshot> sellNarsariRop = <QueryDocumentSnapshot>[].obs;
  List favNarsariRopList = [];

  sellAllBhangar(BuildContext context) async {
    try {
      isLodingNarsariRop.value = true;
      sellNarsariRop.value = await firebaseGetwhere("advertise", "item_type", "નર્સરી રોપ લે-વેચ");
      if (sellNarsariRop.isNotEmpty) {
        for (int i = 0; i < sellNarsariRop.length; i++) {
          favNarsariRopList.add(sellNarsariRop[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingNarsariRop.value = false;
    } on Exception catch (e) {
      isLodingNarsariRop.value = false;
      print(e);
    }
  }
}
