import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/utils/firebase_get.dart';

class JobController extends GetxController {
 // RxBool isIcon = true.obs;
  RxBool isLodingJob = false.obs;
  RxList<QueryDocumentSnapshot> getJob = <QueryDocumentSnapshot>[].obs;
  List favJobList = [];

  getAvailableJob(BuildContext context) async {
    try {
      isLodingJob.value = true;
      getJob.value = await firebaseGetwhere("advertise", "item_type", "નોકરી");
      if (getJob.isNotEmpty) {
        for (int i = 0; i < getJob.length; i++) {
          favJobList.add(getJob[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingJob.value = false;
    } on Exception catch (e) {
      isLodingJob.value = false;
      print(e);
    }
  }
}
