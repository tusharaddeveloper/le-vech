import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/Auth%20Controller/login_controller.dart';
import 'package:le_vech/Controller/Auth%20Controller/noted_controller.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/drop_down.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/utils/snackbar.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/app_button.dart';
import 'package:le_vech/Widgets/app_textfieled.dart';
import 'package:le_vech/Widgets/string_const.dart';

class NotedScreen extends StatefulWidget {
  String Mobile;

  NotedScreen({Key? key, required this.Mobile}) : super(key: key);

  @override
  State<NotedScreen> createState() => _NotedScreenState();
}

class _NotedScreenState extends State<NotedScreen> {
  NotedController notedController = Get.put(NotedController());
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    loginController.mobileNoController.value.text = widget.Mobile;
    notedController.getDis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Obx(() {
      return Column(children: [
        AppBarWidget(height: 130, width: double.infinity, isLogo: false, info: AppString.noteText),
        Expanded(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      InkWell(
                          onTap: () {
                            notedController.selectImage(context);
                          },
                          child: Stack(children: [
                            Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(color: AppColor.primarycolor, border: Border.all(color: AppColor.themecolor, width: 2), borderRadius: BorderRadius.circular(80)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: notedController.selectedProfile.value.path.isEmpty
                                        ? Image(image: AssetImage(AppImage.profileImage))
                                        : Image.file(notedController.selectedProfile.value, fit: BoxFit.cover))),
                            Positioned(
                                bottom: 0, right: 10, child: CircleAvatar(backgroundColor: AppColor.themecolor, radius: 14, child: Icon(Icons.camera_alt, color: AppColor.primarycolor, size: 16)))
                          ])),
                      const SizedBox(height: 20),
                      AppTextField(txtValue: AppString.name, controller: notedController.nameController.value),
                      const SizedBox(height: 10),
                      AppTextField(txtValue: AppString.surName, controller: notedController.surnameController.value),
                      const SizedBox(height: 10),
                      AppTextField(txtValue: AppString.mobileNo, controller: loginController.mobileNoController.value, keytype: TextInputType.number, maxLength: 10, readOnly: true, counterTxt: ''),
                      const SizedBox(height: 10),
                      AppTextField(txtValue: AppString.guj, readOnly: true),
                      const SizedBox(height: 10),
                      DropDown(
                          items: notedController.districList,
                          dropdownvalue: notedController.districSelect.value,
                          onTap: (String value) {
                            notedController.districSelect.value = value;
                            notedController.districSelectId.value = notedController.districListId[notedController.districList.indexOf(notedController.districSelect.value)];
                            notedController.isFirst.value = false;
                            notedController.getTaluka();
                          }),
                      const SizedBox(height: 10),
                      DropDown(
                          items: notedController.talukaList,
                          dropdownvalue: notedController.talukaSelect.value,
                          onTap: (String value) {
                            notedController.talukaSelect.value = value;
                            notedController.talukaSelectId.value = notedController.talukaListId[notedController.talukaList.indexOf(notedController.talukaSelect.value)];
                            notedController.getVillage();
                          }),
                      const SizedBox(height: 10),
                      DropDown(
                          items: notedController.villageList,
                          dropdownvalue: notedController.villageSelect.value,
                          onTap: (String value) {
                            notedController.villageSelect.value = value;
                            notedController.villageSelectId.value = notedController.villageListId[notedController.villageList.indexOf(notedController.villageSelect.value)];
                          }),
                      const SizedBox(height: 10),
                      AppTextField(txtValue: AppString.add, controller: notedController.addressController.value, maxLines: 4),
                      const SizedBox(height: 20),
                      AppButton(
                          height: 60,
                          width: double.infinity,
                          buttontxt: AppString.noteText,
                          isLoad: notedController.isLoading.value,
                          onTap: () {
                            if (notedController.selectedProfile.value.path.isEmpty) {
                              errorSnackBar(context, AppString.pleaseAddImage);
                            } else if (notedController.nameController.value.text.isEmpty) {
                              errorSnackBar(context, AppString.pleaseName);
                            } else if (notedController.surnameController.value.text.isEmpty) {
                              errorSnackBar(context, AppString.pleaseSurName);
                            } else if (notedController.addressController.value.text.isEmpty) {
                              errorSnackBar(context, AppString.pleaseAdd);
                            } else {
                              notedController.setData(context, widget.Mobile);
                            }
                          })
                    ]))))
      ]);
    })));
  }
}
