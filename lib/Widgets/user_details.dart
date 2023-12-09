// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:le_vech/widgets.dart/string_const.dart';
//
// import 'app_bar.dart';
// import 'app_button.dart';
// import 'app_textfieled.dart';
//
// class Userdetail extends StatefulWidget {
//   const Userdetail({super.key});
//
//   @override
//   State<Userdetail> createState() => _UserdetailState();
// }
//
// class _UserdetailState extends State<Userdetail> {
//   TextEditingController districtController = TextEditingController();
//   TextEditingController talukaController = TextEditingController();
//   TextEditingController villageController = TextEditingController();
//   @override
//   void initState() {
//
//     super.initState();
//   }
//
//   void setData() async {
//     try {
//       await FirebaseFirestore.instance.collection("location_data").doc(districtController.text).set({
//
//         'district': districtController.text ,
//         'taluka': talukaController.text ,
//         'village':  villageController.text,
//
//       }).then((value) {
//
//       });
//     } catch (e) {
//       print(e);
//       // TODO
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return  Scaffold(
//
//       body:
//       SingleChildScrollView(
//         child: Column(
//           children: [
//
//
//             AppBarWidget(isLogo: true, height: size.height * 0.5, width: double.infinity, logoHeight: size.height * 0.28, logoWidth: size.height * 0.28),
//             SizedBox(height: 30,),
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                 children: [
//                   AppTextField(
//                     txtValue: AppString.dis,
//                     controller: districtController,
//                     isIcon: false,
//                     preIcon: false, /*lableValue: AppString.surName*/
//                   ),
//                   SizedBox(height: 10,),
//                   AppTextField(
//                     txtValue: AppString.taluka,
//                     controller: talukaController,
//                     isIcon: false,
//                     preIcon: false, /*lableValue: AppString.surName*/
//                   ),
//                   SizedBox(height: 10,),
//                   AppTextField(
//                     txtValue: AppString.village,
//                     controller: villageController,
//                     isIcon: false,
//                     preIcon: false, /*lableValue: AppString.surName*/
//                   ),
//                   SizedBox(height: 30,),
//                   InkWell(
//                     onTap: () {
//                       setData();
//
//
//                     },
//                     child: AppButton(
//                       height: 50,
//                       width: 170,
//                       // isLoad: isLoading,
//                       buttontxt: AppString.getOtp,
//                     ),
//                   ),
//
//                 ],
//               ),
//             ),
//
//           ],
//         ),
//       ),
//
//
//
//     );
//   }
// }
