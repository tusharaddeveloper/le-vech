import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:le_vech/screens/auth.dart/login_screen.dart';
import 'package:le_vech/screens/auth.dart/noted_screen.dart';
import 'package:le_vech/utils/firebase_get.dart';
import 'package:le_vech/utils/snackbar.dart';
import 'package:le_vech/widgets.dart/app_bar.dart';
import 'package:le_vech/widgets.dart/app_textfieled.dart';

import 'package:le_vech/widgets.dart/color_const.dart';

import 'package:le_vech/widgets.dart/string_const.dart';


import '../Home Screen/home_screen.dart';

class OtpScreen extends StatefulWidget {
  String varId;
  String mo;

  OtpScreen({Key? key, required this.mo, required this.varId}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isLoading = false;
  TextEditingController verifyotp = TextEditingController();
  FirebaseAuth? auth;
  List<QueryDocumentSnapshot> firebasedata = <QueryDocumentSnapshot>[];

  void verifyOtp() async {
    auth = FirebaseAuth.instance;
    final code = verifyotp.text.trim();
    try {
      setState(() {
        isLoading=true;
      });
      PhoneAuthCredential phonecredential = PhoneAuthProvider.credential(verificationId: widget.varId, smsCode: code);
      UserCredential result = await auth!.signInWithCredential(phonecredential);

      print('OTP CODE ${phonecredential}');
      if (result.user != null) {
        getData();
      } else {
        setState(() {
          isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Center(
                child: Text(
              'Invalid Otp',
              style: TextStyle(color: Colors.black),
            ))));
      }
    } catch (e) {  setState(() {
      isLoading=false;
    });
    errorSnackBar(context, AppString.enterRightOtp);
    }
  }

  void getData() async {
    firebasedata=await firebaseGetwhere('users', 'mobile_number', 'widget.mo');
    // var storeData = await FirebaseFirestore.instance.collection("users").where("mobile_number", isEqualTo: widget.mo).get();
    //firebasedata = storeData.docs;
    if (firebasedata.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotedScreen(Mobile: widget.mo),
          ));
    }
    setState(() {
      isLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(isLogo: true, height: size.height * 0.38, width: double.infinity, logoHeight: size.height * 0.18, logoWidth: size.height * 0.18),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
                child: Column(
                  children: [
                    Text(
                      AppString.enterOtp,
                      style: TextStyle(color: AppColor.themecolor, fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 24),
                    AppTextField(
                      controller: verifyotp,
                      txtValue: AppString.otpCode,
                      lableValue: AppString.otpText,
                      keytype: TextInputType.number,
                      isIcon: false,
                      preIcon: true,
                      maxLength: 6,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        verifyOtp();
                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: AppColor.themecolor),
                        child: Center(
                          child: isLoading?const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: CircularProgressIndicator(color: Colors.white,),
                          )
                              :Text(
                            AppString.nextPage,
                            style: TextStyle(color: AppColor.primarycolor, fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 26),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSCreen()));
                      },
                      child: Text(

                        AppString.otpBack,
                        style: TextStyle(color: AppColor.themecolor, fontSize: 18, fontWeight: FontWeight.w600),
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
