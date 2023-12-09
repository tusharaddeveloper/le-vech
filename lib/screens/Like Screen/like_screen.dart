import 'package:flutter/material.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/image_const.dart';
import 'package:le_vech/Widgets/string_const.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({Key? key}) : super(key: key);

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  bool isIcon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.txtfilled,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            AppBarWidget(
              height: 130,
              width: double.infinity,
              isLogo: false,
              info: AppString.like,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                cursorColor: AppColor.primarycolorblack,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.shadow,
                  focusColor: AppColor.shadow,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColor.primarycolorblack,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: AppString.searchBar,
                  hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primarycolorblack),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: GridView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4.8 / 5.8, crossAxisSpacing: 2, mainAxisSpacing: 2),
                  itemBuilder: (context, index) {
                    return itemWidget(
                      index: index,
                    );
                  }),
            )
          ]),
        ),
      ),
    );
  }
}

class itemWidget extends StatefulWidget {
  int index;

  itemWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<itemWidget> createState() => _itemWidgetState();
}

class _itemWidgetState extends State<itemWidget> {
  bool isIcon = true;
  List<String> imageList = [AppImage.tractorEicher, AppImage.cow, AppImage.horse, AppImage.bike, AppImage.car];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.primarycolor),
          child: Column(
            children: [
              SizedBox(height: 8),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                child: Container(
                  height: 100,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(image: AssetImage(imageList[widget.index]), fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.tractorName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          width: 110,
                          child: Text(
                            "₹20,400,000000",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: AppColor.price, fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isIcon = !isIcon;
                            });
                          },
                          child: Icon(
                            isIcon ? Icons.favorite : Icons.favorite_border,
                            color: isIcon ? AppColor.iconColor : AppColor.primarycolorblack,
                            size: 24,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
