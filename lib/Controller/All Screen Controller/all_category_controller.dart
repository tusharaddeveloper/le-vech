import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/Auth%20Controller/noted_controller.dart';
import 'package:le_vech/Controller/Profile%20Controller/profile_controller.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';

class AllCategoryController extends GetxController {
  ProfileController profileController = Get.put(ProfileController());
  NotedController notedController = Get.put(NotedController());

  RxBool isIcon = true.obs;
  RxBool isLodingData = false.obs;
  RxString selectedItem = ''.obs;

  List<String> imageList = [
    AppImage.allCategory,
    AppImage.tractorEicher,
    AppImage.cow,
    AppImage.horse,
    AppImage.bike,
    AppImage.car,
    AppImage.imglogo,
    AppImage.khetFasalImg,
    "${AppImage.electricalItems}",
    AppImage.leptopTVComputer,
    AppImage.jobIcon,
    AppImage.phoneLevecha,
    AppImage.imglogo,
    AppImage.jaminMakanPloat,
    AppImage.biyaranlevech,
    AppImage.imglogo,
    AppImage.fruitsAndVegetables,
    AppImage.narsarirRop,
    AppImage.sheepAndBakra,
    AppImage.sanedoImg,
    AppImage.trecterOjar,
    AppImage.khetOjarImg,
    AppImage.imglogo,
    AppImage.oxImages,
    AppImage.dogImg
  ];
  List itemName = [
    AppString.allInfo,
    AppString.tractor,
    AppString.cow,
    AppString.horse,
    AppString.twoWheel,
    AppString.fourWheel,
    AppString.others,
    "ખેત પેદાશ લે - વેચ",
    "ઇલેક્ટ્રોનિક સાધનો લે-વેચ",
    "લેપટોપ કમ્પ્યુટર ટીવી લે-વેચ",
    "નોકરી",
    "મોબાઇલ લે-વેચ",
    "ભંગાર લે-વેચ",
    "મકાન દુકાન પ્લોટ લે-વેચ",
    "બિયારણ દવા લે-વેચ",
    "જમીન લે-વેચ",
    "ફળ શાકભાજી લે-વેચ",
    "નર્સરી રોપ લે-વેચ",
    "ઘેટાં બકરાં લે-વેચ",
    "સનેડો ટ્રેક્ટર લે-વેચ",
    "ટ્રેક્ટર ઓજાર લે-વેચ",
    "ખેત ઓજાર લે-વેચ",
    "પક્ષીઓ લે-વેચ",
    "બળદ લે-વેચ",
    "કુતરા લે-વેચ"
  ];
  List favList = [];
  RxList<QueryDocumentSnapshot> profileData = <QueryDocumentSnapshot>[].obs;

  // RxBool isLoader = false.obs;

  getAllads(BuildContext context) async {
    try {
      isLodingData.value = true;
      profileData.value = await firebaseGet('advertise');
      if (profileData.isNotEmpty) {
        for (int i = 0; i < profileData.length; i++) {
          favList.add(profileData[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }
      isLodingData.value = false;
      print(favList);
    } on Exception catch (e) {
      isLodingData.value = false;
      print(e);
    }
  }
}
