import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:le_vech/screens/Auth/otp_screen.dart';
import 'package:le_vech/utils/snackbar.dart';
import 'package:le_vech/Widgets/string_const.dart';

class LoginController extends GetxController {
  Rx<TextEditingController> mobileNoController = TextEditingController().obs;
  RxString varId = "".obs;
  FirebaseAuth? auth;
  RxBool progressvalue = false.obs;
  RxBool showbutton = false.obs;
  RxBool isLoading = false.obs;

  void userlogin(BuildContext context) async {
    try {
      if (mobileNoController.value.text.isNotEmpty) {
        isLoading.value = true;
        auth = FirebaseAuth.instance;
        auth!.verifyPhoneNumber(
            phoneNumber: '+91' + mobileNoController.value.text,
            timeout: const Duration(seconds: 60),
            verificationCompleted: (AuthCredential credetial) async {
              print('abcd${credetial}');
              isLoading.value = false;
            },
            verificationFailed: (error) {
              progressvalue.value = true;
              isLoading.value = false;
              errorSnackBar(context, error.code);
              print('error1002 ${error.message}');
            },
            codeSent: (String verificationId, int? resendToken) async {
              varId.value = verificationId;
              progressvalue.value = true;
              showbutton.value = true;
              isLoading.value = false;
              Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(varId: varId.value, mo: mobileNoController.value.text)));
            },
            codeAutoRetrievalTimeout: (verificationId) {});
      } else {
        errorSnackBar(context, AppString.enterNum);
      }
    } catch (a) {
      print(a);
      isLoading.value = false;
    }
  }
}
