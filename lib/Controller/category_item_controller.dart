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
  ScrollController controllerGreedView = ScrollController();

  DocumentSnapshot? startAfterDocument;

  int perPage = 10;
  RxBool gettingMoreProduct = false.obs;
  RxBool moreProductAvailable = true.obs;

  List<String> imageList = [
    AppImage.allCategory,
    AppImage.tractorEicher,
    AppImage.cow,
    AppImage.buffaloImg,
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
    AppImage.sanedoImg,
    AppImage.trecterOjar,
    AppImage.vehicalIma,
    AppImage.khetOjarImg,
    AppImage.birds,
    AppImage.oxImages,
    AppImage.dogImg,
    AppImage.animalImg,
    AppImage.anya,
  ];

  List<String> itemName = [
    AppString.allInfo,
    AppString.tractor,
    AppString.cow,
    "ભેંસ લે-વેચ",
    AppString.horse,
    AppString.twoWheel,
    AppString.fourWheel,
    "ખેત પેદાશ લે-વેચ",
    "ઇલેક્ટ્રોનિક સાધનો લે-વેચ",
    "લેપટોપ કમ્પ્યુટર ટીવી લે-વેચ",
    "નોકરી",
    "મોબાઇલ લે-વેચ",
    "ભંગાર લે-વેચ",
    "મકાન દુકાન પ્લોટ જમીન લે-વેચ",
    "બિયારણ દવા લે-વેચ",
    "ફળ શાકભાજી લે-વેચ",
    "નર્સરી રોપ લે-વેચ",
    "સનેડો ટ્રેક્ટર લે-વેચ",
    "ટ્રેક્ટર ઓજાર લે-વેચ",
    "અન્ય વાહન લે-વેચ",
    "ખેત ઓજાર લે-વેચ",
    "પક્ષીઓ લે-વેચ",
    "બળદ લે-વેચ",
    "કુતરા લે-વેચ",
    "અન્ય પ્રાણી લે-વેચ",
    AppString.others,
  ];

  animateToIndex(int index) {
    if (controller.hasClients) {
      controller.position.animateTo(index * 116, duration: const Duration(seconds: 2), curve: Curves.easeOutSine);
    }
  }

  Future runData(BuildContext context, int index) async {
    print(index);
    if (index == 0) {
      allCategoryItem(context);
      await animateToIndex(index);
    } else {
      categoryItem(context, itemName[index]);
      await animateToIndex(index);
    }
  }

  categoryItem(BuildContext context, String categrish) async {
    try {
      startAfterDocument = null;
      allSellCow.clear();
      gettingMoreProduct.value = false;
      moreProductAvailable.value = true;
      favCategoryItemList.clear();
      isLodingData.value = true;
      allSellCow.value = await firebaseGetwhereLimit("advertise", "item_type", categrish, perPage);

      startAfterDocument = allSellCow[allSellCow.length - 1];
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
    print("dataget sijgiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiid             rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrf");
  }

  allCategoryItem(BuildContext context) async {
    try {
      startAfterDocument = null;
      allSellCow.clear();
      gettingMoreProduct.value = false;
      moreProductAvailable.value = true;
      favCategoryItemList.clear();

      isLodingData.value = true;
      allSellCow.value = await firebaseLimite('advertise', perPage);
      startAfterDocument = allSellCow[allSellCow.length - 1];

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

  void getMoreActivityData() async {
    if (moreProductAvailable == false) {
      print("No more product");
      return;
    }
    if (gettingMoreProduct == true) {
      return;
    }
    gettingMoreProduct.value = true;
    var getTradeData = await firebasePaginationData('advertise', startAfterDocument!, perPage);
    if (getTradeData.isNotEmpty) {
      for (int i = 0; i < getTradeData.length; i++) {
        favCategoryItemList.add(getTradeData[i]['fav_user']);
      }
      print("data get");
    } else {
      print("No Data Found");
    }
    if (getTradeData.length < perPage) {
      moreProductAvailable.value = false;
    }
    allSellCow.addAll(getTradeData);
    startAfterDocument = getTradeData[getTradeData.length - 1];
    gettingMoreProduct.value = false;
  }

  void getLoadMoreData(String categrish) async {
    if (moreProductAvailable == false) {
      print("No more product");
      return;
    }
    if (gettingMoreProduct == true) {
      return;
    }
    gettingMoreProduct.value = true;
  var getTradeData = await firebaseCategrishPaginationData("advertise", "item_type", categrish, startAfterDocument!, perPage );
    if (getTradeData.isNotEmpty) {
      for (int i = 0; i < getTradeData.length; i++) {
        favCategoryItemList.add(getTradeData[i]['fav_user']);
      }
      print("data get");
    } else {
      print("No Data Found");
    }
    if (getTradeData.length < perPage) {
      moreProductAvailable.value = false;
    }
    allSellCow.addAll(getTradeData);
    startAfterDocument = getTradeData[getTradeData.length - 1];
    gettingMoreProduct.value = false;

  }
}