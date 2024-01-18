import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class ElectronicController extends GetxController {
  RxBool isIcon = true.obs;
  RxBool isLodingElectronic = false.obs;
  RxList<QueryDocumentSnapshot> allSellElectronic = <QueryDocumentSnapshot>[].obs;
  List favElectronicList = [];

  sellElectronic(BuildContext context) async {
    try {
      isLodingElectronic.value = true;
      allSellElectronic.value = await firebaseGetwhere("advertise", "item_type", "ઇલેક્ટ્રોનિક સાધનો લે-વેચ");
      if (allSellElectronic.isNotEmpty) {
        for (int i = 0; i < allSellElectronic.length; i++) {
          favElectronicList.add(allSellElectronic[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingElectronic.value = false;
    } on Exception catch (e) {
      isLodingElectronic.value = false;
      print(e);
    }
  }
}
