import 'package:flutter/material.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';

enum SampleItem { itemOne, itemTwo }

class SendAdd extends StatefulWidget {
  const SendAdd({Key? key}) : super(key: key);

  @override
  State<SendAdd> createState() => _SendAddState();
}

class _SendAddState extends State<SendAdd> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.txtfilled,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  AppBarWidget(isLogo: false, height: 130, width: double.infinity, info: AppString.youSendInfo),
                  SizedBox(height: 12),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(AppString.youSendInfo, style: TextStyle(color: AppColor.primarycolorblack, fontSize: 22)),
                        SizedBox(height: 16),
                        ListView.builder(
                            itemCount: 5,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LeVechProfile()));
                                  },
                                  child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(color: AppColor.primarycolor, borderRadius: BorderRadius.circular(12)),
                                          child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                              child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                                Container(
                                                    height: 120,
                                                    width: 120,
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), image: DecorationImage(image: AssetImage(AppImage.cow), fit: BoxFit.cover))),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                    Text("જર્સી ગાય", overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(color: AppColor.themecolor, fontSize: 22, fontWeight: FontWeight.w500)),
                                                    Text("માહિતી : jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(color: AppColor.primarycolorblack, fontSize: 18, fontWeight: FontWeight.w300)),
                                                    Row(children: [
                                                      Text(
                                                          "₹20,000", overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.priceclr, fontSize: 20, fontWeight: FontWeight.w400)),
                                                      InkWell(onTap: () {}, child: Icon(Icons.delete_forever, color: AppColor.iconColor, size: 24))
                                                    ])
                                                  ]),
                                                )
                                              ])))));
                            })
                      ]))
                ]))));
  }
}
