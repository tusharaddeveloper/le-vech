import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:le_vech/screens/auth.dart/otp_screen.dart';
import 'package:le_vech/widgets.dart/app_bar.dart';
import 'package:le_vech/widgets.dart/app_button.dart';
import 'package:le_vech/widgets.dart/app_textfieled.dart';


import 'package:le_vech/widgets.dart/color_const.dart';

import 'package:le_vech/widgets.dart/string_const.dart';


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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void userlogin(BuildContext context) async {
    try {
      setState(() {
        isLoading=true;
      });
      _auth = FirebaseAuth.instance;

      _auth!.verifyPhoneNumber(
        phoneNumber: '+91' + mobileNoController.text,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential credetial) async {
          print('abcd${credetial}');
          setState(() {
            isLoading=false;
          });
        },
        verificationFailed: (error) {
          setState(() {
            progressvalue = true;
            isLoading=false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Center(
                  child: Text(
                error.code,
                style: const TextStyle(color: Colors.black),
              ))));
          print('error1002 ${error.message}');
        },
        codeSent: (String verificationId, int? resendToken) async {
          varId = verificationId;

          setState(() {
            progressvalue = true;
            showbutton = true;
            isLoading=false;
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

    } catch (a) {
      print(a);
      setState(() {
        isLoading=false;
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
                    InkWell(
                      onTap: () {
                        //Navigator.push(context,MaterialPageRoute(builder: (context)=>OtpScreen()));
                        // userlogin();
                        userlogin(context);
                      },
                      child: AppButton(
                        height: 50,
                        width: 170,
                        isLoad: isLoading,
                        buttontxt: AppString.getOtp,
                      ),
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
