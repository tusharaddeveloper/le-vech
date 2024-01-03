import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/Auth%20Controller/otp_controller.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/app_textfieled.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'login_screen.dart';

class OtpScreen extends StatefulWidget {
  String varId;
  String mo;

  OtpScreen({Key? key, required this.mo, required this.varId}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  OTPController otpController = Get.put(OTPController());

  @override
  void dispose() {
    otpController.verifyotp.value.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(body: SafeArea(child: SingleChildScrollView(child: Obx(() {
      return Column(children: [
        AppBarWidget(isLogo: true, height: size.height * 0.38, width: double.infinity, logoHeight: size.height * 0.18, logoWidth: size.height * 0.18),
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
            child: Column(children: [
              Text(AppString.enterOtp, style: TextStyle(color: AppColor.themecolor, fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 24),
              AppTextField(controller: otpController.verifyotp.value, txtValue: AppString.otpCode, lableValue: AppString.otpText, keytype: TextInputType.number, maxLength: 6),
              const SizedBox(height: 10),
              InkWell(
                  onTap: () {
                    otpController.verifyOtp(context, widget.varId, widget.mo);
                  },
                  child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: AppColor.themecolor),
                      child: Center(
                          child: otpController.isLoading.value
                              ? const Padding(padding: EdgeInsets.all(3.0), child: CircularProgressIndicator(color: Colors.white))
                              : Text(AppString.nextPage, style: TextStyle(color: AppColor.primarycolor, fontSize: 20, fontWeight: FontWeight.w500))))),
              const SizedBox(height: 26),
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginSCreen()));
                  },
                  child: Text(AppString.otpBack, style: TextStyle(color: AppColor.themecolor, fontSize: 18, fontWeight: FontWeight.w600)))
            ]))
      ]);
    }))));
  }
}
