import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:le_vech/Screens/catrgory_item_screen.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';
import 'package:flutter/material.dart';

class CatrgoryItemController extends GetxController {
  CatrgoryItemScreen catrgoryItemScreen = Get.put(CatrgoryItemScreen());
  RxList<QueryDocumentSnapshot> allSellCow = <QueryDocumentSnapshot>[].obs;
  RxBool isLodingData = false.obs;
  List favCategoryItemList = [];
  ScrollController controller = ScrollController();

  List<String> imageList = [
    AppImage.allCategory,
    AppImage.tractorEicher,
    AppImage.cow,
    AppImage.horse,
    AppImage.bike,
    AppImage.car,
    AppImage.khetFasalImg,
    "${AppImage.electricalItems}",
    AppImage.leptopTVComputer,
    AppImage.jobIcon,
    AppImage.phoneLevecha,
    AppImage.bhangar,
    AppImage.jaminMakanPloat,
    AppImage.biyaranlevech,
    AppImage.fruitsAndVegetables,
    AppImage.narsarirRop,
    AppImage.sheepAndBakra,
    AppImage.sanedoImg,
    AppImage.trecterOjar,
    AppImage.khetOjarImg,
    AppImage.birds,
    AppImage.oxImages,
    AppImage.dogImg,
    AppImage.anya,
  ];
  List<String> itemName = [
    AppString.allInfo,
    AppString.tractor,
    AppString.cow,
    AppString.horse,
    AppString.twoWheel,
    AppString.fourWheel,
    "ખેત પેદાશ લે - વેચ",
    "ઇલેક્ટ્રોનિક સાધનો લે-વેચ",
    "લેપટોપ કમ્પ્યુટર ટીવી લે-વેચ",
    "નોકરી",
    "મોબાઇલ લે-વેચ",
    "ભંગાર લે-વેચ",
    "મકાન દુકાન પ્લોટ જમીન લે-વેચ",
    "બિયારણ દવા લે-વેચ",
    "ફળ શાકભાજી લે-વેચ",
    "નર્સરી રોપ લે-વેચ",
    "ઘેટાં બકરાં લે-વેચ",
    "સનેડો ટ્રેક્ટર લે-વેચ",
    "ટ્રેક્ટર ઓજાર લે-વેચ",
    "ખેત ઓજાર લે-વેચ",
    "પક્ષીઓ લે-વેચ",
    "બળદ લે-વેચ",
    "કુતરા લે-વેચ",
    AppString.others,
  ];

  animateToIndex(int index) {
    if (controller.hasClients) {
      controller.position.jumpTo(index * 116);
    }
  }

  Future  runData(BuildContext context,int index) async {
    print(index);
    if (index == 0) {
      allCategoryItem(context);
      await animateToIndex( index);
    } else {
      categoryItem(context,itemName[index]);
      await animateToIndex(index);
    }
  }

  categoryItem(BuildContext context, String categrish) async {
    try {
      isLodingData.value = true;
      allSellCow.value = await firebaseGetwhere("advertise", "item_type", categrish);

      if (allSellCow.isNotEmpty) {
        for (int i = 0; i < allSellCow.length; i++) {
          favCategoryItemList.add(allSellCow[i]['fav_user']);
        }
      } else {
        print("No Data Found");
      }

      isLodingData.value = false;
    } on Exception catch (e) {
      isLodingData.value = false;
      print(e);
    }
  }

  allCategoryItem(BuildContext context) async {
    try {
      isLodingData.value = true;
      allSellCow.value = await firebaseGet('advertise');

      if (allSellCow.isNotEmpty) {
        for (int i = 0; i < allSellCow.length; i++) {
          favCategoryItemList.add(allSellCow[i]['fav_user']);
        }
        print("data get");
      } else {
        print("No Data Found");
      }

      isLodingData.value = false;
    } on Exception catch (e) {
      isLodingData.value = false;
      print(e);
    }
  }
}
