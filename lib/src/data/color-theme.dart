import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ListifyColor extends Equatable {
  final Color primary;
  final Color accent;
  final Color appbarFont;
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
    @required this.bodyBackground,
    @required this.listTileCardBackground,
    @required this.listTileFontColor,
    @required this.listTileIconColor,
    @required this.buttonPrimary,
    @required this.buttonSecondary,
  });

  Map<String, dynamic> toJson() {
    return {
      'primary': primary?.value,
      'accent': accent?.value,
      'appbarFont': appbarFont?.value,
      'bodyBackground': bodyBackground?.value,
      'listTileCardBackground': listTileCardBackground?.value,
      'listTileFontColor': listTileFontColor?.toJson(),
      'listTileIconColor': listTileIconColor?.toJson(),
      'buttonPrimary': buttonPrimary?.toJson(),
      'buttonSecondary': buttonSecondary?.toJson(),
    };
  }

  static ListifyColor fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListifyColor(
      primary: Color(map['primary']),
      accent: Color(map['accent']),
      appbarFont: Color(map['appbarFont']),
      bodyBackground: Color(map['bodyBackground']),
      listTileCardBackground: Color(map['listTileCardBackground']),
      listTileFontColor: ListTileFontColor.fromJson(map['listTileFontColor']),
      listTileIconColor: ListTileIconColor.fromJson(map['listTileIconColor']),
      buttonPrimary: ButtonColor.fromJson(map['buttonPrimary']),
      buttonSecondary: ButtonColor.fromJson(map['buttonSecondary']),
    );
  }

  @override
  List<Object> get props => [
        primary,
        accent,
        appbarFont,
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

  Map<String, dynamic> toJson() {
    return {
      'primary': primary?.value,
      'secondary': secondary?.value,
    };
  }

  static ListTileFontColor fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ListTileFontColor(
      primary: Color(json['primary']),
      secondary: Color(json['secondary']),
    );
  }

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

  Map<String, dynamic> toJson() {
    return {
      'normal': normal?.value,
      'primary': primary?.value,
      'secondary': secondary?.value,
      'danger': danger?.value,
    };
  }

  static ListTileIconColor fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ListTileIconColor(
      normal: Color(json['normal']),
      primary: Color(json['primary']),
      secondary: Color(json['secondary']),
      danger: Color(json['danger']),
    );
  }

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

  Map<String, dynamic> toJson() {
    return {
      'background': background?.value,
      'fontColor': fontColor?.value,
    };
  }

  static ButtonColor fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ButtonColor(
      background: Color(json['background']),
      fontColor: Color(json['fontColor']),
    );
  }

  @override
  List<Object> get props => [
        background,
        fontColor,
      ];
}
