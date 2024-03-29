import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/send_add_controller.dart';
import 'package:le_vech/Widgets/app_text.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';

class SendAdd extends StatefulWidget {
  const SendAdd({Key? key}) : super(key: key);

  @override
  State<SendAdd> createState() => _SendAddState();
}

class _SendAddState extends State<SendAdd> {
  SendAddController sendAddController = Get.put(SendAddController());

  @override
  void initState() {
    sendAddController.getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.txtfilled,
        body: SafeArea(child: SingleChildScrollView(child: Obx(() {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AppBarWidget(isLogo: false, height: 130, width: double.infinity, info: AppString.youSendInfo),
            const SizedBox(height: 12),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  sendAddController.isGetAddLodding.value
                      ? const Center(child: CircularProgressIndicator())
                      : sendAddController.adsData.isNotEmpty
                          ? ListView.builder(
                              itemCount: sendAddController.adsData.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => LeVechProfile(detail: sendAddController.adsData[index])));
                                    },
                                    child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(color: AppColor.primarycolor, borderRadius: BorderRadius.circular(12)),
                                            child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                 /* Container(
                                                      height: 130,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                        image: DecorationImage(
                                                            image: NetworkImage(sendAddController.adsData[index]["item_img"][0].toString().isNotEmpty
                                                                ? sendAddController.adsData[index]["item_img"][0].toString()
                                                                : "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                                            fit: BoxFit.cover),)),*/
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(8),
                                                    child: CachedNetworkImage(
                                                        height: 130,
                                                        width: 120,
                                                        imageUrl: sendAddController.adsData[index]["item_img"][0].toString().isNotEmpty
                                                            ? sendAddController.adsData[index]["item_img"][0].toString()
                                                            : "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                                        placeholder: (context, url) => Image(image: AssetImage(AppImage.imglogo),fit: BoxFit.cover,),
                                                        errorWidget: (context, url, error) => Image(image: AssetImage(AppImage.imglogo),fit: BoxFit.cover),
                                                        fit: BoxFit.cover),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                    AppText(
                                                        text: sendAddController.adsData[index]['item_type'],
                                                        txtColor: AppColor.themecolor,
                                                        size: 18,
                                                        fontWeight: FontWeight.bold,
                                                        overflow: TextOverflow.ellipsis),
                                                    AppText(
                                                        text: sendAddController.adsData[index]['district'],
                                                        txtColor: AppColor.themecolor,
                                                        size: 14,
                                                        fontWeight: FontWeight.w500,
                                                        overflow: TextOverflow.ellipsis),
                                                    AppText(
                                                        text: sendAddController.adsData[index]['taluka'],
                                                        txtColor: AppColor.themecolor,
                                                        size: 14,
                                                        fontWeight: FontWeight.w500,
                                                        overflow: TextOverflow.ellipsis),
                                                    AppText(
                                                        text: sendAddController.adsData[index]['village'],
                                                        txtColor: AppColor.themecolor,
                                                        size: 14,
                                                        fontWeight: FontWeight.w500,
                                                        overflow: TextOverflow.ellipsis),

                                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                      Expanded(
                                                        child: AppText(
                                                            text: "₹ ${sendAddController.adsData[index]['price']}",
                                                            txtColor: AppColor.priceclr,
                                                            size: 18,
                                                            fontWeight: FontWeight.w500,
                                                            overflow: TextOverflow.ellipsis),
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            sendAddController.logOut(context, index);
                                                          },
                                                          child: Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.delete_forever, color: AppColor.iconColor, size: 26)))
                                                    ])
                                                  ]))
                                                ])))));
                              })
                          : Container(
                              height: 400,
                              alignment: Alignment.center,
                              child: AppText(
                                  text: AppString.noItemAdd,
                                  txtColor: AppColor.iconColor,
                                  size: 22,
                                  fontWeight: FontWeight.w500,
                                  txtAlign: TextAlign
                                      .center),
                            )
                ]))
          ]);
        }))));
  }
}
