import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ListifyColor extends Equatable {
  final MaterialColor primary;
  final Color accent;
  final Color appbarFont;
  final Color textPrimary;
  final Color bodyBackground;
  final Color listTileCardBackground;
  final ListTileFontColor listTileFontColor;
  final ListTileIconColor listTileIconColor;
  final ButtonColor buttonPrimary;
  final ButtonColor buttonSecondary;

  ListifyColor({
    @required this.primary,
    @required this.accent,
    @required this.appbarFont,
    @required this.textPrimary,
    @required this.bodyBackground,
    @required this.listTileCardBackground,
    @required this.listTileFontColor,
    @required this.listTileIconColor,
    @required this.buttonPrimary,
    @required this.buttonSecondary,
  });

  @override
  List<Object> get props => [
        primary,
        accent,
        appbarFont,
        textPrimary,
        bodyBackground,
        listTileCardBackground,
        listTileFontColor,
        listTileIconColor,
        buttonPrimary,
        buttonSecondary,
      ];
}

class ListTileFontColor extends Equatable {
  final Color primary;
  final Color secondary;

  ListTileFontColor({
    @required this.primary,
    @required this.secondary,
  });

  @override
  List<Object> get props => [
        primary,
        secondary,
      ];
}

class ListTileIconColor extends Equatable {
  final Color normal;
  final Color primary;
  final Color secondary;
  final Color danger;

  ListTileIconColor({
    @required this.normal,
    @required this.primary,
    @required this.secondary,
    @required this.danger,
  });

  @override
  List<Object> get props => [
        normal,
        primary,
        secondary,
        danger,
      ];
}

class ButtonColor extends Equatable {
  final Color background;
  final Color fontColor;

  ButtonColor({
    @required this.background,
    @required this.fontColor,
  });

  @override
  List<Object> get props => [
        background,
        fontColor,
      ];
}
