import 'package:flutter/material.dart';

import 'color-theme.dart';

ListifyColor defaultTheme() {
  return ListifyColor(
    primary: Colors.indigo,
    accent: Color(0xffE91E63),
    appbarFont: Colors.white,
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
