import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class BirdController extends GetxController {

  RxBool isLodingBirds = false.obs;
  RxList<QueryDocumentSnapshot> sellBirds = <QueryDocumentSnapshot>[].obs;
  List favBirdsList = [];

  sellAllBirds(BuildContext context) async {
    try {
      isLodingBirds.value = true;
      sellBirds.value = await firebaseGetwhere("advertise", "item_type","પક્ષીઓ લે-વેચ");
      if (sellBirds.isNotEmpty) {
        for (int i = 0; i < sellBirds.length; i++) {
          favBirdsList.add(sellBirds[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingBirds.value = false;
    } on Exception catch (e) {
      isLodingBirds.value = false;
      print(e);
    }
  }
}
