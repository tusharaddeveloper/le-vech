import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:le_vech/Widgets/app_text.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/image_const.dart';

class SellProfileImages extends StatefulWidget {
  SellProfileImages({super.key, required this.image});

  List image = [];

  @override
  State<SellProfileImages> createState() => _SellProfileImagesState();
}

class _SellProfileImagesState extends State<SellProfileImages> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.txtfilled,
        appBar: AppBar(
          backgroundColor: AppColor.themecolor,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: AppColor.primarycolor),
          title: AppText(text: "ફોટાઓ", size: 20, txtColor: AppColor.primarycolor, fontWeight: FontWeight.w600),
        ),
        body: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarouselSlider(
                options: CarouselOptions(height: double.infinity, enableInfiniteScroll: false, enlargeCenterPage: true),
                items: widget.image
                    .map(
                      (i) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                            imageUrl: i.toString(),
                            placeholder: (context, url) => Image(
                                  image: AssetImage(AppImage.imglogo),
                                  fit: BoxFit.cover,
                                ),
                            errorWidget: (context, url, error) => Image(image: AssetImage(AppImage.imglogo), fit: BoxFit.cover),
                            fit: BoxFit.fitWidth),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
