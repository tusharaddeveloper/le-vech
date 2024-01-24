import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:le_vech/Widgets/app_conts.dart';
import 'package:le_vech/utils/firebase_get.dart';

class LikeController extends GetxController {
  RxBool isLodingData = false.obs;
   List favListTemp = [];

  RxList<QueryDocumentSnapshot> getWhereLike = <QueryDocumentSnapshot>[].obs;
  RxList<QueryDocumentSnapshot> profileData = <QueryDocumentSnapshot>[].obs;

  List favList = [];
  getLike() async {
    try {
      isLodingData.value = true;
      profileData.value = await firebaseGet('advertise');
      if(profileData.isNotEmpty){
        setLike();
      }
    } on Exception catch (e) {
      isLodingData.value = false;
      print(e);
    }
    isLodingData.value = false;
  }

  setLike()async{
    for(int i=0;i<profileData.length;i++){
      List temp=profileData[i]['fav_user'];
      if(temp.contains(userId)){
        getWhereLike.add(profileData[i]);
      }
    }

  }


}
