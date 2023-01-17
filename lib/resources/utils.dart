import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';

class CommonUtilities {

  //Input Text Form Field
  static getTextInputDecor(String labelText, IconData iconData,
      {Color colorBorder = Colors.black, Color colorIcon = Colors.black}) {
    return InputDecoration(
        focusedErrorBorder:
        OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        errorBorder:
        OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        labelText: labelText,
        labelStyle: TextStyle(color: colorBorder),
        prefixIcon: Icon(
          iconData,
          color: colorIcon,
        ));
  }


  //Input TextFormField for Password
  static getTextInputDecorPass(
      String labelText, IconData iconData, Function onLockedClick,
      {Color colorBorder = Colors.black,
        Color colorIcon = Colors.black,
        bool isLocked = true}) {
    return InputDecoration(
        focusedErrorBorder:
        OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        errorBorder:
        OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        labelText: labelText,
        labelStyle: TextStyle(color: ColorManager.primaryUi),
        prefixIcon: Icon(
          iconData,
          color: colorIcon,
        ),
        suffixIcon: InkWell(
            onTap: () {
              onLockedClick();
            },
            child: Icon(
              isLocked ? Icons.visibility_off : Icons.visibility,
              color: colorIcon,
            )));
  }
}