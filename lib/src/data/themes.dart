import 'package:flutter/material.dart';

import 'color-theme.dart';

ListifyTheme indigoPinkLight() {
  return ListifyTheme(
    primary: Colors.indigo,
    accent: Colors.pink,
    appbarFont: Colors.white,
    textPrimary: Colors.black.withOpacity(0.80),
    bodyBackground: Color(0xffFAFAFA),
    listTileCardBackground: Colors.white,
    listTileFontColor: ListTileFontColor(
      primary: Colors.black.withOpacity(0.7),
      secondary: Color(0xff737373),
    ),
    listTileIconColor: ListTileIconColor(
      normal: Color(0xff8C8C8C),
      primary: Colors.green,
      secondary: Colors.pink,
      danger: Colors.red,
    ),
    buttonPrimary: ButtonColor(
      background: Colors.indigo,
      fontColor: Colors.white,
    ),
    buttonSecondary: ButtonColor(
      background: Colors.pink,
      fontColor: Colors.white,
    ),
  );
}

ListifyTheme tealPurpleLight() {
  return ListifyTheme(
    primary: Colors.teal,
    accent: Colors.purple,
    appbarFont: Colors.white,
    textPrimary: Colors.black.withOpacity(0.80),
    bodyBackground: Color(0xffFAFAFA),
    listTileCardBackground: Colors.white,
    listTileFontColor: ListTileFontColor(
      primary: Colors.black.withOpacity(0.7),
      secondary: Color(0xff737373),
    ),
    listTileIconColor: ListTileIconColor(
      normal: Color(0xff8C8C8C),
      primary: Colors.green,
      secondary: Colors.purple,
      danger: Colors.redAccent,
    ),
    buttonPrimary: ButtonColor(
      background: Colors.teal,
      fontColor: Colors.white,
    ),
    buttonSecondary: ButtonColor(
      background: Colors.purple,
      fontColor: Colors.white,
    ),
  );
}

ListifyTheme indigoPinkDark() {
  return ListifyTheme(
    primary: Colors.indigo,
    accent: Colors.pink,
    appbarFont: Colors.white,
    textPrimary: Colors.white.withOpacity(0.65),
    bodyBackground: Color(0xff282C34),
    listTileCardBackground: Color(0xff21252B),
    listTileFontColor: ListTileFontColor(
      primary: Colors.white.withOpacity(0.80),
      secondary: Color(0xff737373),
    ),
    listTileIconColor: ListTileIconColor(
      normal: Color(0xff8C8C8C),
      primary: Colors.green,
      secondary: Colors.pink,
      danger: Colors.redAccent,
    ),
    buttonPrimary: ButtonColor(
      background: Colors.indigo,
      fontColor: Colors.white,
    ),
    buttonSecondary: ButtonColor(
      background: Colors.pink,
      fontColor: Colors.white,
    ),
  );
}

ListifyTheme tealPurpleDark() {
  return ListifyTheme(
    primary: Colors.teal,
    accent: Colors.purple,
    appbarFont: Colors.white,
    textPrimary: Colors.white.withOpacity(0.65),
    bodyBackground: Color(0xff282C34),
    listTileCardBackground: Color(0xff21252B),
    listTileFontColor: ListTileFontColor(
      primary: Colors.white.withOpacity(0.80),
      secondary: Color(0xff737373),
    ),
    listTileIconColor: ListTileIconColor(
      normal: Color(0xff8C8C8C),
      primary: Colors.green,
      secondary: Colors.purple,
      danger: Colors.redAccent,
    ),
    buttonPrimary: ButtonColor(
      background: Colors.teal,
      fontColor: Colors.white,
    ),
    buttonSecondary: ButtonColor(
      background: Colors.purple,
      fontColor: Colors.white,
    ),
  );
}
