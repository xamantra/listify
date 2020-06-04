import 'package:flutter/material.dart';

import 'color-theme.dart';

ListifyColor defaultTheme() {
  return ListifyColor(
    primary: Colors.indigo,
    accent: Color(0xffE91E63),
    appbarFont: Colors.white,
    textPrimary: Colors.black.withOpacity(0.80),
    bodyBackground: Color(0xffFAFAFA),
    listTileCardBackground: Colors.white,
    listTileFontColor: ListTileFontColor(
      primary: Colors.black,
      secondary: Color(0xff737373),
    ),
    listTileIconColor: ListTileIconColor(
      normal: Color(0xff8C8C8C),
      primary: Colors.green,
      secondary: Color(0xffE91E63),
      danger: Colors.red,
    ),
    buttonPrimary: ButtonColor(
      background: Color(0xff3F51B5),
      fontColor: Colors.white,
    ),
    buttonSecondary: ButtonColor(
      background: Color(0xffE91E63),
      fontColor: Colors.white,
    ),
  );
}

ListifyColor darkTheme() {
  return ListifyColor(
    primary: Colors.indigo,
    accent: Color(0xffE91E63),
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
      secondary: Color(0xffE91E63),
      danger: Colors.redAccent,
    ),
    buttonPrimary: ButtonColor(
      background: Color(0xff3F51B5),
      fontColor: Colors.white,
    ),
    buttonSecondary: ButtonColor(
      background: Color(0xffE91E63),
      fontColor: Colors.white,
    ),
  );
}
