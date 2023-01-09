import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'fonts_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      // will be used in case of disable button for example
      accentColor: ColorManager.grey,
      // card view theme
      cardTheme: CardTheme(color: ColorManager.white, shadowColor: ColorManager.grey, elevation: AppSize.s10),
      // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.primaryOpacity70,
          titleTextStyle: getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16)),
      // Button theme
      buttonTheme: ButtonThemeData(shape: StadiumBorder(), disabledColor: ColorManager.grey1, splashColor: ColorManager.primaryOpacity70, buttonColor: ColorManager.primary),
      // Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white), primary: ColorManager.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s8)))),
      // Text theme
      textTheme: TextTheme(
        headline1: getSemiBoldStyle(color: ColorManager.darkGrey, fontSize: FontSize.s16),
        headline2: getMediumStyle(color: ColorManager.lightGrey, fontSize: FontSize.s14),
        caption: getRegularStyle(color: ColorManager.grey),
        bodyText1: getRegularStyle(color: ColorManager.grey),
      ),

      // input decoration theme (text from field)
      inputDecorationTheme: InputDecorationTheme(
          // Content padding
          contentPadding: EdgeInsets.all(AppSize.s8),
          // Hint style
          hintStyle: getRegularStyle(color: ColorManager.grey),
          // Label style
          labelStyle: getMediumStyle(color: ColorManager.lightGrey),
          // Error style
          errorStyle: getRegularStyle(color: ColorManager.error),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s4), borderRadius: BorderRadius.circular(AppSize.s8)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s4), borderRadius: BorderRadius.circular(AppSize.s8)),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.error, width: AppSize.s4), borderRadius: BorderRadius.circular(AppSize.s8))));
}
