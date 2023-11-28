import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter/material.dart';

void succesSnackBar(BuildContext context, String text){
  showTopSnackBar(
    Overlay.of(context),
     CustomSnackBar.success(
      message:
      text,
    ),
  );

}void errorSnackBar(BuildContext context, String text){
  showTopSnackBar(
    Overlay.of(context),
     CustomSnackBar.error(
      message:
      text,
    ),
  );
}