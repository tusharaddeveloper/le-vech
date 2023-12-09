import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:le_vech/utils/snackbar.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/app_button.dart';
import 'package:le_vech/Widgets/app_textfieled.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/string_const.dart';
import 'otp_screen.dart';

class LoginSCreen extends StatefulWidget {
  const LoginSCreen({Key? key}) : super(key: key);

  @override
  State<LoginSCreen> createState() => _LoginSCreenState();
}

class _LoginSCreenState extends State<LoginSCreen> {
  TextEditingController mobileNoController = TextEditingController();
  String varId = "";
  FirebaseAuth? _auth;
  bool progressvalue = false;
  bool showbutton = false;
  bool isLoading = false;

  void userlogin(BuildContext context) async {
    try {
      if (mobileNoController.text.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        _auth = FirebaseAuth.instance;
        _auth!.verifyPhoneNumber(
          phoneNumber: '+91' + mobileNoController.text,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential credetial) async {
            print('abcd${credetial}');
            setState(() {
              isLoading = false;
            });
          },
          verificationFailed: (error) {
            setState(() {
              progressvalue = true;
              isLoading = false;
            });
            errorSnackBar(context, error.code);
            print('error1002 ${error.message}');
          },
          codeSent: (String verificationId, int? resendToken) async {
            varId = verificationId;
            setState(() {
              progressvalue = true;
              showbutton = true;
              isLoading = false;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpScreen(
                          varId: varId,
                          mo: mobileNoController.text,
                        )));
          },
          codeAutoRetrievalTimeout: (verificationId) {},
        );
      } else {
        errorSnackBar(context, AppString.enterNum);
      }
    } catch (a) {
      print(a);
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(isLogo: true, height: size.height * 0.5, width: double.infinity, logoHeight: size.height * 0.28, logoWidth: size.height * 0.28),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppString.enterNum,
                      style: TextStyle(color: AppColor.themecolor, fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 24),
                    AppTextField(
                      txtValue: AppString.mobileNo,
                      lableValue: AppString.mobileNo,
                      controller: mobileNoController,
                      isIcon: false,
                      preIcon: true,
                      maxLength: 10,
                      keytype: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    AppButton(
                      height: 50,
                      width: 170,
                      isLoad: isLoading,
                      buttontxt: AppString.getOtp,
                      onTap: () {
                        userlogin(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
