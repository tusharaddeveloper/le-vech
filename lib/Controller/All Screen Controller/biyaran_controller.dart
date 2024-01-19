import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';

class BiyaranController extends GetxController {
  RxBool isLodingBiyaran = false.obs;
  RxList<QueryDocumentSnapshot> allSellBiyaran = <QueryDocumentSnapshot>[].obs;

  List favBiyaranList = [];

  sellAllBiyaran(BuildContext context) async {
    try {
      isLodingBiyaran.value = true;
      allSellBiyaran.value = await firebaseGetwhere("advertise", "item_type", "બિયારણ દવા લે-વેચ");

      if (allSellBiyaran.isNotEmpty) {
        for(int i=0;i<allSellBiyaran.length;i++){
          favBiyaranList.add(allSellBiyaran[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingBiyaran.value = false;
    } on Exception catch (e) {
      isLodingBiyaran.value = false;
      print(e);
    }
  }
}
