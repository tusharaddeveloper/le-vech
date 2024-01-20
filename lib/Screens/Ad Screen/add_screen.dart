import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:le_vech/Controller/Auth%20Controller/noted_controller.dart';
import 'package:le_vech/Controller/add_controller.dart';
import 'package:le_vech/Widgets/app_bar.dart';
import 'package:le_vech/Widgets/app_button.dart';
import 'package:le_vech/Widgets/app_text.dart';
import 'package:le_vech/Widgets/app_textfieled.dart';
import 'package:le_vech/Widgets/color_const.dart';
import 'package:le_vech/Widgets/drop_down.dart';
import 'package:le_vech/Widgets/string_const.dart';

class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({Key? key}) : super(key: key);

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  NotedController notedController = Get.put(NotedController());
  AddController addController = Get.put(AddController());

  bool isLoading = false;

  @override
  void initState() {
    addController.selectedImages.clear();
    notedController.getDis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: SingleChildScrollView(child: Obx(() {
      return Column(children: [
        AppBarWidget(isLogo: false, height: 130, width: double.infinity, info: AppString.addItem),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: InkWell(
            onTap: () {
              addController.getFromGallery(context);
            },
            child: Row(
              children: [
                AppText(text: AppString.addPhoto,txtColor: AppColor.primarycolorblack,size: 20,fontWeight: FontWeight.w500)
                /*Text(AppString.addPhoto, style: const TextStyle(color: Color(0xff000000), fontSize: 20, fontWeight: FontWeight.w500))*/,
                const SizedBox(width: 8),
                Icon(Icons.add_circle_outline, size: 28, color: AppColor.themecolor),
              ],
            ),
          ),
        ),
        addController.selectedImages.isEmpty
            ? const SizedBox()
            : CarouselSlider(
                options: CarouselOptions(height: 190, autoPlay: false, autoPlayInterval: const Duration(seconds: 2), aspectRatio: 16 / 9, viewportFraction: 1, enableInfiniteScroll: false),
                items: addController.selectedImages.map((i) {
                  return Builder(builder: (BuildContext context) {
                    return Column(children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 190,
                            width: double.infinity,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            child: Image.file(i, fit: BoxFit.fill),
                          ))
                    ]);
                  });
                }).toList(),
              ),
        const SizedBox(height: 20),
        AppText(text: AppString.sellingItem,txtColor: AppColor.primarycolorblack,size: 18,fontWeight: FontWeight.w400),

        const SizedBox(height: 20),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(children: [
              DropDown(
                  items: [ AppString.allInfo,
                    AppString.tractor,
                    AppString.cow,
                    AppString.horse,
                    AppString.twoWheel,
                    AppString.fourWheel,
                    AppString.others,
                    "ખેત પેદાશ લે - વેચ",
                    "ઇલેક્ટ્રોનિક સાધનો લે-વેચ",
                    "લેપટોપ કમ્પ્યુટર ટીવી લે-વેચ",
                    "નોકરી",
                    "મોબાઇલ લે-વેચ",
                    "ભંગાર લે-વેચ",
                    "મકાન દુકાન પ્લોટ જમીન લે-વેચ",
                    "બિયારણ દવા લે-વેચ",
                    "ફળ શાકભાજી લે-વેચ",
                    "નર્સરી રોપ લે-વેચ",
                    "ઘેટાં બકરાં લે-વેચ",
                    "સનેડો ટ્રેક્ટર લે-વેચ",
                    "ટ્રેક્ટર ઓજાર લે-વેચ",
                    "ખેત ઓજાર લે-વેચ",
                    "પક્ષીઓ લે-વેચ",
                    "બળદ લે-વેચ",
                    "કુતરા લે-વેચ"],
                  dropdownvalue: addController.selectItem,
                  onTap: (String value) {
                    setState(() {
                      addController.selectItem = value;
                    });
                  }),
              const SizedBox(height: 10),
              AppTextField(controller: addController.addNameController, txtValue: AppString.name),
              const SizedBox(height: 20),
              AppTextField(controller: addController.priceController, txtValue: AppString.price, keytype: TextInputType.number),
              const SizedBox(height: 20),
              AppText(text: AppString.sellingInfo,txtColor: AppColor.primarycolorblack,size: 18,fontWeight: FontWeight.w400),
              /*Text(AppString.sellingInfo, style: TextStyle(color: AppColor.primarycolorblack, fontWeight: FontWeight.w400, fontSize: 18)),*/
              const SizedBox(height: 20),
              AppTextField(controller: addController.detailsController, txtValue: AppString.infoSend, maxLines: 4, counterTxt: ""),
              const SizedBox(height: 20),
              AppText(text: AppString.sellingplace,txtColor: AppColor.primarycolorblack,size: 18,fontWeight: FontWeight.w400),
             // Text(AppString.sellingplace, style: TextStyle(color: AppColor.primarycolorblack, fontWeight: FontWeight.w400, fontSize: 18)),
              const SizedBox(height: 20),
              AppTextField(txtValue: AppString.guj, readOnly: true),
              const SizedBox(height: 10),
              DropDown(
                  items: notedController.districList,
                  dropdownvalue: notedController.districSelect.value,
                  onTap: (String value) {
                    setState(() {
                      notedController.districSelect.value = value;
                      notedController.districSelectId.value = notedController.districListId[notedController.districList.indexOf(notedController.districSelect.value)];
                      notedController.isFirst.value = false;
                      notedController.getTaluka();
                    });
                  }),
              const SizedBox(height: 10),
              DropDown(
                  items: notedController.talukaList,
                  dropdownvalue: notedController.talukaSelect.value,
                  onTap: (String value) {
                    setState(() {
                      notedController.talukaSelect.value = value;
                      notedController.talukaSelectId.value = notedController.talukaListId[notedController.talukaList.indexOf(notedController.talukaSelect.value)];
                      notedController.getVillage();
                    });
                  }),
              const SizedBox(height: 10),
              DropDown(
                  items: notedController.villageList,
                  dropdownvalue: notedController.villageSelect.value,
                  onTap: (String value) {
                    setState(() {
                      notedController.villageSelect.value = value;
                      notedController.villageSelectId.value = notedController.villageListId[notedController.villageList.indexOf(notedController.villageSelect.value)];
                    });
                  }),
              const SizedBox(height: 10),
              AppTextField(controller: addController.addMobileController, txtValue: AppString.mobileNo, keytype: TextInputType.number, lableValue: AppString.mobileNo, counterTxt: '', maxLength: 10),
              const SizedBox(height: 10),
              AppTextField(controller: addController.addressController, txtValue: AppString.add, maxLines: 4, counterTxt: ""),
              const SizedBox(height: 20),
              AppButton(
                  height: 60,
                  width: double.infinity,
                  isLoad: addController.isItemAddLoader.value,
                  buttontxt: AppString.send,
                  onTap: () {
                    /* if (notedController.nameController.value.text.isEmpty) {
                      errorSnackBar(context, AppString.pleaseName);
                    } else if (addController.priceController.value.text.isEmpty) {
                      errorSnackBar(context, AppString.pleaseAddprice);
                    } else if (addController.detailsController.value.text.isEmpty) {
                      errorSnackBar(context, AppString.pleaseAddinfo);
                    } else if (addController.addMobileController.value.text.isEmpty) {
                      errorSnackBar(context, AppString.enterNum);
                    } else if (notedController.addressController.value.text.isEmpty) {
                      errorSnackBar(context, AppString.pleaseAdd);
                    } else {*/
                    addController.setItemData(context);
                  })
            ]))
      ]);
    }))));
  }
}
