import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:le_vech/screens/Auth/noted_screen.dart';
import 'package:le_vech/screens/Auth/splash_screen.dart';
import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';
import 'Widgets/color_const.dart';
import 'firebase_options.dart';
import 'screens/Ad Screen/add_screen.dart';
import 'screens/Home Screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColor.themecolor));
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
     //  home: LeVechProfile());
     //   home: HomeScreen(mobileNo: "9824685852"));
      //   home: SplashScreen());
    home: AddItemsScreen());
         //home: NotedScreen(Mobile: '8469497184',));
  }
}
