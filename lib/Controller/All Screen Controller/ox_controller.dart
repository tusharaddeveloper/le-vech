import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class OXController extends GetxController {

  RxBool isLodingOX = false.obs;
  RxList<QueryDocumentSnapshot> sellOX = <QueryDocumentSnapshot>[].obs;
  List favOXList = [];

  sellAllOX(BuildContext context) async {
    try {
      isLodingOX.value = true;
      sellOX.value = await firebaseGetwhere("advertise", "item_type","બળદ લે-વેચ");
      if (sellOX.isNotEmpty) {
        for (int i = 0; i < sellOX.length; i++) {
          favOXList.add(sellOX[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingOX.value = false;
    } on Exception catch (e) {
      isLodingOX.value = false;
      print(e);
    }
  }
}
