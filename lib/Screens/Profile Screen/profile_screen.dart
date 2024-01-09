import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/Auth%20Controller/noted_controller.dart';
import 'package:le_vech/Controller/Profile%20Controller/profile_controller.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/app_button.dart';
import 'package:le_vech/Widgets/app_textfieled.dart';
import 'package:le_vech/Widgets/drop_down.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'package:le_vech/utils/snackbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());
  NotedController notedController = Get.put(NotedController());

  @override
  void initState() {
    notedController.getDis();
    profileController.getMobileNumber(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
      AppBarWidget(height: 130, width: double.infinity, isLogo: false, info: AppString.noteAddText),
      const SizedBox(height: 10),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Obx(() {
            return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                  onTap: () {
                    profileController.selectImage(context);
                  },
                  child: Stack(children: [
                    Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(color: AppColor.primarycolor, border: Border.all(color: AppColor.themecolor, width: 2), borderRadius: BorderRadius.circular(80)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: /*profileController.selectedProfile.value.path.isEmpty
                                ? profileController.profileUrl.value != ''
                                    ? Image(
                                        image: NetworkImage(profileController.profileUrl.value),
                                        fit: BoxFit.cover,
                                      )
                                    : const Image(image: AssetImage('assets/images/logops.jpg'))
                                : Image.file(profileController.selectedProfile.value, fit: BoxFit.cover))*/
                            profileController.selectedProfile.value.path.isEmpty ?CachedNetworkImage(
                                height: 100,
                                width: 100,
                                imageUrl:  profileController.profileUrl.value ,
                                placeholder: (context, url) => Image(image: AssetImage(AppImage.imglogo)),
                                errorWidget: (context, url, error) => Image(image: AssetImage(AppImage.imglogo)),
                                fit: BoxFit.cover):Image.file(profileController.selectedProfile.value, fit: BoxFit.cover),
                        ),),
                    Positioned(bottom: 0, right: 10, child: CircleAvatar(backgroundColor: AppColor.themecolor, radius: 14, child: Icon(Icons.camera_alt, color: AppColor.primarycolor, size: 16)))
                  ])),
              const SizedBox(height: 20),
              AppTextField(txtValue: AppString.name, controller: profileController.nameController),
              const SizedBox(height: 10),
              AppTextField(txtValue: AppString.surName, controller: profileController.surnameController),
              const SizedBox(height: 10),
              AppTextField(txtValue: AppString.mobileNo, keytype: TextInputType.number, controller: profileController.mobileController, maxLength: 10, counterTxt: ''),
              const SizedBox(height: 10),
              AppTextField(txtValue: AppString.guj, readOnly: true),
              const SizedBox(height: 10),
              DropDown(
                  items: notedController.districList,
                  dropdownvalue: notedController.districSelect.value,
                  onTap: (String value) {
                    setState(() {
                      notedController.districSelect.value = value;
                      notedController.districSelectId.value = notedController.districListId[notedController.districList.indexOf(notedController.districSelect.value)];
                      notedController.isFirst.value = false;
                      notedController.getTaluka();
                    });
                  }),
              const SizedBox(height: 10),
              DropDown(
                  items: notedController.talukaList,
                  dropdownvalue: notedController.talukaSelect.value,
                  onTap: (String value) {
                    setState(() {
                      notedController.talukaSelect.value = value;
                      notedController.talukaSelectId.value = notedController.talukaListId[notedController.talukaList.indexOf(notedController.talukaSelect.value)];
                      notedController.getVillage();
                    });
                  }),
              const SizedBox(height: 10),
              DropDown(
                  items: notedController.villageList,
                  dropdownvalue: notedController.villageSelect.value,
                  onTap: (String value) {
                    setState(() {
                      notedController.villageSelect.value = value;
                      notedController.villageSelectId.value = notedController.villageListId[notedController.villageList.indexOf(notedController.villageSelect.value)];
                    });
                  }),
              const SizedBox(height: 20),
              AppTextField(txtValue: AppString.add, maxLines: 4, controller: profileController.addressController),
              const SizedBox(height: 20),
              AppButton(
                  height: 54,
                  width: double.infinity,
                  buttontxt: AppString.update,
                  onTap: () {
                    if (profileController.profileUrl.value.isEmpty) {
                      errorSnackBar(context, AppString.pleaseAddImage);
                    } else if (profileController.nameController.text.isEmpty) {
                      errorSnackBar(context, AppString.pleaseName);
                    } else if (profileController.surnameController.text.isEmpty) {
                      errorSnackBar(context, AppString.pleaseSurName);
                    } else if (profileController.mobileController.text.isEmpty) {
                      errorSnackBar(context, AppString.enterNum);
                    } else if (profileController.addressController.text.isEmpty) {
                      errorSnackBar(context, AppString.pleaseAdd);
                    } else {
                      profileController.updateProfile(context, profileController.profileData[0].id);
                    }
                  },
                  isLoad: profileController.isUpdateLoding.value)
            ]);
          }))
    ]))));
  }
}
