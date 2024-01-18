import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class LaptopTVComputerController extends GetxController {
  RxBool isIcon = true.obs;
  RxBool isLodingLaptoptv = false.obs;
  RxList<QueryDocumentSnapshot> allSellLeptopTvComputer = <QueryDocumentSnapshot>[].obs;
  List favLodingLaptoptvList = [];

  sellLaptopTVComputer(BuildContext context) async {
    try {
      isLodingLaptoptv.value = true;
      allSellLeptopTvComputer.value = await firebaseGetwhere("advertise", "item_type", "લેપટોપ કમ્પ્યુટર ટીવી લે-વેચ" );
      if (allSellLeptopTvComputer.isNotEmpty) {
        for (int i = 0; i < allSellLeptopTvComputer.length; i++) {
          favLodingLaptoptvList.add(allSellLeptopTvComputer[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingLaptoptv.value = false;
    } on Exception catch (e) {
      isLodingLaptoptv.value = false;
      print(e);
    }
  }
}
