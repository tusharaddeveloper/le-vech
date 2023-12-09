import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:le_vech/Widgets/app_button.dart';
import 'package:le_vech/Widgets/app_textfieled.dart';
import 'package:le_vech/Widgets/drop_down.dart';
import 'package:le_vech/screens/Home%20Screen/home_screen.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/string_const.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController disController = TextEditingController();
  TextEditingController eMailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                height: 130,
                width: double.infinity,
                color: AppColor.themecolor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 28, bottom: 26),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColor.primarycolor,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: 16),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), image: DecorationImage(fit: BoxFit.cover, image: NetworkImage("https://t3.ftcdn.net/jpg/02/43/12/34/240_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg"))),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12, left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "User name",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: AppColor.primarycolor, fontSize: 22),
                              ),
                              Text(
                                "+91 9824685800",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: AppColor.primarycolor, fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  AppTextField(txtValue: AppString.name, isIcon: false, preIcon: false, lableValue: AppString.name),
                  SizedBox(height: 10),
                  AppTextField(txtValue: AppString.surName, isIcon: false, preIcon: false, lableValue: AppString.surName),
                  SizedBox(height: 10),
                  AppTextField(
                    txtValue: AppString.mobileNo,
                    preIcon: true,
                    keytype: TextInputType.number,
                    lableValue: AppString.mobileNo,
                    maxLength: 10,
                    counterTxt: '',
                  ),
                  SizedBox(height: 10),
                  AppTextField(
                    controller: eMailController,
                    txtValue: AppString.eMail,
                    isIcon: false,
                    preIcon: true,
                    preIconData: Icons.email,
                    lableValue: AppString.eMail,
                  ),
                  SizedBox(height: 10),
                  AppTextField(
                    txtValue: AppString.guj,
                    readOnly: true,
                  ),
                  SizedBox(height: 10),
                  DropDown(items: [
                    'Item 1',
                    'Item 2',
                    'Item 3',
                    'Item 4',
                    'Item 5',
                  ], dropdownvalue: 'Item 1', onTap: (String value) {}),
                  SizedBox(height: 10),
                  DropDown(items: [
                    'Item 1',
                    'Item 2',
                    'Item 3',
                    'Item 4',
                    'Item 5',
                  ], dropdownvalue: 'Item 1', onTap: (String value) {}),
                  SizedBox(height: 10),
                  DropDown(items: [
                    'Item 1',
                    'Item 2',
                    'Item 3',
                    'Item 4',
                    'Item 5',
                  ], dropdownvalue: 'Item 1', onTap: (String value) {}),
                  SizedBox(height: 10),
                  AppTextField(txtValue: AppString.add, isIcon: false, lableValue: AppString.add, maxLines: 4, preIcon: false),
                  SizedBox(height: 20),
                  InkWell(
                      onTap: () {
                        if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(eMailController.text)) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Invalid Email"),
                            backgroundColor: AppColor.iconColor,
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(4),
                          ));
                        }
                      },
                      child: AppButton(height: 54, width: double.infinity, buttontxt: AppString.update)),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
