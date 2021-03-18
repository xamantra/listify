import 'package:flutter/material.dart';

import '../models/index.dart';

class CustomTheme extends InheritedWidget {
  CustomTheme({
    Key? key,
    required Widget child,
    required this.theme,
  }) : super(key: key, child: child);

  final ListifyTheme theme;

  static ListifyTheme of(BuildContext context) {
    // ignore: deprecated_member_use
    return context.dependOnInheritedWidgetOfExactType<CustomTheme>()!.theme;
  }

  @override
  bool updateShouldNotify(CustomTheme oldWidget) {
    var notSameTheme = oldWidget.theme != theme;
    return notSameTheme;
  }
}
