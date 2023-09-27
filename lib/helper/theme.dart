// Flutter imports:
import 'package:jokes/helper/app_constants.dart';
import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
// Define the default brightness and colors.
  brightness: Brightness.light,
  primarySwatch: AppConstants.generateMaterialColor(AppConstants.primaryColor),
  primaryColor: AppConstants.primaryColor,
  useMaterial3: true,
  indicatorColor: AppConstants.primaryColor,
// Define the default font family.
  splashColor: AppConstants.primaryColor.withOpacity(0.2),
  highlightColor: AppConstants.primaryColor.withOpacity(0.2),
  scaffoldBackgroundColor: AppConstants.scaffoldBgColor,
  canvasColor: AppConstants.white,
  unselectedWidgetColor: AppConstants.blueSky,
  buttonTheme: ButtonThemeData(
    buttonColor: AppConstants.primaryColor,
    disabledColor: AppConstants.blueSky,
    splashColor: AppConstants.primaryColor.withOpacity(0.2),
    alignedDropdown: true,
  ),
  iconTheme: const IconThemeData(color: AppConstants.black),
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontSize: 24, color: AppConstants.black, fontWeight: FontWeight.w700),
    headline2: TextStyle(
        fontSize: 22, color: AppConstants.black, fontWeight: FontWeight.w700),
    headline3: TextStyle(
        fontSize: 20, color: AppConstants.black, fontWeight: FontWeight.w500),
    headline4: TextStyle(
        fontSize: 16, color: AppConstants.black, fontWeight: FontWeight.w400),
    subtitle1: TextStyle(
        fontSize: 18, color: AppConstants.black, fontWeight: FontWeight.w500),
    subtitle2: TextStyle(
        fontSize: 14, color: AppConstants.black, fontWeight: FontWeight.w400),
    bodyText1: TextStyle(
        fontSize: 12, color: AppConstants.black, fontWeight: FontWeight.w400),
    bodyText2: TextStyle(
        fontSize: 10, color: AppConstants.black, fontWeight: FontWeight.w400),
  ),

  dataTableTheme: DataTableThemeData(
    headingRowColor:
        MaterialStateProperty.all(AppConstants.black.withAlpha(25)),
    horizontalMargin: 24,
    decoration: BoxDecoration(
      border: Border.all(
        color: AppConstants.black.withAlpha(100),
      ),
    ),
    headingTextStyle: const TextStyle(
        fontSize: 14, color: AppConstants.black, fontWeight: FontWeight.w700),
    dataTextStyle: const TextStyle(
        fontSize: 14, color: AppConstants.black, fontWeight: FontWeight.w400),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
  }),
);

InputDecoration customDecorations(String label, {FocusNode? myFocusNode}) {
  return InputDecoration(
    labelStyle: myFocusNode != null
        ? TextStyle(
            color: myFocusNode.hasFocus
                ? AppConstants.blueSky
                : AppConstants.black.withOpacity(0.5))
        : TextStyle(color: AppConstants.black.withOpacity(0.5)),
    labelText: label,
    alignLabelWithHint: true,
    isDense: true,
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: AppConstants.black, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusColor: AppConstants.blueSky,
    fillColor: AppConstants.white,
    hoverColor: AppConstants.warmSand,
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppConstants.darkWoodColor,
        width: 1,
      ),
    ),
  );
}
