import 'package:flutter/material.dart';

import 'package:le_vech/screens/Profile%20Screen/le_vech_profile.dart';


import 'package:le_vech/widgets.dart/color_const.dart';
import 'package:le_vech/widgets.dart/image_const.dart';



class FourWheel extends StatefulWidget {
  const FourWheel({Key? key}) : super(key: key);

  @override
  State<FourWheel> createState() => _FourWheelState();
}

class _FourWheelState extends State<FourWheel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LeVechProfile(),
        ));
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.primarycolor),
          child: Column(
            children: [
              SizedBox(
                height: 08,
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                child: Container(
                  height: 100,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(image: AssetImage(AppImage.car), fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "કાર વેચવાનો છે",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColor.primarycolorblack, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "₹2,50,000",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: AppColor.price, fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isIcon = !isIcon;
                            });
                          },
                          child: Icon(
                            isIcon ? Icons.favorite_border : Icons.favorite,
                            color: isIcon ? AppColor.primarycolorblack : AppColor.iconColor,
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
