import 'package:flutter/material.dart';
import 'package:le_vech/Widgets/app_text.dart';
import 'color_const.dart';

class DropDown extends StatefulWidget {
  List<String> items;
  String dropdownvalue = '';
  Function onTap;

  DropDown({Key? key, required this.items, required this.dropdownvalue, required this.onTap}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 54,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(28), border: Border.all(color: AppColor.primarycolorblack, width: 0.9), color: AppColor.primarycolor),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownButton(
                isExpanded: true,

                // Initial Value
                value: widget.dropdownvalue,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                // Array list of items
                underline: SizedBox(),
                items: widget.items.map((String items) {
                  return DropdownMenuItem(value: items, child: /*Text(items, style: TextStyle(fontSize: 18, color: AppColor.primarycolorblack))*/
                  AppText(text: items,txtColor: AppColor.primarycolorblack,size: 18),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.onTap(newValue!);
                  });
                })));
  }
}
