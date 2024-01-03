import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';
import 'package:le_vech/utils/firebase_get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SampleItem { itemOne, itemTwo }

class SendAdd extends StatefulWidget {
  const SendAdd({Key? key}) : super(key: key);

  @override
  State<SendAdd> createState() => _SendAddState();
}

class _SendAddState extends State<SendAdd> {
  SampleItem? selectedMenu;
  List<QueryDocumentSnapshot> adsData = <QueryDocumentSnapshot>[];
  String mo = '';
  late SharedPreferences prefs;

  getMobileNumber() async {
    prefs = await SharedPreferences.getInstance();
    mo = prefs.getString("mobile_number").toString();
    getProfileData();
  }

  getProfileData() async {
    adsData = await firebaseGetwhere('advertise', 'login_mo', mo);
    setState(() {});
  }

  @override
  void initState() {
    getMobileNumber();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.txtfilled,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppBarWidget(isLogo: false, height: 130, width: double.infinity, info: AppString.youSendInfo),
          const SizedBox(height: 12),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(AppString.youSendInfo, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 22)),
                const SizedBox(height: 16),
                adsData.isNotEmpty
                    ? ListView.builder(
                        itemCount: adsData.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LeVechProfile(detail: adsData[index])));
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
                                            Container(
                                                height: 130,
                                                width: 120,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), image: DecorationImage(image: AssetImage(AppImage.cow), fit: BoxFit.cover))),
                                            const SizedBox(width: 10),
                                            Expanded(
                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                              Text(adsData[index]['item_type'],
                                                  overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.themecolor, fontSize: 18, fontWeight: FontWeight.bold)),
                                              Text(adsData[index]['district'],
                                                  overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.themecolor, fontSize: 14, fontWeight: FontWeight.w500)),
                                              Text(adsData[index]['taluka'], overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.themecolor, fontSize: 14, fontWeight: FontWeight.w500)),
                                              Text(adsData[index]['village'], overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.themecolor, fontSize: 14, fontWeight: FontWeight.w500)),
                                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                Text(adsData[index]['price'], overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.priceclr, fontSize: 18, fontWeight: FontWeight.w500)),
                                                InkWell(onTap: () {}, child: Icon(Icons.delete_forever, color: AppColor.iconColor, size: 24))
                                              ])
                                            ]))
                                          ])))));
                        })
                    : Container(
                        height: 400,
                        alignment: Alignment.center,
                        child: Text(AppString.noItemAdd, style: TextStyle(color: AppColor.iconColor, fontSize: 22, fontWeight: FontWeight.w500), textAlign: TextAlign.center))
              ]))
        ]))));
  }
}
