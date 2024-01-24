import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:le_vech/Widgets/app_text.dart';
import 'package:le_vech/Widgets/color_const.dart';

class SellProfileImages extends StatelessWidget {
  SellProfileImages({super.key,required this.image});
   List image=[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: AppColor.txtfilled,
        appBar: AppBar(
          backgroundColor: AppColor.themecolor,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: AppColor.primarycolor),
          title: AppText(text: "Photos",size: 20,txtColor: AppColor.primarycolor,fontWeight: FontWeight.w600,),
        ),
        body: Builder(

          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: double.infinity,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true
                ),
                items: image.map((i) => Image(image: NetworkImage(i)))
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

