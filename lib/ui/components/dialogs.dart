// Basic Imports
import 'package:flutter/material.dart';

// Extra Widgets
import 'package:awesome_dialog/awesome_dialog.dart';

class FormDialogs {
  static Future informativeDialog(
      {required BuildContext context,
      required String message,
      String title = 'Aviso'}) async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      titleTextStyle: Theme.of(context).textTheme.headline1,
      desc: message,
      descTextStyle: Theme.of(context).textTheme.bodyText1,
      btnCancelOnPress: null,
      btnOkOnPress: () {},
    ).show();
  }
}
