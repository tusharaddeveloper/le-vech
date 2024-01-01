import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class TractorScreenController extends GetxController {
  RxBool isIcon = true.obs;
  RxBool isLodingData = false.obs;
  List<QueryDocumentSnapshot> profileData = <QueryDocumentSnapshot>[];

  RxBool isLoader = false.obs;

  getProfileData(BuildContext context) async {
    try {
      isLoader.value=true;
      profileData = await firebaseGet('advertise');
      if (profileData.isNotEmpty) {
            print("object gffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffgggggggggggggggggggggggggggggfgfg");
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Data Found")));
      }
      isLoader.value=false;
    } on Exception catch (e) {
      isLoader.value=false;
      print(e);
    }
  }

}