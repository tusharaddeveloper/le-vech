import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/like_screen_controller.dart';
import 'package:le_vech/Screens/Profile%20Screen/le_vech_profile.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/app_conts.dart';
import 'package:le_vech/Widgets/app_text.dart';
import 'package:le_vech/Widgets/app_textfieled.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/firebase_get.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({Key? key}) : super(key: key);

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  LikeController likeController = Get.put(LikeController());

  @override
  void initState() {
    likeController.getLike();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          backgroundColor: AppColor.txtfilled,
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(children: [
            AppBarWidget(height: 130, width: double.infinity, isLogo: false, info: AppString.like),
            const SizedBox(height: 20),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: AppTextField(txtValue: AppString.searchBar, prefixIcon: Icons.search)),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: likeController.isLodingData.value
                    ? const CircularProgressIndicator()
                    :likeController.getWhereLike.isNotEmpty? GridView.builder(
                        itemCount: likeController.getWhereLike.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4.8 / 5.8, crossAxisSpacing: 2, mainAxisSpacing: 2),
                        itemBuilder: (context, index) {
                          return ItemWidget(index: index);
                        })
                    : Container(
                        height: 400,
                        alignment: Alignment.center,
                    child: AppText(text: "કોઈ જાહેરાત નથી મળી.",txtColor: AppColor.iconColor,size: 22,fontWeight: FontWeight.w500,txtAlign: TextAlign.center))
            )
          ]))));
    });
  }
}

class ItemWidget extends StatefulWidget {
  int index;

  ItemWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  LikeController likeController = Get.put(LikeController());
  //bool isIcon = true;
 // List<String> imageList = [AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car];


  @override
  void initState() {
    likeController.favListTemp.value = likeController.getWhereLike[widget.index]['fav_user'];

    print(likeController.favListTemp);
    super.initState();
  }
  @override
  void dispose() {
    likeController.getWhereLike.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeVechProfile(detail: likeController.profileData[widget.index])));
          },
          child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.primarycolor),
                  child: Column(children: [
                    const SizedBox(height: 08),
                    Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        child: Container(
                            height: 100,
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                image: NetworkImage(likeController.getWhereLike[widget.index]["item_img"][0].toString().isNotEmpty
                                    ? likeController.getWhereLike[widget.index]["item_img"][0].toString()
                                    : "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                fit: BoxFit.cover,
                              ),
                            ))),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          /*Text(likeController.getWhereLike[widget.index]["item_type"],overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600)),*/
                           AppText(text: likeController.getWhereLike[widget.index]["item_type"],txtColor: AppColor.primarycolorblack,size: 16,fontWeight: FontWeight.w600,txtAlign: TextAlign.center,overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                                child:  AppText(text: likeController.getWhereLike[widget.index]["price"],overflow: TextOverflow.ellipsis,txtColor: AppColor.price,size: 16,fontWeight: FontWeight.w700),
                              /*Text(likeController.getWhereLike[widget.index]["price"], overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.price, fontSize: 16, fontWeight: FontWeight.w700))*/),
                            InkWell(
                                onTap: () {
                                  /*if (notedController.favoriteList.contains(allCategoryController.profileData[widget.index].id)) {
                                    notedController.favoriteList.remove(allCategoryController.profileData[widget.index].id);
                                  } else {
                                    notedController.favoriteList.add(allCategoryController.profileData[widget.index].id);
                                  }
                                  allCategoryController.addFavorite(context);*/
                                  if (likeController.favListTemp.contains(userId)) {
                                    likeController.favListTemp.remove(userId);
                                    print(userId);
                                  } else {
                                    likeController.favListTemp.add(userId);
                                    print(userId);
                                  }
                                  updateData('advertise', likeController.getWhereLike[widget.index].id, {'fav_user': likeController.favListTemp});
                                  setState(() {});
                                },
                                child: Icon(likeController.favListTemp.contains(userId)  ? Icons.favorite : Icons.favorite_border,
                                    color: likeController.favListTemp.contains(userId) ? AppColor.iconColor : AppColor.primarycolorblack, size: 24))
                          ])
                        ]))
                  ]))));
    });
  }
}
