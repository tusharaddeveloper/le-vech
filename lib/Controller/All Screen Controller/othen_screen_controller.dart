import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';

class OtherScreenController extends GetxController {
  RxBool isIcon = true.obs;
  RxBool isOtharLodingData = false.obs;
  RxList<QueryDocumentSnapshot> getOtherAds = <QueryDocumentSnapshot>[].obs;


  sellOtherAds(BuildContext context) async {
    try {
      isOtharLodingData.value = true;
      getOtherAds.value = await firebaseGetwhere("advertise", "item_type", AppString.others);

      if (getOtherAds.isNotEmpty) {
        print("Object GET Othar ADSSSSSSSSSSSSSSSSSSSS");
      } else {
        print("No Data Found");
      }

      isOtharLodingData.value = false;
    } on Exception catch (e) {
      isOtharLodingData.value = false;
      print(e);
    }
  }


}
