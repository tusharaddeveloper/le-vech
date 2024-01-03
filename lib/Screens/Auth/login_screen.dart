import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/Auth%20Controller/login_controller.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/app_button.dart';
import 'package:le_vech/Widgets/app_textfieled.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/string_const.dart';

class LoginSCreen extends StatefulWidget {
  const LoginSCreen({Key? key}) : super(key: key);

  @override
  State<LoginSCreen> createState() => _LoginSCreenState();
}

class _LoginSCreenState extends State<LoginSCreen> {
  LoginController loginController = Get.put(LoginController());
  @override
  void dispose() {
    loginController.mobileNoController.value.clear();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(body: SafeArea(child: SingleChildScrollView(child: Obx(() {
      return Column(children: [
        AppBarWidget(isLogo: true, height: size.height * 0.5, width: double.infinity, logoHeight: size.height * 0.28, logoWidth: size.height * 0.28),
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(AppString.enterNum, style: TextStyle(color: AppColor.themecolor, fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 24),
              AppTextField(txtValue: AppString.mobileNo, lableValue: AppString.mobileNo, controller: loginController.mobileNoController.value, maxLength: 10, keytype: TextInputType.number),
              const SizedBox(height: 10),
              AppButton(
                  height: 50,
                  width: 170,
                  isLoad: loginController.isLoading.value,
                  buttontxt: AppString.getOtp,
                  onTap: () {
                    loginController.userlogin(context);
                  })
            ]))
      ]);
    }))));
  }
}
