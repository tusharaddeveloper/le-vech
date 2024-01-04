import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/Profile%20Controller/profile_controller.dart';
import 'package:le_vech/utils/firebase_get.dart';

class SendAddController extends GetxController {

  ProfileController profileController = Get.put(ProfileController());

  List<QueryDocumentSnapshot> adsData = <QueryDocumentSnapshot>[];
  RxBool isGetAddLodding = false.obs;



  getProfileData() async {
    isGetAddLodding.value = true;
    try {
      adsData = await firebaseGetwhere('advertise', 'login_mo', profileController.mo!);
    } on Exception catch (e) {
      isGetAddLodding.value = false;
     print(e);
    }
    isGetAddLodding.value = false;
  }

  deleteData(String deleteId) async {

    try {
      FirebaseFirestore.instance.collection("le-vech_config").doc("developer").collection("advertise").doc(deleteId).delete();
    } on Exception catch (e) {
    print(e);
    }
    print("data delete");
    await getProfileData();
  }

   logOut(BuildContext context, int id) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('To Delete Jaherat .'),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the Dialog
              },
            ),
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () {
                deleteData(adsData[id].id);
                Navigator.of(context).pop();
                // Navigate to login
              }
            ),
          ],
        );
      },
    );
  }


}
