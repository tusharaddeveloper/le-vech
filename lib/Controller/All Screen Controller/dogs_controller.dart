import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class DogsController extends GetxController {

  RxBool isLodingDogs = false.obs;
  RxList<QueryDocumentSnapshot> sellDogs = <QueryDocumentSnapshot>[].obs;
  List favDogsList = [];

  sellAllDogs(BuildContext context) async {
    try {
      isLodingDogs.value = true;
      sellDogs.value = await firebaseGetwhere("advertise", "item_type", "કુતરા લે-વેચ");
      if (sellDogs.isNotEmpty) {
        for (int i = 0; i < sellDogs.length; i++) {
          favDogsList.add(sellDogs[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingDogs.value = false;
    } on Exception catch (e) {
      isLodingDogs.value = false;
      print(e);
    }
  }
}
