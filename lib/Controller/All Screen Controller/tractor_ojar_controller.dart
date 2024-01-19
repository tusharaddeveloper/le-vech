import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class TractorOjarController extends GetxController {

  RxBool isLodingTractorOjar = false.obs;
  RxList<QueryDocumentSnapshot> sellTractorOjar = <QueryDocumentSnapshot>[].obs;
  List favTractorOjarList = [];

  sellAllTractorOjar(BuildContext context) async {
    try {
      isLodingTractorOjar.value = true;
      sellTractorOjar.value = await firebaseGetwhere("advertise", "item_type", "ટ્રેક્ટર ઓજાર લે-વેચ");
      if (sellTractorOjar.isNotEmpty) {
        for (int i = 0; i < sellTractorOjar.length; i++) {
          favTractorOjarList.add(sellTractorOjar[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingTractorOjar.value = false;
    } on Exception catch (e) {
      isLodingTractorOjar.value = false;
      print(e);
    }
  }
}
