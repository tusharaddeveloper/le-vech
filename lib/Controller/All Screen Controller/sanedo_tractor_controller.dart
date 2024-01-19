import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class SanedoTractorController extends GetxController {

  RxBool isLodingSanedoTractor = false.obs;
  RxList<QueryDocumentSnapshot> sellSanedoTractor = <QueryDocumentSnapshot>[].obs;
  List favSanedoTractorList = [];

  sellAllSanedoTractor(BuildContext context) async {
    try {
      isLodingSanedoTractor.value = true;
      sellSanedoTractor.value = await firebaseGetwhere("advertise", "item_type", "સનેડો ટ્રેક્ટર લે-વેચ" );
      if (sellSanedoTractor.isNotEmpty) {
        for (int i = 0; i < sellSanedoTractor.length; i++) {
          favSanedoTractorList.add(sellSanedoTractor[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingSanedoTractor.value = false;
    } on Exception catch (e) {
      isLodingSanedoTractor.value = false;
      print(e);
    }
  }
}
